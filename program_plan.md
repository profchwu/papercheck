# 清華大學永續論文檢查程式規劃書

## 1. 專案目標

建立一個以英文介面為主、可部署到 GitHub Pages 的純前端 HTML 檢查工具，讓使用者一次貼上論文的 title、abstract、keywords，或分別上傳/輸入三個欄位。程式會依據清華大學永續網站可見的 SDGs 研究分類脈絡，以及 Elsevier 2023 Sustainable Development Goals Mapping 的 17 項 SDG query/keyphrase 文件，判斷文字是否具備「可被辨識為永續論文」的特徵，並針對需要補強的地方提供紅色標註與修改建議。

本工具定位為「投稿/登錄前自我檢查與文字優化建議」，不是清華大學官方採認系統。不過檢查結果會依程式規則明確顯示 `PASS` 或 `FAIL`，並說明造成 `FAIL` 的原因。

## 1.1 給 AI 開發工具的實作說明

本規劃書必須足以讓其他 AI 開發工具直接依規格實作。實作時請遵守以下原則：

- 不需要再重新設計產品方向，請依本規劃書製作。
- 不可加入後端、伺服器、資料庫、雲端 API 或 AI API。
- 不可把使用者輸入送出瀏覽器。
- 所有檢查需在瀏覽器端完成。
- 必須保留 Elsevier 2023 SDG Mapping 資料來源與 attribution。
- `PASS` / `FAIL` 是本工具規則判斷，不可宣稱為清華大學官方審查結果。
- 開發完成後，使用者應可將整個資料夾直接放到 GitHub Pages 執行。

## 2. 已下載參考資料

資料已存放於 `sources/`：

| 檔案 | 來源連結 | 用途 |
| --- | --- | --- |
| `sources/nthu-sdgs-home.html` | https://sdgs.nthu.edu.tw/ | 清華永續網站首頁與內嵌資料，確認清華以 SDGs 作為研究、教學、行政與創新行動框架。 |
| `sources/nthu-sdgs-app-bundle.js` | https://sdgs.nthu.edu.tw/_nuxt/c0219e5.js | 清華永續網站前端程式資料，已看到與「教師研究」、「碩博士論文」、「research paper confirmation」相關路徑，可作為校內採認流程線索。 |
| `sources/un-sdgs-goals.html` | https://sdgs.un.org/goals | 聯合國 17 項 SDGs 官方目標文字，作為各 SDG 主題定義的基礎。 |
| `sources/sdg-research-mapping-initiative.html` | https://arxiv.org/abs/2209.07285 | SDG Research Mapping Initiative 方法論，說明研究論文如何映射到 SDGs，且該方法被 Times Higher Education Impact Rankings 使用。 |
| `sources/osdg-approach.html` | https://arxiv.org/abs/2005.14569 | OSDG 開源 SDG 文字分類方法，作為關鍵詞與文字分類設計參考。 |
| `sources/osdg-2.html` | https://arxiv.org/abs/2211.11252 | OSDG 2.0 多語分類方法，作為中英文混合文本與多語永續語彙判斷參考。 |
| `sources/sdg-research-mapping.pdf` | https://arxiv.org/pdf/2209.07285 | SDG Research Mapping Initiative 論文 PDF。 |
| `sources/sdg-research-mapping-source/` | https://arxiv.org/e-print/2209.07285 | 論文 TeX 原始檔，用於追溯 Elsevier 2023 SDG Mapping 資料集連結。 |
| `sources/elsevier-datasets-bundle.js` | https://elsevier.digitalcommonsdata.com/datasets/bundle.js | Elsevier Data Repository 前端程式，用於確認檔案清單與下載 API。 |
| `sources/elsevier-sdg-2023/queries/` | https://elsevier.digitalcommonsdata.com/datasets/y2zyy9vwzy/1 | Elsevier 2023 SDG Mapping 的 17 個 Scopus query 文字檔。 |
| `sources/elsevier-sdg-2023/descriptions/` | https://elsevier.digitalcommonsdata.com/datasets/y2zyy9vwzy/1 | Elsevier 2023 SDG Mapping 的 17 個 SDG description/keyphrase HTML 檔。 |
| `sources/elsevier-sdg-2023/queries-file-list.json` | Elsevier Data Repository API | 17 個 query 檔的檔案清單、file id、SHA256、下載 URL。 |
| `sources/elsevier-sdg-2023/descriptions-file-list.json` | Elsevier Data Repository API | 17 個 description/keyphrase 檔的檔案清單、file id、SHA256、下載 URL。 |

