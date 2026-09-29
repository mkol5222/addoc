# addoc

Source repo for the static document site hosted at
**https://addoc.klaud.online/** (Cloudflare Pages project `addoc`).

Each document is a single self-contained HTML file in `public/`, linked
from the landing page `public/index.html`. There is no build step —
what's in `public/` is deployed as-is.

## Layout

```
public/
  index.html                     # landing page with the list of documents
  ai-agent-101.html               # a document
  how-agents-talk-to-llms.html    # a document
  zaklady-openai-api.html         # a document
```

Cloudflare Pages serves clean URLs, so `public/my-doc.html` is reachable
at `https://addoc.klaud.online/my-doc`. Unknown paths fall back to
`index.html` (SPA fallback configured on the Pages project).

## Adding a new document

1. Add the new `public/<slug>.html` file (self-contained HTML/CSS, no
   external assets required).
2. Add a `<li><a class="card" href="<slug>">...</a></li>` entry to the
   list in `public/index.html`, matching the existing card style
   (title + short description).
3. Deploy (see below) and commit.

Ask your assistant to do steps 1–2 for you when you paste/describe a new
doc — it will also handle the index update.

## Deploying

Requires the Cloudflare Wrangler CLI and a logged-in account with access
to the `addoc` Pages project.

```bash
npx wrangler login          # only if not already authenticated
npx wrangler pages deploy public --project-name=addoc
```

## Local preview

```bash
npx wrangler pages dev public
```
