#!/bin/bash
clear
yum update -y
yum install epel-release -y
dialog
if (( $? != 0 )); then
        yum install dialog -y
fi
dialog --backtitle "LRS Tecnologia LTDA" --ok-label Reiniciar --msgbox "Bem-vindo!" 0 0

function menu(){
opcao=$(dialog --stdout                                        \
	--backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar  	                        \
        --cancel-label Sair                             \
        --menu "Selecione Sistema Operacional:"   	\
        0 0 0                                           \
        1 "rhel(RedHat/CentOS)"		                \
        2 "Suse"		        	        \
        3 "AIX"				                \
        4 "Debian"			                \
        5 "Ubuntu" 					\
        6 "Não sei meu SO" ) 

case $opcao in
        1) versionrhel;;
        2) versionsuse;;
        3) versionaix;;
        4) versiondebian;;
        5) versionubuntu;;
        6) helpso ;;
        *) exit;;
esac
}

function versionrhel(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do rhel:"            \
        0 0 0                                           \
        1 "5"                                           \
        2 "6"                                           \
        3 "7"                                           \
        4 "Não sei minha versão"                       \
        5 "Sair" )
if (( $? == 0 )); then
	case $opcao in
	        1) echo "5" > /zabbix/.config/var/versionso.txt; zbx5;;
	        2) echo "6" > /zabbix/.config/var/versionso.txt; zbx6;;
	        3) echo "7" > /zabbix/.config/var/versionso.txt; zbx7;;
	        4) helpversion ;;
       		5) exit ;;
	esac
elif (( $? == 1 )); then
        menu
else
        exit
fi
}
function zbx5(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Agent"                                \
        2 "Sair" )
if (( $? == 0 )); then
	case $opcao in
       		1) versionzbxa5 ;;
     		2) exit ;;
	esac
elif (( $? == 1 )); then
	versionrhel
else	
	exit
fi
}
function zbx6(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                               \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el6/en/x86_64/rpmforge/RPMS/fping-3.9-1.el6.rf.x86_64.rpm" > /zabbix/.config/var/fpinglink.txt; echo "fping-3.9-1.el6.rf.x86_64.rpm" > /zabbix/.config/var/fpingrpm.txt; echo "https://rpmfind.net/linux/centos/6/os/x86_64/Packages/libevent-1.4.13-4.el6.x86_64.rpm" > /zabbix/.config/var/libeventrpm.txt; echo "https://rpmfind.net/linux/centos/6/os/x86_64/Packages/unixODBC-2.2.14-14.el6.x86_64.rpm" > /zabbix/.config/var/unixodbcrpm.txt; versionzbxs6 ;;
                2) echo "http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el6/en/x86_64/rpmforge/RPMS/fping-3.9-1.el6.rf.x86_64.rpm" > /zabbix/.config/var/fpinglink.txt; echo "fping-3.9-1.el6.rf.x86_64.rpm" > /zabbix/.config/var/fpingrpm.txt; echo "https://rpmfind.net/linux/centos/6/os/x86_64/Packages/libevent-1.4.13-4.el6.x86_64.rpm" > /zabbix/.config/var/libeventrpm.txt; echo "https://rpmfind.net/linux/centos/6/os/x86_64/Packages/unixODBC-2.2.14-14.el6.x86_64.rpm" > /zabbix/.config/var/unixodbcrpm.txt; versionzbxp6 ;;
                3) versionzbxa6 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versionrhel
else
        exit
fi
}
function zbx7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione o que deseja instalar:"       \
        0 0 0                                           \
        1 "Zabbix Server"                               \
        2 "Zabbix Proxy"                                \
        3 "Zabbix Agent"                                \
        4 "Sair" )
