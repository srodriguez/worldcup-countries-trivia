# World Cup Country Trivia

An mdBook study site for kids preparing for school exams on FIFA World Cup countries. Built for the 2026 World Cup.

## Countries

| Country | Study Guide | Quiz Sets | Practice Quiz |
|---------|-------------|-----------|---------------|
| 🇫🇷 France | ✅ | 3 × 10 Q | ✅ |
| 🇩🇪 Germany | ✅ | 3 × 10 Q | ✅ |
| 🇮🇹 Italy | ✅ | 3 × 10 Q | ✅ |
| 🇪🇸 Spain | ✅ | 3 × 10 Q | ✅ |
| 🏴󠁧󠁢󠁥󠁮󠁧󠁿 England | — | — | ✅ |
| 🇧🇷 Brasil | — | — | ✅ |

Each practice quiz has 10 questions following Bloom's taxonomy: 6 knowledge (recall), 2 understanding (explain/interpret), 2 apply/analysis (reason/compare). Answers are tap-to-reveal.

## Dev setup

```bash
nix develop       # enter shell with mdbook
mdbook serve      # live preview at http://localhost:3000
mdbook build      # build to ./book/
```

## Build the site (no shell needed)

```bash
nix build         # builds to ./result/ (symlink into Nix store)
```

## Deploy to alienlab (NixOS home server)

See `../alienlab-worldcup-trivia.nix` for the NixOS nginx module.

**Option A — Declarative (full Nix):** wire the flake as an input to alienlab's `flake.nix`, import the module, then `nixos-rebuild switch`. The built site lives in the Nix store — no manual copying.

**Option B — Manual:** build on Mac with `nix build`, rsync `./result/` to `alienlab:/var/www/worldcup-trivia/`, serve with nginx.

## Project structure

```
site/
├── flake.nix           # packages.default = mdbook build; devShells.default = mdbook
├── book.toml           # mdBook config (navy theme, no section labels)
└── src/
    ├── SUMMARY.md      # mdBook table of contents
    ├── introduction.md
    ├── france/
    │   ├── README.md           # quick facts table
    │   ├── study-guide.md
    │   ├── quiz-answers.md     # 3 quiz sets, tap-to-reveal answers
    │   └── practice-quiz.md   # 10-question mixed practice set
    ├── germany/  (same structure)
    ├── italy/    (same structure)
    ├── spain/    (same structure)
    ├── england/
    │   ├── README.md
    │   └── practice-quiz.md
    └── brasil/
        ├── README.md
        └── practice-quiz.md
```

## Adding a new country

1. Create `src/<country>/` with `README.md` (quick facts table) and `practice-quiz.md` (10 questions, Bloom's structure)
2. Optionally add `study-guide.md` and `quiz-answers.md` for full content
3. Add entries to `src/SUMMARY.md`
4. Run `mdbook serve` to verify
