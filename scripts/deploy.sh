#!/usr/bin/env bash
# Stamps public/index.html with the current UTC timestamp and short
# commit id into a throwaway dist/ folder, then deploys dist/ to the
# addoc Cloudflare Pages project.
set -euo pipefail

cd "$(dirname "$0")/.."

BUILD_TIME="$(date -u +"%Y-%m-%d %H:%M UTC")"
BUILD_COMMIT="$(git rev-parse --short HEAD)"

rm -rf dist
cp -R public dist

# macOS/BSD sed requires -i '' ; GNU sed requires -i (no arg). Handle both.
if sed --version >/dev/null 2>&1; then
  SED_INPLACE=(-i)
else
  SED_INPLACE=(-i '')
fi

sed "${SED_INPLACE[@]}" \
  -e "s/{{BUILD_TIME}}/${BUILD_TIME}/" \
  -e "s/{{BUILD_COMMIT}}/${BUILD_COMMIT}/" \
  dist/index.html

npx --yes wrangler@4.141.0 pages deploy dist --project-name=addoc "$@"
