# MemoApp

## rubyのバージョン（rubyはすでにインストールされているものと仮定します）

ruby 3.3.0 (2023-12-25 revision 5124f9ac75)

## developmentモードでのアプリケーションの起動

1. リポジトリのクローン

```console
$ git clone -b thmz337-memo https://github.com/thmz337/memo_app.git
```

2. gemのインストール

```console
$ cd memo_app
$ bundle install 
```

3. アプリケーションの起動

```console
$ bundle exec rackup -p 4567
```

4. ブラウザで以下のURLを入力

```
http://localhost:9292/
```

## productionモードでの起動

1. リポジトリのクローン

```console
$ git clone -b thmz337-memo https://github.com/thmz337/memo_app.git
```

2. gemのインストール

```console
$ cd memo_app
$ bundle config set --local without test development
$ bundle install
```

3. アプリケーションの起動

```console
$ bundle exec rackup -p 4567 -E production
```

4. ブラウザで以下のURLを入力

```
http://localhost:9292/
```