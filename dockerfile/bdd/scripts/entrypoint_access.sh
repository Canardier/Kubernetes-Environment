ENTPATH="/docker-entrypoint-initdb.d/"
if [ -d $ENTPATH ];
then
    FILES=$(ls $ENTPATH)
    for f in $FILES
    do mysql $MYSQL_DATABASE < $ENTPATH/$f
    done
fi