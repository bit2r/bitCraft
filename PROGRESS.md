# Quarto Craft 진행 기록

---

## 2026-03-30 — Phase 1 완료 + Phase 2 진행

### 완료 항목

- [x] 프로젝트 디렉토리 구조 생성
- [x] 디자인 토큰: colors.scss, typography.scss, spacing.scss
- [x] 컴포넌트: callout.scss, table.scss, code.scss
- [x] SCSS 빌드 시스템: main.scss (@use/@forward), _variables.scss, _mixins.scss
- [x] Quarto 전용 테마: quarto-theme.scss (레이어 경계 + scss:uses)
- [x] 4종 템플릿: report, presentation, dashboard, book
- [x] report 렌더링 검증 → docs/index.html 정상 출력
- [x] Git 초기 커밋: `7a01fde`
- [x] 기술문서: `tech_document/2026-03-30_quarto-craft-디자인시스템-초기구축.md`
- [x] Agent 기반 전환: CLAUDE.md, PLAN.md, PROGRESS.md, commands, skills

### 해결한 이슈

1. Dart Sass `@import` 폐기 경고 → `@use`/`@forward` 마이그레이션
2. Quarto SCSS 레이어 경계 누락 → `quarto-theme.scss` 별도 생성
3. `color.adjust` 네임스페이스 에러 → `/*-- scss:uses --*/` 섹션 추가

---

## 2026-03-30 — v1.0 평가 및 v2.0 개선

### v1.0 평가 결과 (29/50점)

브라우저에서 5개 템플릿 스크린샷 기반 평가 실시.
주요 문제: 타이틀 블록 밋밋함, 인라인 코드 보더 과함, Dashboard 차트 깨짐, 코드 배경 구분 약함.

### v2.0 개선 항목

- [x] 타이틀 블록 리디자인: primary-50 그라데이션 배경 + primary-500 하단 보더
- [x] abstract 영역: 배경색 + 좌측 primary-400 보더
- [x] H2 하단 primary-100 구분선 + 섹션 간격 확대 (3rem)
- [x] 인라인 코드: 보더 제거, 배경색 #EEF0F6로 강화
- [x] 코드 블록: 배경 #F4F5FA로 구분 강화
- [x] 표 헤더: neutral-50 배경색, primary-200 하단 보더
- [x] 표 캡션: font-weight medium + italic
- [x] Dashboard: matplotlib 반환값 억제 (`_ =`), 도넛 차트 변환
- [x] Book: 서문 번호 체계 수정 (number-sections: false)
- [x] evaluate 커맨드 추가
- [x] 기술문서: `2026-03-30_문서품질평가-v1.0.md`

---

## 2026-03-30 — v2.0 평가 및 v2.5 개선

### v2.0 평가 결과 (37.5/50점, +8.5)

타이틀 블록/코드/표 대폭 개선 확인. Presentation 브랜딩 부재가 최대 이슈.

### v2.5 개선 항목

- [x] Presentation 전용 테마 (quarto-revealjs.scss) 분리
- [x] 타이틀 슬라이드: 인디고 그라데이션 배경 + 흰색 텍스트
- [x] 컨텐츠 슬라이드: H2 인디고색 + 구분선, 코드/표 스타일
- [x] 마지막 슬라이드: 중앙 정렬 + 인디고 컬러
- [x] 하단 진행 바 + 슬라이드 번호 스타일링
- [x] 메타데이터 타이틀 블록 내부 배치 (반투명 배경 카드)
- [x] 타이틀-abstract 간격 축소
- [x] Shiny app 템플릿 추가 (bslib + 디자인 토큰 매핑)
- [x] 기술문서: `2026-03-30_문서품질평가-v2.0.md`

### 다음 작업

- [ ] Typst PDF 타이틀 페이지 디자인
- [ ] 다크 모드 토큰
- [ ] Shiny app 실행 검증

---

## 2026-06-17 — GOTCHA 조판 함정 문서화 + typst-pdf 표본 반영

### 완료 항목

- [x] `GOTCHA.md` 신설 — pansei 발행 GOTCHA 를 디자인 시스템 관점으로 적응(선거·지도·ES 등 고유 항목 제외, Typst·한국어·타이포그래피 일반 함정 12개로 재번호). 체크리스트는 `templates/*` 경로로 재작성
- [x] typst-pdf 표본(`templates/typst-pdf/index.qmd`)에 **한글 어절 보호** `#show` 규칙 적용 → 베이스라인에서 실측된 "수준의" 어절 중간 끊김 해소
- [x] PDF 이미지 시각 검증(`pdftoppm`) — 어절 보호·수식·표·코드 정상 확인

### 해결한 이슈

1. Typst `lang: ko` 기본 CJK 줄바꿈이 한글을 글자 단위로 끊음(조사 분리) → 한글 포함 토큰 box 규칙으로 어절 보호
2. **pansei 원본의 전역 `#show regex("\S+"): box` 가 수식 원자 간격까지 깨뜨림**(`f(x)` → `f ( x )`) 발견 → 셀렉터를 한글 포함 토큰 `\S*[가-힣]\S*` 로 한정해 수식·코드·영문 보존 (GOTCHA §6)
3. §7 한글 이탤릭 점검 grep 이 `**굵게**` 오탐 → PCRE lookaround `(?<!\*)…(?!\*)` 로 단일 별표만 매치하도록 개선

### 추가 정정 (폰트 깨짐 보고 대응)

4. **Pretendard 미설치 → 한글 붓글씨 폴백**: 이 맥에 브랜드 본문 폰트 Pretendard 가 없어 PDF 한글이 Nanum Brush 류로 깨짐(렌더는 `unknown font` warning 만 내고 에러 없음). `brew install --cask font-pretendard` 로 설치 → 재렌더 정상. GOTCHA §6b 신규 문서화
5. **어절 보호 `#show` 위치 정정**: 본문 raw 블록에 두면 *앞*에 렌더되는 초록(abstract)·제목·TOC 에 미적용 → 초록 "컴파일"이 "컴파"/"일"로 끊김(설치 후 발견). `_quarto.yml` 의 `include-in-header` 로 올려 문서 전역 적용. GOTCHA §6 정정

### 비고

- quarto-craft 는 공유 Typst 테마가 없음(SCSS 레이어는 HTML/RevealJS 전용). 표본에 적용한 규칙은 다른 6종 템플릿으로 자동 전파되지 않음 → 시스템 전역 적용은 재사용 가능한 Typst partial 도입이 후속 과제
- §9(list/table leading) 수치는 pansei 기준값이라 미적용. 다줄 항목·긴 셀 추가 시 quarto-craft `linestretch`/line-height 에 맞춰 도입

### 다음 작업

- [ ] 재사용 Typst partial(`typst-template`/`brand-typst`)로 한글 조판 기본값 시스템 전역화
- [ ] Typst PDF 타이틀 페이지 디자인

---

## 로그 형식

```markdown
## YYYY-MM-DD — Phase N: 작업 설명

### 완료 항목
- [x] 작업 내용

### 해결한 이슈
1. 문제 → 해결 방법

### 다음 작업
- [ ] 예정 작업
```
