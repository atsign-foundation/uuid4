#!/bin/bash
gcc -Wall -Wextra -o example -I../src/ -I../include/ -I../include/uuid4/ ../src/uuid4.c example.c
