import std.stdio;
import std.getopt;
import std.array;

import paths;

string data = "file.dat";
int length = 24;
bool verbose;
enum Color { no, yes };
Color color;

version (unittest) {}
	else
void main(string[] args)
{
	getopt(
			args,
			std.getopt.config.bundling,
			"length|l",    &length,    // numeric
			"file|f",      &data,      // string
			"verbose|v",   &verbose,   // flag
			"color|c",     &color);    // enum

	writefln ("Got length %d.", length);
	writefln ("Got file %s.", data);
	if (verbose)
		writeln ("We're verbose!");
	else
		writeln ("We're quiet.");
	writefln ("Got color %d.", color);

	if (args[1..$].length) {
		write("Found non-option arguments: ");
		writefln ("%s.", args[1..$].join(", "));
	}
}
