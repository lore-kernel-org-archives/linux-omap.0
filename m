From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [RFC 02/15] scripts/dtc: build schema index for dts validation
Date: Tue, 24 Sep 2013 18:52:08 +0200
Message-ID: <1380041541-17529-3-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Add the infrastructure for dts validation through schema. The code build
an index of all the schemas found in a path given by the user on the
command line. This index will be used for the validation of a dts, it will be
used to know if a schema exists for a particular node and where to find it.

The association between a node of a dts and a schema is made through the
compatible property of the former.

timer1: timer@4a318000 {
    compatible = "ti,omap3430-timer";
    reg = <0x4a318000 0x80>;
    interrupts = <0x0 0x25 0x4>;
    ti,hwmods = "timer1";
    ti,timer-alwon;
};

A schema for this node would probably be something like this:
/dts-v1/;
/ {
    compatible = "ti,omap3430-timer";
    ...
};

The compatible property in the schema is specified through a regular
expression so if the schema must validate timers for every omap device,
something like this would probably be more appropriate:
    compatible = "ti,omap[0-9]+-timer";

It is possible to specify several compatible in a single schema like this:
    compatible = "ti,omap3430-timer", "ti,omap4430-timer";

The following syntax is also available:
    compatible {
        description = "A small description";
        value = "ti,omap4430-timer";
    };

Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 scripts/dtc/.gitignore    |   2 +-
 scripts/dtc/Makefile      |   9 +-
 scripts/dtc/dtc.c         |  19 ++-
 scripts/dtc/dtc.h         |  11 ++
 scripts/dtc/schema-test.c |  67 +++++++++++
 scripts/dtc/schema.c      | 288 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 390 insertions(+), 6 deletions(-)
 create mode 100644 scripts/dtc/schema-test.c
 create mode 100644 scripts/dtc/schema.c

diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
index 095acb4..ff556dd 100644
--- a/scripts/dtc/.gitignore
+++ b/scripts/dtc/.gitignore
@@ -2,4 +2,4 @@ dtc
 dtc-lexer.lex.c
 dtc-parser.tab.c
 dtc-parser.tab.h
-
+schema-test
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 2a48022..7da5209 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,15 +1,18 @@
 # scripts/dtc makefile
 
-hostprogs-y	:= dtc
+hostprogs-y	:= dtc schema-test
 always		:= $(hostprogs-y)
 
 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
-		   srcpos.o checks.o util.o
+		   srcpos.o checks.o util.o schema.o
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
+schema-test-objs := $(dtc-objs:dtc.o=) schema-test.o
+
 # Source files need to get at the userspace version of libfdt_env.h to compile
 
 HOSTCFLAGS_DTC := -I$(src) -I$(src)/libfdt
+HOST_LOADLIBES := -lpcre
 
 HOSTCFLAGS_checks.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_data.o := $(HOSTCFLAGS_DTC)
@@ -20,6 +23,8 @@ HOSTCFLAGS_livetree.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_srcpos.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_treesource.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_util.o := $(HOSTCFLAGS_DTC)
+HOSTCFLAGS_schema.o := $(HOSTCFLAGS_DTC)
+HOSTCFLAGS_schema-test.o := $(HOSTCFLAGS_DTC)
 
 HOSTCFLAGS_dtc-lexer.lex.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_dtc-parser.tab.o := $(HOSTCFLAGS_DTC)
diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index 215ae92..a7881f0 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -96,16 +96,21 @@ static void  __attribute__ ((noreturn)) usage(void)
 	fprintf(stderr, "\t-W [no-]<checkname>\n");
 	fprintf(stderr, "\t-E [no-]<checkname>\n");
 	fprintf(stderr, "\t\t\tenable or disable warnings and errors\n");