if (( $? == 0 )); then
        case $opcao in
                1) echo "http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el7/en/x86_64/rpmforge/RPMS/fping-3.10-1.el7.rf.x86_64.rpm" > /zabbix/.config/var/fpinglink.txt; echo "fping-3.10-1.el7.rf.x86_64" > /zabbix/.config/var/fpingrpm.txt; echo "https://rpmfind.net/linux/centos/7/os/x86_64/Packages/libevent-2.0.21-4.el7.x86_64.rpm" > /zabbix/.config/var/libeventrpm.txt; echo "https://rpmfind.net/linux/centos/7/os/x86_64/Packages/unixODBC-2.3.1-11.el7.x86_64.rpm" > /zabbix/.config/var/unixodbcrpm.txt; versionzbxs7 ;;
                2) echo "http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el7/en/x86_64/rpmforge/RPMS/fping-3.10-1.el7.rf.x86_64.rpm" > /zabbix/.config/var/fpinglink.txt; echo "fping-3.10-1.el7.rf.x86_64" > /zabbix/.config/var/fpingrpm.txt; echo "https://rpmfind.net/linux/centos/7/os/x86_64/Packages/libevent-2.0.21-4.el7.x86_64.rpm" > /zabbix/.config/var/libeventrpm.txt; echo "https://rpmfind.net/linux/centos/7/os/x86_64/Packages/unixODBC-2.3.1-11.el7.x86_64.rpm" > /zabbix/.config/var/unixodbcrpm.txt; versionzbxp7 ;;
                3) versionzbxa7 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        versionrhel
else
        exit
fi
}
function versionzbxa5(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair." )
if (( $? == 0 )); then
	case $opcao in
        	1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versiona530 ;;
       		2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versiona534 ;;
        	3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versiona540 ;;
		4) exit ;;
	esac
elif (( $? == 1 )); then
        zbx5
else
	exit
fi
}
function versionzbxa6(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair." )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versiona630 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versiona634 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versiona640 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        zbx6
else
        exit
fi
}
function versionzbxa7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair." )      
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versiona730 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versiona734 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versiona740 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        zbx7
else
        exit
fi
}
function versionzbxs6(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair." )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versions630 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versions634 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versions640 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        zbx6
else
        exit
fi
}
function versionzbxs7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair." )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versions730 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versions734 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versions740 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        zbx7
else
        exit
fi
}
function versionzbxp6(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair." )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versionp630 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versionp634 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versionp640 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        zbx6
else
        exit
fi
}
function versionzbxp7(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.0"                                           \
        2 "3.4"                                           \
        3 "4.0"                                           \
        4 "Sair." )
if (( $? == 0 )); then
        case $opcao in
                1) echo "3.0" > /zabbix/.config/var/versionprimary.txt; versionp730 ;;
                2) echo "3.4" > /zabbix/.config/var/versionprimary.txt; versionp734 ;;
                3) echo "4.0" > /zabbix/.config/var/versionprimary.txt; versionp740 ;;
                4) exit ;;
        esac
elif (( $? == 1 )); then
        zbx7
else
        exit
fi
}
function versions630(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.0-1.el6.noarch.rpm"                                 \
        2 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0-1.el6.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxx;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionzbxs6
else
        exit
fi
}
function versions730(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.0-1.el7.noarch.rpm"                                 \
        2 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0-1.el7.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxx;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionzbxs7
else
        exit
fi
}
function versions634(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.4-1.el6.noarch.rpm"                                 \
        2 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4-1.el6.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxx;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionzbxs6
else
        exit
fi
}
function versions734(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "3.4-1.el7.centos.noarch.rpm"                                 \
        2 "3.4-2.el7.noarch.rpm"                                 \
        3 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4-1.el7.centos.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxx;;
                        2) echo "3.4-2.el7.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxx;;
                        3) exit;;
        esac
elif (( $? == 1 )); then
        versionzbxs7
else
        exit
