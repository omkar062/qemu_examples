FILE_NAME="$1"

if [ ! "$FILE_NAME" ]; then
echo -e "usage:  $0 <file.s>\n"
exit 1
fi

NAME=`echo "$FILE_NAME" | cut -d '.' -f 1`
echo "name: $NAME"

PREFIX=arm-none-eabi-
${PREFIX}"as" -o $NAME.o $NAME.s
${PREFIX}ld -Ttext=0x20000000 -o $NAME.elf $NAME.o
#${PREFIX}ld -e start -o $NAME.elf $NAME.o
${PREFIX}nm $NAME.elf

${PREFIX}objcopy -O binary $NAME.elf $NAME.bin
