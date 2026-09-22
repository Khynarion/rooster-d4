# Bouwt de USB-/offline-versie: ÉÉN dubbelklikbaar bestand, zonder enige internetverbinding.
# Voor plaatsen waar het web geblokkeerd is (bv. door de IT-dienst): geen server nodig, geen
# installatie, gewoon openen vanaf een USB-stick, netwerkschijf of lokale map.
#
# Verschil met de gewone PWA-versie (bouw.ps1):
#  - Geen Google Fonts (die vragen een internetverbinding) — gebruikt in de plaats de lettertypes
#    die al op elke Windows-pc staan (Segoe UI / Consolas). Ziet er heel licht anders uit, werkt
#    verder identiek.
#  - Geen manifest.webmanifest en geen service worker — die hebben toch geen nut vanaf een lokaal
#    bestand (installeren als app en de "offline-cache" werken enkel via https/localhost).
#  - Het icoon zit als data ingebed in het bestand zelf (geen aparte icons-map nodig).
#
# Gebruik (PowerShell, in deze map):  powershell -ExecutionPolicy Bypass -File .\bouw-usb.ps1
# Resultaat: usb\Rooster-D4-USB.html — dat ene bestand is alles wat je moet kopiëren.

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)
New-Item -ItemType Directory -Force "$root\usb" | Out-Null

$bron = [IO.File]::ReadAllText("$root\bron\equite-d4.html", $utf8)

# 1) De 2 regels die lettertypes bij Google ophalen weghalen (enige externe verbinding in de tool).
$bron = $bron -replace '(?m)^<link rel="preconnect" href="https://fonts\.googleapis\.com">\r?\n', ''
$bron = $bron -replace '(?m)^<link rel="stylesheet" href="https://fonts\.googleapis\.com/css2\?[^"]*">\r?\n', ''

# 2) De lettertype-variabelen laten terugvallen op wat al op de pc staat, i.p.v. het (nu niet meer
#    geladen) Public Sans / JetBrains Mono — anders toont de browser zijn eigen standaardlettertype.
$bron = $bron -replace "--font-ui:'Public Sans', system-ui, -apple-system, sans-serif;", "--font-ui: system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif;"
$bron = $bron -replace "--font-mono:'JetBrains Mono', ui-monospace, 'SFMono-Regular', monospace;", "--font-mono: ui-monospace, 'Cascadia Mono', Consolas, 'SFMono-Regular', monospace;"

if($bron -match 'fonts\.googleapis|fonts\.gstatic'){ throw "Er staat nog een verwijzing naar Google Fonts in — dit bestand zou dan tóch een internetverbinding proberen te maken." }

$iconBytes = [IO.File]::ReadAllBytes("$root\icons\icon-192.png")
$iconB64 = [Convert]::ToBase64String($iconBytes)

$kop = @"
<!doctype html>
<html lang="nl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="theme-color" content="#2F6F62">
<link rel="icon" type="image/png" href="data:image/png;base64,$iconB64">
<style>html{background:var(--paper,#121613);}</style>
<!-- Rooster D4 — offline/USB-versie. Geen internetverbinding nodig: alle lettertypes en het icoon
     zitten in dit ene bestand. Gegevens blijven, zoals altijd, enkel in deze browser opgeslagen. -->

"@

$staart = @"

</body>
</html>
"@

[IO.File]::WriteAllText("$root\usb\Rooster-D4-USB.html", $kop + $bron + $staart, $utf8)
$grootte = [Math]::Round((Get-Item "$root\usb\Rooster-D4-USB.html").Length / 1KB, 0)
Write-Host "Klaar: usb\Rooster-D4-USB.html gebouwd ($grootte KB, één bestand, geen internetverbinding nodig)."
