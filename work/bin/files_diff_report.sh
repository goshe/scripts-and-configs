#!/bin/bash

# 
# TODO:
# 1. copy actual files
#   1.1. distiller/DER
#   1.2. distiller/MWR
#   1.3. laazer/E_Inserts
#   1.4. pu-laazer/E_Inserts
# 2. Create listings 
#   2.1 Illegal filenames
#   2.2 count distiller
#   2.3 count laazer/e_inserts
#   2.4 count pu-laazer/e_inserts
#   2.5 duplicates MWR / DER
# 3. Report
#. ./bat/functions.sh

# TestDirs
#export PDF_MWR="/D/work/Reiseinfos_abgleich/distiller_all"
#export PDF_DER=$PDF_MWR

export TMP_DER=filesDER.txt
export TMP_MWR=filesMWR.txt

export PDF_MWR="//distiller01/Reiseinfos/PDF-Inserts/PDF_Reiseinfos_MWR"
export PDF_DER="//distiller01/Reiseinfos/PDF-Inserts/PDF_Reiseinfos_DER"
export LAZER_INS="//pulaser01/E_Inserts"
export PU_LAZER_INS="//laser01/E_Inserts"

function grepIllegal {
    grep -iv 'V[0-9][0-9][0-9][0-9][0-9]\.pdf'
}

function countIllegal {
    echo $1 | grepIllegal | wc -l
}

function listAllFiles {
    find $1 -type f -printf '%f\n'
}

function createResults {
    echo -e "Anzahl aller Inserts ($2)\t\t $(echo $1 | wc -w)"
    echo -e "Anzahl abw. von Vnnnnn.PDF ($2)\t\t $(countIllegal $1 )"
    
}

filesDistillerDER=$(listAllFiles "$PDF_DER")
filesDistillerMWR=$(listAllFiles "$PDF_MWR")

# Auswertung DER
createResults "$filesDistillerDER" "DER"
# Auswertung MWR
createResults "$filesDistillerMWR" "MWR"

echo -e "\n# ----------------------------------------------------------- #\n"

echo "$filesDistillerDER" > $TMP_DER
echo "$filesDistillerMWR" > $TMP_MWR

echo -e "Anzahl Übereinstimmung (DER/MWR)\t $(grep -Fxf $TMP_DER $TMP_MWR | wc -w )"
echo -e "Anzahl distiller (ohne Doubletten)\t $(sort $TMP_DER $TMP_MWR | uniq | wc -l )"

echo -e "Anzahl Inserts auf laser01\t\t $(listAllFiles "$LAZER_INS" | wc -w )"
echo -e "Anzahl Inserts auf pulaser01\t\t $(listAllFiles "$PU_LAZER_INS" | wc -w )"

rm $TMP_DER
rm $TMP_MWR