## 2.1 Elsevier 2023 SDG Mapping 檔案清單

Query files:

- `sources/elsevier-sdg-2023/queries/SDG01.txt`
- `sources/elsevier-sdg-2023/queries/SDG2.txt`
- `sources/elsevier-sdg-2023/queries/SDG03.txt`
- `sources/elsevier-sdg-2023/queries/SDG04.txt`
- `sources/elsevier-sdg-2023/queries/SDG05.txt`
- `sources/elsevier-sdg-2023/queries/SDG06.txt`
- `sources/elsevier-sdg-2023/queries/SDG07.txt`
- `sources/elsevier-sdg-2023/queries/SDG08.txt`
- `sources/elsevier-sdg-2023/queries/SDG09.txt`
- `sources/elsevier-sdg-2023/queries/SDG10.txt`
- `sources/elsevier-sdg-2023/queries/SDG11.txt`
- `sources/elsevier-sdg-2023/queries/SDG12.txt`
- `sources/elsevier-sdg-2023/queries/SDG13.txt`
- `sources/elsevier-sdg-2023/queries/SDG14.txt`
- `sources/elsevier-sdg-2023/queries/SDG15.txt`
- `sources/elsevier-sdg-2023/queries/SDG16.txt`
- `sources/elsevier-sdg-2023/queries/SDG17.txt`

Description/keyphrase files:

- `sources/elsevier-sdg-2023/descriptions/sdg_01_no_poverty.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_02_zero_hunger.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_03_good_health_and_well_being.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_04_quality_education.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_05_gender_equality.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_06_clean_water_and_sanitation.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_07_affordable_and_clean_energy.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_08_decent_work_and_economic_growth.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_09_industry_innovation_and_infrastructure.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_10_reduced_inequality.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_11_sustainable_cities_and_communities.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_12_responsible_consumption_and_production.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_13_climate_action.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_14_life_below_water.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_15_life_on_land.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_16_peace_justice_and_strong_institutions.html`
- `sources/elsevier-sdg-2023/descriptions/sdg_17_partnerships_for_the_goals.html`

## 3. 待採用的判斷原則

1. 優先使用 Elsevier 2023 SDG Mapping 的 `TITLE-ABS` 與 `AUTHKEY` query 詞組，對應檢查 title、abstract、keywords。
2. 判斷是否有「研究貢獻」與「永續目標」之間的明確連結，而不只是背景句提到 sustainable 或 SDGs。
3. keywords 應包含可被檢索系統捕捉的主題詞，避免只有過度籠統詞，例如 model、analysis、system、performance。
4. abstract 應至少具備：研究問題、方法/資料、主要結果、永續影響或對應 SDG。
5. title 若完全沒有永續或 SDG 可檢索詞，應提示加入更具辨識度的詞，但不強迫把每篇論文都寫成 SDG 標語。
6. 若同時命中多個 SDG，程式會列出主要 SDG 與次要 SDG，並在畫面上顯示「This paper is most suitable for SDG X: [theme]」。
7. 檢查結果必須明確顯示 `PASS` 或 `FAIL`。`PASS` 表示程式規則判斷 title/abstract/keywords 已有足夠 SDG 可檢索性；`FAIL` 表示至少有關鍵欄位缺少 SDG 可檢索線索或永續貢獻描述。

## 4. 程式功能規格

### 4.0 部署與技術限制

- 必須完全使用前端網頁技術執行：HTML、CSS、JavaScript。
- 不使用後端、不使用資料庫、不使用 API key、不呼叫外部 AI 服務。
- 可直接部署到 GitHub Pages。
- 使用者輸入的 title、abstract、keywords 只在瀏覽器本機分析，不上傳。
- 正式檔案建議結構：
  - `index.html`
  - `assets/sdg-core-index.js`
  - `assets/sdg-keywords/sdg-01.js` 至 `assets/sdg-keywords/sdg-17.js`
  - `sources/references.md`

