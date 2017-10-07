
create table #spInfos
(
	spid smallint,
	kpid int,
	dbid int,
	cpu bigint,
	memusage bigint,
	status varchar(50),
	open_tran int,
	eventinfo varchar(4000)
)

select spid
into #spTemp
from sysprocesses

declare @spidCount int
select @spidCount = COUNT(*)
from #spTemp

while ( @spidCount > 0 )
begin

	declare @spid smallint
	select top 1 @spid = spid
	from #spTemp

	declare @execStr varchar(255)
	set @execStr = 'dbcc inputbuffer(' + cast(@spid as nchar(3)) + ')'

	create table #inputBufferTemp
	(
		EventType varchar(50),
		Parameters int,
		EventInfo varchar(4000)
	)

	insert #inputBufferTemp
	EXEC (@execStr)
	
	declare @eventinfo varchar(4000)
	select @eventinfo = EventInfo
	from #inputBufferTemp

	insert #spInfos
	select spid, kpid, dbid, cpu, memusage, status, open_tran, @eventInfo
	from sysprocesses
	where spid = @spid

	drop table #inputBufferTemp
	
	delete from #spTemp
	where spid = @spid
	
	select @spidCount = COUNT(*)
	from #spTemp
end

drop table #spTemp

SELECT  *
FROM    #spInfos
where status = 'background'
ORDER BY cpu desc