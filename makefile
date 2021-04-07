CC=g++
CF=-pedantic -W

MODELS_DIR=models
SERVER_MODELS_DIR=$(MODELS_DIR)/server
CLIENT_MODELS_DIR=$(MODELS_DIR)/client

BUILD_DIR=build
SERVER_BUILD_DIR=$(BUILD_DIR)/server
CLIENT_BUILD_DIR=$(BUILD_DIR)/client

INCLUDE=$(MODELS_DIR)/include
INCLUDE_BUILD_DIR=$(BUILD_DIR)/include

SERVER_ROOT=ServerRoot
CLIENT_ROOT=ClientRoot

all: $(SERVER_BUILD_DIR) $(CLIENT_BUILD_DIR) $(INCLUDE_BUILD_DIR) $(SERVER_ROOT)/server $(CLIENT_ROOT)/client

$(SERVER_BUILD_DIR):
	mkdir -p $(SERVER_BUILD_DIR)

$(CLIENT_BUILD_DIR):
	mkdir -p $(CLIENT_BUILD_DIR)

$(INCLUDE_BUILD_DIR):
	mkdir -p $(INCLUDE_BUILD_DIR)

$(SERVER_ROOT):
	mkdir -p $(SERVER_ROOT)

$(CLIENT_ROOT):
	mkdir -p $(CLIENT_ROOT)

# Server executable build

$(SERVER_ROOT)/server: $(SERVER_BUILD_DIR)/main.o 
	$(CC) $(CF) -o $(SERVER_ROOT)/server $(SERVER_BUILD_DIR)/main.o 

$(SERVER_BUILD_DIR)/main.o: $(SERVER_MODELS_DIR)/main.c 
	$(CC) $(CF) -c -I$(INCLUDE) -o $(SERVER_BUILD_DIR)/main.o $(SERVER_MODELS_DIR)/main.c


# Client executable build

$(CLIENT_ROOT)/client $(CLIENT_BUILD_DIR)/main.o 
	$(CC) $(CF) -o $(CLIENT_ROOT)/client $(CLIENT_BUILD_DIR)/main.o 

$(CLIENT_BUILD_DIR)/main.o: $(CLIENT_MODELS_DIR)/main.c
	$(CC) $(CF) -c -I$(INCLUDE) -o $(CLIENT_BUILD_DIR)/main.o $(CLIENT_MODELS_DIR)/main.c

# Include executable build


.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(SERVER_ROOT)/server $(CLIENT_ROOT)/client *.o &> /dev/null