若要極簡部署，也可合併為單一 `index.html`，但因 Elsevier keyword/query 資料量較大，正式版本優先採分檔按需載入。

### 4.0.0 必須產出的檔案結構

正式實作需產出以下檔案：

```text
/
├─ index.html
├─ assets/
│  ├─ sdg-core-index.js
│  └─ sdg-keywords/
│     ├─ sdg-01.js
│     ├─ sdg-02.js
│     ├─ sdg-03.js
│     ├─ sdg-04.js
│     ├─ sdg-05.js
│     ├─ sdg-06.js
│     ├─ sdg-07.js
│     ├─ sdg-08.js
│     ├─ sdg-09.js
│     ├─ sdg-10.js
│     ├─ sdg-11.js
│     ├─ sdg-12.js
│     ├─ sdg-13.js
│     ├─ sdg-14.js
│     ├─ sdg-15.js
│     ├─ sdg-16.js
│     └─ sdg-17.js
└─ sources/
   └─ references.md
```

`sources/` 可以保留本機下載的原始參考資料；正式部署到 GitHub Pages 時，若檔案過大，可只保留 `sources/references.md`，列出資料來源與授權。

### 4.0.2 JavaScript 全域資料格式

`assets/sdg-core-index.js` 必須定義：

```javascript
window.SDG_CORE_INDEX = [
  {
    id: 13,
    code: "SDG 13",
    name: "Climate Action",
    officialName: "Take urgent action to combat climate change and its impacts",
    coreTerms: ["climate change", "global warming", "greenhouse gas", "carbon footprint"],
    aliases: ["GHG", "CO2", "climate risk"],
    source: "UN SDGs + Elsevier 2023 SDG Mapping descriptions"
  }
];
```

每個 `assets/sdg-keywords/sdg-XX.js` 必須定義或追加：

```javascript
window.SDG_KEYWORDS = window.SDG_KEYWORDS || {};
window.SDG_KEYWORDS[13] = {
  id: 13,
  code: "SDG 13",
  name: "Climate Action",
  source: "Elsevier 2023 Sustainable Development Goals (SDGs) Mapping",
  terms: [
    { term: "climate change", weight: 5, fields: ["title", "abstract", "keywords"] },
    { term: "greenhouse gas emissions", weight: 5, fields: ["title", "abstract", "keywords"] },
    { term: "carbon footprint", weight: 4, fields: ["title", "abstract", "keywords"] }
  ],
  negativeTerms: ["Triassic climate", "prehistoric climate", "paleoclimate"],
  queryFile: "sources/elsevier-sdg-2023/queries/SDG13.txt"
};
```

欄位要求：

- `term`：比對詞組，小寫化後比對。
- `weight`：1 至 5，越明確越高。
- `fields`：可套用欄位，至少支援 `title`、`abstract`、`keywords`。
- `negativeTerms`：用來降低誤判。
- `source`：必須保留 Elsevier attribution。

### 4.0.1 前端設計要求

- 介面需精美、現代、專業，適合作為研究行政或學術支援工具使用。
- 首屏直接呈現可用的檢查工具，不做行銷式 landing page。
- 視覺風格以乾淨、明亮、可信任為主，避免過度裝飾。
- 使用清楚的狀態卡片顯示：
  - `Decision: PASS / FAIL`
  - `Best-fit SDG`
  - `Confidence`
  - `Fields needing revision`
- 紅色標註要醒目但不刺眼，需能清楚指出需修改處。
- 支援桌機與手機版面，不得出現文字重疊或按鈕溢出。

### 4.1 輸入方式

- The interface will be primarily in English.
- Provide one large text area for pasting title, abstract, and keywords together.
- 支援常見標籤自動解析：
  - `Title:`
  - `Abstract:`
  - `Keywords:`
  - `論文題目：`
  - `摘要：`
  - `關鍵字：`
- 若沒有標籤，先用段落長度與位置推測：
  - 第一段短文字視為 title。
  - 最後一段含逗號、分號或多個短詞視為 keywords。
  - 中間長段視為 abstract。
- 另提供三個獨立欄位，讓使用者可手動修正自動判讀結果。

### 4.2 檢查項目

- Title 檢查：
  - 是否有可辨識的永續/SDG 主題詞。
  - 是否過短、過長或過度籠統。
  - 是否能看出研究對象與永續議題。
