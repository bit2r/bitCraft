# Quarto Craft 개발 계획

## Phase 1 — 프로젝트 기반 구축 ✅

- [x] 프로젝트 디렉토리 구조 생성
- [x] package.json, _quarto.yml, _extension.yml 설정
- [x] 디자인 토큰 생성 (colors, typography, spacing)
- [x] 컴포넌트 스타일 생성 (callout, table, code)
- [x] SCSS 빌드 시스템 구성 (@use/@forward 문법)
- [x] Quarto 전용 테마 파일 (quarto-theme.scss) 생성
- [x] 4종 템플릿 생성 (report, presentation, dashboard, book)
- [x] report 템플릿 렌더링 검증
- [x] Git 초기화 및 커밋

## Phase 2 — Agent 기반 전환 ✅

- [x] CLAUDE.md 작성 (프로젝트 가이드)
- [x] PLAN.md 작성 (개발 로드맵)
- [x] PROGRESS.md 작성 (진행 기록)
- [x] .claude/commands/ 생성 (build, preview, status)
- [x] .claude/skills/ 생성 (quarto-dev, scss-design-system)
- [x] tech_document/ 기술문서 정리

## Phase 3 — 템플릿 고도화

- [ ] report 템플릿: abstract, 참고문헌, 부록 지원
- [ ] presentation 템플릿: 커스텀 슬라이드 레이아웃
- [ ] dashboard 템플릿: 실제 데이터 연동 예시
- [ ] book 템플릿: 색인, 교차참조, 부록 구조

## Phase 4 — 디자인 시스템 확장

- [ ] 다크 모드 토큰 추가
- [ ] 추가 컴포넌트 (badge, card, sidebar, navbar)
- [ ] 반응형 타이포그래피 (viewport 기반)
- [ ] 색상 팔레트 변형 (warm, cool, monochrome)

## Phase 5 — Extension 패키징 & 배포

- [ ] Quarto extension 패키징 (`quarto install`)
- [ ] 샘플 갤러리 페이지 생성
- [ ] README 문서화
- [ ] GitHub 릴리즈

## 기술 결정

| 결정 | 선택 | 이유 |
|------|------|------|
| SCSS 문법 | `@use`/`@forward` | Dart Sass 3.0 호환, 네임스페이스 격리 |
| 타입 스케일 | Major Third (1.250) | 한국어 제목/본문 비율에 적합 |
| 본문 행간 | 1.75 | 한국어 가독성 최적 (영문 1.5 대비) |
| 본문 폰트 | Pretendard Variable | 한글 최적화 가변 폰트, CDN 서브셋 지원 |
| 코드 폰트 | JetBrains Mono | 리가처 지원, 한글 주석 호환 |
| 간격 단위 | 4px | 미세 조정 가능한 최소 단위 |
| Quarto 테마 | 레이어 분리 | Bootstrap 파이프라인 통합 필수 |
