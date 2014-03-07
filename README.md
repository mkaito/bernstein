# Bernstein

Bernstein Spec version 0.8

Bernstein, German for "amber", is a no-bullshit tool for project management and
time tracking. I chose the name because amber is the colour between red and
green on traffic lights. Traffic represents the movement of a project towards
completion. Red represents problems, bugs, and other issues preventing
progress. Green represents the resolution of these problems. Amber sits between
the problems and their resolutions, helping us figure out what the hell needs
to be done.

**It is also not implemented.** This document outlines my motivations, the
desired behaviour of the finished program, and serves as a simple roadmap for
development. Most of my work right now revolves around exploring and
documenting what I expect the program to do. I've been playing with
explorations in several languages in git branches. None of them are anywhere
near complete, and are just playground tidbits at best.

Bernstein has some basic project-root finding powers. It will search for the
upwards-nearest occurrence of a `.git`, `.hg`, `Makefile`, `Rakefile`, or
`.bernstein`. If none of these are found, it will assume $HOME is the project
root. In any case, a `.bernstein` folder is expected to exist at the same level
as the project root. You can create one with `bernstein init <path>`, where
`<path>` defaults to the current working directory.

Bernstein is inherently offline operating. It only knows about files and text.
You can collaborate with others by placing your `.bernstein` folder in a
service such as Dropbox, or by checking it into version control. I'm concerned
about cluttering the commit history with project updates, though. Perhaps
that's a non-issue, but it's worth discussing.

## Storage

The only things backing Bernstein are plaintext files and folders. This is a
primary design principle. Bernstein offers convenience to manipulate the
storage tree, but you can also just use any other tools you would like, such as
grep, find, and Vim. If you find yourself on a machine without Bernstein, you
can still explore and manipulate the `.bernstein` tree, albeit with some added
difficulty.

A `.bernstein` file system entry is a folder which holds local data and
configuration for Bernstein. Every entry is represented by a file or folder in
this tree. See the tree represented below for an example of a single issue,
with a single task and some messages. All data is serialized to YAML.  Messages
can be signed. When a signature is found, Bernstein will verify it, and display
either a green checkmark or a red cross next to the message header.

				.bernstein
				├── config.yaml
				└── issues
						└── bug
								└── cli-accepts-erroneous-input
										├── tasks
										│   └── basic-validation
										│       ├── messages
										│       │   ├── 1393370530.yaml
										│       │   ├── 1393370535.yaml
										│       │   ├── 1393370535.sig
										│       │   ├── 1393370540.yaml
										│       │   └── 1393370540.sig
										│       └── data.yaml
										├── messages
										│   ├── 1393370410.yaml
										│   ├── 1393370415.yaml
										│   ├── 1393370420.yaml
										│   └── 1393370420.sig
										└── data.yaml

## Implementation

Preliminary exploration suggests I should use Bash to write Bernstein. I would,
however, like to consider a compiled language, for speed and ease of
distribution of the resulting binaries. Suggestions are most welcome.

## Terminology, workflow, and purpose.

An "issue" is a problem that needs to be solved, a feature that needs to be
implemented, an enhancement that needs to happen. Something that needs to be
done but is too big for a single "task".

A "task" is something that needs to be worked on. A single step towards issue
completion. Like entries in a TODO list. Time is tracked on the task level. You
can clock in to a task, and clock out. Marking a task as completed
automatically clocks you out. Tasks always exist inside an issue, and not on
their own. (Perhaps simplify the management of issues with only a single task?)

A "discussion" is a stream of messages attached to either an issue  or a task.
Each message is cryptographically signed by its author, and Bernstein will
reject unsigned messages or messages with invalid signatures.

Generally speaking, an issue is a large task within a project.  Each issue is
divided into smaller tasks. Most of the time, all tasks in an issue will be
carried out by the same person, which is why the assignment defaults to
yourself. However, you might need someone else to fix something for you. To
formalize this, you assign them a task, and they will see it.

