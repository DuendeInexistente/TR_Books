

Commands used
get book jsons:

```sh
cat ../Tamriel_Data.json | jq '.[] | select(.type == "Book")' -c | sed -s 's/\\r/\\\\r/g' | sed -s 's/\\n/\\\\n/g' >monolibro.json
```

```sh
COUNT=0
while IFS="" read -r p || [ -n "$p" ]
do
  COUNT=$(($COUNT+1))
  echo $p | jq
  echo $p | grep -v "<deprecated>" >libros/$COUNT.json
done < monolibro.json
```

The files at this point had a bunch of fake escape sequences. I had to replace `\\(\w)` with `\\\\\1` across the whole folder.

Add headers to files:

```sh
for file in Unedited/*; do
cat header.txt >/tmp/file ; echo $file
jq <"$file">>/tmp/file
echo ]>>/tmp/file
mv -f /tmp/file head/$file
done
```

Give the files sensible filenames. Note if I do this over again: Much better to load the file contents into a variable and read that than to read every file five times to get its keys.

```sh
for file in Unedited/*; do
title=$(cat $file | jq '.[].name' | grep -v null | sed 's/\"//g' | sed 's/ /_/g' | sed "s/'//g")
type=$(cat $file | jq '.[].data.book_type' | grep -v null | sed 's/\"//g' | sed 's/ /_/g' | sed "s/'//g")
fixedfile=$(echo $file | sed 's/\.json//g')
uni=$(echo $fixedfile | sed 's/Unedited\///')
id=$(cat $file | jq '.[].id' | grep -v null | sed 's/\"//g' | sed 's/ /_/g' | sed "s/'//g")

mv $file Unedited/$type-$id-$title-$uni.json

done
```

Name prefixes:
BAD CHAR - Some character or another breaks jq. Still converts to esp fine.
