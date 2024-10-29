#!/bin/bash

echo cd ~
echo cd dify/docker
echo git pull origin main
echo docker compose down
echo docker compose pull
echo docker compose up -d
echo docker ps -a
echo 以降は手動実行
echo 
echo 
echo docker rm <CONTAINER ID>
echo docker rm --force <CONTAINER ID>
echo sudo lsof -i -P | grep "LISTEN"
echo sudo kill
echo sudo rm -rf dify
echo git clone https://github.com/langgenius/dify.git
echo 
echo 
echo 依存関係：https://note.com/ai_tarou/n/n4899f0058fe5
echo 1. サンドボックスコンテナ内にアクセス
echo 　Difyが動作しているサンドボックスコンテナ（例：docker-sandbox-1）にアクセスします。
echo docker exec -it docker-sandbox-1 /bin/bash
echo 
echo 2. python-requirements.txtファイルの確認と編集
echo 　依存関係が記述されているpython-requirements.txtファイルが存在するか確認し、必要なパッケージを追加します。
echo 　不要　find / -name "python-requirements.txt"
echo 　ファイルが存在した場合、以下のコマンドで内容を確認します。
echo cat /dependencies/python-requirements.txt
echo 　もしファイルが空であれば、以下のコマンドでrequestsとその依存関係を追加
echo 例：echo "requests" >> /dependencies/python-requirements.txt
echo 
echo 4. パッケージの依存関係チェック
echo 　インストールが正しく行われたかを確認するために、依存関係をチェックします。
echo pip check
echo 　問題がなければ、OKです。
echo 
echo 5. キャッシュのクリア
echo 　古いキャッシュが影響している可能性があるため、pipキャッシュをクリアします。
echo pip cache purge
echo 
echo 6. サンドボックスの再起動
echo 　ホスト環境に戻り、コンテナを再起動して依存関係を反映させます。
echo exit
echo docker restart docker-sandbox-1
echo 
echo 7. 動作確認
echo dify起動
echo 
echo エラー処理
echo ping google.comできない
echo sudo nano /etc/resolv.conf　でDNSサーバを変更する
echo  nameserver 8.8.8.8
echo  nameserver 8.8.4.4
echo これを入れる
echo エラー処理終わり
echo 
echo エラー処理
echo difyが再起動ループしていた。
echo 原因は、pythonモジュールのインストール失敗らしい
echo 面倒だから、dify再インストールしようとした。
echo ~ディレクトリで、difyをgit clone https://github.com/langgenius/dify.gitできなかった。
echo sudo rm -rf dify*をやっても、すぐにdifyディレクトリが生まれる
echo docker psでdify関係が動いているので、全部止める
echo docker stop <CONTAINER ID>
echo docker psでdifyの停止を確認
echo git clone https://github.com/langgenius/dify.gitできた！
echo cd dify/docker
echo docker compose up -d　で起動
echo エラー処理終わり
echo エラー処理

cd ~
cd dify/docker

git pull origin main
docker compose down
docker compose pull
docker compose up -d
docker ps -a
