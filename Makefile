# KernelPatch এর সোর্স কোডের পাথ (আপনার সেটআপ অনুযায়ী পরিবর্তন করুন)
KP_DIR ?= ../KernelPatch

# টুলচেইন প্রিফিক্স (আপনার ইনস্টল করা টুলচেইন অনুযায়ী পরিবর্তন করুন)
# যেমন: aarch64-none-elf-  অথবা  aarch64-linux-gnu-
TARGET_COMPILE ?= aarch64-none-elf-

CC := $(TARGET_COMPILE)gcc
LD := $(TARGET_COMPILE)ld

# KernelPatch এর হেডার ডিরেক্টরিগুলো
INCLUDE_DIRS := . include patch/include linux/include linux/arch/arm64/include linux/tools/arch/arm64/include
INCLUDE_FLAGS := $(foreach dir,$(INCLUDE_DIRS),-I$(KP_DIR)/kernel/$(dir))

# আপনার মডিউলের অবজেক্ট ফাইল
objs := dark_kpm.o

# আউটপুট ফাইলের নাম
TARGET := DFFG.kpm

all: $(TARGET)

$(TARGET): $(objs)
	$(CC) -r -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -c -O2 -o $@ $<

clean:
	rm -rf *.kpm
	find . -name "*.o" | xargs rm -f

.PHONY: all clean