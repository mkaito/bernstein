# Bernstein

Bernstein, German for "amber", is a no-bullshit tool for project management and
time tracking. 

Bernstein has some basic project-root finding powers. It will search for the
upwards-nearest ocurrence of a `.git`, `.hg`, `Makefile`, `Rakefile`, or
`.bernstein`. If none of these are found, it will assume $HOME is the project
root. In any case, a `.bernstein` folder is expected to exist at the same level
as the project root. You can create one with `bernstein init`.

Bernstein is inherently offline operating. You can collaborate with others by
placing your `.bernstein` folder in a service such as Dropbox, or by checking
it into version control.

## Git integration

Creating a project will create a branch with the same name. Merging the branch
into master or develop (configurable), marks the project as done and archives
it. Tasks can be closed via commit messages such as
"Fixes bug/cli/input-verification".

Add flags to supress automatic stuff. Allow to configure behaviour.

## Terminology, workflow, and purpose.

A "project", in bernstein, is not meant to be as big and overarching as you
might think. Working on fixing a bug is a project. Fixing up some documentation
is another project. For anything you would create a new branch in git, a
project is the right size.

A "task" is something that needs to be worked on. A single step towards project
completion. Like entries in a TODO list. Time is tracked on the task level. You
can clock in to a task, and clock out. Marking a task as completed
automatically clocks you out.

A "discussion" is a stream of messages attached to either a project or a task.
Each message is cryptographically signed by its author.

Generally speaking, a project is a large task within a development project.
Each project is divided into smaller tasks. Most of the time, all tasks in a
project will be carried out by the same person, which is why the assignment
defaults to yourself. However, you might need someone else to fix something for
you. To formalize this, you assign them a task.

## Identifiers

Projects and tasks are uniquely identified by a path-like string, where tasks
are represented "inside" their projects, as if their were files in a folder. I
suggest you keep the path tokens succint and simple. For more verbose prose,
you can use the discussion feature.

## Example usage

When giving the create commands the `-d` flag, vim opens the newly created
entry to allow for more verbose description to be filled in.

		$ bernstein init
		.bernstein successfully created

		$ bernstein project create -d bug/cli-accepts-erroneous-input
		Project bug/42 has been created.
		Switched to a new branch 'bug/cli-accepts-erroneous-input'

		$ bernstein task create -p high -d bug/cli-accepts-erroneous-input/basic-verification
		Task bug/cli-accepts-erroneous-input/basic-verification created with high priority. Assigned to mkaito.

		$ bernstein activity
		TASK (mkaito) bug/cli-accepts-erroneous-input/basic-verification was created by mkaito.
		PROJECT bug/cli-accepts-erroneous-input was created by mkaito.

		$ bernstein show bug/cli-accepts-erroneous-input
		Project bug/cli-accepts-erroneous-input.
		No time registers found.

		mkaito:
			We've had reports of the CLI accepting input that leads to errors when
			trying to process it, especially when trying to read it back from a file.
			We should try to sanitize input as good as we can, and reject anything we
			can't.

		$ bernstein show bug/cli-accepts-erroneous-input/basic-verification
		Task basic-verification in project bug/cli-accepts-erroneous-input.
		Assigned to mkaito.
		No time registers found.

		mkaito:
			I'm going to implement some very basic input checking, and write a few
			unit tests.

		magbo:
			Make sure it works well with unicode.

		mkaito:
			Sure, I'll get it working.

		$ bernstein task begin bug/cli-accepts-erroneous-input/basic-verification
		You have clocked into bug/cli-accepts-erroneous-input/basic-verification as of 14:25.
		Please remember to clock back out. Should you forget, you can clock out
		with a specific time or duration. See bernstein help task stop.

		$ bernstein task stop 16:30
		You have clocked out of bug/cli-accepts-erroneous-input/basic-verification as of 16:30,
		adding 2:05 into the time register.

		$ bernstein activity
		TASK (mkaito) bug/cli-accepts-erroneous-input/basic-verification had 2:05 clocked by mkaito.
		TASK (mkaito) bug/cli-accepts-erroneous-input/basic-verification was created by mkaito.
		PROJECT bug/cli-accepts-erroneous-input was created by mkaito.

vim:ft=markdown:fo=tn:tw=79
