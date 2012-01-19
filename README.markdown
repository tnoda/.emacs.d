# .emacs.d - 個人的な Emacs 初期化ファイル

tnoda/.emacs.d は個人的な Emacs 初期化ファイルです．
誤りの指摘やアドバイスがありましたら，"Issues" に日本語でお願いします．

## 動作環境

* Emacs 23.3
* Mac OS X 10.6.8

## インストール

次のコマンドでインストーラを実行します．

    curl tnoda.github.com/.emacs.d/install | sh

このインストーラは tnoda/.emacs.d を clone するほか，
Git サブモジュールを初期化したり，

* APEL/SEMI/FLIM
* Wanderlust
* SKK
* Emacs-w3m
* Mew

をインストールしたりします．

インストーラの実行が完了すると，`~/.emacs.d/install.el` が作られます．
足りない elisp は，このファイルにあるフォームを上から一行ずつ
`C-x C-e` (`eval-last-sexp`) してインストールいってください．
`auto-install-*` なフォームは問題なく eval できますが，最初の
`package-install` の前に一度だけ，`M-x package-list-packages` して，
ELPA や Marmalade からパッケージ一覧を取得する必要があります．

## 構成ファイル

### init.el

`~/.emacs.d/*.org` を `org-babel-load-file` するだけのファイルです．
このファイルでは `tnoda/dotfiles-dir` 以外は何も設定していません．
コードは <http://orgmode.org/worg/org-contrib/babel/intro.html>
にある例を，ほぼそのまま使っています．

### tnoda.org

初期化ファイルの本体です．通常 `init.el` に書かれる設定は，
全てこのファイルに書かれています．Emacs 起動時には `init.el` が
このファイルを tangle して `tnoda.el` を生成・ロードします．

また，インストーラ実行時には，インストーラがこのファイルを
tangle して，各種インストールスクリプト (`install-*.sh`) を
生成・実行します．

## ライセンス

MIT-LICENSE ファイルを参照してください．