Bernstein is not a public bug tracker. Use something else for that instead. It
is an internal tool, intended to help plan and streamline work effort in a
development team. The suggested approach is simply manually "importing" issues
and tasks from a public tracker, as any automated would inherently turn
bernstein into a CLI client for any public tracker service you might use. Use
bernstein for internal book keeping, and use something else for public issue
discussion.

## Identifiers

Issues and tasks are namespaced like files in folders, and separated by a
colon. Anything that's a valid file or folder name is a valid identifier, but I
suggest you stick to basic ASCII with little punctuation, for portability and
ease of typing. Bernstein can generate unique identifiers for you, but I
recommend that you pick a descriptive string yourself instead. Identifiers
should be kept descriptive, but short. For more verbose descriptions, you can
`bernstein edit <identifier path>`, which will open your `$EDITOR`, and allow
arbitrary text to be attached to it. This text will be shown by `bernstein show
<identifier path>`, along with any discussion. Examples follow.

An issue identifier

	better-pretty-printing

A namespaced issue identifier

	feature/better-pretty-printing

Namespaces can be nested arbitrarily deep

	feature/interface/printing/better-pretty-printing

Issue identifiers are separated from task identifiers by a colon

	better-pretty-printing:colourize-output

Issues can also be namespaced

	better-pretty-printing:colours/colourize-output

Of course, you can also nest them arbitrarily deep

	better-pretty-printing:output/terminals/colours/colourize-output

An example of both sides deeply namespaced

	feature/interface/printing/better-pretty-printing:output/terminals/colours/colourize-output

Whether and how deep you want to namespace things is entirely up to you.
Bernstein doesn't care.

## Example usage

When giving the create commands the `-d` flag, `$EDITOR` opens the newly
created entry to allow for more verbose description to be filled in.

	$ bernstein init
	./.bernstein successfully created

	$ bernstein create -d bug/cli-accepts-erroneous-input
	I bug/cli-accepts-erroneous-input has been created.

	$ bernstein create -p high -d bug/cli-accepts-erroneous-input:basic-verification
	T bug/cli-accepts-erroneous-input/basic-verification created with high priority. Assigned to mkaito.

	$ bernstein log
	T (mkaito) bug/cli-accepts-erroneous-input/basic-verification was created by mkaito.
	issue bug/cli-accepts-erroneous-input was created by mkaito.

	$ bernstein show bug/cli-accepts-erroneous-input
	I bug/cli-accepts-erroneous-input.
	No time registers found.

	mkaito:
		We've had reports of the CLI accepting input that leads to errors when
		trying to process it, especially when trying to read it back from a file.
		We should try to sanitize input as good as we can, and reject anything we
		can't.

	$ bernstein show bug/cli-accepts-erroneous-input:basic-verification
	T basic-verification in issue bug/cli-accepts-erroneous-input.
	Assigned to mkaito.
	No time registers found.

	&#x2713; mkaito:
		I'm going to implement some very basic input checking, and write a few
		unit tests.

	&#x2717; magbo:
		Make sure it works well with unicode.

	mkaito:
		Sure, I'll get it working.

	$ bernstein begin bug/cli-accepts-erroneous-input:basic-verification
	You have clocked into bug/cli-accepts-erroneous-input:basic-verification as of 14:25.
	Please remember to clock back out. Should you forget, you can clock out
	with a specific time or duration. See bernstein help task stop.

	$ bernstein stop 16:30
	You have clocked out of bug/cli-accepts-erroneous-input:basic-verification as of 16:30,
	adding 2:05 into the time register.

	$ bernstein log
	T (mkaito) bug/cli-accepts-erroneous-input:basic-verification had 2:05 clocked by mkaito.
	T (mkaito) bug/cli-accepts-erroneous-input:basic-verification was created by mkaito.
	I bug/cli-accepts-erroneous-input was created by mkaito.

vim:ft=markdown:fo=tn:tw=79
