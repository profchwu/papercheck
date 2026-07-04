# NTHU Sustainability Paper Checker V1.0

國立清華大學數理教育研究所 吳智鴻教授開發

NTHU Sustainability Paper Checker is a static, browser-only web app for checking whether a paper title, abstract, and keywords are likely to be SDG-detectable for sustainability paper recognition review. The app is designed for GitHub Pages deployment and does not require a backend server, API key, database, or user login.

Public site: https://profchwu.github.io/papercheck/

## Important Notice

This tool is for reference only. PASS/FAIL reflects this tool's rule-based assessment using downloaded SDG mapping references. The final recognition decision must follow National Tsing Hua University's official review and standards.

## Main Features

- Paste title, abstract, and keywords together in one text box.
- Automatically parses Title, Abstract, and Keywords with relaxed label detection.
- Supports labels such as `Title`, `title`, `TITLE`, `Abstract`, `ABSTRACT`, `Keyword`, `Keywords`, and `Key words`.
- Does not require colons after field labels.
- Supports common layouts:
  - first paragraph as title, second as abstract, third as keywords
  - title before an `ABSTRACT` label
  - `Keywords:` or `Keywords` at the end
  - same-line labels such as `Title ... Abstract ... Keywords ...`
- Checks all 17 SDG keyword modules derived from Elsevier 2023 SDG Mapping data.
- Shows a clear `PASS` or `FAIL` decision.
- Shows the best-fit SDG and secondary SDG candidates.
- Highlights matched SDG terms and possible revision issues.
- Provides field-level suggestions for title, abstract, and keywords.

## Current Version

### V1.0 - Revised 2026-07-04

- Added public title: `NTHU Sustainability Paper Checker V1.0`.
- Added revision date: `Revised 2026-07-04`.
- Added Chinese author attribution: `國立清華大學數理教育研究所 吳智鴻教授開發`.
- Added English reference-only disclaimer.
- Changed the final check flow to scan all 17 SDG keyword modules instead of only pre-screened SDGs.
- Relaxed field parsing for Title, Abstract, and Keywords.
- Fixed parsing when the title appears before an `ABSTRACT` label.
- Added support for field labels without colons and with mixed casing.
- Fixed handling of SDG modules whose exclusion terms are not arrays.

## Version History

### Initial GitHub Pages App

- Built a static HTML/CSS/JavaScript application for GitHub Pages.
- Added one large paste box and editable Title, Abstract, and Keywords fields.
- Added PASS/FAIL result panel, best-fit SDG display, matched terms, and red marked suggestions.
- Added Elsevier-derived SDG keyword data modules.

### Field Parsing Improvements

- Improved auto-detection for common paper formats.
- Added paragraph-based parsing:
  - first paragraph = Title
  - second paragraph = Abstract
  - third paragraph = Keywords
- Added line-based fallback for inputs without blank lines.

### Attribution and Disclaimer Update

- Added developer attribution.
- Added clearer English disclaimer that official recognition must follow NTHU standards.

### V1.0 Full SDG Scan

- Changed final scoring to check SDG 1 through SDG 17.
- Updated the UI status text to `Checked Elsevier keyword modules`.
- Confirmed sample sustainability education paper returns `PASS` and best-fit `SDG 4 Quality Education`.

## Test Example

The following paper sample was tested:

Title:
`Combining experiential learning with digital game-based learning to enhance learning motivation, reduce cognitive load and increase acceptance of sustainable education`

Keywords:
`Experiential learning, Digital game-based learning, Sustainable education, Sustainable education game, Cognitive load, Motivation`

Result:

- Decision: `PASS`
- Best-fit SDG: `SDG 4 Quality Education`
- All 17 SDG modules checked
- Key matched terms: `education`, `learning`, `barrier`, `design`

## Data Sources

- Elsevier 2023 Sustainable Development Goals Mapping, DOI `10.17632/y2zyy9vwzy.1`, CC BY 4.0  
  https://elsevier.digitalcommonsdata.com/datasets/y2zyy9vwzy/1
- UN Sustainable Development Goals  
  https://sdgs.un.org/goals
- National Tsing Hua University SDGs  
  https://sdgs.nthu.edu.tw/

## Files

- `index.html`: main static web app.
- `assets/sdg-core-index.js`: lightweight SDG core index.
- `assets/sdg-keywords/sdg-01.js` to `assets/sdg-keywords/sdg-17.js`: Elsevier-derived SDG keyword modules.
- `README.md`: user-facing documentation and version history.
- `SPEC.md`: program specification.
- `Prompt.md`: summarized development prompt and process log.
- `sources/references.md`: source reference notes.

## Deployment

The app is designed for GitHub Pages:

1. Put `index.html` and the `assets/` folder in the repository root.
2. Enable GitHub Pages.
3. Select branch `main` and folder `/ (root)`.
4. Open the GitHub Pages URL.

No build step is required.

