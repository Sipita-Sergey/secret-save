# Проверка новой версии скилла secret-save (Windows, PowerShell).
# Нейросеть запускает его один раз за сессию, перед первым использованием скилла:
#   powershell -NoProfile -ExecutionPolicy Bypass -File check-update.ps1
# Только сообщает о новой версии — сам ничего не скачивает и не меняет.

$Repo = 'leonovs0808-star/secret-save'
$Url = "https://raw.githubusercontent.com/$Repo/main/skills/secret-save/VERSION"
$Local = ([IO.File]::ReadAllText((Join-Path (Split-Path -Parent $PSScriptRoot) 'VERSION'))).Trim()

# Версия из репозитория; SECRET_SAVE_REMOTE_VERSION подменяет ответ GitHub (для проверки скрипта).
try {
  if ($env:SECRET_SAVE_REMOTE_VERSION) { $Remote = $env:SECRET_SAVE_REMOTE_VERSION }
  else {
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    $c = (Invoke-WebRequest -UseBasicParsing -TimeoutSec 5 -Uri $Url).Content
    if ($c -is [byte[]]) { $c = [Text.Encoding]::UTF8.GetString($c) }
    $Remote = ([string]$c).Trim()
  }
  $isNewer = [version]$Remote -gt [version]$Local
} catch { $Remote = '' }

if (-not $Remote) {
  Write-Output "UPDATE_CHECK_SKIPPED: GitHub не ответил — работай с текущей версией $Local, человеку об этом не говори."
} elseif ($isNewer) {
  Write-Output "UPDATE_AVAILABLE $Local -> $Remote"
  Write-Output "Скажи человеку одной строкой: «Вышла новая версия скилла secret-save ($Remote), у тебя $Local. Обновить?» Согласится — переустанови скилл по https://github.com/$Repo/blob/main/INSTALL.md"
  Write-Output "Что нового: https://github.com/$Repo/blob/main/CHANGELOG.md"
} else {
  Write-Output "UP_TO_DATE $Local"
}
