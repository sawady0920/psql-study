# CURSOR

以下のイメージで実行できる
```
BEGIN;
DECLARE curs2 CURSOR FOR SELECT * from chords;
FETCH FORWARD 2 FROM curs2;
MOVE FORWARD 2 FROM curs2;
FETCH FORWARD 2 FROM curs2;
MOVE FORWARD 2 FROM curs2;
FETCH FORWARD 2 FROM curs2;
```

## 宣言

### 構文
```
DECLARE カーソル名 [SCROLL] CURSOR [{WITH|WITHOUT} HOLD] FOR クエリ
```

|オプション|説明|
|----------|---------|
|SCROLL|順方向/逆方向にアクセス|
|NO SCROLL|順方向のみアクセス|
|WITH HOLD|トランザクション終了後もカーソル維持| 
|WITHOUT HOLD|トランザクション終了後、カーソル維持しない| 
他にもFOR UPDATE/FOR READ ONLY/INSENSITIVEがある


## フェッチ

### 構文
```
FETCH { オプション { FROM | IN } } カーソル名
```

## クローズ

### 構文
CLOSE { カーソル名 | ALL }