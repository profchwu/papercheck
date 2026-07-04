# Program Specification

## Project

NTHU Sustainability Paper Checker V1.0

Developer attribution: 國立清華大學數理教育研究所 吳智鴻教授開發

Revision date: 2026-07-04

## Objective

Create a front-end-only HTML application that helps users evaluate whether a paper title, abstract, and keywords are likely to satisfy sustainability paper recognition expectations. The tool must show a clear PASS or FAIL result, identify the most suitable SDG, and provide revision suggestions with red marks for items that may need improvement.

The result is advisory only. Official recognition must follow National Tsing Hua University's review and standards.

## Platform Requirements

- Must run with static front-end web technologies only.
- Must be deployable on GitHub Pages.
- Must not require a server, database, cloud function, API key, or external AI API.
- Must keep user input in the browser.
- Must use English as the primary interface language.
- Must show author attribution in Chinese.

## Input Requirements

The app provides:

- One large paste box for combined title, abstract, and keywords.
- Three editable fields:
  - Title
  - Abstract
  - Keywords

### Field Parsing Rules

The parser must accept relaxed formats:

- Case-insensitive labels:
  - `Title`, `title`, `TITLE`
  - `Abstract`, `abstract`, `ABSTRACT`
  - `Keyword`, `Keywords`, `Key words`, `KEYWORDS`
- Optional punctuation:
  - colon `:`
  - full-width colon `：`
  - hyphen `-`
  - dash
- Paragraph fallback:
  - first paragraph = Title
  - second paragraph = Abstract
  - third paragraph = Keywords
- Title-before-abstract format:
  - text before `ABSTRACT` is treated as Title if no explicit Title label exists.
- Same-line labels:
  - `Title ... Abstract ... Keywords ...`

## SDG Data Requirements

The app uses:

- UN SDG names and official goal statements.
- Elsevier 2023 Sustainable Development Goals Mapping dataset.
- 17 SDG keyword modules:
  - `assets/sdg-keywords/sdg-01.js`
  - ...
  - `assets/sdg-keywords/sdg-17.js`

Each keyword module stores:

- SDG id
- SDG code
- SDG name
- source attribution
- positive matching terms
- optional negative/exclusion terms

## Scoring Requirements

The app checks all 17 SDG keyword modules during the final Check action.

Field weights:

```javascript
const FIELD_WEIGHTS = {
  title: 3,
  keywords: 3,
  abstract: 1.5
};
```

PASS thresholds:

```javascript
const PASS_THRESHOLDS = {
  finalScore: 12,
  titleOrKeywordMatch: 1,
  abstractMatch: 1,
  minKeywordCount: 3,
  minAbstractSignalTypes: 3
};
```

The app evaluates:

- matched terms in title
- matched terms in abstract
- matched terms in keywords
- abstract signals:
  - purpose
  - method
  - result
  - sustainability impact
- keyword count
- exclusion terms
- possible overclaiming language

## Output Requirements

The result panel must display:

- Decision: `PASS` or `FAIL`
- Confidence
- Best-fit SDG
- Secondary SDG candidates, if any
- Checked Elsevier keyword modules
- Matched Elsevier-derived terms
- Reasons for FAIL, if any
- Suggestions

The marked review panel must display:

- Title review
- Abstract review
- Keywords review
- green marks for matched SDG terms
- red marks for issues or missing content

## UI Requirements

- Polished, responsive layout.
- Desktop: two-column workspace.
- Mobile: single-column layout.
- No backend or landing page.
- Clear buttons:
  - Parse
  - Check
  - Load sample
  - Clear
  - Copy suggestions
- Text must fit in containers across screen sizes.
- Results must not rely on color alone.

## Source Attribution Requirements

Footer and documentation must cite:

- Elsevier 2023 Sustainable Development Goals Mapping, DOI `10.17632/y2zyy9vwzy.1`, CC BY 4.0.
- UN Sustainable Development Goals.
- National Tsing Hua University SDGs.

## Known Limitations

- This is a rule-based checker, not an official NTHU review system.
- It cannot guarantee paper recognition.
- Elsevier SDG mapping terms are used as reference signals, not as the sole official standard.
- Some terms may match multiple SDGs.
- Human review is still required for final interpretation.

## Verification Cases

### Case 1: Sustainability Education Paper

Expected result:

- PASS
- Best-fit SDG: SDG 4 Quality Education
- All 17 SDGs checked

### Case 2: Climate Paper

Expected result:

- PASS
- Best-fit SDG: SDG 13 Climate Action

### Case 3: Generic Technical Paper

Expected result:

- FAIL
- low SDG detectability
- suggestions to add specific SDG terms

