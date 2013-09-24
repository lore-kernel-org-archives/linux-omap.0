From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC 15/15] scripts/dtc: add verbose options
Date: Tue, 24 Sep 2013 18:52:21 +0200
Message-ID: <1380041541-17529-16-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:41261 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab3IXQxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 12:53:11 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm2so4136827wib.16
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 09:53:10 -0700 (PDT)
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>

From: Fabien Parent <fparent@baylibre.com>

The verbose option '-B' will show additional messages in addition
to all validation errors. Right now the level 0 prints every nodes
which don't have at least one schema associated to it. Level 1
prints every properties which were not validated due to missing
constraints.
Activate the verbose mode by default into the Makefile.

Usage example:
    dtc -M ./bindings -B 1 file.dts

A count of errors found so far as also been added and is printed
on each error.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 scripts/Makefile.lib |   2 +-
 scripts/dtc/dtc.c    |  11 ++++-
 scripts/dtc/dtc.h    |   1 +
 scripts/dtc/schema.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 118 insertions(+), 20 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 358dd69..ea1484e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -264,7 +264,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = $(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 \
-		-M $(objtree)/bindings \
+		-M $(objtree)/bindings -B 1 \
 		-i $(dir $<) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index a7881f0..8fee7ca 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -99,6 +99,8 @@ static void  __attribute__ ((noreturn)) usage(void)
 	fprintf(stderr, "\t-M <schema folder>");
 	fprintf(stderr,
 		"\t\tCheck the dts using schemas from the specified folder\n");
+	fprintf(stderr, "\t-B <number>\n");
+	fprintf(stderr, "\t\tLevel of verbosity from the schema validation\n");
 	exit(3);
 }
 
@@ -111,7 +113,7 @@ int main(int argc, char *argv[])
 	const char *outname = "-";
 	const char *depname = NULL;
 	const char *schemadir = NULL;
-	int force = 0, sort = 0;
+	int force = 0, sort = 0, verbose = 0;
 	const char *arg;
 	int opt;
 	FILE *outf = NULL;
@@ -123,7 +125,7 @@ int main(int argc, char *argv[])
 	minsize    = 0;
 	padsize    = 0;
 
