# 開發提示詞與過程彙整

本文件整理「清華永續論文檢查工具 V1.0」的需求形成、資料蒐集、開發與修正過程，可作為之後使用其他 AI 開發工具重建或擴充本專案的依據。

## 一、最初需求

使用者希望建立一個 HTML 版本的檢查程式，可讓使用者上傳或貼上論文的題名、摘要與關鍵字，並針對是否符合「清華大學永續論文」相關規範提供修改建議。

核心要求包括：

- 程式必須是純前端網頁技術。
- 必須方便部署到 GitHub Pages。
- 使用者可以一次貼上 Title、Abstract、Keywords。
- 程式需自動分辨三個欄位。
- 需提供整體建議。
- 需要修改的地方要以紅色標註。
- 採認風險必須有明確的 `PASS` 或 `FAIL`。
- 檢查結果需顯示最適合的 SDG 主題。
- 介面以英文為主。
- 網頁需精美、可直接使用。

## 二、資料蒐集需求

使用者要求在開始寫程式前，先上網搜尋並下載相關資料。

資料蒐集方向包括：

- 清華大學 SDGs 與永續論文採認相關資料。
- Elsevier 2023 SDG Mapping dataset。
- SDG 17 項相關 keyword/query 文件。
- 聯合國 SDG 官方資料。
- 其他 SDG mapping 或研究分類相關資料。

主要參考來源：

- 國立清華大學 SDGs  
  https://sdgs.nthu.edu.tw/
- Elsevier 2023 Sustainable Development Goals Mapping  
  https://elsevier.digitalcommonsdata.com/datasets/y2zyy9vwzy/1
- 聯合國永續發展目標  
  https://sdgs.un.org/goals

## 三、規劃書需求

使用者要求先寫程式規劃書，並且規劃書需能讓其他 AI 開發工具依據該文件完成程式。

規劃書需包含：

- 程式功能
- 需要參考的資料來源連結
- 下載檔案
- 前端技術架構
- SDG 檢查邏輯
- PASS/FAIL 判斷規則
- UI 設計方向
- 部署方式
- 限制與免責聲明

後續也要求規劃書必須明確說明：

- 本工具不能完全取代清華大學官方認定。
- 判斷結果僅供參考。
- 最終採認仍需以清華大學正式標準為準。

## 四、程式實作需求

使用者要求直接寫出程式。

實作內容包括：

- `index.html`
- `assets/sdg-core-index.js`
- `assets/sdg-keywords/sdg-01.js` 至 `sdg-17.js`
- `sources/references.md`
- `tools/build_sdg_data.ps1`

主要功能包括：

- 大型貼上文字框。
- 自動解析 Title、Abstract、Keywords。
- 可手動編輯三個欄位。
- 檢查 SDG keyword 命中。
- 顯示 `PASS` 或 `FAIL`。
- 顯示最佳 SDG。
- 顯示命中詞。
- 顯示紅色修正標註。
- 顯示修改建議。

## 五、GitHub 部署需求

使用者要求建立新的 GitHub repository：

- repo 名稱：`papercheck`
- public repository
- 部署到 GitHub Pages

過程中因命令列 GitHub 帳號與 repository owner 權限不一致，改用 GitHub 網頁介面完成檔案上傳與 GitHub Pages 設定。

GitHub repository：  
https://github.com/profchwu/papercheck

GitHub Pages：  
https://profchwu.github.io/papercheck/

## 六、欄位解析修正需求

使用者指出 Title、Abstract、Keywords 的判斷需要更準確，不應要求嚴格格式。

使用者提供的規則：

- 通常第一個段落是 Title。
- 第二個段落是 Abstract。
- 第三個部分是 Keyword。

後續又要求：

- `Title:`
- `Abstract:`
- `Keywords:`

這三個欄位格式抓取需更寬鬆。

實作後支援：

- 大小寫不敏感。
- 冒號可有可無。
- 支援全形冒號。
- 支援連字號與破折號。
- 支援 `Keyword`、`Keywords`、`Key words`。
- 支援 Title 在 `ABSTRACT` 標籤前面的格式。
- 支援同一行連續標籤。

