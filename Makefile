CC = gcc
AS = as
LD = gcc

CFLAGS  = -m32 -O2 -g -Wall
ASFLAGS = --32 -g
LDFLAGS = -m32 -g

TARGET = test_taylor

C_SRC   = main.c
ASM_SRC = taylor_optimized.s

C_OBJ   = main.o
ASM_OBJ = taylor_optimized.o

OUT = wyniki.txt

# ===== DOMYŚLNY CEL =====
all: run

# ===== BUILD =====
$(C_OBJ): $(C_SRC)
	$(CC) $(CFLAGS) -c -o $@ $<

$(ASM_OBJ): $(ASM_SRC)
	$(AS) $(ASFLAGS) -o $@ $<

$(TARGET): $(C_OBJ) $(ASM_OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

# ===== RUN =====
run: $(TARGET)
	@echo "▶ Uruchamiam benchmark Taylora (optimized)"
	./$(TARGET)

# ===== CLEAN =====
clean:
	rm -f $(TARGET) $(C_OBJ) $(ASM_OBJ) $(OUT)

.PHONY: all run clean

