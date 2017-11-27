if [ ! -e "flash.bin" ]; then
dd if=/dev/zero of=flash.bin bs=4096 count=4096
fi
FILE_NAME="$1"

if [ ! "$FILE_NAME" ]; then
echo -e "usage:  $0 <file.s>\n"
exit 1
fi


echo "Flashing binary: $FILE_NAME"
dd if=$FILE_NAME of=flash.bin bs=4096 conv=notrunc
qemu-system-arm -M connex -pflash flash.bin -nographic -serial /dev/null
