#!/bin/bash
vso=$(cat /zabbix/.config/var/versionso.txt)
vprimary=$(cat /zabbix/.config/var/versionprimary.txt)
vzbx=$(cat /zabbix/.config/var/versionzbx.txt)
fpingrpm=$(cat /zabbix/.config/var/fpingrpm.txt)
libeventrpm=$(cat /zabbix/.config/var/libeventrpm.txt)
unixodbcrpm=$(cat /zabbix/.config/var/unixodbcrpm.txt)

yum install wget gcc gcc-c++ kernel-devel OpenIPMI-libs net-snmp -y 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação das dependencias" 0 0
        exit
fi
rpm -ivh /zabbix/.config/archives/$fpingrpm
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação do fping" 0 0
        exit
fi
yum install fping -y
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação do fping pelo repo" 0 0
        exit
fi
rpm -ivh /zabbix/.config/archives/$libeventrpm 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? download e instalação do libevent" 0 0
        exit
fi
rpm -ivh /zabbix/.config/archives/$unixodbcrpm
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - download e instalação do OBDC" 0 0
        exit
fi
rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - importação key zabbix" 0 0
        exit
fi
rpm -ivh http://repo.zabbix.com/zabbix/$vprimary/rhel/$vso/x86_64/zabbix-proxy-mysql-$vzbx
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - download e instalação do repo zabbix" 0 0
        exit
fi
yum install zabbix-proxy-mysql mariadb-server -y
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - instalação do zabbix proxy e mariadb server" 0 0
        exit
fi
systemctl enable mariadb && systemctl start mariadb
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - habilitação do mariadb" 0 0
        exit
fi
function menuroot(){
opcao=$(dialog --stdout                                        \
        --backtitle "ZABBIX INSTALL"               \
        --ok-label Selecionar                           \
        --cancel-label Sair                             \
        --menu "Root do DB:"         \
        0 0 0                                           \
        1 "Usar minha senha do root"                         \
        2 "Root não tem senha (criar senha)" )
case $opcao in
        1) rot1;;
        2) rot2;;
        *) exit;;
esac
}
function rot1(){
rot=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox "Senha root do DB:" 0 0 )
if (( $? == 0 )); then
        varmy=1
        nomedb
elif (( $? == 1 )); then
        menuroot
else
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
        rot1
fi
}
function rot2(){
root1=$( dialog --stdout --ok-label Confirmar --cancel-label Sair --title "Configuração MYSQL" --inputbox "Criar Senha para root do DB:" 0 0 )
if (( $? == 0 )); then
        root2=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox "Confirmar Senha:" 0 0 )
                if (( $? == 0 )); then
                        if [ $root1 == $root2 ]; then
                                varmy=2
                                nomedb
                        else
                                dialog --backtitle "ZABBIX INSTALL" --ok-label Voltar --msgbox "Senhas não combinam" 0 0
                                rot2
                        fi
                elif (( $? == 1 )); then
                        menuroot
                else
                        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
                        rot2
                fi
else
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
        rot2
fi
}
function nomedb(){
namedb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar DB:' 0 0 )
if (( $? == 0 )); then
        usuariodb
elif (( $? == 1 )); then
        menuroot
else
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
        nomedb
fi
}
function usuariodb(){
userdb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar usuário:' 0 0 )
if (( $? == 0 )); then
        senhadb
elif (( $? == 1 )); then
        nomedb
else
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
        usuariodb
fi
}
function senhadb(){
passdb=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --title "Configuração MYSQL" --inputbox 'Criar Senha:' 0 0 )
if (( $? == 0 )); then
        cont
elif (( $? == 1 )); then
        usuariodb
else
        dialog --backtitle "ZABBIX INSTALL" --infobox "Por favor, termine a instação!" 0 0
        senhadb
