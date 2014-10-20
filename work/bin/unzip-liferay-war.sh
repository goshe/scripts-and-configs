#bin/bash!
FILENAME=${1%.*}
TMP_DIR="/tmp/$FILENAME/"

unzipToTemp(){
	unzip -d "$1" "$2"
}

# extract main archive
unzipToTemp "$TMP_DIR" "$1"

# extract contained wars
cd "$TMP_DIR"

for f in `ls *.war`;
do
   echo "Unzipping $f"
   FILENAME=${f%.*}
   unzipToTemp "$FILENAME" $f
done
