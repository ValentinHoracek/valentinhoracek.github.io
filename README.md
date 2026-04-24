# Valentin Horacek Website

This repository contains:

1. A root landing page focused on Systems and Performance.
2. A Hugo blog published under `/blog`.

## Current Site Structure

1. Landing page entry point: [index.html](index.html)
2. Blog shell template: [blog/layouts/_default/baseof.html](blog/layouts/_default/baseof.html)
3. Blog list template: [blog/layouts/_default/list.html](blog/layouts/_default/list.html)
4. Blog post template: [blog/layouts/_default/single.html](blog/layouts/_default/single.html)
5. Blog navigation partial: [blog/layouts/partials/docs-nav.html](blog/layouts/partials/docs-nav.html)
6. Blog table-of-contents partial: [blog/layouts/partials/docs-toc.html](blog/layouts/partials/docs-toc.html)

The blog layout is a 3-column structure:

1. Left: post navigation grouped by year
2. Center: article/list reading surface
3. Right: in-page table of contents

## Styling and Source of Truth

SCSS is the source of truth.

Primary page styles:

1. Home page styles: [scss/4-Pages/_Home.scss](scss/4-Pages/_Home.scss)
2. Blog page styles: [scss/4-Pages/_Blog.scss](scss/4-Pages/_Blog.scss)

SCSS architecture:

1. Utilities: [scss/0-Utils](scss/0-Utils)
2. Tools: [scss/1-Tools](scss/1-Tools)
3. Base: [scss/2-Base](scss/2-Base)
4. Modules: [scss/3-Modules](scss/3-Modules)
5. Pages: [scss/4-Pages](scss/4-Pages)

Runtime CSS used by pages:

1. Landing page uses [css/Main.min.css](css/Main.min.css)
2. Blog uses [css/Main.min.css](css/Main.min.css)

Generated files:

1. Source-compiled CSS: [css/Main.css](css/Main.css)
2. Minified CSS: [css/Main.min.css](css/Main.min.css)

## Theme Behavior

The blog theme toggle is CSS-only (no JavaScript).

1. Default follows `prefers-color-scheme`
2. Manual override is done with the checkbox in [blog/layouts/_default/baseof.html](blog/layouts/_default/baseof.html)
3. Theme logic is implemented in [scss/4-Pages/_Blog.scss](scss/4-Pages/_Blog.scss)

## Content Structure

Blog content root:

1. [blog/content/posts](blog/content/posts)

Current year folder:

1. [blog/content/posts/2026](blog/content/posts/2026)

Recommended post structure:

1. `blog/content/posts/YYYY/post_name/index.md`

## Local Preview Scripts

Use these scripts from [scripts](scripts):

1. Build static preview payload: [scripts/build-blog-preview.ps1](scripts/build-blog-preview.ps1)
2. Start local preview server: [scripts/start-blog-preview.ps1](scripts/start-blog-preview.ps1)

Preview output directory:

1. [dist](dist)

## Deployment

GitHub Pages deployment is defined in [/.github/workflows/hugo.yml](.github/workflows/hugo.yml):

1. Hugo builds blog content into `dist/blog`
2. Root landing assets are copied into `dist`
3. Final site is published to `gh-pages`

Published paths:

1. Landing page at `/`
2. Blog at `/blog/`