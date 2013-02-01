# tengine_example

Tengine framework examples and deploy files.

## GettingStarted

より詳しい手順は [GettingStarted (イベントハンドリング編)](http://tengine.github.com/getting_started.html)をご覧ください。

### インストール

* MongoDBをインストール
* RabbitMQをインストール

    $ git clone git://github.com/tengine/tengine_example.git
    $ cd tengine_example
    $ bundle install

### 接続テスト

localhost上でMongoDBとRabbitMQがデフォルトのポートで動作している場合、以下のコマンドでtenginedの動作確認ができます。

    $ bundle exec tengined -k test
    
上記コマンドを実行した結果、以下の出力が得られることを確認します

    STDOUT  Connection test success.


### 設定ファイルをひな形のファイルからコピーして作成

configディレクトリ以下のファイルはすべて環境によって変更することを前提としていますので、.exampleという拡張子がついています。
これを .example を取り除いたファイル名でコピーします。

    $ for i in config/*.example; do cp $i `echo $i | sed s/.example//`; done

###  tengined 設定ファイルの変更

必要に応じて設定ファイルを変更します。各項目については [tenginedの設定ファイル](http://tengine.github.com/tengined_config.html) をご覧ください。


## Copyright

Copyright (c) 2012 - 2013 Groovenauts, Inc.  See LICENSE.txt for further details.
