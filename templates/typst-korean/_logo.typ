// ---------------------------------------------------------------------------
// TeX / LaTeX 워드마크 — 본문 폰트(Pretendard) 위에서 고전 로고의 자형을 재현
// ---------------------------------------------------------------------------
// latex.ltx 의 커닝값을 그대로 옮겼다: E 는 0.5ex 내려, A 는 0.7배로 줄여 0.7ex 올린다.
// box() 로 감싸 어절 중간 줄바꿈(La↵TeX)을 막는다.

#let tex-logo = box[T#h(-0.1667em)#text(baseline: 0.215em)[E]#h(-0.125em)X]

#let latex-logo = box[L#h(-0.36em)#text(size: 0.7em, baseline: -0.3em)[A]#h(-0.15em)#tex-logo]

// 문자열 show 규칙 — 최좌단 매칭이므로 "LaTeX"(위치 0)이 내부 "TeX"보다 먼저 잡힌다.
// "ko.TeX"·"XeTeX"·"LuaTeX" 는 비-TeX 부분이 평문이라 "TeX" 규칙만으로 로고가 박힌다.
#show "LaTeX": latex-logo
#show "TeX": tex-logo
