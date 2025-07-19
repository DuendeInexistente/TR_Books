

Commands used
Add headers to files:

for file in Unedited/*; do
cat header.txt >/tmp/file ; echo $file
jq <"$file">>/tmp/file
echo ]>>/tmp/file
mv -f /tmp/file head/$file
done

Name prefixes:
BAD CHAR - Some character or another won't let the json properly. 
