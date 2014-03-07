#include <stdbool.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "files.h"

bool is_prefix_of(const char *string, const char *prefix) {
	fprintf (stderr, "Comparing %s to %s.\n", prefix, string);
	while (*prefix) {
		if (*prefix++ != *string++) {
			return false;
		}
	}

	return true;
}

int cmpstringp (const void *a, const void *b)
{
	const char **ia = (const char **)a;
	const char **ib = (const char **)b;
	fprintf (stderr, "Comparing %s to %s.\n", *ia, *ib);
	return strcmp(*ia, *ib);
}

char* path_to_project(const char *path)
{
	char projects[][100] = {
		"bug/42",
		"bug/35",
		"bug/stuff-broke",
		"bug/stuff-broke-again"
	};

	int project_num = sizeof projects / sizeof *projects;
	qsort(projects, project_num, sizeof *projects, cmpstringp);

	for (int i = 0; i <= project_num; i++) {
		if (is_prefix_of(path, projects[i])) {
			return projects[i];
		}
	}

	return NULL;
}