- Abstract 檢查：
  - 是否出現研究問題、方法、結果、影響四個要素。
  - 是否將研究成果連到 SDG 或永續議題。
  - 是否只有空泛宣稱而缺少具體內容。
  - 是否有可補強的 SDG 目標詞。
- Keywords 檢查：
  - 是否至少包含 3 至 6 個有效關鍵字。
  - 是否有永續檢索詞。
  - 是否與 title/abstract 的主題一致。
  - 是否有過度泛化、重複或不利檢索的詞。
- 整體檢查：
  - 推測可能對應的 SDG 目標。
  - 顯示最適合的 SDG 主題，例如 `Best-fit SDG: SDG 13 Climate Action`。
  - 顯示整體採認結果：`PASS` 或 `FAIL`。
  - 顯示 `PASS/FAIL` 理由。
  - 產生「優先修改建議」。

### 4.2.1 SDG 按需載入流程

為避免一次載入 17 項 Elsevier keywords/query 導致網頁資料過大，正式程式採兩階段分析：

1. Lightweight pre-screening
   - 先載入 `assets/sdg-core-index.js`。
   - 這份檔案只包含每個 SDG 的少量代表詞、UN SDG 名稱、Elsevier description 中整理出的 top-level keyphrases。
   - 用 title、abstract、keywords 初步計算 17 項 SDG 分數。

2. Best-fit SDG selection
   - 取分數最高的 1 至 3 個 SDG 作為候選。
   - 畫面先顯示 provisional best-fit SDG。

3. Lazy loading Elsevier keywords
   - 只載入最高分 SDG 對應的完整 keyword/query 模組，例如 `assets/sdg-keywords/sdg-13.js`。
   - 若第二名與第一名分數接近，再載入第二名與第三名。
   - 使用完整 Elsevier-derived keyword set 重新評分。

4. Final decision
   - 依完整載入後的 SDG 分數、欄位完整性、title/abstract/keywords 的可檢索性，產生 `PASS` 或 `FAIL`。
   - 顯示 `Best-fit SDG` 與 `Secondary SDG candidates`。

此設計可以讓 GitHub Pages 版本維持快速載入，同時保留 Elsevier keyword/query 的檢核依據。

### 4.2.2 必須實作的函式

`index.html` 內的 JavaScript 至少需實作以下函式，函式名稱可調整，但功能不可省略：

```javascript
function parseInput(rawText) {}
function normalizeText(text) {}
function preScreenSdgs(parsedPaper) {}
function loadSdgKeywordModule(sdgId) {}
function scoreWithLoadedKeywords(parsedPaper, sdgId) {}
function determineBestFit(scoredSdgs) {}
function determinePassFail(parsedPaper, bestFit, fieldScores) {}
function buildSuggestions(parsedPaper, bestFit, decision) {}
function buildHighlightedText(fieldName, text, issues, matchedTerms) {}
function renderResults(result) {}
```

輸入輸出要求：

- `parseInput(rawText)` 回傳 `{ title, abstract, keywords }`。
- `preScreenSdgs(parsedPaper)` 回傳依分數排序的 SDG 陣列。
- `determineBestFit(scoredSdgs)` 回傳 `{ primary, secondary }`。
- `determinePassFail(...)` 回傳 `{ decision: "PASS" | "FAIL", reasons: [] }`。
- `renderResults(result)` 必須更新畫面上的 decision、best-fit SDG、紅色標註與建議。

### 4.2.3 PASS / FAIL 規則

第一版請使用以下明確規則：

`PASS` 條件：

- `title`、`abstract`、`keywords` 三欄都存在。
- best-fit SDG final score 達到門檻。
- 至少有一個 Elsevier-derived term 出現在 `title` 或 `keywords`。
- `abstract` 至少包含一個 SDG-related term。
- `abstract` 至少包含研究目的/方法/結果/影響其中三類訊號。
- 沒有強烈 negativeTerms 或 overclaiming pattern 導致降級。

`FAIL` 條件：

- 缺少 title、abstract 或 keywords 任一欄。
- best-fit SDG score 太低。
- 只有 abstract 提到永續，但 title 與 keywords 完全沒有可檢索詞。
- keywords 少於 3 個有效詞。
- 命中 negativeTerms 且缺少當代永續脈絡。
- 摘要只有空泛永續宣稱，沒有方法或結果。

