# egor-a-p_infra
egor-a-p Infra repository

## Домашнее задание 3

### Конфигурация

bastion_IP = 35.198.167.169

someinternalhost_IP = 10.156.0.3 

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

