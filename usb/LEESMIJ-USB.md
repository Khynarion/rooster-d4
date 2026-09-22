# Rooster D4 — USB-/offline-versie

**`Rooster-D4-USB.html` is het enige bestand dat je nodig hebt.** Alles zit erin: geen internetverbinding,
geen installatie, geen server. Bedoeld voor plaatsen waar het gewone web geblokkeerd is (bv. door een
IT-dienst) of waar je gewoon liever niets installeert.

## Gebruiken

1. Kopieer `Rooster-D4-USB.html` naar een USB-stick, een netwerkschijf, of gewoon een map op de pc.
2. Dubbelklik het bestand. Het opent in je standaardbrowser (Chrome, Edge, Firefox).
3. Klaar — de tool werkt volledig, ook zonder internet.

## Wat is er anders dan de gewone (online) versie?

- **Geen Google Fonts.** De online versie laadt 2 lettertypes bij Google; die verbinding is hier
  weggelaten. In de plaats gebruikt de tool de lettertypes die al op de pc staan (Segoe UI / Consolas
  op Windows). Ziet er heel licht anders uit, werkt verder identiek.
- **Geen "installeren als app"-knop en geen offline-cache-mechanisme** (dat heeft toch geen nut vanaf
  een lokaal bestand — die functies werken enkel via een echte website-adres).
- Verder exact dezelfde tool, met exact dezelfde functies.

## Gegevens

Precies zoals bij de andere versies: alles wat je invult blijft **in de browser waarin je het bestand
opende**, op dát apparaat. Een kopie van het bestand op een andere pc, of een andere browser op dezelfde
pc, start met een lege lijst. Gebruik "Team & clusters → Instellingen overzetten" om gegevens over te
zetten (zie de uitleg in de tool zelf, tab 7).

**Let op bij een USB-stick**: als je het bestand elke keer van de stick zelf opent (niet gekopieerd naar
de pc), hangen je gegevens af van welke pc/browser je gebruikt op dat moment — niet van de stick. De
stick bevat enkel het programma, niet je ingevulde rooster.

## Bijwerken naar een nieuwe versie

Vraag een nieuwe `Rooster-D4-USB.html` (of laat ze bouwen met `bouw-usb.ps1` in de hoofdmap, na een
wijziging in `bron\equite-d4.html`) en vervang gewoon het oude bestand. Je gegevens blijven staan — die
zitten in de browser, niet in dit bestand.
