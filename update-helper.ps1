$Env:PATH += ':/home/linuxbrew/.linuxbrew/opt/node@16/bin' 

$v2raya_latest = Invoke-WebRequest -Uri 'https://api.github.com/repos/v2raya/v2raya/releases/latest' | ConvertFrom-Json | Select-Object tag_name | ForEach-Object { ([string]$_.tag_name).Split('v')[1] }
$v2raya_url = 'https://github.com/v2rayA/v2rayA/archive/refs/tags/' + 'v' + $v2raya_latest + '.tar.gz'
$v2raya_source_path = 'v2rayA-' + $v2raya_latest

Write-Output $v2raya_latest; Write-Output $v2raya_source_path; Write-Output $v2raya_url
Invoke-WebRequest -Uri $v2raya_url -OutFile 'v2raya_latest.tar.gz'
bsdtar -f "./v2raya_latest.tar.gz" -x -C "./"
Set-Location $v2raya_source_path
pwsh -c "Set-Location ./gui ;yarn; yarn build"
Copy-Item -Path ./web -Destination ./service/server/router/ -Force -Recurse
Set-Location ./service
$env:CGO_ENABLED = "0"
$build_flags = '-X github.com/v2rayA/v2rayA/conf.Version=' + $v2raya_latest + '-homebrew' + ' -s -w'
$env:GOARCH = "amd64"; $env:GOOS = "linux"; go build -ldflags $build_flags -o '../v2raya_amd64_linux'
$env:GOARCH = "amd64"; $env:GOOS = "darwin"; go build -ldflags $build_flags -o '../v2raya_amd64_darwin'
$env:GOARCH = "arm64"; $env:GOOS = "darwin"; go build -ldflags $build_flags -o '../v2raya_arm64_darwin'
Set-Location ../

New-Item -ItemType Directory -Path ./ -Name "v2raya-x86_64-linux"
New-Item -ItemType Directory -Path ./ -Name "v2raya-x86_64-macos"
New-Item -ItemType Directory -Path ./ -Name "v2raya-aarch64-macos"
upx -9 "./v2raya_amd64_linux" -o "./v2raya-x86_64-linux/v2raya"
upx -9 "./v2raya_amd64_darwin" -o "./v2raya-x86_64-macos/v2raya"
upx -9 "./v2raya_arm64_darwin" -o "./v2raya-aarch64-macos/v2raya"

Compress-Archive -Path "./v2raya-x86_64-linux/*" -DestinationPath "./v2raya-x86_64-linux.zip"
Get-FileHash "v2raya-x86_64-linux.zip" | Select-Object Hash | ForEach-Object { ([string]$_.Hash) } | Out-File -Path v2raya-x86_64-linux-sha256.txt

Compress-Archive -Path "./v2raya-x86_64-macos/*" -DestinationPath "./v2raya-x86_64-macos.zip"
Get-FileHash "v2raya-x86_64-macos.zip" | Select-Object Hash | ForEach-Object { ([string]$_.Hash) } | Out-File -Path v2raya-x86_64-macos-sha256.txt

Compress-Archive -Path "./v2raya-aarch64-macos/*" -DestinationPath "./v2raya-aarch64-macos.zip"
Get-FileHash "v2raya-aarch64-macos.zip" | Select-Object Hash | ForEach-Object { ([string]$_.Hash) } | Out-File -Path v2raya-aarch64-macos-sha256.txt