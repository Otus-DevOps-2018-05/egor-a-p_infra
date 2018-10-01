[![Build Status](https://travis-ci.org/Otus-DevOps-2018-05/egor-a-p_infra.svg?branch=master)](https://travis-ci.org/Otus-DevOps-2018-05/egor-a-p_infra)
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

## Домашнее задание 5

Что сделано:

 - создание packer-ом образа reddit-base;
 - создание packer-ом образа reddit-full;
 - скрипт создания виртуальной машины на базе образа reddit-full.
 
 ## Домашнее задание 6
 
Что сделано:
 
 - добавил в идейку плагин для terraform-a;
 - конфигурация инстанса с помощью terraform;
 - вывод ip-адреса инстанса;
 - конфигурация firewall с помощью terraform;
 - деплой тестового приложения с помощью provisioners,
 - объявление перменных и использование их в конфигурации.
 
Задание со *:

 - довалены ключи для пользователей appuser1 и appuser2;
 - после добавления ключа через web интерфейс GCP и применение конфигурации terraform добавленный ключ был потерт;
 
Terraform приводит инстанс описанной конфигурации. Внешние изменения игнорируются и затираются.

Задание с **:

 - параметризация количества инстансов в конфигурация terraform;
 - конфигурация healthcheck-а, пула и правила пересылки;
 - вывод ip-адресов инстансов и пула;
 - переменная для количества инстансов со значением 1 по умолчанию.
 
 ## Домашнее задание 7
 
Что сделано:
 
 - созданы модули app, db, vpc;
 - параметризация модуля vpc;
 - созданы конфигурации двух окружений stage и prod;
 - созданы бакеты.
 
Задание со *:

 - созданы backend-ы для prod и stage;
 - проверена блокировка.
 
Задание с *:

 - добавлены provisioner-ы для деплоя reddit app и конфигурации монги;
 - с помощью null_resource сделал деплой опциональным (по другому не придумал).

 ## Домашнее задание 8

Что сделано:
 
 - добавлен requirements.txt и установлен ansible;
 - добавлен inventory;
 - добавлена конфигурация;
 - добавлен YAML inventory;
 - добавлен плейбук;
 - пройдены шаги домашнего задания.

При первом выполнении плейбука не произошло изменений, т.к. репозиторий уже был склонирован.
```
PLAY RECAP ****************************************************************
appserver                  : ok=2    changed=0    unreachable=0    failed=0 
```
После его удаления и выполнения плейбука во второй раз изменения произошли.
```
PLAY RECAP ****************************************************************
appserver                  : ok=2    changed=1    unreachable=0    failed=0 
```

Задание со *:

 - добавлен валидный inventory.json;
 - добавлен скрипт inventory.sh;
 - отредактирован ansible.cfg.
 
  ## Домашнее задание 9
 
 Что сделано:
  
  - отключен провижининг приложения в terraform;
  - выполнена работа самостоятельная работа;
  - создано три play-book'а для приложения, базы и деплоя;
  - созданы play-book'и для packer'a.

 Задание со *:
 
  - добавлен динамический inventory gce.go.

  ## Домашнее задание 10
 
 Что сделано:
  
  - добавлены роли app и db;
  - добавлены окружения stage и prod;
  - использована роль для nginx;
  - добавлена роль users, credentials зашифрованы ansible vault.

 Задание со *:
 
  - динамический inventory gce.go перенесен в окружения.
  
 Задание с **:
   
  - сконфигурирован travis.yml для валидации;
  - добавлен бейдж.
 
  ## Домашнее задание 11
 
 Что сделано:
  
  - создание VM с помощью Vagrant;
  - добавлен Ansible провижинер для проверки работы ролей;
  - доработаны роли app и db, добавлены тэги ruby и install;
  - локальное тестирование роли db + тест на порт;
  - роли db и app теперь используются в плейбуках packer_db.yml и packer_app.yml.

 Задание со *:
 
  - роль db вынесена в отдельный репозиторий https://github.com/egor-a-p/otus-db-role;
  - тесты гоняются при билде в gce;
  - оповещение настроено, но не работает, видимо из-за ограничений.