fi
}
function versions640(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "4.0-1.el6.noarch.rpm"                                 \
        2 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0-1.el6.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxx;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionzbxs6
else
        exit
fi
}
function versions740(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Server:"    \
        0 0 0                                           \
        1 "4.0-1.el7.noarch.rpm"                                 \
        2 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0-1.el7.noarch.rpm" > /zabbix/.config/var/versionzbx.txt; selinuxx;;
                        2) exit;;
        esac
elif (( $? == 1 )); then
        versionzbxs7
else
        exit
fi
}
function versionp630(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.0.0-2.el6.x86_64.rpm"                                 \
        2 "3.0.1-1.el6.x86_64.rpm"                                 \
        3 "3.0.1-2.el6.x86_64.rpm"                                \
        4 "3.0.2-1.el6.x86_64.rpm"                                \
        5 "3.0.11-1.el6.x86_64.rpm"                                \
        6 "3.0.12-1.el6.x86_64.rpm"                                \
        7 "3.0.13-1.el6.x86_64.rpm"                                \
        8 "3.0.13-2.el6.x86_64.rpm"                                \
        9 "3.0.14-1.el6.x86_64.rpm"      \
        10 "3.0.15-1.el6.x86_64.rpm"       \
        11 "3.0.16-1.el6.x86_64.rpm"        \
        12 "3.0.17-1.el6.x86_64.rpm"         \
        13 "3.0.18-1.el6.x86_64.rpm"           \
        14 "3.0.19-1.el6.x86_64.rpm"            \
        15 "3.0.2-1.el6.x86_64.rpm"        \
        16 "3.0.20-1.el6.x86_64.rpm"         \
        17 "3.0.21-1.el6.x86_64.rpm"        \
        18 "3.0.22-1.el6.x86_64.rpm"              \
        19 "3.0.23-1.el6.x86_64.rpm"               \
        20 "3.0.24-1.el6.x86_64.rpm"               \
        21 "3.0.3-1.el6.x86_64.rpm"                \
        22 "3.0.4-1.el6.x86_64.rpm"                \
        23 "3.0.5-1.el6.x86_64.rpm"                 \
        24 "3.0.6-1.el6.x86_64.rpm"                \
        25 "3.0.7-1.el6.x86_64.rpm"                 \
        26 "3.0.8-1.el6.x86_64.rpm"     \
        27 "3.0.9-1.el6.x86_64.rpm"        \
        28 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0.0-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.0.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.0.1-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.0.10-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.0.11-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.0.12-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                       	7) echo "3.0.13-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.0.13-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.0.14-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.0.15-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.0.16-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.0.17-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.0.18-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.0.19-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.0.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.0.20-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.0.21-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.0.22-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) echo "3.0.23-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        20) echo "3.0.24-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        21) echo "3.0.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        22) echo "3.0.4-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        23) echo "3.0.5-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        24) echo "3.0.6-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        25) echo "3.0.7-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        26) echo "3.0.8-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        27) echo "3.0.9-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        28) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-proxy.sh
elif (( $? == 1 )); then
        versionzbxp6
else
        exit
