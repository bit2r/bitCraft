# koreandoc

한국어 Typst 조판을 위한 Quarto 포맷 확장. `format: koreandoc-typst` 한 줄로 한국어 PDF
조판에 필요한 것 — **받침 기반 자동 조사(助詞)**, 어절 보호, 한글↔라틴 간격, 한국어 레이블 —
이 한 번에 켜진다.

ko.TeX/oblivoir(LaTeX `memoir` + `kotex-utf`)가 오랫동안 맡아 온 한국어 조판 경험을,
LaTeX 매크로가 아닌 Typst 네이티브로 다시 구현했다.

## 특징

- **자동 조사** — 앞말의 받침을 읽어 은/는·이/가·을/를·과/와·(으)로를 자동 선택. 한글뿐 아니라
  숫자·라틴 끝글자도 한국어 발음으로 판정한다(ko.TeX 의 `josa_code` 테이블 이식).
- **어절 보호** — 한글 어절이 글자 단위로 끊기지 않게 묶는다(수식은 건드리지 않음).
- **한글↔라틴 간격** · **한국어 레이블**(그림·표·목차) — Typst 코어 `lang: ko` 활용.
- **인용문 명조**(Noto Serif KR) · **TeX/LaTeX 로고** 자형.

## 설치

```bash
quarto add statkclee/bitCraft
```

## 사용

문서 front matter 또는 `_quarto.yml` 에:

```yaml
format: koreandoc-typst
```

자동 조사는 인라인 raw typst 로 호출한다:

```markdown
`#eul-reul("책")`{=typst} 펴고 `#euro("서울")`{=typst} 간다.
```

→ "책을 펴고 서울로 간다."

### 조사 헬퍼 함수

| 함수 | 조사 | 예 |
|---|---|---|
| `josa(말, 받침형, 무받침형)` | (코어) | — |
| `eun-neun` | 은/는 | `#eun-neun("학생")` → 학생은 |
| `i-ga` | 이/가 | `#i-ga("친구")` → 친구가 |
| `eul-reul` | 을/를 | `#eul-reul("책")` → 책을 |
| `gwa-wa` | 과/와 | `#gwa-wa("산")` → 산과 |
| `euro` | (으)로 | `#euro("서울")` → 서울로 |

그 밖에 `a-ya`(아/야)·`i-na`((이)나)·`i-ra`((이)라)·`i-yeo`((이)여).

**숫자**: 0·3·6→받침, 1·7·8→ㄹ, 2·4·5·9→무받침. **라틴**: l→ㄹ, m·n→받침, 그 외→무받침.
(ko.TeX 와 동일하게 l·m·n 외 자음 라틴은 무받침으로 본다.)

## 요구 사항

- Quarto >= 1.4, Typst >= 0.14
- 폰트(시스템 설치): **Pretendard**(본문), **Noto Serif KR**(인용), **D2Coding ligature**(코드)

## 예제

`template.qmd` 가 확장의 모든 기능을 보이는 쇼케이스이자 `quarto use template` 시작 문서다.
렌더 결과는 [`docs/template.pdf`](docs/template.pdf).

```bash
quarto render
```
