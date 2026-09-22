# Rooster D4 — installeerbare versie (PWA)

Dienstlijst maker OK AZ Vesalius. Alle gegevens (personeel, roosters, wensen, uren) blijven in de browser van de
gebruiker — er staat niets op de server.

## Inhoud van deze map

| Bestand | Wat het is |
|---|---|
| `index.html` | de tool zelf (gebouwd uit `bron/equite-d4.html`) |
| `manifest.webmanifest` | naam, icoon en kleuren van de app |
| `sw.js` | zorgt dat de tool ook zonder internet opent (gebouwd door `bouw.ps1`) |
| `icons/` | app-iconen |
| `bron/` | de bewerkbare bron van de tool en het sjabloon van `sw.js` |
| `bouw.ps1` | bouwt `index.html` en `sw.js` opnieuw na een wijziging in `bron/` |

## Online zetten met GitHub Pages

1. Maak op github.com een nieuwe **lege** repository (bv. `rooster-d4`), zonder README.
2. Upload de bestanden van deze map (Add file → Upload files): `index.html`, `manifest.webmanifest`, `sw.js`,
   de map `icons` en, als je wil, `bron`, `bouw.ps1` en dit bestand.
3. Repository → Settings → Pages → *Deploy from a branch* → branch `main`, map `/ (root)` → Save.
4. Na ± 1 minuut staat de tool op `https://<gebruikersnaam>.github.io/rooster-d4/`.

## Installeren als app

Open het adres in Chrome of Edge → in de adresbalk verschijnt een installatie-icoon (of menu → *Installeren* /
*App installeren*). Daarna staat er een icoon op het bureaublad en opent de tool in een eigen venster.

## Gegevens meenemen naar de installeerbare versie

Elk adres heeft zijn eigen opslag: de installeerbare versie start dus leeg. Zet je gegevens over met
**Team & clusters → Instellingen overzetten**: vink in de oude versie "Volledige back-up" aan, exporteer, kopieer de
tekst, en plak ze in de nieuwe versie bij "Instellingen importeren".

## Geen internet toegelaten? De USB-/offline-versie

Is het web geblokkeerd (bv. door een IT-dienst)? Gebruik dan `usb\Rooster-D4-USB.html` — één bestand
zonder enige internetverbinding, te openen vanaf een USB-stick, netwerkschijf of gewoon een map op de
pc. Zie `usb\LEESMIJ-USB.md`. Bouwen/bijwerken: `powershell -ExecutionPolicy Bypass -File .\bouw-usb.ps1`.

## Bijwerken na een wijziging

1. Vervang `bron/equite-d4.html` door de nieuwe versie.
2. Voer uit: `powershell -ExecutionPolicy Bypass -File .\bouw.ps1`
3. Upload `index.html` en `sw.js` opnieuw naar GitHub. Wie de app opent krijgt de nieuwe versie automatisch
   (de app kijkt eerst online en valt pas terug op de opgeslagen kopie als er geen internet is).
