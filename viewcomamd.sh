#!/bin/bash
#
# viewcomand – interaktif pause setelah tiap perintah, 
#             tapi tetap suportif untuk blok if/while/case, dll.

usage() {
  echo "Usage: $0 -f <scriptfile>"
  exit 1
}

# Parse opsi -f
while getopts ":f:" opt; do
  case $opt in
    f) SCRIPT="$OPTARG" ;;
    *) usage ;;
  esac
done

# Validasi input
[[ -z "$SCRIPT" ]] && { echo "Error: file skrip belum ditentukan."; usage; }
[[ ! -f "$SCRIPT" ]] && { echo "Error: file '$SCRIPT' tidak ditemukan."; exit 1; }

# Pasang DEBUG trap: dijalankan sebelum setiap perintah di-shell
trap 'echo; read -p "Silahkan tekan Enter untuk melanjutkannya…" _; echo' DEBUG

# Sumber (source) skrip target — dijalankan di shell ini, jadi blok-blok tetap utuh
source "$SCRIPT"

# Lepas trap dan akhiri
trap - DEBUG
echo "Semua command di script telah selesai dieksekusi."
exit 0