建議初始門檻：

```javascript
const PASS_THRESHOLDS = {
  finalScore: 12,
  titleOrKeywordMatch: 1,
  abstractMatch: 1,
  minKeywordCount: 3,
  minAbstractSignalTypes: 3
};
```

### 4.2.4 欄位權重

建議使用以下權重：

```javascript
const FIELD_WEIGHTS = {
  title: 3,
  keywords: 3,
  abstract: 1.5
};
```

若 term 出現在 title 或 keywords，分數應高於只出現在 abstract。

### 4.2.5 初判與完整判分

初判：

- 使用 `SDG_CORE_INDEX.coreTerms` 與 `aliases`。
- 對 17 項 SDG 逐一計分。
- 選出前三名候選。

完整判分：

- 載入第一名完整 keyword module。
- 若第二名分數達第一名的 70% 以上，也載入第二名。
- 若第三名分數達第一名的 70% 以上，也載入第三名。
- 重新計分後決定 final best-fit SDG。

### 4.3 紅色標註設計

- 在結果區顯示三段標註版文字：Title、Abstract、Keywords。
- 對需要修改的文字套用紅色底線或紅色框線。
- 標註類型包含：
  - 缺少 SDG 可檢索詞。
  - 文字太籠統。
  - 永續連結不足。
  - keywords 不完整或不一致。
  - 可能過度宣稱。
- 每個紅色標註旁提供一句具體建議，例如「建議補上 renewable energy 或 energy efficiency 等可檢索詞」。

### 4.3.1 紅色標註輸出規則

紅色標註必須至少覆蓋以下狀況：

- Missing SDG-detectable term in title.
- Keywords do not include the best-fit SDG terms.
- Abstract does not explicitly connect the study to SDG impact.
- Generic words only, such as `model`, `analysis`, `system`, `performance`.
- Possible overclaiming, such as `fully solves`, `guarantees sustainability`, `complete solution`.

畫面上需同時提供：

- red highlight in the text
- issue label
- actionable suggestion

### 4.4 建議輸出

- Display suggestions in English:
  - Title suggestions
  - Abstract suggestions
  - Keywords suggestions
  - Overall recommendation
- Display the best-fit SDG theme and supporting matched terms.
- Display secondary SDG candidates if the score is close.

### 4.5 使用者流程

1. User opens `index.html`.
2. User pastes title, abstract, and keywords into the large text area.
3. User clicks `Parse`.
4. The app auto-fills Title / Abstract / Keywords fields.
5. User edits fields if needed.
6. User clicks `Check`.
7. App runs lightweight SDG pre-screening.
8. App lazy-loads relevant Elsevier keyword module(s).
9. App displays `PASS` or `FAIL`.
10. App displays `Best-fit SDG`.
11. App displays red-marked text and suggestions.
12. User can copy suggestions.

### 4.6 UI 元件清單

必須包含：

- Header: app name and short disclaimer.
- Large paste textarea.
- Three editable fields: Title, Abstract, Keywords.
- Buttons: `Parse`, `Check`, `Clear`, `Copy suggestions`.
- Decision panel: `PASS` / `FAIL`.
- Best-fit SDG panel.
- Secondary SDGs panel.
- Loaded data indicator.
- Matched Elsevier terms list.
- Marked-up Title / Abstract / Keywords review panels.
- Suggestions panel.
- Footer references section.

### 4.7 文案要求

介面主要文案使用英文。必要文字如下：

- App title: `NTHU Sustainability Paper Checker`
- Subtitle: `A browser-based SDG detectability checker for title, abstract, and keywords.`
- Disclaimer: `This tool is not an official NTHU decision. PASS/FAIL reflects this tool's rule-based assessment.`
- Decision labels: `PASS`, `FAIL`
- SDG label: `Best-fit SDG`
- Button labels: `Parse`, `Check`, `Clear`, `Copy suggestions`
- 提供「建議改寫方向」，但不自動改寫成最終版本，避免改動學術原意。
- 可選擇複製建議文字。

## 5. 規則資料設計

正式 HTML 會使用分層 JavaScript 規則資料。資料來源以 Elsevier 2023 SDG Mapping query files 為主，UN SDG 官方目標文字為輔：