fi
}
function versionp730(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.0.0-1.el7.x86_64.rpm"                                 \
        2 "3.0.1-1.el7.x86_64.rpm"                                 \
        3 "3.0.10-1.el7.x86_64.rpm"                                \
        4 "3.0.11-1.el7.x86_64.rpm"                                \
        5 "3.0.12-1.el7.x86_64.rpm"                                \
        6 "3.0.13-1.el7.x86_64.rpm"                                \
        7 "3.0.13-2.el7.x86_64.rpm"                                \
        8 "3.0.14-1.el7.x86_64.rpm"      \
        9 "3.0.15-1.el7.x86_64.rpm"       \
        10 "3.0.16-1.el7.x86_64.rpm"        \
        11 "3.0.17-1.el7.x86_64.rpm"         \
        12 "3.0.18-1.el7.x86_64.rpm"           \
        13 "3.0.19-1.el7.x86_64.rpm"            \
        14 "3.0.2-1.el7.x86_64.rpm"        \
        15 "3.0.20-1.el7.x86_64.rpm"         \
        16 "3.0.21-1.el7.x86_64.rpm"        \
        17 "3.0.22-1.el7.x86_64.rpm"              \
        18 "3.0.23-1.el7.x86_64.rpm"               \
        19 "3.0.24-1.el7.x86_64.rpm"               \
        20 "3.0.3-1.el7.x86_64.rpm"                \
        21 "3.0.4-1.el7.x86_64.rpm"                \
        22 "3.0.5-1.el7.x86_64.rpm"                 \
        23 "3.0.6-1.el7.x86_64.rpm"                \
        24 "3.0.7-1.el7.x86_64.rpm"                 \
        25 "3.0.8-1.el7.x86_64.rpm"     \
        26 "3.0.8-2.el7.x86_64.rpm"     \
        27 "3.0.9-1.el7.x86_64.rpm"        \
        28 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0.0-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.0.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.0.10-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.0.11-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.0.12-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                       	6) echo "3.0.13-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.0.13-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.0.14-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.0.15-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.0.16-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.0.17-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.0.18-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.0.19-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.0.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.0.20-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.0.21-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.0.22-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.0.23-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) echo "3.0.24-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        20) echo "3.0.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        21) echo "3.0.4-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        22) echo "3.0.5-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        23) echo "3.0.6-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        24) echo "3.0.7-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        25) echo "3.0.8-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        26) echo "3.0.8-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        27) echo "3.0.9-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        28) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-proxy.sh
elif (( $? == 1 )); then
        versionzbxp7
else
        exit
