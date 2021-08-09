# データベースクラスタ
- 1つのサーバインスタンスによって管理されるデータベースの集合体・格納領域のこと
- 実態は一つのディレクトリ
- PostgreSQL独自
- initdbで作成される
- 1つのサーバーに複数のデータベースクラスタを作成できる
- 複数のマシンで分散管理することはできない

```
root@postgres:/var/lib/postgresql/data# tree -d
.
├── PG_VERSION # メジャーバージョン(ex.11)
├── base/ # 各データベースのサブディレクトリを格納
│   ├── 1/
│   ├── 13066/
│   ├── 13067/
│   └── 16384/
├── global/ #DB間の共有情報(ユーザー情報など)
├── log/
├── pg_wal/ #トランザクションログを格納
│   └── archive_status
├── postgresql.conf # 基本パラメーター設定
├── pg_hba.conf # クライアントの認証情報を設定
└── postmaster.pid # pidを記録(ex. )

```

- Postgresサーバーに対して1対1
- 一つのサーバーは複数のPostgresサーバーを起動しうる?
- pg_hbaはHost Bus Adapterの略?

## WALとは
- DBの変更履歴ログ=トランザクションログ
- 障害時の復旧に利用する
- ログ先行書き込み(=Write Ahead Logging)



# システムカタログ
- pg_xx
- pg_database: 使用可能なデータベースの情報
    - oid: データベースオブジェクトに割り当てられたid
    - datname: データベース名
    - 参考: https://www.postgresql.jp/document/9.3/html/catalog-pg-database.html


# 最初から定義されているデータベース

|名前|説明|
|---|---|
|template0|Read Only|
|template1|template0のコピーでオブジェクト登録可能。|
|postgres|標準付属ツールのデフォルト接続先。|

- オブジェクト登録が不要の場合はtemnplate0を使う
- 以下、テンプレートの指定方法の例
    - デフォルトテンプレート（template1）を使う場合は、DEFAULTと指定する
    - 例:
        ```
        CREATE DATABASE music TEMPLATE template0;
        ```

# initdbコマンド
- データベースクラスタを作成するコマンド
- rootユーザーでは実行できない
- 作成したOSユーザーは*PostgreSQLの管理ユーザ*と呼ばれる
    - postgresユーザーでinitdbを実行すると管理ユーザはpostgresとなる

```
initdb --help
```

- 重要なものだけ抜粋

```
initdb initializes a PostgreSQL database cluster.

Usage:
  initdb [OPTION]... [DATADIR]

Options:
    -D, --pgdata=]DATADIR     location for this database cluster
    -E, --encoding=ENCODING   set default encoding for new databases
    --locale=LOCALE       set default locale for new databases
    --no-locale           equivalent to --locale=C
    -U, --username=NAME       database superuser name

If the data directory is not specified, the environment variable PGDATA
is used.
```

- 重要なのは以下

|オプション|説明|
|---|---|
|-D --pgdata |データベースクラスタを作成するディレクトリ|
|-E --encoding|文字をバイト列で表現するときのルール|
|--locale --no-locale|文字の並び順・分類・ログメッセージの言語・通過・数字・日時の書式|
|-u --username|作成するDBの管理ユーザ名を指定。未指定の場合はPostgreSQLの管理ユーザと同名になる|

## encoding
- 文字をバイト列で表現するときのルール
- DBに格納するときは「**データベースエンコーディング**(**サーバエンコーディング**)」と呼ぶ
- 日本語では通常、*UTF8*と*EUC_JP*が使われる
- *SJIS*は使用不可
- db単位で設定可能

## locale
- 設定すると検索性能が低くなる場合があるので、日本語を扱う場合には、無効が推奨されている
- db単位で設定可能

## 注意
- localeとencodingには互換性がない場合がある
- ロケールがja_JP.UTF-8の場合、エンコーディングはUTF8を使う
- 推奨通りロケールを無効にしている場合は、エンコーディングは何でもOK

## クライアントエンコーディング
- *UTF8*/*EUC_JP*/*SJIS*が使用可能
- PostgreSQLデータベースエンコーディングとクライアントエンコーディングを一致させる必要はない
- 自動変換を有効にするには、PostgreSQLのパラメータclient_encodingに設定する必要がある
    - 正しく設定しないと文字化けする