## 七、作者與免責聲明需求

使用者要求在標題區加入：

`國立清華大學數理教育研究所 吳智鴻教授開發`

並加入英文說明：

- 本判斷結果僅供參考。
- 判定結果仍需以清華大學為準。

實作後頁面包含：

- 中文作者標示。
- 英文 reference-only disclaimer。
- 明確指出 final recognition decision must follow National Tsing Hua University's official review and standards。

## 八、範例測試需求

使用者提供一篇永續教育與遊戲式學習相關論文範例，要求檢查：

- 是否能正確抓到 Title。
- 是否能正確抓到 Abstract。
- 是否能正確抓到 Keywords。
- 是否能判斷是否通過。
- 是否能抓到正確 SDG。

測試結果：

- Title 正確抓取。
- Abstract 正確抓取。
- Keywords 正確抓取。
- 判定為 `PASS`。
- 最適合 SDG 為 `SDG 4 Quality Education`。
- 命中詞包含 `education`、`learning`、`barrier`、`design`。

## 九、全 17 項 SDG 檢查需求

使用者詢問程式是否正確檢查 SDG 17 項的精準 keywords。

檢查後發現：

- 舊版流程是先預判最可能 SDG，再載入相近 SDG 的 keyword 模組。
- 這樣速度較快，但不能稱為完整檢查 17 項 SDG。

因此 V1.0 修正為：

- 正式按下 `Check` 時，掃描 SDG 1 至 SDG 17 全部 Elsevier-derived keyword 模組。
- UI 改為顯示 `Checked Elsevier keyword modules`。
- 修正部分 SDG 模組排除詞格式造成中斷的問題。

## 十、版本號與日期需求

使用者要求標題加入版本號，從 V1.0 開始算，並加入修正日期。

實作後：

- 頁面標題：`NTHU Sustainability Paper Checker V1.0`
- 修正日期：`Revised 2026-07-04`
- 作者：`國立清華大學數理教育研究所 吳智鴻教授開發`

## 十一、文件化需求

使用者要求製作：

- `README.md`
- 程式規格書
- `Prompt.md`

並且本機資料夾與 GitHub 都要有一份。

後續使用者要求這些文件必須全部改為中文。

本次文件包含：

- `README.md`：程式說明、主要功能、版本紀錄、資料來源與部署方式。
- `SPEC.md`：程式規格、欄位解析規則、SDG 檢查邏輯、PASS/FAIL 門檻、UI 規格與限制。
- `Prompt.md`：需求、提示詞、開發與修正過程彙整。

## 十二、可重用開發提示詞

以下提示詞可用於其他 AI 開發工具重建或延伸本專案：

```text
請建立一個可部署於 GitHub Pages 的純前端網頁工具，名稱為「清華永續論文檢查工具」。
程式只能使用 HTML、CSS、JavaScript，不可使用後端、資料庫、API key 或 AI API。
使用者需能一次貼上論文的 Title、Abstract、Keywords。
欄位解析必須寬鬆，支援大小寫不同、冒號有無不同、段落式貼上、Title 在 ABSTRACT 前方，以及 Keywords 在最後一段或最後一行的格式。
程式需依據 Elsevier 2023 SDG Mapping dataset 建立 SDG 1 至 SDG 17 的 keyword 模組。
正式檢查時必須掃描全部 17 項 SDG keyword 模組。
結果需顯示 PASS 或 FAIL、最佳 SDG、次要 SDG、命中詞、修改建議與紅色標註。
頁面需加入標題 NTHU Sustainability Paper Checker V1.0。
頁面需加入修正日期 Revised 2026-07-04。
頁面需加入作者標示：國立清華大學數理教育研究所 吳智鴻教授開發。
需加入英文免責聲明：結果僅供參考，最終認定以國立清華大學正式審查與標準為準。
請建立 README.md、SPEC.md、Prompt.md，並以中文撰寫。
```

