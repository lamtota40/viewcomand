#!/bin/bash
#
# viewcomand – jaga jeda eksekusi baris demi baris
#

usage() {
  echo "Usage: $0 -f <scriptfile>"
  exit 1
}

# Parse opsi
while getopts ":f:" opt; do
  case $opt in
    f) SCRIPT="$OPTARG" ;;
    *) usage ;;
  esac
done

# Validasi
if [[ -z "$SCRIPT" ]]; then
  echo "Error: nama file skrip belum diberikan."
  usage
fi

if [[ ! -f "$SCRIPT" ]]; then
  echo "Error: File '$SCRIPT' tidak ditemukan."
  exit 1
fi

# Baca dan eksekusi setiap baris
while IFS= read -r line || [[ -n "$line" ]]; do
  # lewati baris kosong atau komentar
  [[ -z "$line" ]] && continue
  [[ "${line:0:1}" == "#" ]] && continue

  echo "Menjalankan: $line"
  eval "$line"

  echo
  read -p "Silahkan tekan Enter untuk melanjutkannya..." dummy
  echo
done < "$SCRIPT"

echo "Semua command di script telah selesai dieksekusi."
exit 0
