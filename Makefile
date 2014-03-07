CFLAGS = -std=gnu99 -g -Wall -pipe
TARGETS= app

all: $(TARGETS)

app: app.c files.c

clean:
	rm -f *.o
	rm -f $(TARGETS)
