MCU = atmega128
INCLUDE=-I/usr/avr/include
CC =avr-gcc
CFLAGS=-g -Wall -mcall-prologues -mmcu=$(MCU) -Os
LDFLAGS=-Wl,-gc-sections -Wl,-relax

all:program


printNumber.o: printNumber.c
	$(CC) $(CFLAGS) -c printNumber.c

waitDelay.o: waitDelay.c
	$(CC) $(CFLAGS) -c waitDelay.c

main.o: main.c
	$(CC) $(CFLAGS) -c main.c



main.elf: waitDelay.o printNumber.o main.o
	$(CC) $(CFLAGS) -o main.elf waitDelay.o printNumber.o main.o

main.hex: main.elf
	 avr-objcopy -j .text -j .data -O ihex  main.elf  main.hex



program: main.hex
	 sudo avrdude -c stk500v2 -p m128 -P avrdoper -U flash:w:main.hex:a
