$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$PortableNode = Join-Path $ProjectRoot ".tools\node-v22.16.0-win-x64"
$Npm = Join-Path $PortableNode "npm.cmd"

if (-not (Test-Path $Npm)) {
  throw "Portable npm was not found at $Npm. Install Node.js/npm or download the portable Node runtime first."
}

Set-Location $ProjectRoot
$env:PATH = "$PortableNode;$env:PATH"
$env:CSC_IDENTITY_AUTO_DISCOVERY = "false"

& $Npm install
& $Npm run electron:dist
