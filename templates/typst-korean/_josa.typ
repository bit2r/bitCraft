// ---------------------------------------------------------------------------
// 자동 조사(助詞) 선택 — ko.TeX(luatexko)의 josa_code 테이블을 Typst 로 이식
// ---------------------------------------------------------------------------
// oblivoir 의 자동 조사는 ko.TeX 와 동일하다(oblivoir-simpledoc §8.4). 그 핵심은
// 앞말의 끝글자를 보고 받침 종류를 셋 중 하나로 분류하는 표다(luatexko.lua 의 josa_code):
//   1 = ㄹ받침      → (으)로 에서 '으' 생략, 그 외 조사는 받침형
//   2 = 무받침(모음) → 는 / 가 / 를 / 로
//   3 = 그 외 받침   → 은 / 이 / 을 / 으로
//
// ⚠ ko.TeX 충실 구현 — 한글뿐 아니라 숫자·라틴 끝글자도 한국어 발음으로 분류한다.
//   숫자: 0·3·6 → 받침, 1·7·8 → ㄹ, 2·4·5·9 → 무받침
//   라틴: l → ㄹ, m·n → 받침, 그 외 알파벳 → 무받침 (ko.TeX 가 특수 처리하는 자음은 l·m·n 뿐)
//   다자리 숫자는 끝자리 발음 기준(예: "100"의 끝 '0' → 받침). ko.TeX 와 동일한 단순화다.
//   한글·ASCII 가 아닌 글자(기호 등)로 끝나면 무받침으로 폴백한다.

// 끝글자의 josa 코드(1=ㄹ / 2=무받침 / 3=받침)를 반환.
#let _josa-code(word) = {
  if word.len() == 0 { return 2 }
  let last = word.clusters().last()
  let code = str.to-unicode(last)
  if code >= 0xAC00 and code <= 0xD7A3 {
    // 한글 음절 — 종성 인덱스(0=없음, 8=ㄹ)
    let jong = calc.rem(code - 0xAC00, 28)
    if jong == 0 { 2 } else if jong == 8 { 1 } else { 3 }
  } else if (0x31, 0x37, 0x38, 0x4C, 0x6C).contains(code) {
    1   // 1·7·8 · L·l → ㄹ받침
  } else if (0x30, 0x33, 0x36, 0x4D, 0x6D, 0x4E, 0x6E).contains(code) {
    3   // 0·3·6 · M·m·N·n → 받침
  } else {
    2   // 2·4·5·9 · 그 외 라틴 · 기호 → 무받침
  }
}

// 받침 있으면(ㄹ 포함) true. (으)로 외의 일반 조사 판정용.
#let has-batchim(word) = _josa-code(word) != 2

// 핵심 함수 — 받침(ㄹ 또는 그 외)이면 with-batchim, 무받침이면 without-batchim.
#let josa(word, with-batchim, without-batchim) = {
  word + (if has-batchim(word) { with-batchim } else { without-batchim })
}

// 명명 헬퍼 (받침형 / 무받침형)
#let eun-neun(word) = josa(word, "은", "는")     // 은/는 (주제)
#let i-ga(word)     = josa(word, "이", "가")     // 이/가 (주격)
#let eul-reul(word) = josa(word, "을", "를")     // 을/를 (목적격)
#let gwa-wa(word)   = josa(word, "과", "와")     // 과/와 (접속)
#let a-ya(word)     = josa(word, "아", "야")     // 아/야 (호격)
#let i-na(word)     = josa(word, "이나", "나")   // (이)나
#let i-ra(word)     = josa(word, "이라", "라")   // (이)라
#let i-yeo(word)    = josa(word, "이여", "여")   // (이)여

// (으)로 예외 — ㄹ받침(1)·무받침(2)은 '로', 그 외 받침(3)만 '으로'.
//   서울로·물로(ㄹ) / 학교로·바다로(무받침) / 책으로·집으로(받침) / 3으로(삼) / 1로(일)
#let euro(word) = {
  word + (if _josa-code(word) == 3 { "으로" } else { "로" })
}