- `sdgGoals`：17 個 SDG 的中英文名稱。
- `sdgCoreIndex`：每個 SDG 的輕量初判關鍵詞，用於首輪判斷最可能 SDG。
- `sdgKeywords`：從 Elsevier query 檔抽取的 TITLE-ABS/AUTHKEY 詞組與各 SDG description/keyphrase 檔整理出的代表 keyphrases，依 SDG 分檔按需載入。
- `weakTerms`：過度籠統詞，例如 analysis、model、study、system、performance。
- `evidenceTerms`：用來辨識方法、結果、影響的詞，例如 results show、we found、evaluate、survey、experiment、policy implication。
- `warningPatterns`：過度宣稱或缺少證據的語句，例如 solve all、fully sustainable、guarantee。
- `passFailRules`：明確判斷 `PASS`/`FAIL` 的條件。

第一版會採 rule-based 判斷，不串接外部 AI 或 API，確保可被檢視、可自行調整。正式製作前會先從 Elsevier query 檔整理一份輕量化 core index，以及 17 份可 lazy-load 的 SDG keyword modules，避免把數 MB 的原始 query 全部塞進單一 HTML 造成頁面過重。

### 5.1 Elsevier query 轉換規則

從 `sources/elsevier-sdg-2023/queries/*.txt` 建立前端 keyword modules 時：

- 抽取 `TITLE-ABS("...")`、`AUTHKEY("...")` 中的詞組。
- 移除重複詞。
- 移除過短且容易誤判的詞，例如單一普通字詞。
- 保留明確片語，例如 `climate change`、`greenhouse gas emissions`、`renewable energy`。
- 將萬用字元 `*` 轉為簡易前綴比對或移除後作保守比對。
- 從 `NOT (...)` 區段抽取 negative terms，放入 `negativeTerms`。
- 每個 SDG module 初版建議限制在 200 至 600 個高價值 terms，避免檔案過大。
- 若 query 太大，優先保留多字片語與在 description/keyphrase 中也出現的詞。

### 5.2 Attribution 要求

頁面 footer 或 references 區必須顯示：

- Elsevier 2023 Sustainable Development Goals (SDGs) Mapping
- DOI: `10.17632/y2zyy9vwzy.1`
- License: `CC BY 4.0`
- URL: `https://elsevier.digitalcommonsdata.com/datasets/y2zyy9vwzy/1`
- UN SDGs URL: `https://sdgs.un.org/goals`
- NTHU SDGs URL: `https://sdgs.nthu.edu.tw/`

## 6. 介面草案

- Main workspace:
  - one large paste box labeled `Paste title, abstract, and keywords`
  - auto-detected `Title`, `Abstract`, and `Keywords` fields
  - primary buttons: `Check`, `Clear`, `Copy suggestions`
- Result summary panel:
  - `Decision: PASS` or `Decision: FAIL`
  - `Best-fit SDG`
  - `Secondary SDG candidates`
  - `Matched Elsevier query/keyphrase terms`
- Detailed review panel:
  - red-marked title/abstract/keywords
  - field-level suggestions
  - matched terms grouped by title, abstract, and keywords
- Data loading indicator:
  - show which SDG keyword module is loaded, e.g. `Loaded Elsevier keywords for SDG 13 Climate Action`
- 不需要安裝套件。

### 6.1 視覺設計規格

- Layout:
  - desktop: two-column workspace, input on the left and results on the right
  - mobile: single-column stacked layout
- Colors:
  - background: near-white or very light neutral
  - primary: deep green or teal
  - accent: amber or blue for SDG indicators
  - error/highlight: controlled red for revision marks
- Typography:
  - system font stack
  - readable sizes, no viewport-based font scaling
- Components:
  - 8px or smaller border radius
  - clear focus states
  - no nested cards
  - no decorative gradient blobs or unrelated illustrations
- Accessibility:
  - labels for all input fields
  - sufficient contrast
  - keyboard-accessible buttons
  - result status visible as text, not color only

### 6.2 Example Result Object

