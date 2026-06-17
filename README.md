# Quarto Craft — Design System

> 한국어 문서에 최적화된 Quarto 디자인 시스템. Pretendard 가변 폰트, 인디고 브랜드 컬러, 4px 간격 시스템 기반의 리포트·프레젠테이션·대시보드·책 템플릿 패키지.

This design system is a recreation of [**`statkclee/quarto-craft`**](https://github.com/statkclee/quarto-craft) — an open-source Quarto theme + extension built for Korean-language scientific/technical publishing.

If you want richer source material than what's distilled here, browse the upstream repository directly:

- Repo: <https://github.com/statkclee/quarto-craft>
- Path notes:
  - `design-system/tokens/` — SCSS source tokens (colors / typography / spacing)
  - `design-system/components/` — SCSS partials for callout, table, code
  - `scss/quarto-theme.scss` — single-file Bootstrap/Quarto theme
  - `scss/quarto-revealjs.scss` — RevealJS slide theme
  - `templates/{report,presentation,dashboard,book,shiny-app,typst-pdf}` — Quarto starter projects
  - `tech_document/` — internal QA write-ups (v1 → v2.5 evaluation notes)

---

## Index — what's in this folder

| Path | What it is |
|------|-----------|
| `README.md` | You are here. Brand, content, visual foundations + iconography. |
| `SKILL.md` | Cross-compatible skill manifest. Read this if invoking the system in Claude Code. |
| `colors_and_type.css` | Single-file CSS distillation. All design tokens as CSS custom properties + base typography rules. **Drop this into any HTML to get the look.** |
| `assets/` | Logo SVGs (light / dark / text), favicon, icon guide. |
| `design-system/tokens/` | Source SCSS tokens — colors, typography, spacing. |
| `design-system/components/` | Source SCSS for callout / table / code components. |
| `scss/` | Full theme files. `quarto-theme.scss` (HTML) and `quarto-revealjs.scss` (slides) are the canonical themes. |
| `templates/` | Original Quarto `_quarto.yml` configs for each output type. |
| `preview/` | Design-system card specimens (typography, swatches, components). Registered for the Design System tab. |
| `ui_kits/quarto-report/` | High-fidelity HTML recreation of a Quarto report rendered with this theme. |
| `ui_kits/quarto-dashboard/` | High-fidelity HTML recreation of a Quarto dashboard. |
| `ui_kits/quarto-book/` | High-fidelity HTML recreation of a Quarto book chapter page. |
| `ui_kits/quarto-revealjs/` | High-fidelity HTML recreation of a RevealJS deck slide. |
| `slides/` | Sample slide layouts (title, section divider, content, code, table, thank-you). |

---

## What this system is for

The four core surfaces Quarto Craft was built to style:

| Surface | Format | Theme |
|--------|--------|-------|
| **Report** | `format: html` (cosmo + quarto-theme) | Long-form scientific docs |
| **Presentation** | `format: revealjs` (quarto-revealjs theme) | 1600×900 indigo slides |
| **Dashboard** | `format: dashboard` | Data app shell |
| **Book** | `format: html` (Quarto book project) | Multi-chapter HTML book |
| Plus | `shiny-app/` (bslib), `typst-pdf/` | Companion templates |

Every surface shares one token system. Change `--color-primary-600` and the whole stack moves with it.

---

## CONTENT FUNDAMENTALS

### Language

The system is **Korean-first**. All template metadata defaults to `lang: ko`, the TOC reads `목차`, dates render as `YYYY년 MM월 DD일`, and the type stack leads with **Pretendard Variable** — a Korean optimised variable font. English copy is supported but treated as a secondary register.

### Tone & voice

- **Polite-neutral, sentence form.** Documentation uses the `~다` / `합니다` declarative register, not casual `~야` / `~요`. From the upstream README: "한국어 문서에 최적화된 Quarto 디자인 시스템" — descriptive, no exclamation marks, no marketing puff.
- **Honest engineering log.** Internal progress is written as dated bullets ("Phase 1 완료", "타이틀 블록 리디자인"), not press releases. The team grades its own work numerically ("v1.0 평가 결과 29/50점") and keeps the failures visible.
- **No second-person address.** Docs describe the system, not the reader. There is no "you" or "당신" voice. Instructions are imperative ("`npm run build` 실행", "토큰 변수 사용") rather than conversational.
- **Bilingual tags are normal.** Section headers commonly pair a Korean phrase with an English technical term: "**디자인 토큰 체계**", "**한국어 최적화 (Korean optimization)**". Use both registers when the audience needs the English keyword for searchability.

### Casing & punctuation

- Korean prose has no case to enforce, but **English technical terms keep their canonical casing**: `SCSS`, `Bootstrap`, `Quarto`, `RevealJS`, `Pretendard`. Never lowercase brand names.
- Headings are **sentence case** (Korean has no concept here); subtitles add a colon, not a dash.
- Code paths and config keys go inside backticks: `_quarto.yml`, `@use`, `$color-primary-600`.
- Block emphasis uses bold (`**...**`); italics are reserved for English book/article titles in citations.

### Emoji

- **Limited, semantic.** A small approved set is documented in `assets/icons.md` and used as section markers in the templates (📊 dashboard, 📝 report, 🎨 design, 📖 book, ⚡ typst, 🔧 build). Treat these as *icons*, not punctuation.
- **Never decorative.** No 🎉 in headings, no 👉 in body copy, no emoji bullet lists.
- **Status emoji are OK in changelogs only.** ✅ / 🚧 / ❌ are used in `PROGRESS.md` for task state — that's the one place they appear inline with prose.

### Concrete examples

- ✅ "한국어 문서에 최적화된 Quarto 디자인 시스템." — clean, declarative, no fluff.
- ✅ "v2.5 평가 결과 37.5/50점 (+8.5)." — engineering log, numeric.
- ❌ "와! 이 디자인 시스템 정말 멋져요 🚀✨" — too casual, decorative emoji, exclamation.
- ❌ "You'll love this design system!" — second person, marketing.

---

## VISUAL FOUNDATIONS

### Color

- **Primary is a single indigo ramp** (10 steps, `#EEF2FF` → `#312E81`). The brand uses `--color-primary-600` (`#4F46E5`); accents pull from `-700` darker and `-100`/`-50` lighter.
- **Neutrals are pure greys** (Tailwind neutral, `#FAFAFA` → `#171717`). No warm or cool tint — this lets the indigo pop.
- **Semantic colors stand alone**: success `#10B981`, warning `#F59E0B`, error `#EF4444`, info `#3B82F6`, caution `#F97316`. They appear only on callouts, alerts, and dashboard `value_box` themes — never as accents in body copy.
- **No multi-hue gradients.** The one gradient in the system is `--color-primary-600 → --color-primary-400` (title block, logo, slide titles). Always indigo-to-indigo.
- **Backgrounds tier**: white (`#FFFFFF`) → neutral-50 (`#FAFAFA`) → code background (`#F4F5FA`, `#EEF0F6`). Each step gets ~3–5% lighter neutrals; cards lift on tier 1, code lives in tier 2.

### Typography

- **Body**: Pretendard Variable, 16px base, line-height **1.75** (deliberately taller than the 1.5 you'd use for Latin — Korean blocks need air).
- **Type scale**: Major Third (1.250 ratio). 9 steps from `--fs-xs` (10.24px) to `--fs-4xl` (48.8px).
- **Letter spacing**: tight (`-0.02em`) on big headlines, wider (`0.05em`) on eyebrows / uppercase labels.
- **`word-break: keep-all`** is set globally so Korean lines never split mid-syllable. This is non-negotiable.
- **Three font roles**: sans (Pretendard) for everything UI/body, serif (Noto Serif KR) reserved for blockquotes only, mono (JetBrains Mono) for code.

### Spacing

- **4px base unit**, scale `--space-1` (4px) through `--space-24` (96px). Section gaps use the `--section-gap-{sm,md,lg,xl}` aliases.
- Layout containers cap at `--content-default: 768px` for prose, `--content-wide: 1024px` for wider tables/figures.

### Backgrounds & imagery

- **No background images, no patterns, no textures.** The system is paper-flat — colour fills carry all expressive weight.
- **Full-bleed treatment is reserved for slide title/section dividers.** They take the indigo gradient corner-to-corner with white text.
- **No hand-drawn or illustrative imagery** in the source system. Figures are data plots only (matplotlib / ggplot rendered into the document via Quarto code cells).
- **Imagery, when added, should be cool-toned and high-contrast** to live next to the indigo. Avoid warm photos or sepia.

### Borders, radii & elevation

- **Radii**: `sm 4px`, `md 8px`, `lg 12px`, `xl 16px`, plus `full` (pill). Cards / pre blocks / callouts use `md`; title block uses `lg`.
- **Borders**: a hairline `1px solid --border-default` (`#E5E5E5`) is the default. Cards and `pre` use this; tables thicken the row separator to 2px `--color-primary-200` on the header only.
- **Shadows are subtle and layered**, modelled on Tailwind:
  - `--shadow-sm` — flat ID cards, code blocks
  - `--shadow-md` — interactive cards
  - `--shadow-lg` — overlays, popovers
  - `--shadow-xl` — modals
  Inner shadows are not used.
- **Accent borders, not full-fill cards.** Callouts use a `4px` coloured left border + 5% colour tint background. Abstract blocks use the same pattern in indigo. No card has a coloured top stripe or a full coloured fill.

### Animation & micro-interactions

- **Transitions are tiny.** Standard duration `0.15s ease` (link hover, table row hover). Nothing longer; no spring physics; no bounces.
- **Hover state on links**: darker colour (`primary-600` → `primary-700`) + underline.
- **Hover state on table rows**: row background flips to `--color-primary-50`.
- **Press / active states**: not explicitly themed — relies on Bootstrap defaults (slightly darker). Buttons in the UI kit follow the same pattern.
- **Slide transition**: `fade` (RevealJS), never slide-in/zoom/cube.

### Layout rules

- **Reading column ≈ 768px** for report long-form prose.
- **Title block is full-width inside the column** with the indigo gradient + bottom border accent.
- **TOC** is a sidebar at small size (`--fs-sm`), greyed out (`--fg-secondary`); active section flips to `primary-600` semibold.
- **Tables are 100% width** of the column, with `font-variant-numeric: tabular-nums` for any numeric column.

### Transparency & blur

- **No frosted glass / backdrop-filter effects.** Backgrounds are solid.
- **Two places use alpha**:
  1. Callout backgrounds — semantic colour at `0.05` opacity over white.
  2. Title block metadata card — `rgba(255, 255, 255, 0.6)` for the white card-on-gradient.
- That's it. Otherwise everything is solid.

### Cards

A "card" in this system is: white background, `--radius-md` corners, `1px` neutral border, `--shadow-sm`. That's it. No coloured top stripe, no coloured left border accent, no rotation, no hover-lift.

---

## ICONOGRAPHY

The system uses **Bootstrap Icons** (`bi-*`) as its primary glyph set — they're bundled with every Quarto HTML output, so no additional load. The source repo documents the working subset in `assets/icons.md`.

### Conventions

- **Icon font** (Bootstrap Icons via Quarto shortcode `{{< bi name >}}`) is the default. No SVG sprites, no PNG icons.
- **Stroke style**: Bootstrap Icons mix line + solid variants. The system uses **line variants** (`bi-file-earmark-text`, `bi-easel`, `bi-book`) for navigation, and **solid variants** for emphasis (avoid mixing in the same row).
- **Sizing**: icons inherit text size. Pair with `var(--fs-sm)` for inline labels and `var(--fs-lg)` for nav.
- **Color**: icons inherit `currentColor`. Default `--fg-secondary`; active state flips to `--color-primary-600`.
- **No custom SVG illustrations.** The only project-drawn vectors are the logo set (`assets/logo*.svg`, `assets/favicon.svg`), which use the indigo gradient + a "Q magnifier" mark with a 45°-rotated diamond inside.
- **Emoji**: a controlled set per `assets/icons.md` for section markers in templates. Not used decoratively in prose.
- **Unicode icons**: not used. Always go through Bootstrap Icons.

### When you need an icon that isn't in Bootstrap Icons

Find the closest `bi-*` first; if missing, use a **Lucide** equivalent at matching stroke weight (1.5px) and flag the substitution in your output. Do not draw a new SVG.

### Logos

- `assets/logo.svg` — primary mark (light bg). Indigo gradient (`#4F46E5 → #818CF8`), rounded square, white "Q" magnifier mark, 45°-rotated diamond inside.
- `assets/logo-dark.svg` — same mark on a darker gradient (`#312E81 → #4F46E5`) for dark surfaces.
- `assets/logo-text.svg` — horizontal lockup: mark + wordmark ("Quarto" black, "Craft" indigo).
- `assets/favicon.svg` — 32×32 simplified version.

---

## Caveats / substitutions

- **Font files**: the upstream system loads **Pretendard Variable** and **Noto Serif KR** and **JetBrains Mono** from CDNs (`cdn.jsdelivr.net`, Google Fonts). No `.ttf`/`.woff` files are vendored in. The CSS in this folder mirrors those imports. If you need offline-only output, download the variable font from <https://github.com/orioncactus/pretendard> and Noto Serif KR / JetBrains Mono from Google Fonts and place them in `fonts/`.
- **Icon set**: Bootstrap Icons is assumed via Quarto's built-in shortcode pipeline. The HTML recreations in `ui_kits/` reference the same set via the official CDN.
