# deploy.ps1 - Commit tat ca thay doi va push len GitHub -> GitHub Pages tu dong rebuild
# Cach dung:  .\deploy.ps1  hoac  .\deploy.ps1 "Noi dung mo ta thay doi"
param(
    [string]$Message = ""
)

Set-Location -Path $PSScriptRoot

# Kiem tra co thay doi khong
$changes = git status --porcelain
if ([string]::IsNullOrWhiteSpace($changes)) {
    Write-Host "Khong co thay doi nao de deploy." -ForegroundColor Yellow
    exit 0
}

Write-Host "Cac file thay doi:" -ForegroundColor Cyan
git status --short

if ([string]::IsNullOrWhiteSpace($Message)) {
    $Message = "Cap nhat noi dung - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
}

git add -A
git commit -m $Message
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Deploy thanh cong! GitHub Pages se cap nhat sau 1-2 phut." -ForegroundColor Green
    Write-Host "Xem tai: https://hoanglong8.github.io/phaply_daoduc_AI/" -ForegroundColor Green
} else {
    Write-Host "Push that bai. Kiem tra ket noi mang / dang nhap GitHub." -ForegroundColor Red
}
