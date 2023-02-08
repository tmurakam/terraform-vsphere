# Terraform code for VMware vSphere

VMware vSphere 用の Terraform コードサンプルです。

任意の個数の VM を Terraform で起動できます。

# Prerequisite

* vSphere vCenter Server が必要です。
* datacenter, cluster を定義しておく必要があります。
* VM作成にあたり、事前にVMテンプレートを作成しておく必要があります。

# How to use

terraform.tfvars.sample を terraform.tfvars にコピーし、設定を行います。

その後 `terraform init`, `terraform deploy` でデプロイを実行します。

各 VM に割り当てられた IP アドレスは `terraform output --json` で取得できます。

# Configurations

設定は terraform.tfvars で行います。

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

## VM 共通

VM の共通設定です。

* vm_template_name: VMテンプレート名
  - 全 VM は、このテンプレートを clone して作成します
* vm_num_cpus: CPU数
* vm_memory: メモリ量 (MB)
* vm_disk_size: ディスクサイズ (GB)

## VM 個別

VM インスタンスごとの設定は `vms` で設定行います。vms には任意の個数の VM を指定できます。

設定例は以下を参照してください。

```
vms = {
  vm1 = {
    name = "vm1"
    datastore_name = "datastore1"
  }
}
```

設定項目は以下の通り。

* name: VMの名前 (ホスト名にもなります)
* datastore_name: VMを格納する datastore の名前

デフォルトでは DHCP により IP アドレスは自動で設定されます。

### DHCP を使用しない場合

DHCP を使用しない場合の例を示します。この場合、IPアドレスはすべて手動で設定する必要があります。

```
dhcp = false

vms = {
  vm1 = {
    name = "vm1"
    datastore_name = "datastore1"
    ipv4_address = "192.168.0.10"
    ipv4_netmask = 24
    ipv4_gateway = "192.168.0.1"
  }
}

dns_servers = [ "192.168.1.1", "8.8.8.8" ]
```

* dhcp: false に設定
* vms
    * ipv4_address: IPv4アドレス
    * ipv4_netmask: ネットマスク長
    * ipv4_gateway: IPv4デフォルトゲートウェイ
* dns_servers: DNSサーバアドレス