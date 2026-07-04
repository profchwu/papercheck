# Development Prompt and Process Summary

This file summarizes the user requirements and development process used to create NTHU Sustainability Paper Checker V1.0.

## Initial Goal

Build an HTML-based checker that lets a user paste a paper title, abstract, and keywords, then evaluates whether the paper is likely to meet the requirements for NTHU sustainability paper recognition.

Core requirements:

- Use front-end-only HTML/CSS/JavaScript.
- Deploy easily on GitHub Pages.
- Use an English interface.
- Provide clear PASS or FAIL.
- Identify the most suitable SDG topic.
- Provide revision suggestions.
- Mark items needing revision in red.
- Search and download NTHU sustainability paper recognition references.
- Download Elsevier SDG keyword files for all 17 SDGs before building the app.

## Research Prompt Summary

The development process included requests to:

- Search online for National Tsing Hua University sustainability paper recognition information.
- Search related SDG mapping and classification references.
- Download Elsevier 2023 Sustainable Development Goals Mapping data.
- Use Elsevier SDG keyword/query data for SDG matching.
- Compare title, abstract, and keywords against SDG-related terms.

Main references used:

- NTHU SDGs: https://sdgs.nthu.edu.tw/
- Elsevier SDG Mapping dataset: https://elsevier.digitalcommonsdata.com/datasets/y2zyy9vwzy/1
- UN SDGs: https://sdgs.un.org/goals

## Planning Prompt Summary

The user requested a program plan that another AI development tool could use to implement the app.

Planning requirements:

- List program features.
- List data sources, links, and downloaded files.
- Explain limitations.
- Explain that the result cannot fully replace NTHU's official decision.
- Specify that the app must run entirely in the browser.
- Specify that the interface should be polished.
- Specify that SDG keyword data should be loaded efficiently.

## Implementation Prompt Summary

The user then requested the full program.

The app was implemented as:

- `index.html`
- `assets/sdg-core-index.js`
- `assets/sdg-keywords/sdg-01.js` through `sdg-17.js`
- `sources/references.md`
- `tools/build_sdg_data.ps1`

Core app behavior:

- Parse pasted Title, Abstract, and Keywords.
- Check SDG keyword matches.
- Show PASS/FAIL.
- Show best-fit SDG.
- Show matched terms.
- Show red revision marks and suggestions.

## Deployment Prompt Summary

The user requested GitHub deployment:

- Create repo: `papercheck`
- Public repository
- Deploy through GitHub Pages

Because command-line push authentication did not match the repository owner, deployment was completed through the GitHub web interface.

Public site:

https://profchwu.github.io/papercheck/

Repository:

https://github.com/profchwu/papercheck

## Iteration Prompt Summary

The user then requested multiple improvements:

### Field Parsing Improvements

User requirement:

- Title, Abstract, and Keywords should be detected more accurately.
- Format should not be strict.
- Usually first paragraph is Title, second is Abstract, third is Keywords.

Implemented:

- paragraph-based parsing
- line-based parsing fallback
- relaxed label parsing
- support for title before `ABSTRACT`

### Attribution and Disclaimer

User requirement:

- Add `國立清華大學數理教育研究所 吳智鴻教授開發`.
- Add English statement that results are for reference only and final recognition follows NTHU.

Implemented:

- Chinese author attribution in the header.
- English reference-only disclaimer.

### Sample Testing

User provided a sustainability education paper example.

Test result:

- Fields parsed correctly.
- Decision: PASS.
- Best-fit SDG: SDG 4 Quality Education.

### Relaxed Label Parsing

User requirement:

- `Title:`, `Abstract:`, `Keywords:` should be detected more flexibly.
- Do not require uppercase/lowercase exactness.
- Do not require colon.

Implemented support for:

- `Title`, `title`, `TITLE`
- `Abstract`, `abstract`, `ABSTRACT`
- `Keyword`, `Keywords`, `Key words`, `KEYWORDS`
- optional colon, full-width colon, hyphen, or dash
- same-line labels

### Full 17 SDG Keyword Check

User asked whether the app correctly checks precise keywords for all 17 SDGs.

Finding:

- Earlier versions used pre-screening and loaded only likely SDG modules.

Implemented in V1.0:

- final Check now scans all 17 Elsevier-derived SDG keyword modules.
- UI now states `Checked Elsevier keyword modules`.

## Version Summary

### Initial GitHub Pages App

- Static browser-only checker.
- PASS/FAIL.
- Best-fit SDG.
- Elsevier-derived keyword modules.

### Field Parsing Update

- Looser paragraph and line parsing.

### Attribution Update

- Added author attribution and NTHU final-decision disclaimer.

### Relaxed Label Parsing Update

- Case-insensitive and punctuation-flexible Title/Abstract/Keywords recognition.

### V1.0 Update

- Added V1.0 title and revision date.
- Added Chinese author attribution.
- Changed final check to scan all 17 SDGs.
- Confirmed sample paper returns PASS and SDG 4.

## Reusable Build Prompt

Use the following prompt to recreate or extend the project:

```text
Build a static GitHub Pages web app named NTHU Sustainability Paper Checker.
The app must run entirely in front-end HTML/CSS/JavaScript without backend, database, API key, or AI API.
The interface should be primarily English and polished.
Users must be able to paste title, abstract, and keywords into one text area.
The parser must flexibly detect Title, Abstract, and Keywords regardless of case, colon usage, or common paragraph layout.
The checker must compare the paper against Elsevier 2023 SDG Mapping keyword data for all 17 SDGs.
The result must show PASS or FAIL, best-fit SDG, checked modules, matched terms, and revision suggestions.
Mark revision issues in red and matched SDG terms in green.
Add the header: NTHU Sustainability Paper Checker V1.0, Revised 2026-07-04.
Add author attribution: 國立清華大學數理教育研究所 吳智鴻教授開發.
Add a disclaimer that results are for reference only and final recognition must follow National Tsing Hua University's official review and standards.
Document sources, version history, limitations, and deployment steps in README.md and SPEC.md.
```

