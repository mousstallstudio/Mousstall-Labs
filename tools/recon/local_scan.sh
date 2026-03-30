#!/bin/bash

# --- Mousstall-Labs : Local Network Recon Tool ---
# Description: Scan rapide du réseau local pour identifier les IP actives.

echo "--- 🛡️ MOUSSTALL-LABS : RECONNAISSANCE RÉSEAU ---"
echo "Recherche des appareils sur le réseau..."

# Récupération de la base de l'IP locale (ex: 192.168.1)
IP_BASE=$(hostname -I | cut -d' ' -f1 | cut -d'.' -f1-3)

echo "Scan du réseau : $IP_BASE.0/24"
echo "-----------------------------------------------"

for ip in {1..254}; do
    # On envoie un seul ping, on attend 1s max, et on ne garde que les réponses
    ping -c 1 -W 1 $IP_BASE.$ip | grep "64 bytes" | cut -d" " -f4 | tr -d ":" &
done

# Attendre que tous les processus en arrière-plan terminent
wait

echo "-----------------------------------------------"
echo "Scan terminé."
