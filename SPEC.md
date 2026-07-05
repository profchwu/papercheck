# 程式規格書

## 專案名稱

清華永續論文檢查工具 V1.1  
NTHU Sustainability Paper Checker V1.1

## 開發者標示

國立清華大學數理教育研究所 吳智鴻教授開發

## 修正日期

2026-07-05

## 專案目標

本專案旨在建立一個純前端網頁工具，協助使用者初步檢查論文的題名、摘要與關鍵字是否具有 SDG 永續發展目標的可辨識度，並提供以下結果：

- 明確的 `PASS` 或 `FAIL`
- 最適合的 SDG 主題
- 可能的次要 SDG 主題
- 命中的 SDG 關鍵詞
- 需要修改的紅色標註
- 題名、摘要與關鍵字的修改建議

本工具僅提供輔助判斷，最終是否採認仍須以國立清華大學正式審查與公告標準為準。

## 平台與技術需求

- 必須使用純前端技術：HTML、CSS、JavaScript。
- 必須可部署於 GitHub Pages。
- 不可依賴後端伺服器。
- 不可依賴資料庫。
- 不可依賴 API 金鑰。
- 不可依賴 AI API。
- 使用者輸入內容必須只在瀏覽器端處理。
- 介面以英文為主。
- 頁面需包含中文作者標示。
- 頁面需明確標示本工具為 independent reference tool，並非國立清華大學官方審查系統。

## 輸入需求

畫面需提供：

- 一個大型文字框，可讓使用者一次貼上 Title、Abstract 與 Keywords。
- 三個可編輯欄位：
  - Title
  - Abstract
  - Keywords

## 欄位解析規格

程式需能辨識寬鬆格式，不要求使用者完全依照固定格式貼上。

### 支援的欄位標籤

Title：

- `Title`
- `title`
- `TITLE`
- `Paper Title`
- `paper title`

Abstract：

- `Abstract`
- `abstract`
- `ABSTRACT`

Keywords：

- `Keyword`
- `Keywords`
- `Key words`
- `KEYWORDS`

### 標點符號規則

欄位標籤後方可以有或沒有：

- 半形冒號 `:`
- 全形冒號 `：`
- 連字號 `-`
- 破折號

### 格式 fallback

若沒有清楚標籤，程式需依照常見論文貼上格式判斷：

- 第一段為 Title
- 第二段為 Abstract
- 第三段為 Keywords

若文字只有換行、沒有空白段落：

- 第一行為 Title
- 最後一行若看起來像關鍵字，則作為 Keywords
- 中間內容作為 Abstract

若文字在 `ABSTRACT` 標籤之前有內容，且沒有明確 `Title` 標籤，則 `ABSTRACT` 前方內容需視為 Title。

## SDG 資料需求

程式使用下列資料：

- 聯合國 17 項 SDG 名稱與官方目標文字。
- Elsevier 2023 Sustainable Development Goals Mapping dataset。
- 17 個 SDG keyword 模組：
  - `assets/sdg-keywords/sdg-01.js`
  - `assets/sdg-keywords/sdg-02.js`
  - ...
  - `assets/sdg-keywords/sdg-17.js`

每一個 SDG keyword 模組需包含：

- SDG id
- SDG code
- SDG name
- 資料來源 attribution
- 正向命中詞
- 選用的排除詞或負向詞

### Elsevier query 轉換規格

資料轉換工具 `tools/build_sdg_data.ps1` 需支援下列 Elsevier query 格式：

- `TITLE-ABS-KEY(...)`
- `TITLE-ABS(...)`
- `AUTHKEY(...)`
- `TITLE(...)`
- 引號詞，例如 `"renewable energy"`
- 大括號詞，例如 `{ODA}`

轉換時需注意：

- 只將真正位於 `NOT (...)` 範圍內的詞列為 negative terms。
- 不可因為 query 中較早出現局部 `AND NOT (...)`，就把後續全部 query 誤判為排除詞。
- SDG 1 至 SDG 17 都必須產生可比對的正向 terms。
- 轉換後資料需保留 Elsevier SDG Mapping attribution 與 CC BY 4.0 授權標示。

## 檢查與評分規格

正式按下 `Check` 時，程式必須檢查 SDG 1 至 SDG 17 全部 keyword 模組，而不是只檢查預判最可能的 SDG。

### 欄位權重

```javascript
const FIELD_WEIGHTS = {
  title: 3,
  keywords: 3,
  abstract: 1.5
};
```

Title 與 Keywords 的權重較高，因為這兩個欄位通常是 SDG 檢索與採認判斷的重要訊號。

### PASS 門檻