+	fprintf(stderr, "\t-M <schema folder>");
+	fprintf(stderr,
+		"\t\tCheck the dts using schemas from the specified folder\n");
 	exit(3);
 }
 
 int main(int argc, char *argv[])
 {
 	struct boot_info *bi;
+	struct schema_db *sdb;
 	const char *inform = "dts";
 	const char *outform = "dts";
 	const char *outname = "-";
 	const char *depname = NULL;
+	const char *schemadir = NULL;
 	int force = 0, sort = 0;
 	const char *arg;
 	int opt;
@@ -118,7 +123,7 @@ int main(int argc, char *argv[])
 	minsize    = 0;
 	padsize    = 0;
 
-	while ((opt = getopt(argc, argv, "hI:O:o:V:d:R:S:p:fqb:i:vH:sW:E:"))
+	while ((opt = getopt(argc, argv, "hI:O:o:V:d:R:S:p:fqb:i:vH:sW:E:M:"))
 			!= EOF) {
 		switch (opt) {
 		case 'I':
@@ -130,6 +135,9 @@ int main(int argc, char *argv[])
 		case 'o':
 			outname = optarg;
 			break;
+		case 'M':
+			schemadir = optarg;
+			break;
 		case 'V':
 			outversion = strtol(optarg, NULL, 0);
 			break;
@@ -212,9 +220,14 @@ int main(int argc, char *argv[])
 		fprintf(depfile, "%s:", outname);
 	}
 
-	if (streq(inform, "dts"))
+	if (streq(inform, "dts")) {
 		bi = dt_from_source(arg);
-	else if (streq(inform, "fs"))
+		if (schemadir) {
+			sdb = build_schema_db(schemadir);
+			validate_dt(sdb, bi);
+			free_schema_db(sdb);
+		}
+	} else if (streq(inform, "fs"))
 		bi = dt_from_fs(arg);
 	else if(streq(inform, "dtb"))
 		bi = dt_from_blob(arg);
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 9c45fd2..2b14b3a 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -268,4 +268,15 @@ struct boot_info *dt_from_source(const char *f);
 
 struct boot_info *dt_from_fs(const char *dirname);
 
+/* Schemas */
+
+struct schema_db;
+
+int validate_dt(struct schema_db *db, struct boot_info *bi);
+struct schema_db *build_schema_db(const char *dir);
+void free_schema_db(struct schema_db *db);
+void exit_on_schema_validation_failure(int exit);
+void add_to_schema_db(struct schema_db *db, const char *file);
+struct schema_db *new_schema_db(void);
+
 #endif /* _DTC_H */
diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
new file mode 100644
index 0000000..0eb2499
--- /dev/null
+++ b/scripts/dtc/schema-test.c
@@ -0,0 +1,67 @@
+#include "dtc.h"
+#include <stdio.h>
+#include <fcntl.h>
+
+#define SIZE_ARRAY(x) (sizeof(x)/sizeof((x)[0]))
+
+int quiet;
+int reservenum;
+int minsize;
+int padsize;
+int phandle_format = PHANDLE_BOTH;
+
+struct schema_test {
+	const char *name;
+	const char *dts;
+	const char *schema;
+	int expected_result;
+};
+
+static struct schema_test tests[] = {
+};
+
+int main(void)
+{
+	struct boot_info *bi;
+	struct schema_db *db;
+	int result = 0;
+	int devnull_fd;
+	int stderr_fd;
+
+	exit_on_schema_validation_failure(0);
+	devnull_fd = open("/dev/null", O_RDWR | O_SYNC);
+	stderr_fd = dup(STDERR_FILENO);
+
+	int i;
+	for (i = 0; i < SIZE_ARRAY(tests); i++) {
+		assert(tests[i].name);
+		assert(tests[i].dts);
+		assert(tests[i].schema);
+
+		bi = dt_from_source(tests[i].dts);
+		db = new_schema_db();
+		add_to_schema_db(db, tests[i].schema);
+
+		dup2(devnull_fd, STDERR_FILENO);
+		result = validate_dt(db, bi);
+		dup2(stderr_fd, STDERR_FILENO);
+
+		fprintf(stderr, "[%s] %s\n",
+			result == tests[i].expected_result ? "PASS" : "FAIL",
+			tests[i].name);
+
+		/*
+		 * In case of error re-run the test without hiding the
+		 * error messages
+		 */
+		if (result != tests[i].expected_result) {
+			validate_dt(db, bi);
+			printf("\n");
+		}
+
+		free_dt(bi);
+		free_schema_db(db);
+	}
+
+	return 0;
+}
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
new file mode 100644
index 0000000..dd134d6
--- /dev/null
+++ b/scripts/dtc/schema.c
@@ -0,0 +1,288 @@
+#define _GNU_SOURCE
+#include "dtc.h"
+
+#include <sys/types.h>
+#include <dirent.h>
+#include <pcre.h>
+
+static const char *const SCHEMA_EXT = ".schema";
+static const char *const VALUE_PROPNAME = "value";
+static int exit_on_failure = 0;
+
+struct node_constraints {
+	pcre *re_compat;
+	char *filepath;
+	const char *compatible;
+};
+
+struct schema_db {
+	size_t buffer_size;
+	size_t size;
+
+	struct node_constraints *buffer;
+};
+
+/** Utils **/
+
+static pcre *compile_pattern(const char *pattern)
+{
+	char *regex;
+	const char *error;
+	int erroffset;
+	pcre *re;
+
+	assert(pattern);
+
+	assert(asprintf(&regex, "^%s$", pattern) != -1);
+
+	re = pcre_compile(regex, 0, &error, &erroffset, 0);
+	free(regex);
+
+	return re;
+}
+
+static int get_next_string_offset(struct property *p, int offset)
+{
+	assert(p);
+	assert(offset >= 0);
+
+	while (offset < p->val.len && p->val.val[offset])
+		offset++;
+
+	if (++offset < p->val.len)
+		return offset;
+	return -1;
+}
+
+static int is_prop_value(const char *p)
+{
+	int is_value = 1;
+	const size_t propname_size = strlen(VALUE_PROPNAME);
+
+	assert(p);
+
+	is_value = is_value && strstr(p, VALUE_PROPNAME) == p;
+	is_value = is_value && (p[propname_size] == '@'
+				|| p[propname_size] == '\0');
+
+	return is_value;
+}
+
+/** Schema Validation */
+
+int validate_dt(struct schema_db *db, struct boot_info *bi)
+{
+	assert(bi);
+	assert(db);
+
+	return 1;
+}
+
+void exit_on_schema_validation_failure(int exit)
+{
+	exit_on_failure = exit;
+}
+
+/* Schema DB */
+
+static int is_schema_file(const char *file)
+{
+	const char *str;
+
+	if (!file)
+		return 0;
+
+	str = strstr(file, SCHEMA_EXT);
+	return str && str[strlen(SCHEMA_EXT)] == '\0';
+}
+
+static void init_schema_db(struct schema_db *db)
+{
+	assert(db);
+	memset(db, 0, sizeof(*db));
+
+	/*
+	 * Starts with a DB size of 50 and double its size when the DB is full
+	 */
+	db->buffer_size = 50;
+	db->buffer = xmalloc(sizeof(db->buffer[0]) * db->buffer_size);
+	memset(db->buffer, 0, sizeof(db->buffer[0]) * db->buffer_size);
+}
+
+static struct node_constraints *add_new_entry_to_schema_db(struct schema_db *db)
+{
+	assert(db);
+
+	if (db->size == db->buffer_size) {
+		db->buffer_size *= 2;
+		db->buffer = realloc(db->buffer,
+				     db->buffer_size * sizeof(db->buffer[0]));
+		assert(db->buffer);
+	}
+
+	return &db->buffer[db->size++];
+}
+
+static struct node_constraints*
+add_compatible_to_schema_db(struct schema_db *db,
+			    const char *compatible,
+			    const char *file)
+{
+	struct node_constraints *nc;
+
+	assert(db);
+	assert(compatible);
+	assert(file);
+
+	nc = add_new_entry_to_schema_db(db);
+
+	nc->compatible = compatible;
+	nc->re_compat = compile_pattern(compatible);
+	if (!nc->re_compat)
+		die("Invalid regex for compatible in %s\n", file);
+
+	nc->filepath = xstrdup(file);
+	return nc;
+}
+
+static void add_to_schema_db_from_property(struct schema_db *db,
+					   const char *file,
+					   struct property *p,
+					   struct node *root)
+{
+	int offset = 0;
+
+	assert(db);
+	assert(file);
+	assert(p);
+
+	while (offset >= 0 && offset < p->val.len) {
+		add_compatible_to_schema_db(db, p->val.val + offset, file);
+		offset = get_next_string_offset(p, offset);
+	}
+}
+
+static void add_to_schema_db_from_node(struct schema_db *db,
+				       const char *file,
+				       struct node *n,
+				       struct node *root)
+{
+
+	struct property *p;
+	struct node *iter;
+
+	assert(db);
+	assert(file);
+	assert(root);
+
+	if (!n)
+		return;
+
+	for (p = n->proplist; p; p = p->next) {
+		if (!is_prop_value(p->name))
+			continue;
+		add_to_schema_db_from_property(db, file, p, root);
+	}
+
+	for (iter = n->children; iter; iter = iter->next_sibling)
+		add_to_schema_db_from_node(db, file, iter, root);
+}
+
+void add_to_schema_db(struct schema_db *db, const char *file)
+{
+	struct boot_info *bi;
+	struct node *n;
+	struct property *p;
+
+	assert(db);
+	assert(file);
+
+	bi = dt_from_source(file);
+	if (!bi)
+		die("Unable to load schema: %s\n", file);
+
+	assert(bi->dt);
+
+	n = get_node_by_path(bi->dt, "/compatible");
+	p = get_property(bi->dt, "compatible");
+	if (n)
+		add_to_schema_db_from_node(db, file, n, bi->dt);
+	else if (p)
+		add_to_schema_db_from_property(db, file, p, bi->dt);
+	else
+		die("No 'compatible' found in schema '%s'\n", file);
+
+	free_dt(bi);
+}
+
+static void add_schemas_to_db_from_dir(struct schema_db *db, const char *dir)
+{
+	DIR *d;
+	struct dirent *de;
+	char *filepath;
+	int res;
+
+	assert(dir);
+	assert(db);
+
+	d = opendir(dir);
+	if (!d)
+		die("Cannot open schema directory '%s'\n", dir);
+
+	while ((de = readdir(d)) != NULL) {
+		res = asprintf(&filepath, "%s/%s", dir, de->d_name);
+		assert(res >= 0);
+
+		if (de->d_type == DT_DIR && de->d_name[0] != '.')
+			add_schemas_to_db_from_dir(db, filepath);
+		else if (de->d_type == DT_REG && is_schema_file(de->d_name))
+			add_to_schema_db(db, filepath);
+
+		free(filepath);
+	}
+
+	closedir(d);
+}
+
+struct schema_db *new_schema_db(void)
+{
+	struct schema_db *db;
+
+	db = xmalloc(sizeof(*db));
+	init_schema_db(db);
+
+	return db;
+}
+
+struct schema_db *build_schema_db(const char *dir)
+{
+	struct schema_db *db;
+
+	db = new_schema_db();
+	add_schemas_to_db_from_dir(db, dir);
+
+	return db;
+}
+
+static void free_node_constraints(struct node_constraints *nc)
+{
+	if (!nc)
+		return;
+
+	pcre_free(nc->re_compat);
+	free(nc->filepath);
+}
+
+void free_schema_db(struct schema_db *db)
+{
+	int i;
+
+	if (!db)
+		return;
+
+	for (i = 0; i < db->size; i++)
+		free_node_constraints(db->buffer + i);
+
+	free(db->buffer);
+	free(db);
+}
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
