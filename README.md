# README

* superset
  * <https://superset.apache.org>
* Redush
  * <https://redash.io>

## superset:2.1.0の構築

### 注意

* apach:2.0.1以下のバージョンには脆弱性あり
  * デフォルトのシークレットキーを使っている場合
  * CVE-2023-27524 (CVSS：8.9)

* `PASSWORD`や`SECRET_KEY`は適切に管理してください。

### 構築手順

* docker compose up -d
* ./superset/init.sh
* localhost:8088にアクセス
* user名: admin、password: adminでログイン

### 説明

### superset

* SECRET_KEYをenv_fileにて設定。
  * env_fileはコンテナ内の環境変数を設定できる。
  * 新しいSECRET_KEYを設定したら、`superset re-encrypt-secrets`を実行。
  * その他、PASSWORD類も環境変数管理

* `init.sh`
  * supersetコンテナで初めに実行するコマンド集
    * `superset re-encrypt-secrets`はSECRET_KEYの更新に必要。
      * デフォルトのままでは作業できない。
    * `superset load-examples`はサンプルの設定なので不要であればコメントアウト。
    * admin userの作成を行うので、適宜変更。

* `config.py`
  * supersetコンテナの`/app/superset/config.py`に配置されている、設定ファイル。
  * dbやcacheサーバへの接続や言語設定など、様々な設定を管理している。
  * 今回はmysqlへの接続を記載。

  ```python
  # The SQLAlchemy connection string.
  # コメントアウト(デフォルト設定)
  # SQLALCHEMY_DATABASE_URI = "sqlite:///" + os.path.join(DATA_DIR, "superset.db")
  # 追加(mysql://{USERNAME:PASSWORD@HOST/DATABASE})
  SQLALCHEMY_DATABASE_URI = 'mysql://' + os.environ['MYSQL_USER'] + ':' + os.environ['MYSQL_PASSWORD'] + '@db/superset'
  ```

  * 言語設定の変更

  ```python
  # BABEL_DEFAULT_LOCALE = "en"
  BABEL_DEFAULT_LOCALE = "ja"
  ```

  * REDISの設定

  ```python
  GLOBAL_ASYNC_QUERIES_REDIS_CONFIG = {
    "port": 6379,
    "host": "cache",
    "password": "",
    "db": 0,
    "ssl": False,
  }
  ```

### db

* docker-entrypoint-initdb.dに`create database superset`を配置
  * 初回実行時にsupersetで利用するsupersetデータベースを作成
