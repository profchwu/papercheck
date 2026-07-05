# 清華永續論文檢查工具 V1.1

國立清華大學數理教育研究所 吳智鴻教授開發

本工具是一個純前端、可部署於 GitHub Pages 的網頁檢查程式，用來協助使用者初步判斷論文的題名、摘要與關鍵字是否具有足夠的 SDG 永續發展目標可辨識度。程式不需要後端伺服器、資料庫、API 金鑰或登入系統。

公開網址：  
https://profchwu.github.io/papercheck/

GitHub repository：  
https://github.com/profchwu/papercheck

## 重要聲明

本工具為獨立開發之學術參考工具，不是國立清華大學官方審查系統，也不代表國立清華大學、Elsevier 或聯合國之官方立場。

畫面中的 `PASS` 或 `FAIL` 是依據本工具內建規則與整理後的 SDG 對應資料所產生的輔助判斷，最終採認結果仍須以國立清華大學正式公告、正式規範與正式審查結果為準。

本工具使用之 SDG terms 係根據公開資料來源整理、轉換與簡化，不表示資料來源方對本工具、判斷結果或使用方式有任何背書、保證或認可。

## 主要功能

- 可一次貼上論文的題名、摘要與關鍵字。
- 自動拆分 `Title`、`Abstract`、`Keywords` 三個欄位。
- 欄位標籤判斷採寬鬆規則：
  - 支援 `Title`、`title`、`TITLE`
  - 支援 `Abstract`、`abstract`、`ABSTRACT`
  - 支援 `Keyword`、`Keywords`、`Key words`、`KEYWORDS`
  - 不強制要求冒號
  - 支援全形冒號、半形冒號、連字號與破折號
- 支援常見貼上格式：
  - 第一段為 Title，第二段為 Abstract，第三段為 Keywords
  - Title 在 `ABSTRACT` 標籤之前
  - 最後一段或最後一行為 `Keywords`
  - 同一行連續出現 `Title ... Abstract ... Keywords ...`
- 正式檢查時會比對 SDG 1 至 SDG 17 全部 Elsevier-derived keyword 模組。
- 顯示明確的 `PASS` 或 `FAIL`。
- 顯示最適合的 SDG 主題與可能的次要 SDG。
- 顯示命中的 SDG 相關詞。
- 對需要修改或補強的位置提供紅色標註。
- 提供題名、摘要與關鍵字的修改建議。
- 頁面上方顯示英文統計指標 `Checks` 與 `Page views`。
- 當分數低於 PASS 門檻時，顯示 `No reliable SDG match detected.`，避免將低可信度比對誤認為可靠 SDG。

## 目前版本

### V1.1 - 修正日期：2026-07-05

- 修正 Elsevier query 轉換工具，支援 `TITLE-ABS-KEY(...)` 與 `TITLE(...)` 格式。
- 修正局部 `NOT (...)` 造成後續正向 keyword 被誤判為排除詞的問題。
- 重新產生 SDG 1 至 SDG 17 全部 keyword 模組，確保 17 項 SDG 都有可比對的正向 terms。
- 當論文文字與 SDG 的分數低於門檻時，畫面改顯示 `No reliable SDG match detected.`，避免在 `FAIL` 情境下誤導使用者。
- 重新測試範例論文，確認欄位解析、17 項 SDG 載入、PASS/FAIL 與最佳 SDG 判斷皆可正常運作。

### V1.0 - 修正日期：2026-07-04

- 加入頁面標題：`NTHU Sustainability Paper Checker V1.0`。
- 加入修正日期：`Revised 2026-07-04`。
- 加入中文作者標示：`國立清華大學數理教育研究所 吳智鴻教授開發`。
- 加入英文免責說明，強調結果僅供參考，最終仍以清華大學認定為準。
- 將正式檢查流程改為掃描 SDG 1 至 SDG 17 全部 keyword 模組。
- 放寬 Title、Abstract、Keywords 欄位解析規則。
- 修正「Title 出現在 ABSTRACT 標籤之前」時無法正確抓取題名的問題。
- 支援大小寫混用、無冒號、同一行欄位標籤等格式。
- 修正部分 SDG 模組排除詞格式不同時可能造成中斷的問題。