```javascript
const PASS_THRESHOLDS = {
  finalScore: 12,
  titleOrKeywordMatch: 1,
  abstractMatch: 1,
  minKeywordCount: 3,
  minAbstractSignalTypes: 3
};
```

### 檢查項目

程式需檢查：

- Title 是否包含 SDG 可辨識詞。
- Abstract 是否包含 SDG 可辨識詞。
- Keywords 是否包含 SDG 可辨識詞。
- Keywords 是否至少有 3 個具體詞。
- Abstract 是否包含以下訊號：
  - 研究目的
  - 方法
  - 結果
  - 永續或 SDG 影響
- 是否出現排除詞或可能降低 SDG 關聯性的詞。
- 是否出現過度宣稱語句。

## 輸出規格

結果區需顯示：

- `PASS` 或 `FAIL`
- Confidence
- Best-fit SDG
- Secondary SDG candidates
- Checked Elsevier keyword modules
- Matched Elsevier-derived terms
- FAIL 的原因
- 修改建議

若最佳 SDG 分數低於 `PASS_THRESHOLDS.finalScore`，結果區不可把低分 SDG 顯示為可靠的 Best-fit SDG，需顯示：

`No reliable SDG match detected.`

標註區需顯示：

- Title review
- Abstract review
- Keywords review
- 綠色標註：命中的 SDG 詞
- 紅色標註：需要修改、補強或注意的內容

## 介面規格

- 版面需清楚、精美且可讀。
- 桌機版採兩欄式：
  - 左側輸入
  - 右側結果
- 手機版採單欄式。
- 按鈕包含：
  - Parse
  - Check
  - Load sample
  - Clear
- Copy suggestions
- 頁面最上方中間需顯示兩個英文指標：
  - `Checks`
  - `Page views`
- `Checks` 需在使用者按下 `Check` 時增加。
- `Page views` 需在頁面載入時增加。
- 兩個指標可使用瀏覽器 `localStorage` 本機累計，不需伺服器統計。
- 結果不可只依賴顏色，需有文字標示。
- 文字不可超出容器。
- 不製作行銷式 landing page，開啟後直接是可使用的工具。

## 資料來源標示

頁尾與文件需列出：

- Elsevier 2023 Sustainable Development Goals Mapping，DOI：`10.17632/y2zyy9vwzy.1`，CC BY 4.0。
- 聯合國永續發展目標。
- 國立清華大學 SDGs。
- `NOTICE.md` 需列出第三方資料授權、改作說明、非官方聲明與隱私說明。

## 法律與隱私聲明規格

網站與文件需明確說明：

- 本工具為獨立開發之學術參考工具。
- 本工具不是國立清華大學官方審查系統。
- `PASS`、`FAIL`、Best-fit SDG 與修改建議均為 rule-based suggestions。
- 最終採認結果必須以國立清華大學正式公告、正式規範與正式審查為準。
- Elsevier SDG terms 為依據 CC BY 4.0 授權資料整理、轉換、簡化後使用。
- Attribution does not imply endorsement by Elsevier, the United Nations, or National Tsing Hua University.
- 使用者貼上的論文 title、abstract 與 keywords 僅在瀏覽器本機分析，不由本工具上傳到伺服器。

## 已知限制

- 本工具是 rule-based checker，不是清華大學官方審查系統。
- 本工具不能保證論文一定被採認。
- Elsevier SDG mapping terms 是參考訊號，不等同於唯一官方標準。
- 某些詞可能同時對應多個 SDG。
- 最終解釋仍需人工審查。

## 驗證案例

### 案例一：永續教育論文

預期結果：

- `PASS`
- 最適合 SDG：`SDG 4 Quality Education`
- 需檢查全部 17 項 SDG

### 案例二：氣候變遷論文

預期結果：

- `PASS`
- 最適合 SDG：`SDG 13 Climate Action`

### 案例三：過於一般的技術論文

預期結果：

- `FAIL`
- SDG 可辨識度低
- 顯示 `No reliable SDG match detected.`
- 建議加入更具體的 SDG 相關題名、摘要或關鍵字

## V1.1 驗證重點

- 永續教育範例需正確解析 Title、Abstract、Keywords。
- 永續教育範例預期為 `PASS`，Best-fit SDG 為 `SDG 4 Quality Education`。
- lowercase labels、無冒號、段落 fallback 需可正確解析。
- 氣候變遷與再生能源範例預期為 `PASS`，Best-fit SDG 為 `SDG 13 Climate Action`。
- 弱相關範例預期為 `FAIL`，且顯示 `No reliable SDG match detected.`。
- SDG 1 至 SDG 17 的 keyword modules 均需載入且包含正向 terms。
