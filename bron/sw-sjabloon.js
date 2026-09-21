/* Service worker van Rooster D4 — zorgt dat de tool ook zonder internet opent.
   Gegenereerd door bouw.ps1: de regel met VERSIE wordt bij elke bouw vervangen, zodat een nieuwe
   versie van de tool de oude cache automatisch opruimt. */
const VERSIE = "__VERSIE__";
const KERN = ["./", "index.html", "manifest.webmanifest", "icons/icon-192.png", "icons/icon-512.png", "icons/icon-maskable-512.png"];

self.addEventListener("install", function(e){
  e.waitUntil(caches.open(VERSIE).then(function(c){ return c.addAll(KERN); }).then(function(){ return self.skipWaiting(); }));
});

self.addEventListener("activate", function(e){
  e.waitUntil(
    caches.keys().then(function(keys){
      return Promise.all(keys.filter(function(k){ return k !== VERSIE; }).map(function(k){ return caches.delete(k); }));
    }).then(function(){ return self.clients.claim(); })
  );
});

self.addEventListener("fetch", function(e){
  var req = e.request;
  if(req.method !== "GET") return;
  var url = new URL(req.url);

  // De pagina zelf: eerst het netwerk (zo komt een nieuwe versie meteen binnen), anders de cache.
  if(req.mode === "navigate"){
    e.respondWith(
      fetch(req).then(function(res){
        var kopie = res.clone();
        caches.open(VERSIE).then(function(c){ c.put("index.html", kopie); });
        return res;
      }).catch(function(){ return caches.match("index.html"); })
    );
    return;
  }

  // Lettertypes van Google en andere bestanden: uit de cache tonen en op de achtergrond verversen.
  if(url.origin === self.location.origin || url.hostname === "fonts.googleapis.com" || url.hostname === "fonts.gstatic.com"){
    e.respondWith(
      caches.open(VERSIE).then(function(c){
        return c.match(req).then(function(hit){
          var netwerk = fetch(req).then(function(res){
            if(res && (res.ok || res.type === "opaque")) c.put(req, res.clone());
            return res;
          }).catch(function(){ return hit; });
          return hit || netwerk;
        });
      })
    );
  }
});