```javascript
{
  decision: "FAIL",
  bestFit: {
    id: 13,
    code: "SDG 13",
    name: "Climate Action",
    score: 18.5,
    confidence: "High"
  },
  secondary: [
    { id: 7, code: "SDG 7", name: "Affordable and Clean Energy", score: 12.4 }
  ],
  loadedModules: [13, 7],
  matchedTerms: {
    title: ["carbon footprint"],
    abstract: ["greenhouse gas emissions", "climate change"],
    keywords: []
  },
  reasons: [
    "Keywords do not include SDG-detectable terms for SDG 13."
  ],
  suggestions: [
    "Add one or more precise keywords such as climate change, greenhouse gas emissions, or carbon footprint."
  ]
}
```

## 7. 後續實作步驟

1. 從 `sources/elsevier-sdg-2023/queries/` 抽取 17 項 SDG 的核心 phrases。
2. 從 `sources/elsevier-sdg-2023/descriptions/` 補充 top keyphrases。
3. 建立輕量化 `assets/sdg-core-index.js`。
4. 建立 17 份 `assets/sdg-keywords/sdg-XX.js` 按需載入資料檔。
5. 建立精美、響應式的 `index.html`。
6. 實作自動拆分 title、abstract、keywords。
7. 實作 SDG pre-screening、lazy loading、final scoring、best-fit SDG、secondary candidates。
8. 實作明確 `PASS`/`FAIL` 判斷與理由。
9. 實作紅色標註與修改建議。
10. 加入範例輸入與人工修正欄位。
11. 用幾組中英文摘要測試，修正誤判規則。
12. 最後交付可部署到 GitHub Pages 的靜態前端檔案。

## 7.1 驗收標準

完成品必須符合：

- Opening `index.html` in a browser works.
- GitHub Pages deployment works without build step.
- No backend calls are required.
- User input remains local.
- The UI is polished and responsive.
- The app can parse combined title/abstract/keywords input.
- The app can show `PASS` or `FAIL`.
- The app can show `Best-fit SDG`.
- The app lazy-loads only relevant SDG keyword modules after pre-screening.
- The app shows red highlights for text needing revision.
- The app provides field-level suggestions.
- The references section lists Elsevier, UN SDGs, and NTHU SDGs sources.

## 7.2 測試案例

實作時至少用以下案例測試：

### Case A: Expected PASS, SDG 13

Title:
`Carbon footprint assessment of renewable energy adoption in semiconductor manufacturing`

Abstract:
`This study evaluates greenhouse gas emissions and carbon footprint reductions associated with renewable energy adoption in semiconductor manufacturing. Using life-cycle assessment and plant-level electricity consumption data, we estimate emission reduction potential and discuss implications for climate change mitigation. Results show that renewable electricity procurement can substantially reduce Scope 2 emissions.`

Keywords:
`carbon footprint; greenhouse gas emissions; renewable energy; climate change mitigation; life-cycle assessment`

Expected:

- `PASS`
- Best-fit SDG: `SDG 13 Climate Action`
- Secondary candidate may include `SDG 7 Affordable and Clean Energy`

### Case B: Expected FAIL, too generic

Title:
`A new model for system performance analysis`

Abstract:
`This paper proposes a new model and evaluates system performance. Results show improved accuracy and efficiency compared with existing methods.`

Keywords:
`model; system; performance; analysis`

Expected:

- `FAIL`
- No strong SDG match
- Red marks on generic title and keywords

### Case C: Expected FAIL, abstract only

Title:
`Optimization of urban sensor networks`

Abstract:
`The proposed method can support sustainable cities by improving air pollution monitoring and urban environmental management. Experiments show improved monitoring coverage.`

Keywords:
`sensor network; optimization; monitoring`

Expected:

- `FAIL` or low-confidence `PASS` depending threshold
- Best-fit SDG likely `SDG 11 Sustainable Cities and Communities`
- Suggest adding SDG-detectable terms to title and keywords

## 8. 需要確認的事項

- 已確認：介面以英文為主。
- 已確認：結果需要明確 `PASS` 或 `FAIL`。
- 已確認：結果需顯示最適合的 SDG 主題。
- 已確認：程式必須完全使用前端 HTML/CSS/JavaScript，可部署到 GitHub Pages。
- 已確認：前端介面需精美。
- 已確認：先依最可能 SDG 主題載入對應 Elsevier keywords，避免一次載入全部資料。
- 待確認：是否要支援純中文論文摘要，或第一版先以英文 title/abstract/keywords 為主。
