#Vous devez faire un su root avant toute manipulation
cd 
sudo apt update 

#Installer le pare-feu UFW 
sudo apt install ufw -y 

#Refuser toutes les connexions entrantes (incoming) :  
sudo ufw default deny incoming 

#Autoriser toutes les connexions sortantes (outgoing) 
sudo ufw default allow outgoing 

#Autoriser le trafic entrant sur le port 22 dans le cas où on serait en SSH (pas obligatoire dans notre cas) 
sudo ufw allow 22/tcp 

#Autoriser le trafic entrant sur le port 80 
sudo ufw allow 80/tcp 

#Changer dans les dossiers new_config.yaml bind-address: "127.0.0.1" 
echo"Regardez le rapport pour savoir quoi mettre dans ce dossier."
sleep 5
sudoedit /gotosocial/new_config.yaml 

#Pour bien fermer le port  
sudo ufw deny 8080/tcp    # Bloque le port 8080 pour l’extérieur 

#Mettre en marche le firewall  
sudo ufw enable 

#Vérifier nos règles de pare-feu 
sudo ufw status verbose 

#Fail2Ban
cd
#Installer fail2ban
sudo apt install fail2ban –y
#Activer le service Fail2Ban
sudo systemctl enable --now fail2ban 
 
#Afficher le statuts de fail2ban
sudo systemctl status fail2ban 

#Si il existe pas créer le dossier /etc/fail2ban 
mkdir /etc/fail2ban 

#Ce déplacer dans ce fichier  
cd /etc/fail2ban 

#Créer le fichier jail.local 
echo "Regardez le rapport pour savoir quoi mettre dans ce dossier."
sleep 5
touch jail.local 

#Modifier ce fichier et ajouter le script présent dans le rapport ci-dessous 
sudoedit jail.local 

## Retourner dans le répertoire global 
cd 

#Recharger la configuration 
sudo systemctl reload fail2ban

#Vérifier que ça fonctionne  
sudo fail2ban-client status

#Ajouter des logs s'il n’existe pas  
cd /etc/caddy  
echo"Regardez le rapport pour savoir quoi mettre dans ce dossier."
sleep 5
sudoedit Caddyfile  

#Création de la Jail 
cd /etc/fail2ban/jail.d 
echo"Regardez le rapport pour savoir quoi mettre dans ce dossier."
sleep 5
touch web-enum-caddy.conf
sudoedit web-enum-caddy.conf

#Création d’un filtre adapté à nos logs. :  
cd  
cd /etc/fail2ban/filter.d 
echo"Regardez le rapport pour savoir quoi mettre dans ce dossier."
sleep 5
touch web-enum-caddy.conf 
sudoedit web-enum-caddy.conf 

#Etape 3 Recharger Fail2Ban
cd 
sudo systemctl reload fail2ban

#Etape 4 verifier que la jail est active  
sudo fail2ban-client status web-enum-caddy 