fi
}
function versionp634(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
	1 "3.4.0-1.el6.x86_64.rpm"                                 \
        2 "3.4.1-1.el6.x86_64.rpm"					\
	3 "3.4.10-1.el6.x86_64.rpm"				\
	4 "3.4.11-1.el6.x86_64.rpm"				\
	5 "3.4.12-1.el6.x86_64.rpm"				\
	6 "3.4.13-1.el6.x86_64.rpm"				\
	7 "3.4.14-1.el6.x86_64.rpm"				\
	8 "3.4.15-1.el6.x86_64.rpm"				\
	9 "3.4.2-1.el6.x86_64.rpm"					\
	10 "3.4.3-1.el6.x86_64.rpm"				\
	11 "3.4.4-1.el6.x86_64.rpm"				\
	12 "3.4.4-2.el6.x86_64.rpm"				\
	13 "3.4.5-1.el6.x86_64.rpm"				\
	14 "3.4.6-1.el6.x86_64.rpm"				\
	15 "3.4.7-1.el6.x86_64.rpm"				\
	16 "3.4.8-1.el6.x86_64.rpm"				\
	17 "3.4.9-1.el6.x86_64.rpm"				\
	18 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.9-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-proxy.sh
elif (( $? == 1 )); then
        versionzbxp6
else
        exit
fi
}
function versionp734(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "3.4.0-1.el7.x86_64.rpm"                                 \
        2 "3.4.1-1.el7.x86_64.rpm"                                 \
        3 "3.4.10-1.el7.x86_64.rpm"                                \
        4 "3.4.11-1.el7.x86_64.rpm"                                \
        5 "3.4.12-1.el7.x86_64.rpm"                                \
        6 "3.4.13-1.el7.x86_64.rpm"                                \
        7 "3.4.14-1.el7.x86_64.rpm"                                \
        8 "3.4.15-1.el7.x86_64.rpm"                                \
        9 "3.4.2-1.el7.x86_64.rpm"                                 \
        10 "3.4.3-1.el7.x86_64.rpm"                                \
        11 "3.4.4-1.el7.x86_64.rpm"                                \
        12 "3.4.4-2.el7.x86_64.rpm"                                \
        13 "3.4.5-1.el7.x86_64.rpm"                                \
        14 "3.4.6-1.el7.x86_64.rpm"                                \
        15 "3.4.7-1.el7.x86_64.rpm"                                \
        16 "3.4.8-0.el7.x86_64.rpm"                                \
        17 "3.4.8-1.el7.x86_64.rpm"                                \
        18 "3.4.9-1.el7.x86_64.rpm"                                \
        19 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-0.0.1r80210.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.8-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.4.9-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-proxy.sh
elif (( $? == 1 )); then
        versionzbxp7
else
        exit
fi
}
function versionp640(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "4.0.0-2.el6.x86_64.rpm"                                 \
        2 "4.0.1-1.el6.x86_64.rpm"                                 \
        3 "4.0.2-1.el6.x86_64.rpm"                                \
        4 "4.0.3-1.el6.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;	
        esac
        bash /zabbix/.config/rhel/zabbix-proxy.sh
elif (( $? == 1 )); then
        versionzbxp6
else
        exit
fi
}
function versionp740(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Proxy:"    \
        0 0 0                                           \
        1 "4.0.0-2.el7.x86_64.rpm"                                 \
        2 "4.0.1-1.el7.x86_64.rpm"                                 \
        3 "4.0.2-1.el7.x86_64.rpm"                                \
        4 "4.0.3-1.el7.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-proxy.sh
elif (( $? == 1 )); then
        versionzbxp7
else
        exit
fi
}
function versiona530(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
	1 "3.0.0-2.el5.x86_64.rpm"				 	\
	2 "3.0.1-2.el5.x86_64.rpm" 3 "3.0.10-1.el5.x86_64.rpm" 4 "3.0.11-1.el5.x86_64.rpm" 5 "3.0.12-1.el5.x86_64.rpm" 6 "3.0.13-1.el5.x86_64.rpm" 7 "3.0.13-2.el5.x86_64.rpm" 8 "3.0.14-1.el5.x86_64.rpm" 9 "3.0.15-1.el5.x86_64.rpm" 10 "3.0.16-1.el5.x86_64.rpm" 11 "3.0.17-1.el5.x86_64.rpm" 12 "3.0.18-1.el5.x86_64.rpm" 13 "3.0.19-1.el5.x86_64.rpm" 14 "3.0.2-1.el5.x86_64.rpm" 15 "3.0.20-1.el5.x86_64.rpm" 16 "3.0.21-1.el5.x86_64.rpm" 17 "3.0.22-1.el5.x86_64.rpm" 18 "3.0.23-1.el5.x86_64.rpm" 19 "3.0.24-1.el5.x86_64.rpm" 20 "3.0.3-1.el5.x86_64.rpm" 21 "3.0.4-1.el5.x86_64.rpm" 22 "3.0.5-1.el5.x86_64.rpm" 23 "3.0.6-1.el5.x86_64.rpm" 24 "3.0.7-1.el5.x86_64.rpm" 25 "3.0.8-1.el5.x86_64.rpm"	26 "3.0.9-1.el5.x86_64.rpm" 27 "Sair")
if (( $? == 0 )); then
        case $opcao in      
			1) echo "3.0.0-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			2) echo "3.0.1-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			3) echo "3.0.10-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			4) echo "3.0.11-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			5) echo "3.0.12-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;; 
			6) echo "3.0.13-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			7) echo "3.0.13-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			8) echo "3.0.14-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			9) echo "3.0.15-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			10) echo "3.0.16-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;        
			11) echo "3.0.17-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			12) echo "3.0.18-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			13) echo "3.0.19-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			14) echo "3.0.2-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			15) echo "3.0.20-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			16) echo "3.0.21-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			17) echo "3.0.22-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			18) echo "3.0.23-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			19) echo "3.0.24-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			20) echo "3.0.3-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			21) echo "3.0.4-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			22) echo "3.0.5-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			23) echo "3.0.6-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			24) echo "3.0.7-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			25) echo "3.0.8-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			26) echo "3.0.9-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
			27) exit;;
        esac
	bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa5
else
        exit
