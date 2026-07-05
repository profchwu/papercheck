# 第三方資料與免責聲明

本專案為獨立開發之學術參考工具，並非國立清華大學、Elsevier 或聯合國之官方系統。

## Elsevier SDG Mapping Data

本工具使用並整理下列公開資料作為 SDG 關鍵詞比對參考：

- 資料名稱：Elsevier 2023 Sustainable Development Goals (SDGs) Mapping
- DOI：10.17632/y2zyy9vwzy.1
- 來源：https://elsevier.digitalcommonsdata.com/datasets/y2zyy9vwzy/1
- 授權：Creative Commons Attribution 4.0 International (CC BY 4.0)
- 授權連結：https://creativecommons.org/licenses/by/4.0/

本專案已將該資料轉換、篩選、簡化並整理為瀏覽器端可載入的 SDG keyword 模組，用於規則式文字比對。上述改作與整理不代表 Elsevier 對本工具、判斷結果或使用方式有任何背書、保證或認可。

V1.1 版資料轉換支援 Elsevier query 中的 `TITLE-ABS-KEY(...)`、`TITLE-ABS(...)`、`AUTHKEY(...)` 與 `TITLE(...)` 格式，並將局部 `NOT (...)` 內容整理為排除詞，以避免將排除條件誤作為正向 SDG terms。

## UN SDGs

本工具參考聯合國永續發展目標名稱與目標分類：

- United Nations Sustainable Development Goals
- 來源：https://sdgs.un.org/goals

本工具未使用聯合國官方標誌或官方 SDG 圖示作為品牌識別。本工具不代表聯合國官方工具，也不表示聯合國對本工具有任何背書。

## National Tsing Hua University

本工具以國立清華大學永續論文採認情境作為使用情境參考，但不是國立清華大學官方審查系統。畫面中的 PASS、FAIL、SDG match 與修改建議均為本工具依內建規則產生之輔助判斷。

最終採認結果必須以國立清華大學正式公告、正式規範與正式審查結果為準。

## Privacy Notice

本工具為純前端網頁。使用者貼上的 title、abstract 與 keywords 會在瀏覽器本機分析，不會由本工具上傳到伺服器。Checks 與 Page views 僅儲存在使用者瀏覽器的 localStorage。
