#bin/bash!
#
# util to compress a extracted liferay lpkg
# just target the containing folder

LPKG_NAME=${1%/}

cd "$LPKG_NAME"

for f in */;
do
  if [ $f != "META-INF/" ]; then
    WAR_NAME=${f%/}
    echo "Compressing $f"
    cd "$f"
    zip -r "$WAR_NAME.war" ./*
    mv "$WAR_NAME.war" ..
    cd ..
    rm -rf "$f"
  fi
done
echo "Packing LPKG $LPKG_NAME"
zip -r "$LPKG_NAME.lpkg" ./*
mv "$LPKG_NAME.lpkg" ..
cd ..
rm -rf "$LPKG_NAME"