fi
}
function versiona630(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0.0-2.el6.x86_64.rpm"                                 \
        2 "3.0.1-1.el6.x86_64.rpm"                                 \
        3 "3.0.1-2.el6.x86_64.rpm"                                    \
        4 "3.0.10-1.el6.x86_64.rpm"                                 \
        5 "3.0.11-1.el6.x86_64.rpm"                                \
        6 "3.0.12-1.el6.x86_64.rpm"                        \
        7 "3.0.13-1.el6.x86_64.rpm"    \
        8 "3.0.13-2.el6.x86_64.rpm"     \
        9 "3.0.14-1.el6.x86_64.rpm"      \
        10 "3.0.15-1.el6.x86_64.rpm"       \
        11 "3.0.16-1.el6.x86_64.rpm"        \
        12 "3.0.17-1.el6.x86_64.rpm"         \
        13 "3.0.18-1.el6.x86_64.rpm"           \
        14 "3.0.19-1.el6.x86_64.rpm"            \
        15 "3.0.2-1.el6.x86_64.rpm"        \
        16 "3.0.20-1.el6.x86_64.rpm"         \
        17 "3.0.21-1.el6.x86_64.rpm"        \
        18 "3.0.22-1.el6.x86_64.rpm"              \
        19 "3.0.23-1.el6.x86_64.rpm"               \
        20 "3.0.24-1.el6.x86_64.rpm"               \
        21 "3.0.3-1.el6.x86_64.rpm"                \
        22 "3.0.4-1.el6.x86_64.rpm"                \
        23 "3.0.5-1.el6.x86_64.rpm"                 \
        24 "3.0.6-1.el6.x86_64.rpm"                \
        25 "3.0.7-1.el6.x86_64.rpm"                 \
        26 "3.0.8-1.el6.x86_64.rpm"     \
        27 "3.0.9-1.el6.x86_64.rpm"        \
        28 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0.0-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.0.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.0.1-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.0.10-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.0.11-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.0.12-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                       	7) echo "3.0.13-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.0.13-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.0.14-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.0.15-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.0.16-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.0.17-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.0.18-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.0.19-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.0.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.0.20-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.0.21-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.0.22-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) echo "3.0.23-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        20) echo "3.0.24-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        21) echo "3.0.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        22) echo "3.0.4-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        23) echo "3.0.5-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        24) echo "3.0.6-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        25) echo "3.0.7-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        26) echo "3.0.8-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        27) echo "3.0.9-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        28) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa6
else
        exit
fi

}
function versiona730(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.0.0-2.el7.x86_64.rpm"                                 \
        2 "3.0.1-1.el7.x86_64.rpm"                                 \
        3 "3.0.10-1.el7.x86_64.rpm"                                 \
        4 "3.0.11-1.el7.x86_64.rpm"                                \
        5 "3.0.12-1.el7.x86_64.rpm"                        \
        6 "3.0.13-1.el7.x86_64.rpm"    \
        7 "3.0.13-2.el7.x86_64.rpm"     \
        8 "3.0.14-1.el7.x86_64.rpm"      \
        9 "3.0.15-1.el7.x86_64.rpm"       \
        10 "3.0.16-1.el7.x86_64.rpm"        \
        11 "3.0.17-1.el7.x86_64.rpm"         \
        12 "3.0.18-1.el7.x86_64.rpm"           \
        13 "3.0.19-1.el7.x86_64.rpm"            \
        14 "3.0.2-1.el7.x86_64.rpm"        \
        15 "3.0.20-1.el7.x86_64.rpm"         \
        16 "3.0.21-1.el7.x86_64.rpm"        \
        17 "3.0.22-1.el7.x86_64.rpm"              \
        18 "3.0.23-1.el7.x86_64.rpm"               \
        19 "3.0.24-1.el7.x86_64.rpm"               \
        20 "3.0.3-1.el7.x86_64.rpm"                \
        21 "3.0.4-1.el7.x86_64.rpm"                \
        22 "3.0.5-1.el7.x86_64.rpm"                 \
        23 "3.0.6-1.el7.x86_64.rpm"                \
        24 "3.0.7-1.el7.x86_64.rpm"                 \
        25 "3.0.8-1.el7.x86_64.rpm"     \
        26 "3.0.9-1.el7.x86_64.rpm"        \
        27 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.0.0-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.0.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.0.10-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.0.11-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.0.12-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.0.13-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.0.13-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.0.14-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.0.15-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.0.16-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.0.17-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.0.18-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.0.19-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.0.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.0.20-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.0.21-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.0.22-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.0.23-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) echo "3.0.24-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        20) echo "3.0.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        21) echo "3.0.4-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        22) echo "3.0.5-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        23) echo "3.0.6-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        24) echo "3.0.7-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        25) echo "3.0.8-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        26) echo "3.0.9-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        27) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa7
