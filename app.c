#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "files.h"
#include "app.h"

int main (void) {
	const char path[] = "bug/stuff-broke-again/foo";
	char *project;


	if ((project = path_to_project(path)))
		printf ("Found project string: %s.\n", project);
	else puts ("No match found...");

	exit (EXIT_SUCCESS);
}
