module paths;

import std.algorithm;
import std.datetime;

string path_to_project(string path, string[] projects) pure {
	// Alphabetic sorting puts the shorter of two equally starting strings first,
	// but we want the longest possible match, which is why we reverse the list.
	foreach(p; projects.sort.reverse)
		if(path.startsWith(p))
			return p;

	return null;
}

unittest {
	string[] projects = [
			     "bug/42",
			     "bug/stuff-doesnt-work", 
			     "feature/better-printing-support", 
			     "feature/better-printing",
			     "feature/more-stuff",
			     "bug/meh-shit-broke",
			     "bug/another-thing-broke"
			     ];

	assert(path_to_project("feature/better-printing-support/pretty-printer", projects)
	       == "feature/better-printing-support");
	assert(path_to_project("feature/better-printing/awesome-printer", projects) 
	       == "feature/better-printing");
	assert(path_to_project("bug/42/some-task", projects) 
	       == "bug/42");
	assert(path_to_project("does/not/exist", projects)
	       == null);
}