fi
}
function cont(){
if (( $varmy == 2 )); then
        mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$root2');"
        mysql -u root -p$root2 -e "create database $namedb character set utf8 collate utf8_bin; grant all privileges on $namedb.* to $userdb@localhost identified by '$passdb'; flush privileges;" | dialog --backtitle "ZABBIX INSTALL" --infobox "Instalando, aguarde (15/19)..." 0 0
elif (( $varmy == 1 )); then
        mysql -u root -p$rot -e "create database $namedb character set utf8 collate utf8_bin; grant all privileges on $namedb.* to $userdb@localhost identified by '$passdb'; flush privileges;" | dialog --backtitle "ZABBIX INSTALL" --infobox "Instalando, aguarde (16/19)..." 0 0
fi

if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - Configuração do banco de dados" 0 0
        exit
fi
zcat /usr/share/doc/zabbix-proxy-mysql*/schema.sql.gz | mysql -u $userdb $namedb -p$passdb 
if (( $? != 0 )); then
        dialog --backtitle "ZABBIX INSTALL" --ok-label Sair --msgbox "erro $? - Utilização do zcat" 0 0
        exit
fi
srv
}
function srv(){
server=$( dialog --stdout --ok-label Confirmar --cancel-label Sair --inputbox 'IP do Zabbix Server:' 0 0 )
case $? in
        0) echo "Server=$server" > /etc/zabbix/zabbix_proxy.conf; hstnm;;
        *) exit;
esac
}
function hstnm(){
hostn=$( dialog --stdout --ok-label Confirmar --cancel-label Voltar --inputbox 'Hostname:' 0 0 )
if (( $? == 0 )); then
        echo "Hostname=$hostn" >> /etc/zabbix/zabbix_proxy.conf
        echo "DBName=$namedb" >> /etc/zabbix/zabbix_proxy.conf
        echo "DBUser=$userdb" >> /etc/zabbix/zabbix_proxy.conf
        echo "DBPassword=$passdb" >> /etc/zabbix/zabbix_proxy.conf
        fin
elif (( $? == 1 )); then
        srv
else
        exit
fi
}
function fin(){
echo "LogFile=/var/log/zabbix/zabbix_proxy.log" >> /etc/zabbix/zabbix_proxy.conf

iptables -F

mv /usr/lib/systemd/system/zabbix-proxy.service /zabbix/.config/rhel/zabbix-proxy.service.old
cp /zabbix/.config/rhel/zabbix-proxy.service /usr/lib/systemd/system/zabbix-proxy.service

systemctl enable zabbix-proxy
systemctl start zabbix-proxy 
yum install policycoreutils-python -y 
cat /var/log/audit/audit.log | grep zabbix_proxy | grep denied | audit2allow -M zabbix_proxy 
semodule -i zabbix_proxy.pp 
setsebool -P zabbix_can_network=1
systemctl start zabbix-proxy 
echo "module zabbix_proxy 1.0;" > zabbix_proxy.te
echo "require {" >> zabbix_proxy.te
echo "        type zabbix_t;" >> zabbix_proxy.te
echo "        type zabbix_port_t;" >> zabbix_proxy.te
echo "        class process setrlimit;" >> zabbix_proxy.te
echo "        class tcp_socket name_connect;" >> zabbix_proxy.te
echo "}" >> zabbix_proxy.te
echo " " >> zabbix_proxy.te
echo "#============= zabbix_t ==============" >> zabbix_proxy.te
echo "allow zabbix_t self:process setrlimit;" >> zabbix_proxy.te
echo " " >> zabbix_proxy.te
echo "#!!!! This avc is allowed in the current policy" >> zabbix_proxy.te
echo "allow zabbix_t zabbix_port_t:tcp_socket name_connect;" >> zabbix_proxy.te

checkmodule -m -M zabbix_proxy.te -o zabbix_proxy.mod 
semodule_package -m zabbix_proxy.mod -o zabbix_proxy.pp
semodule -i zabbix_proxy.pp
systemctl restart zabbix-proxy
dialog --backtitle "ZABBIX INSTALL" --ok-label ok --msgbox "Instalação completa" 0 0
dialog --backtitle "ZABBIX INSTALL" --title "LOG zabbix_proxy" --tailbox /var/log/zabbix/zabbix_proxy.log 100 100
exit
}
menuroot