else
        exit
fi

}
function versiona534(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.4.0-1.el5.x86_64.rpm"                                 \
        2 "3.4.1-1.el5.x86_64.rpm" 3 "3.4.10-1.el5.x86_64.rpm" 4 "3.4.11-1.el5.x86_64.rpm" 5 "3.4.12-1.el5.x86_64.rpm" 6 "3.4.13-1.el5.x86_64.rpm" 7 "3.4.14-1.el5.x86_64.rpm" 8 "3.4.15-1.el5.x86_64.rpm" 9 "3.4.2-1.el5.x86_64.rpm" 10 "3.4.3-1.el5.x86_64.rpm" 11 "3.4.4-1.el5.x86_64.rpm" 12 "3.4.4-2.el5.x86_64.rpm" 13 "3.4.5-1.el5.x86_64.rpm" 14 "3.4.6-1.el5.x86_64.rpm" 15 "3.4.7-1.el5.x86_64.rpm" 16 "3.4.8-1.el5.x86_64.rpm" 17 "3.4.9-1.el5.x86_64.rpm" 18 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.9-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa5
else
        exit
fi
}
function versiona634(){
opcao=$(dialog --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
	1 "3.4.0-1.el6.x86_64.rpm"                                 \
        2 "3.4.1-1.el6.x86_64.rpm"					\
	3 "3.4.10-1.el6.x86_64.rpm"				\
	4 "3.4.11-1.el6.x86_64.rpm"				\
	5 "3.4.12-1.el6.x86_64.rpm"				\
	6 "3.4.13-1.el6.x86_64.rpm"				\
	7 "3.4.14-1.el6.x86_64.rpm"				\
	8 "3.4.15-1.el6.x86_64.rpm"				\
	9 "3.4.2-1.el6.x86_64.rpm"					\
	10 "3.4.3-1.el6.x86_64.rpm"				\
	11 "3.4.4-1.el6.x86_64.rpm"				\
	12 "3.4.4-2.el6.x86_64.rpm"				\
	13 "3.4.5-1.el6.x86_64.rpm"				\
	14 "3.4.6-1.el6.x86_64.rpm"				\
	15 "3.4.7-1.el6.x86_64.rpm"				\
	16 "3.4.8-1.el6.x86_64.rpm"				\
	17 "3.4.9-1.el6.x86_64.rpm"				\
	18 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.9-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa6
else
        exit
fi
}
function versiona734(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "3.4.0-1.el7.x86_64.rpm"                                 \
        2 "3.4.1-1.el7.x86_64.rpm"                                 \
        3 "3.4.10-1.el7.x86_64.rpm"                                \
        4 "3.4.11-1.el7.x86_64.rpm"                                \
        5 "3.4.12-1.el7.x86_64.rpm"                                \
        6 "3.4.13-1.el7.x86_64.rpm"                                \
        7 "3.4.14-1.el7.x86_64.rpm"                                \
        8 "3.4.15-1.el7.x86_64.rpm"                                \
        9 "3.4.2-1.el7.x86_64.rpm"                                 \
        10 "3.4.3-1.el7.x86_64.rpm"                                \
        11 "3.4.4-1.el7.x86_64.rpm"                                \
        12 "3.4.4-2.el7.x86_64.rpm"                                \
        13 "3.4.5-1.el7.x86_64.rpm"                                \
        14 "3.4.6-1.el7.x86_64.rpm"                                \
        15 "3.4.7-1.el7.x86_64.rpm"                                \
        16 "3.4.8-0.el7.x86_64.rpm"                                \
        17 "3.4.8-1.el7.x86_64.rpm"                                \
        18 "3.4.9-1.el7.x86_64.rpm"                                \
        19 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "3.4.0-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "3.4.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "3.4.10-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "3.4.11-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) echo "3.4.12-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        6) echo "3.4.13-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        7) echo "3.4.14-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        8) echo "3.4.15-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        9) echo "3.4.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        10) echo "3.4.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        11) echo "3.4.4-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        12) echo "3.4.4-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        13) echo "3.4.5-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        14) echo "3.4.6-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        15) echo "3.4.7-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        16) echo "3.4.8-0.0.1r80210.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        17) echo "3.4.8-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        18) echo "3.4.9-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        19) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa7
