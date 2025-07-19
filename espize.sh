rm -rf esp

for file in Unedited/*; do
mkdir -p esp/Unedited
echo $file
./tes3conv $file esp/$file.esp
done
