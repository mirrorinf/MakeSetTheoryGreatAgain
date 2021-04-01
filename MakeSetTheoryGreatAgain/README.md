#  Make Set Theory Great Again !

Happy April 1!

As the project name indicates this repo is intended to be Hilaryous. But somehow it is serious.

## Mission

This repo is (the first steps into) a formal proof system which is based on first order logic + ZFC. So LEM and AC are out there. It concerns with proofs that are as non-constructive as possible. No type theories or intuitionist logic here. I value laïcité. Classical logic should get the same support as constructivism from a laïc person, isn't it? Classical, intuitionist, paraconsistent... All logics are created equal, right?

## Design

In Coq or Lean a tactic language is embedded into a dependantly typed specification language. Here we do the exact opposite. The specification language, i.e. FOL+ZFC, is embedded into Swift, a mighty multi-paradigm programming language. Swift is certainly more useful than OCaml, not to mention the poor tactic language inside Coq or Lean. At least a slight modification to Swift source files is unlikely to be catastrophic.

I don't have the patience to develop any lexer or parser. The beautifully engineered Swift compiler will do the job. What if there was a bug in swiftc? Well, what if the CIA hacked your computer and messed with your Coq installlation? There is no such thing as absolute correctness.

## Progress

Almost 0. However, something like (∀x)((∀y)((∀z)(z∈x ↔ z∈y) ↔ (x==y))) (the extensionality axiom) is now completely valid Swift code.(See ZFC.swift) There is a slight syntactic compromise: a quantifier must be parenthesized together with its bound variable.
