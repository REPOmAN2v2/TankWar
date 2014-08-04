# Authors: SanicEggnog, TalosThoren
# Filename: Makefile
# Date: July 2014
# Description: Makefile for TankWar2D.

ODIR=./obj
BDIR=./bin
SDIR=./src

CFLAGS := -Wall -g

HEADERS := map.h render.h sdl.h endgame.h gameplay.h menu.h moves.h saves.h
_OBJECTS := $(HEADERS:.h=.o)
OBJECTS = $(patsubst %,$(ODIR)/%,$(_OBJECTS))

ifdef COMSPEC
	LIBS := -lmingw32 -lSDL2main -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -luser32 -lgdi32 -lwinmm -ldxguid
	CC = gcc
	CFLAGS := $(CFLAGS) -std=c11
else
	LIBS := `sdl2-config --cflags --libs` -lSDL2_image -lSDL2_mixer -lSDL2_ttf
	CC = g++
endif

INCLUDES := -I. -I$(ODIR)
#PRODCFLAGS = -O2 -std=c11 -mwindows

default: TankWar2D

build:
	@test -d $(ODIR) || mkdir $(ODIR)
	@test -d $(BDIR) || mkdir $(BDIR)

check: TankWar2D
	./TankWar2D

clean:
	rm -rf ./obj/
	rm -rf ./bin/TankWar2D
	rm -f ./*~
	rm -f ./*.swp

rebuild: clean default

TankWar2D: ${OBJECTS} $(SDIR)/include.h
	${CC} $^ $(SDIR)/main.c $(INCLUDES) $(LIBS) $(CFLAGS) -o $(BDIR)/$@

$(ODIR)/%.o: $(SDIR)/%.c $(SDIR)/%.h $(SDIR)/include.h build
	${CC} $< -c $(CFLAGS) -o $@

.PHONY: default clean check dist distcheck install rebuild uninstall
