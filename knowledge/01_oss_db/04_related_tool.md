# pgAdmin4
- クライアントツール

# pg_ctl
- 起動・停止・状態管理に使う
- rootユーザーでは、実行できないので注意
```
$ pg_ctl status
pg_ctl: cannot be run as root
Please log in (using, e.g., "su") as the (unprivileged) user that will own the server process.
```

## pg_ctl stop

|オプション|説明|
|---|---|
|-D --pgdata|データベースクラスタ指定|
|-W|完了するまで待たない|
|-t|最大待ち時間。単位は秒。デフォルトは60s。|
|-m|シャットダウンモード｜

## pg_ctl restart

|オプション|説明|
|---|---|
|-D --pgdata|データベースクラスタ指定|
|-t|最大待ち時間。単位は秒。デフォルトは60s。|
|-m|シャットダウンモード｜

## **シャットダウンモード**について
|モード|名|説明|
|---|---|---|
|s[mart]|スマートシャットダウン|切断を待ってから停止。|
|f[ast]|高速シャットダウン|デフォルト。強制切断してトランザクションをロールバック。その後停止。|
|i[mmidiate]|即時シャットダウン|クリーンアップをせずに停止。クラッシュと同じ。次回起動時には復旧処理が必要。基本使わないはず。障害再現のときに使うイメージ|

## pg_ctl reload
- 設定ファイルの再読み込み
    - postgres.conf
    - pg_hba.conf
- パラメーターによっては反映されないものもあるので注意


## pg_ctl status
- 起動状態を見る

## pg_ctl kill
- プロセスにシグナルを送る
    - 送信可能シグナル: HUP/INT/QUIT/ABRT/TERM/USR1/USR2

|シグナル|説明|
|---|---|
|TERM|スマートシャットダウン|
|INT|高速シャットダウン|
|QUIT|即時シャットダウン|
|HUP|設定ファイル再読み込み|