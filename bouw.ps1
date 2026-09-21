# Bouwt de installeerbare versie (PWA) uit bron\equite-d4.html.
# Gebruik (PowerShell, in deze map):  powershell -ExecutionPolicy Bypass -File .\bouw.ps1
# Daarna staan index.html en sw.js klaar om te uploaden naar de hosting (GitHub Pages).

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)

$bron = [IO.File]::ReadAllText("$root\bron\equite-d4.html", $utf8)

# De bron is een "fragment" (zoals een Artifact): geen doctype/head/body. Hier komt de omhulling bij.
$kop = @'
<!doctype html>
<html lang="nl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="theme-color" content="#2F6F62">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<link rel="manifest" href="manifest.webmanifest">
<link rel="icon" type="image/png" href="icons/icon-192.png">
<link rel="apple-touch-icon" href="icons/icon-192.png">
<style>html{background:var(--paper,#121613);}</style>

'@

$staart = @'

<script>
if("serviceWorker" in navigator){
  window.addEventListener("load", function(){ navigator.serviceWorker.register("sw.js").catch(function(){}); });
}
</script>
</body>
</html>
'@

[IO.File]::WriteAllText("$root\index.html", $kop + $bron + $staart, $utf8)

$versie = "rooster-d4-" + (Get-Date -Format "yyyyMMdd-HHmmss")
$sw = [IO.File]::ReadAllText("$root\bron\sw-sjabloon.js", $utf8).Replace("__VERSIE__", $versie)
[IO.File]::WriteAllText("$root\sw.js", $sw, $utf8)

Write-Host "Klaar: index.html + sw.js gebouwd ($versie)."
