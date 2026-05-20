#!/bin/bash

# Copy right: J. Ignacio Lucas Lledó. 2024.
#
# L'objectiu d'este script és instal·lar els programes "plink",
# "admixture" i "evalAdmix" per la realització de la pràctica amb
# ordinador número 5 de l'assignatura "Principals Transicions Evolutives".
# Distribuït amb llicència GPL 3.0, sense garanties de què funcione.
# Pot quedar obsolet molt ràpidament.

if [ ! -d $HOME/bin ]; then mkdir $HOME/bin; fi
if [ -e $HOME/.profile ]; then . $HOME/.profile; fi

# Comprova l'enllaç a la descàrrega en la web https://www.cog-genomics.org/plink2/
# i actualitza si cal la variable PLINK_SOURCE:
PLINK_SOURCE=https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20250819.zip
PLINK_DIR=$(basename -s .zip $PLINK_SOURCE)
if [ -z $(which plink) ]; then
   if [ ! -d $HOME/bin/$PLINK_DIR ]; then
      mkdir $HOME/bin/$PLINK_DIR
   fi
   wget $PLINK_SOURCE
   unzip $PLINK_DIR.zip -d $HOME/bin/$PLINK_DIR
   ln -s $HOME/bin/$PLINK_DIR/plink $HOME/bin/plink
   rm $PLINK_DIR.zip
fi

# David Alexander és un dels autors. El software també es pot trobar a la pàgina
# de github de John November, l'altre autor: https://github.com/NovembreLab/admixture
if [ -z $(which admixture) ]; then
   wget https://dalexander.github.io/admixture/binaries/admixture_linux-1.4.0.tar.gz
   tar -xzvf admixture_linux-1.4.0.tar.gz
   mv admixture_linux-1.4.0 $HOME/bin/
   ln -s $HOME/bin/admixture_linux-1.4.0/admixture $HOME/bin/admixture
   rm admixture_linux-1.4.0.tar.gz
fi

if [ -z $(which evalAdmix) ]; then
   SCRIPT_DIR=$(pwd)
   cd $HOME/bin
      git clone https://github.com/GenisGE/evalAdmix.git
      cd evalAdmix
         make
         EA_VERSION=$(./evalAdmix 2> /dev/null | head -n 1 | cut -d " " -f 3)
      cd ..
      mv evalAdmix evalAdmix_v$EA_VERSION
      if [ -e evalAdmix ]; then rm evalAdmix; fi
   cd $SCRIPT_DIR
   ln -s $HOME/bin/evalAdmix_v$EA_VERSION/evalAdmix $HOME/bin/evalAdmix
fi