-	while ((opt = getopt(argc, argv, "hI:O:o:V:d:R:S:p:fqb:i:vH:sW:E:M:"))
+	while ((opt = getopt(argc, argv, "hI:O:o:V:d:R:S:p:fqb:i:vH:sW:E:M:B:"))
 			!= EOF) {
 		switch (opt) {
 		case 'I':
@@ -192,6 +194,10 @@ int main(int argc, char *argv[])
 			parse_checks_option(false, true, optarg);
 			break;
 
+		case 'B':
+			verbose = strtol(optarg, NULL, 0);
+			break;
+
 		case 'h':
 		default:
 			usage();
@@ -223,6 +229,7 @@ int main(int argc, char *argv[])
 	if (streq(inform, "dts")) {
 		bi = dt_from_source(arg);
 		if (schemadir) {
+			set_verbosity_level(verbose);
 			sdb = build_schema_db(schemadir);
 			validate_dt(sdb, bi);
 			free_schema_db(sdb);
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 64fdc8a..a4731e0 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -293,6 +293,7 @@ int validate_dt(struct schema_db *db, struct boot_info *bi);
 struct schema_db *build_schema_db(const char *dir);
 void free_schema_db(struct schema_db *db);
 void exit_on_schema_validation_failure(int exit);
+void set_verbosity_level(int verbosity);
 void add_to_schema_db(struct schema_db *db, const char *file);
 struct schema_db *new_schema_db(void);
 
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index e349e01..3a2f831 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -46,6 +46,8 @@
 static const char *const SCHEMA_EXT = ".schema";
 static const char *const VALUE_PROPNAME = "value";
 static int exit_on_failure = 0;
+static int verbose;
+static int error_count;
 
 struct str_list {
 	char *str;
@@ -57,6 +59,11 @@ struct node_list {
 	struct node_list *next;
 };
 
+struct property_list {
+	struct property *property;
+	struct property_list *next;
+};
+
 struct range {
 	uint32_t low;
 	uint32_t high;
@@ -236,7 +243,7 @@ static void dt_error(struct node_list *path,
 
 	assert(format);
 
-	fprintf(stderr, "FATAL ERROR");
+	fprintf(stderr, "[%d] FATAL ERROR", ++error_count);
 	if (p) {
 		fprintf(stderr, " in %s:%d:%d",
 			p->loc.file, p->loc.line, p->loc.col);
@@ -581,15 +588,42 @@ static int check_value(struct property *p, struct prop_constraints *pc)
 	return 1;
 }
 
+static void remove_from_property_list(struct property *p,
+				      struct property_list **plist)
+{
+	struct property_list *iter;
+	struct property_list *next_iter;
+	struct property_list *prev_iter = NULL;
+
+	if (!plist || !*plist)
+		return;
+
+	iter = *plist;
+	for_each_safe(iter, iter, next_iter) {
+		if (strcmp(p->name, iter->property->name)) {
+			prev_iter = iter;
+			continue;
+		}
+
+		if (prev_iter)
+			prev_iter->next = iter->next;
+		else
+			*plist = iter->next;
+		free(iter);
+	}
+}
+
 static int validate_properties(struct node *n,
 			       struct node *schema,
-			       struct node_list *path);
+			       struct node_list *path,
+			       struct property_list **plist);
 
 static int validate_property(struct node *n,
 			     struct property *p,
 			     struct prop_constraints *pc,
 			     struct node *schema,
-			     struct node_list *path)
+			     struct node_list *path,
+			     struct property_list **plist)
 {
 	int ret = 1;
 
@@ -598,12 +632,16 @@ static int validate_property(struct node *n,
 	assert(pc);
 	assert(path);
 
+	if (p && plist)
+		remove_from_property_list(p, plist);
+
 	if (pc->is_required && !p) {
 		if (pc->can_be_inherited && path->next) {
 			assert(path->next->n);
 			ret &= validate_properties(path->next->n,
 						   schema,
-						   path->next);
+						   path->next,
+						   plist);
 		} else {
 			DT_ERROR(path, NULL, "Missing property '%s'\n",
 				 schema->name);
@@ -636,7 +674,8 @@ end:
 
 static int validate_properties(struct node *n,
 			       struct node *schema,
-			       struct node_list *path)
+			       struct node_list *path,
+			       struct property_list **plist)
 {
 	struct property *p;
 	struct property *iter;
@@ -652,13 +691,13 @@ static int validate_properties(struct node *n,
 
 	iter = n->proplist;
 	p = get_property_matching_pattern(&iter, pc->name ?: schema->name);
-	ret &= validate_property(n, p, pc, schema, path);
+	ret &= validate_property(n, p, pc, schema, path, plist);
 
 	/* if other properties match the pattern */
 	while (iter && p) {
 		p = get_property_matching_pattern(&iter, schema->name);
 		if (p)
-			ret &= validate_property(n, p, pc, schema, path);
+			ret &= validate_property(n, p, pc, schema, path, plist);
 		else
 			break;
 	}
@@ -722,12 +761,14 @@ static struct node *find_parent_node(struct node *schema,
 
 static int validate_node(struct node *n,
 			 struct node_constraints *nc,
-			 struct node_list *path);
+			 struct node_list *path,
+			 struct property_list **plist);
 
 static void free_node_constraints(struct node_constraints *nc);
 
 static int validate_parents(struct node *schema,
-			    struct node_list *path)
+			    struct node_list *path,
+			    struct property_list **plist)
 {
 	struct node *n;
 	struct node_constraints *nc;
@@ -746,7 +787,7 @@ static int validate_parents(struct node *schema,
 		memset(nc, 0, sizeof(*nc));
 		load_node_constraints(nc, schema);
 		nc->dt = schema;
-		ret &= validate_node(n, nc, path);
+		ret &= validate_node(n, nc, path, plist);
 		free_node_constraints(nc);
 	}
 
@@ -792,7 +833,8 @@ static struct node *find_current_compatible_node(struct node_constraints *nc)
 }
 
 static int validate_compatible(struct node_constraints *nc,
-			       struct node_list *path)
+			       struct node_list *path,
+			       struct property_list **plist)
 {
 	int ret = 1;
 	struct node *n;
@@ -808,12 +850,13 @@ static int validate_compatible(struct node_constraints *nc,
 	if (!n)
 		return ret;
 
-	return ret & validate_parents(n, path);
+	return ret & validate_parents(n, path, plist);
 }
 
 static int validate_node(struct node *n,
 			 struct node_constraints *nc,
-			 struct node_list *path)
+			 struct node_list *path,
+			 struct property_list **plist)
 {
 	struct node *iter;
 	struct str_list *pattern;
@@ -828,9 +871,9 @@ static int validate_node(struct node *n,
 
 	for (iter = nc->dt->children; iter; iter = iter->next_sibling) {
 		if (!strcmp(iter->name, "parents"))
-			ret &= validate_parents(iter, path);
+			ret &= validate_parents(iter, path, plist);
 		else
-			ret &= validate_properties(n, iter, path);
+			ret &= validate_properties(n, iter, path, plist);
 	}
 
 	/* Check whether the node has all the required children nodes */
@@ -915,6 +958,25 @@ end:
 	return ret;
 }
 
+static struct property_list *build_proplist(struct node *node)
+{
+	struct property *p;
+	struct property_list *plist = NULL;
+	struct property_list *new_plist;
+
+	for (p = node->proplist; p; p = p->next) {
+		new_plist = xmalloc(sizeof(*new_plist));
+		memset(new_plist, 0, sizeof(*new_plist));
+
+		new_plist->next = plist;
+
+		plist = new_plist;
+		plist->property = p;
+	}
+
+	return plist;
+}
+
 static int for_each_compatible_validate(struct schema_db *db,
 					struct property *p,
 					struct node *node,
@@ -924,23 +986,46 @@ static int for_each_compatible_validate(struct schema_db *db,
 	int i;
 	int offset = 0;
 	int ret = 1;
+	int has_compatible_in_db = 0;
+	struct property_list *plist;
+	struct property_list *plist_next;
+	char *path_str;
 
 	assert(db);
 	assert(node);
 	assert(p);
 	assert(p->val.type == STRING);
 
+	plist = build_proplist(node);
+
 	while (offset >= 0 && offset < p->val.len) {
 		i = 0;
+		has_compatible_in_db = 0;
 		while ((nc = get_node_constraints_of(db, p->val.val + offset,
 						     &i)) != NULL) {
-			ret &= validate_node(node, nc, path);
-			ret &= validate_compatible(nc, path);
+			ret &= validate_node(node, nc, path, &plist);
+			ret &= validate_compatible(nc, path, &plist);
+			has_compatible_in_db = 1;
+		}
+
+		if (!has_compatible_in_db && verbose) {
+			fprintf(stderr, "[%d] No schema available for '%s'\n",
+				++error_count, p->val.val + offset);
 		}
 
 		offset = get_next_string_offset(p, offset);
 	}
 
+	if (verbose > 1) {
+		for_each_safe(plist, plist, plist_next) {
+			path_str = build_path(path);
+			fprintf(stderr, "[%d] Property undefined: '%s%s'\n",
+				++error_count, path_str, plist->property->name);
+			free(plist);
+			free(path_str);
+		}
+	}
+
 	return ret;
 }
 
@@ -998,6 +1083,11 @@ void exit_on_schema_validation_failure(int exit)
 	exit_on_failure = exit;
 }
 
+void set_verbosity_level(int verbosity)
+{
+	verbose = verbosity;
+}
+
 /* Schema DB */
 
 static int is_schema_file(const char *file)
-- 
1.8.1.2

