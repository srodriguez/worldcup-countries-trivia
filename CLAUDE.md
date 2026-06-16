# CLAUDE.md — World Cup Country Trivia

## What this project is

An mdBook static site with study guides and quizzes for kids preparing for school exams on FIFA World Cup countries. Built by Seb Rodriguez for his son during the 2026 World Cup.

## Repo layout

```
worldcup-countries-trivia/
├── CLAUDE.md                        # this file
├── alienlab-worldcup-trivia.nix     # NixOS nginx module for home server
└── site/
    ├── README.md                    # project overview + how to build/deploy
    ├── flake.nix                    # packages.default (build) + devShells.default (dev)
    ├── book.toml                    # mdBook config
    └── src/
        ├── SUMMARY.md               # mdBook table of contents (edit to add pages)
        ├── introduction.md
        ├── france/                  # full content: README, study-guide, quiz-answers, practice-quiz
        ├── germany/                 # full content
        ├── italy/                   # full content
        ├── spain/                   # full content
        ├── england/                 # practice-quiz only (no study guide yet)
        └── brasil/                  # practice-quiz only (no study guide yet)
```

## Content conventions

**quiz-answers.md** — three quiz sets of 10 questions each. Each question uses a `<details>`/`<summary>` tap-to-reveal block. Bloom's taxonomy distribution per set: 6 knowledge, 2 understanding, 2 apply/analysis.

**practice-quiz.md** — 10-question mixed set. For countries with existing quiz sets: 2 questions from each of the 3 sets + 4 new questions. For countries without quiz sets (England, Brasil): all 10 new. Same tap-to-reveal format. Bloom's distribution: 6 knowledge, 2 understanding, 2 apply/analysis.

**study-guide.md** — prose narrative covering history, culture, geography, sport, and famous people. Not a list — written to be read, not memorised.

**README.md** (in each country dir) — quick facts table: capital, population, official language, currency, government, famous landmarks, national sport.

## Build and dev

```bash
# Enter dev shell
nix develop

# Live preview (http://localhost:3000)
mdbook serve

# Build static site to ./book/
mdbook build

# Build as Nix derivation (output: ./result/)
nix build
```

Requires Nix with flakes enabled (`experimental-features = nix-command flakes` in nix.conf).

## Deployment

Served via nginx on **alienlab** (home server running NixOS). The nginx config is in `alienlab-worldcup-trivia.nix` at the repo root — this is a NixOS module, not part of the mdBook site itself.

**Declarative (Option A):** Wire `worldcup-trivia` as a flake input in alienlab's `flake.nix`, import the module, rebuild. The Nix store path is used directly as the nginx root — no file copying.

**Manual (Option B):** `nix build` on Mac, rsync `./result/` to `alienlab:/var/www/worldcup-trivia/`, point nginx root at that path.

Access: `http://alienlab` or `http://<tailscale-ip>` from inside the Tailscale network. Port 80, HTTP only (no HTTPS redirect).

## Adding a country

1. `mkdir site/src/<country>`
2. Create `README.md` (quick facts table), `practice-quiz.md` (10 Q, Bloom's structure)
3. Optionally add `study-guide.md` and `quiz-answers.md`
4. Add all new pages to `site/src/SUMMARY.md`
5. `mdbook serve` to verify rendering

## Owner / context

- **Owner:** Seb Rodriguez (srodriguez / rodriguez.sebastianalberto@gmail.com)
- **Audience:** Seb's son, primary/secondary school age
- **Language:** English
- **Tone:** Educational but engaging — rich contextual tips, not dry facts
- **Score threshold for prize:** 8/10 on each practice quiz
