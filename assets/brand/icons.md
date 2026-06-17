# Quarto Craft 아이콘 & 로고 가이드

## 로고 파일

| 파일 | 용도 | 크기 |
|------|------|------|
| `logo.svg` | 기본 로고 (인디고 그라데이션) | 512x512 |
| `logo-dark.svg` | 다크 모드 로고 | 512x512 |
| `logo-text.svg` | 로고 + 텍스트 조합 | 320x80 |
| `favicon.svg` | 브라우저 파비콘 | 32x32 |

## 로고 구성

- **Q 심볼**: Quarto의 Q를 원형 + 검색 돋보기 스타일로 표현
- **다이아몬드**: 중앙에 45도 회전 사각형 — "Craft" 정밀 공예 의미
- **그라데이션**: `$color-primary-600` (#4F46E5) → `$color-primary-400` (#818CF8)

## 권장 아이콘 세트

프로젝트 전반에서 [Bootstrap Icons](https://icons.getbootstrap.com/)를 사용합니다.
Quarto HTML 출력에 기본 포함되어 별도 설치 불필요.

### 자주 사용하는 아이콘

| 아이콘 | 코드 | 용도 |
|--------|------|------|
| {{< bi file-earmark-text >}} | `bi-file-earmark-text` | 문서/보고서 |
| {{< bi easel >}} | `bi-easel` | 프레젠테이션 |
| {{< bi speedometer2 >}} | `bi-speedometer2` | 대시보드 |
| {{< bi book >}} | `bi-book` | 책 |
| {{< bi filetype-pdf >}} | `bi-filetype-pdf` | PDF |
| {{< bi code-slash >}} | `bi-code-slash` | 코드 |
| {{< bi palette >}} | `bi-palette` | 디자인/테마 |
| {{< bi fonts >}} | `bi-fonts` | 타이포그래피 |

## 이모지 사용 규칙

템플릿과 문서에서 이모지를 사용할 경우:

| 이모지 | 의미 | 사용 위치 |
|--------|------|-----------|
| 📊 | 데이터/차트 | Dashboard, 분석 |
| 📝 | 문서/보고서 | Report |
| 🎨 | 디자인/스타일 | 디자인 시스템 |
| 📖 | 책/가이드 | Book |
| 🖥️ | 프레젠테이션 | Presentation |
| ⚡ | 빠른/성능 | Typst |
| 🔧 | 설정/도구 | 빌드, 설정 |
