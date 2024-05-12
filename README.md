# MemoApp

## rubyのバージョン（rubyはすでにインストールされているものと仮定します）

ruby 3.3.0 (2023-12-25 revision 5124f9ac75)

## developmentモードでのアプリケーションの起動

1. リポジトリのクローン

```console
$ git clone https://github.com/thmz337/memo_app.git
```

2. gemのインストール

```console
$ bundle install 
```

3. アプリケーションの起動

```console
$ bundle exec rackup
```

## productionモードでの起動

1. リポジトリのクローン

```console
$ git clone https://github.com/thmz337/memo_app.git
```

2. gemのインストール

```console
$ bundle config set --local without test development
$ bundle install
```

3. アプリケーションの起動

```console
$ bundle exec rackup -E production
```