# index-reader (Fly.io static site)

A minimal static site: one `index.html` served by nginx on Alpine.
No JavaScript logic, no external requests, no redirects.

## Files

| File | Purpose |
|------|---------|
| `index.html` | The page that is served. |
| `nginx.conf` | nginx server block — listens on 8080, static files only. |
| `Dockerfile` | `nginx:1.27-alpine`, copies the two files above. |
| `fly.toml` | Fly app config (port 8080, auto-stop, 256 MB). |

## Deploy

```bash
# Install the CLI if needed
curl -L https://fly.io/install.sh | sh

fly auth login

# First time: pick a globally-unique app name and skip the auto-deploy
fly launch --no-deploy

# Ship it
fly deploy

fly open
```

## Notes

- `app = "index-reader"` in `fly.toml` must be globally unique. `fly launch`
  will offer to rename it if the name is taken.
- Change `primary_region` if you want a different one (`fly platform regions`
  lists them).
- The container serves on port 8080; Fly's proxy terminates TLS and forwards
  `force_https` traffic to it.
- To edit the page: change `index.html` and run `fly deploy` again.

## Local test (no Docker needed)

```bash
cd fly-index-reader
python3 -m http.server 8099
# open http://127.0.0.1:8099
```

That serves the same `index.html` exactly as nginx will, minus the security
headers and the 8080 port.
