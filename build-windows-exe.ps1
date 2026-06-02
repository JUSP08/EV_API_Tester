$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectRoot

function Resolve-Python {
  $codexPython = Join-Path $env:USERPROFILE ".cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"
  if (Test-Path $codexPython) {
    return $codexPython
  }

  $python = Get-Command python.exe -ErrorAction SilentlyContinue
  if ($python) {
    return $python.Source
  }

  throw "Python was not found."
}

$Python = Resolve-Python
& $Python -m pip install -r requirements-dev.txt
& $Python -m PyInstaller `
  --noconfirm `
  --clean `
  --name "EV API Tester" `
  --add-data "index.html;." `
  --add-data "app.js;." `
  --add-data "styles.css;." `
  --add-data "server.py;." `
  ev_api_tester.py

Write-Host ""
Write-Host "Built executable at:"
Write-Host "$ProjectRoot\dist\EV API Tester\EV API Tester.exe"