else
        exit
fi
}
function versiona540(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "4.0.0-2.el5.x86_64.rpm"                                 \
        2 "4.0.1-1.el5.x86_64.rpm"                                 \
        3 "4.0.2-1.el5.x86_64.rpm"                                \
        4 "4.0.3-1.el5.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el5.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa5
else
        exit
fi
}
function versiona640(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "4.0.0-2.el6.x86_64.rpm"                                 \
        2 "4.0.1-1.el6.x86_64.rpm"                                 \
        3 "4.0.2-1.el6.x86_64.rpm"                                \
        4 "4.0.3-1.el6.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el6.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;	
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa6
else
        exit
fi
}
function versiona740(){
opcao=$(dialog  --stdout                                        \
        --backtitle "LRS Tecnologia LTDA"               \
        --ok-label Selecionar                           \
        --cancel-label Voltar                           \
        --menu "Selecione a versão do Zabbix Agent:"    \
        0 0 0                                           \
        1 "4.0.0-2.el7.x86_64.rpm"                                 \
        2 "4.0.1-1.el7.x86_64.rpm"                                 \
        3 "4.0.2-1.el7.x86_64.rpm"                                \
        4 "4.0.3-1.el7.x86_64.rpm"                                \
        5 "Sair")
if (( $? == 0 )); then
        case $opcao in
                        1) echo "4.0.0-2.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        2) echo "4.0.1-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        3) echo "4.0.2-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        4) echo "4.0.3-1.el7.x86_64.rpm" > /zabbix/.config/var/versionzbx.txt;;
                        5) exit;;
        esac
        bash /zabbix/.config/rhel/zabbix-agent.sh
elif (( $? == 1 )); then
        versionzbxa7
else
        exit
fi
}
function helpso(){
cat /etc/*-release | grep PRETTY_NAME | cut -d= -f 2 > /zabbix/.config/var/seuso.txt
dialog --backtitle "LRS Tecnologia LTDA" --title "Seu Sistema Operacional" --tailbox /zabbix/.config/var/seuso.txt 0 0
if (( $? == 0 )); then
	menu
else
	exit
fi
}
function helpversion(){
cat /etc/*-release | grep VERSION | cut -d= -f 2 > /zabbix/.config/var/seuso.txt
dialog --backtitle "LRS Tecnologia LTDA" --title "Sua Versão" --tailbox /zabbix/.config/var/seuso.txt 0 0
if (( $? == 0 )); then
	menu
else
	exit
fi
}
function selinuxx(){
setenforce 0
echo "SELINUX=disabled" > /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config
bash /zabbix/.config/rhel/zabbix-server.sh
}
menu
