CC          := clang
CFLAGS      := -Wall -Werror -Wextra -Wpedantic -Weverything
DBG_CFLAGS  := -O0 -g
RLS_CFLAGS  := -O2
LDFLAGS     :=
TARGET      := main

SRC_DIR     := ./src
BUILD_DIR   := ./build
SRCS        := $(shell find $(SRC_DIR) -name "*.c" | grep -v $(TARGET))
OBJS        := $(subst $(SRC_DIR),$(BUILD_DIR),$(SRCS))
OBJS        := $(OBJS:.c=.o)
OBJ_DIRS 	:= $(shell dirname $(OBJS))

.PHONY : debug release all clean run

debug : CFLAGS += $(DBG_CFLAGS)
debug : all

release : CFLAGS += $(RLS_CFLAGS)
release : all

all : $(OBJ_DIRS) $(TARGET)

$(TARGET) : $(SRC_DIR)/$(TARGET).c $(OBJS)
	$(CC) $^ -o $@ $(CFLAGS) $(LDFLAGS)

$(BUILD_DIR)/%.o : $(SRC_DIR)/%.c $(SRC_DIR)/%.h
	$(CC) $< -c $(CFLAGS) -o $@

$(OBJ_DIRS) :
	mkdir -p $@

clean :
	rm -rf $(TARGET) $(OBJS)

run :
	./$(TARGET)
