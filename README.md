# Terraform code for VMWare vSphere

VMware vSphere 用の Terraform コードサンプルです。

任意の個数の VM を Terraform で起動できます。

# Prequisite

vSphere vCenter Server が必要です。

# How to use

terraform.tfvars.sample を terraform.tfvars にコピーし、設定を行います。

その後 `terraform init`, `terraform deploy` でデプロイを実行します。

# Configurations

設定は terraform.tfvrs で行います。

## vCenter Server 設定

vCenter Server 接続設定として、以下の設定が必要です。

* vcenter_server: vCenter Server の FQDN
* user: vCenter Server 管理者のユーザ名
* password: vCenter Server 管理者のパスワード

vCenter Server には事前に datacenter, cluster を定義しておく必要があります。

* datacenter: datacenter名
* clustere: cluster名

network には、VM を接続するネットワーク名 ("VM Network" など)を指定します。

* network: network名

## VM 設定

VM の設定は vms に行います。vms には任意の個数の VM を指定できます。
設定項目は以下のコマンドを参照してください。

```
vms = {
  vm1 = {
    name = "vm1"
    datastore_name = "datastore1"
    iso_datastore_name = "datastore1"
    iso_path = "/ISOs/ubuntu-22.04.1-live-server-amd64.iso"
    guest_id = "ubuntu64Guest"
  }
}
```

設定項目は以下の通り。

* name: VMの名前
* datastore_name: VMを作成する datastore の名前
* iso_datastore_name: マウントする ISO を格納したデータストア名
* iso_path: マウントする ISO ファイルのデータストア内のパス
* guest_id: ゲストID
