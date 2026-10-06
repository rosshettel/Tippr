// Offline support: serve the app from cache, refreshing the cache in the background.
const CACHE = 'tippr-v2';
const SHELL = [
  './',
  './index.html',
  './manifest.webmanifest',
  './icons/apple-touch-icon.png',
  './icons/icon-192.png',
  './icons/icon-512.png',
];

// The app's own files, plus the Geist fonts from Google Fonts.
const CACHED_ORIGINS = [self.location.origin, 'https://fonts.googleapis.com', 'https://fonts.gstatic.com'];

self.addEventListener('install', event => {
  event.waitUntil(caches.open(CACHE).then(cache => cache.addAll(SHELL)));
  self.skipWaiting();
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', event => {
  const req = event.request;
  if (req.method !== 'GET' || !CACHED_ORIGINS.includes(new URL(req.url).origin)) return;

  // Stale-while-revalidate: answer from cache right away, update it for next launch.
  const fresh = caches.open(CACHE).then(cache =>
    fetch(req)
      .then(res => {
        if (res.ok) cache.put(req, res.clone());
        return res;
      })
      .catch(() => undefined)
  );
  event.waitUntil(fresh);
  event.respondWith(
    caches.match(req, { ignoreSearch: true }).then(cached =>
      cached || fresh.then(res => res || Response.error())
    )
  );
});
