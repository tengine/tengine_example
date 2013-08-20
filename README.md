# tengine_example

Tengine framework examples and deploy files.

## GettingStarted

より詳しい手順は [GettingStarted (イベントハンドリング編)](http://tengine.github.com/getting_started.html)をご覧ください。

### 必須要件

* MongoDB 2.0以降
* RabbitMQ 2.6.1以降

### インストール

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

### tengined 設定ファイルの変更

必要に応じて設定ファイルを変更します。各項目については [tenginedの設定ファイル](http://tengine.github.com/tengined_config.html) をご覧ください。


### イベントハンドラの動作確認

#### ターミナルA

```
$ cd tengine_example
$ bundle exec tengined -T app/event_dsl/uc01_execute_processing_for_event.rb
```


#### ターミナルB

```
$ cd tengine_example
$ bundle console
> sender = Tengine::Event::Sender.new(logger: Logger.new(STDOUT) )
> EM.run{ sender.fire(:event01) }
```

これで app/event_dsl/uc01_execute_processing_for_event.rb が動作して、
ターミナルAにhandler01と出力されます。


### ジョブの動作確認

#### ターミナルA

* tengine_job_agentのインストール

```
$ gem install tengine_job_agent
$ rbenv rehash # rbenvを使っているなら
```


```
$ cd tengine_example
```

* ジョブの実行サーバの登録

ここではlocalhostを実行サーバとして登録します

```
$ bundle exec tengine_resource server add localhost --addresses ip_address:127.0.0.1
```

登録確認

```
$ bundle exec tengine_resource server list
(snip)
+---------------+----------+-----------+--------+----------------------------+---------------------------+---------------------------+
|   provider    | virtual? |   name    | status |         addresses          |        created_at         |        updated_at         |
+---------------+----------+-----------+--------+----------------------------+---------------------------+---------------------------+
| ManualControl | physical | localhost |        | {"ip_address":"127.0.0.1"} | 2013-08-20T11:52:12+09:00 | 2013-08-20T11:52:12+09:00 |
+---------------+----------+-----------+--------+----------------------------+---------------------------+---------------------------+
```


* 実行サーバへの認証情報の登録

以下のusername,xxxxxxxxはローカルホストのユーザー名パスワードに変更して実行してください。

```
$ bundle exec tengine_resource credential add ssh_pk --username username --password xxxxxxxx
```

登録確認

```
$ bundle exec tengine_resource credential list
(snip)
+--------+-----------------------------------------------+---------------------------+---------------------------+
|  name  |                  auth_values                  |        created_at         |        updated_at         |
+--------+-----------------------------------------------+---------------------------+---------------------------+
| ssh_pk | {"username":"goku","password":"xxxxxxxxxxxx"} | 2013-08-20T11:53:27+09:00 | 2013-08-20T11:53:27+09:00 |
+--------+-----------------------------------------------+---------------------------+---------------------------+
```

* tenginedデーモン起動

```
$ export MM_CMD_PREFIX="cd `pwd` && bundle exec" # bundlerを使っている場合
$ bundle exec tengined -T app/job_dsl/hello_world.rb
```



#### ターミナルB

```
$ cd tengine_example
$ bundle exec tengine_job list
(snip)
+-------------+--------+----------+-----------+------------+---------------------------+---------------------------+
|    name     |  type  | category |  server   | credential |        created_at         |        updated_at         |
+-------------+--------+----------+-----------+------------+---------------------------+---------------------------+
| root_jobnet | normal | job_dsl  | localhost | ssh_pk     | 2013-08-20T11:34:36+09:00 | 2013-08-20T11:34:36+09:00 |
+-------------+--------+----------+-----------+------------+---------------------------+---------------------------+
```

ジョブが登録されていることを確認


```
$ bundle exec tengine_job kick root_jobnet
```


ターミナルAの方に以下のような出力が出たらOK
```
2013-08-20T12:27:33+09:00 INFO  /Users/akima/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/tengine_job-1.2.0/lib/tengine/job/runtime/jobnet.rb#153 Tengine::Job::Runtime::RootJobnet#finish
```




## Copyright

Copyright (c) 2012 - 2013 Groovenauts, Inc.  See LICENSE.txt for further details.
