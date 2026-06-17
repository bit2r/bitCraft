# Quarto Craft 디자인 시스템 초기 구축

- **작업일**: 2026-03-30
- **커밋**: `7a01fde` (29 files, 3,329 lines)

---

## 1. 프로젝트 구조

```
quarto-craft/
├── _extensions/quarto-craft/     # Quarto extension
│   ├── _extension.yml
│   └── assets/quarto-craft.css
├── design-system/
│   ├── tokens/                   # 디자인 토큰
│   │   ├── _index.scss
│   │   ├── colors.scss
│   │   ├── typography.scss
│   │   └── spacing.scss
│   └── components/               # 재사용 컴포넌트
│       ├── _index.scss
│       ├── callout.scss
│       ├── table.scss
│       └── code.scss
├── scss/
│   ├── _variables.scss           # 토큰 → Bootstrap 변수 매핑
│   ├── _mixins.scss              # heading-style, text-style 등
│   ├── main.scss                 # 독립 빌드용 진입점 (@use 문법)
│   └── quarto-theme.scss         # Quarto 전용 테마 (레이어 경계 포함)
├── css/quarto-craft.css          # 컴파일된 CSS
├── templates/
│   ├── report/                   # 보고서
│   ├── presentation/             # RevealJS 슬라이드
│   ├── dashboard/                # 대시보드
│   └── book/                     # 책
├── _quarto.yml
└── package.json
```

## 2. 디자인 토큰

### 2.1 색상 (`colors.scss`)

| 카테고리 | 토큰 예시 | 값 |
|----------|-----------|-----|
| Primary | `$color-primary-600` | #4F46E5 (인디고) |
| Neutral | `$color-neutral-900` | #171717 |
| Semantic | `$color-success` | #10B981 |
| Text | `$color-text-primary` | $color-neutral-900 |
| Border | `$color-border-default` | $color-neutral-200 |
| Callout | `$color-callout-note` | $color-info |

### 2.2 타이포그래피 (`typography.scss`)

**폰트 패밀리**

| 용도 | 폰트 | 변수 |
|------|-------|------|
| 본문/UI | Pretendard Variable | `$font-family-sans` |
| 인용/강조 | Noto Serif KR | `$font-family-serif` |
| 코드 | JetBrains Mono | `$font-family-mono` |

**타입 스케일 (Major Third 1.250)**

| 토큰 | 크기 | 용도 |
|------|------|------|
| `$font-size-4xl` | 3.052rem (48.8px) | H1 |
| `$font-size-3xl` | 2.441rem (39px) | H2 |
| `$font-size-2xl` | 1.953rem (31.25px) | H3 |
| `$font-size-xl` | 1.563rem (25px) | H4 |
| `$font-size-lg` | 1.25rem (20px) | H5 |
| `$font-size-md` | 1.125rem (18px) | H6, lead text |
| `$font-size-base` | 1rem (16px) | 본문 |
| `$font-size-sm` | 0.8rem (12.8px) | caption, small |

**한국어 최적화 행간**

| 토큰 | 값 | 용도 |
|------|-----|------|
| `$line-height-tight` | 1.3 | 제목 |
| `$line-height-snug` | 1.5 | 부제목 |
| `$line-height-normal` | 1.75 | 본문 (한국어 최적) |
| `$line-height-relaxed` | 1.9 | 넓은 본문 |

**기타 한국어 설정**
- `word-break: keep-all` — 단어 단위 줄바꿈
- `letter-spacing: -0.02em` — 큰 제목용 자간 조정

### 2.3 간격 (`spacing.scss`)

- 4px 기반 (`$spacing-unit: 0.25rem`)
- `$spacing-1`(4px) ~ `$spacing-24`(96px)
- Border radius: `$radius-sm`(4px) ~ `$radius-xl`(16px)
- Shadow: `$shadow-sm`, `$shadow-md`, `$shadow-lg`

## 3. 컴포넌트

### 3.1 Callout (`callout.scss`)
- 5가지 변형: note, tip, warning, important, caution
- 왼쪽 4px 보더 + 배경색 5% 투명도
- 헤더 색상은 `color.adjust($lightness: -10%)`

### 3.2 Table (`table.scss`)
- 줄무늬 배경 (`tr:nth-child(even)`)
- 호버 시 `$color-primary-50` 배경
- thead uppercase + `$letter-spacing-wide`
- compact 변형 (`.table-compact`, `.table-sm`)

### 3.3 Code (`code.scss`)
- 인라인: `$color-primary-700` 텍스트 + `$color-bg-code` 배경
- 블록: `$radius-md` 둥근 모서리 + `$shadow-sm`
- `.code-with-filename` 파일명 표시
- `.cell-output` Quarto 계산 출력 스타일

## 4. SCSS 빌드 시스템

### 두 가지 SCSS 파일

| 파일 | 용도 | 문법 |
|------|------|------|
| `scss/main.scss` | 독립 CSS 빌드 (`npm run build`) | Dart Sass `@use`/`@forward` |
| `scss/quarto-theme.scss` | Quarto `theme:` 설정용 | Quarto 레이어 (`/*-- scss:defaults --*/`, `/*-- scss:rules --*/`) |

**빌드 차이점**: Quarto는 자체 SCSS 파이프라인(Bootstrap 통합)을 사용하므로 `@use` 모듈 시스템 대신 레이어 경계 마커가 필요했음. `/*-- scss:uses --*/` 섹션에서 `@use "sass:color"` 로드.

### NPM 스크립트

```bash
npm run build   # compressed, no source map
npm run dev     # expanded + source map
npm run watch   # 파일 변경 감지 자동 빌드
```

## 5. 템플릿

모든 템플릿의 `output-dir: docs`.

| 템플릿 | 타입 | 주요 설정 |
|--------|------|-----------|
| `templates/report/` | html | TOC, 번호 섹션, 마진 참조 |
| `templates/presentation/` | revealjs | 1600x900, fade 전환 |
| `templates/dashboard/` | dashboard | valuebox + matplotlib 차트 |
| `templates/book/` | book | HTML + PDF, 챕터 구조 |

## 6. 해결한 이슈

1. **Dart Sass `@import` 폐기 경고** → `@use`/`@forward` 문법으로 마이그레이션, 경고 0개 달성
2. **Quarto SCSS 레이어 경계 누락** → `quarto-theme.scss` 별도 생성, `/*-- scss:defaults --*/` + `/*-- scss:rules --*/` 레이어 분리
3. **`color.adjust` 네임스페이스 에러** → `/*-- scss:uses --*/` 섹션에 `@use "sass:color"` 추가
