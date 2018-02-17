param([string]$repo,
      [string]$space = "Frontline")

$root = ''
$rootVar = Get-ChildItem -Path env:GITHUB_PATH -ErrorAction SilentlyContinue
if (-not $?) {
    $root = "C:\\GitHub"
} else {
    $root = $rootVar.Value
}

$path = "$root\\$space"
if ($repo) {
    $path += "\\$repo"
}

cd $path