## 版本更新紀錄

### 初始 GitHub Pages 版本

- 建立純 HTML/CSS/JavaScript 的靜態網頁工具。
- 建立貼上區、Title、Abstract、Keywords 三個欄位。
- 建立 PASS/FAIL 結果區、最佳 SDG 顯示、命中詞與紅色修正標註。
- 建立 Elsevier-derived SDG keyword 模組。

### 欄位解析改進

- 增加段落式解析：
  - 第一段為 Title
  - 第二段為 Abstract
  - 第三段為 Keywords
- 增加無空白行時的行解析 fallback。
- 改善混合格式貼上時的判斷。

### 作者與免責聲明更新

- 加入開發者標示。
- 加入英文說明：本工具結果僅供參考，最終判定以清華大學為準。

### V1.0 全 17 項 SDG 檢查

- 將正式檢查改為掃描全部 17 項 SDG。
- 畫面文字改為 `Checked Elsevier keyword modules`。
- 使用永續教育範例測試，結果為 `PASS`，最佳 SDG 為 `SDG 4 Quality Education`。

## 測試範例

測試論文題名：

`Combining experiential learning with digital game-based learning to enhance learning motivation, reduce cognitive load and increase acceptance of sustainable education`

測試關鍵字：

`Experiential learning, Digital game-based learning, Sustainable education, Sustainable education game, Cognitive load, Motivation`

測試結果：

- 判定：`PASS`
- 最適合 SDG：`SDG 4 Quality Education`
- 已檢查 SDG 1 至 SDG 17 共 17 項
- 主要命中詞：`education`、`learning`、`barrier`、`design`

V1.1 另以寬鬆格式與弱相關文字重新測試：

- 小寫欄位標籤、無冒號格式可正確解析。
- 段落 fallback 可正確解析。
- 氣候變遷與再生能源範例可判定為 `PASS`，最佳 SDG 為 `SDG 13 Climate Action`。
- 弱相關範例可判定為 `FAIL`，並顯示 `No reliable SDG match detected.`。

## 資料來源

- Elsevier 2023 Sustainable Development Goals Mapping，DOI：`10.17632/y2zyy9vwzy.1`，授權：CC BY 4.0  
  https://elsevier.digitalcommonsdata.com/datasets/y2zyy9vwzy/1
- 聯合國永續發展目標  
  https://sdgs.un.org/goals
- 國立清華大學 SDGs  
  https://sdgs.nthu.edu.tw/

詳細第三方資料告知、授權標示與免責聲明請見：`NOTICE.md`。

## 隱私說明

本工具為純前端網頁。使用者貼上的 title、abstract 與 keywords 會在瀏覽器本機分析，不會由本工具上傳到伺服器。Checks 與 Page views 僅儲存在使用者瀏覽器的 localStorage。

## 專案檔案

- `index.html`：主要網頁程式。
- `assets/sdg-core-index.js`：SDG 核心索引資料。
- `assets/sdg-keywords/sdg-01.js` 至 `assets/sdg-keywords/sdg-17.js`：17 項 SDG keyword 模組。
- `README.md`：程式說明與版本紀錄。
- `SPEC.md`：程式規格書。
- `Prompt.md`：開發提示詞與過程彙整。
- `sources/references.md`：資料來源紀錄。
- `NOTICE.md`：第三方資料授權、改作、非官方與隱私聲明。
- `tools/build_sdg_data.ps1`：Elsevier query 轉換與 SDG keyword 模組產生工具。

## 部署方式

本工具適合部署於 GitHub Pages。

1. 將 `index.html` 與 `assets/` 放在 repository 根目錄。
2. 進入 GitHub repository 的 Pages 設定。
3. 選擇 `main` branch。
4. 選擇 `/ (root)`。
5. 儲存後開啟 GitHub Pages 網址。

本工具不需要建置步驟。
