# egor-a-p_infra
egor-a-p Infra repository

## Домашнее задание 3

### Конфигурация

bastion_IP = 35.206.137.210

someinternalhost_IP = 10.132.0.3

### Подключения к someinternalhost в одну команду:

Force pseudo-terminal allocation:  ```ssh -i ~/.ssh/appuser -t -A appuser@35.206.137.210 ssh 10.132.0.3```

Jump:  ```ssh -i ~/.ssh/appuser -J appuser@35.206.137.210 appuser@10.132.0.3```

### Подключение по алиасу someinternalhost

Добавить конфигурацию:

```
cat <<EOF >> ~/.ssh/config 
Host someinternalhost
HostName 10.132.0.3
User appuser
IdentityFile ~/.ssh/appuser
ForwardAgent yes
ProxyCommand ssh appuser@35.206.137.210 nc %h %p
EOF
```
Подключиться по алиасу: ```ssh someinternalhost```

## Домашнее задание 4

### Конфигурация

testapp_IP = 35.205.123.228

testapp_port = 9292

Создание инстанса со скриптом:

```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --metadata-from-file startup-script=startup_hw4.sh \
  --restart-on-failure
```  

Добавление правила в firewall:

```
gcloud compute firewall-rules create default-puma-server \
  --target-tags=puma-server \
  --allow tcp:9292
```

## Домашнее задание 4

Что сделано:

 - создание packer-ом образа reddit-base;
 - создание packer-ом образа reddit-full;
 - скрипт создания виртуальной машины на базе образа reddit-full.