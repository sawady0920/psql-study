# クライアント接続デフォルト(CLIENT CONNECTION DEFAULT)

## client_encoding
以下は一例
- *UTF8*
- *EUC_JP*
- *SJIS*
- 参考: https://www.postgresql.jp/document/10/html/multibyte.html

|項目|説明|
|---|---|
|パラメータ型|文字列|
|デフォルト値|SQL_ASCII(この設定の場合、クライアントとデータベース間での自動変換はされない)|
|設定反映タイミング|いつでも|

例

```
client_encoding = 'SJIS'
```


