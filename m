From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [RFC 03/15] scripts/dtc: validate each nodes and properties
Date: Tue, 24 Sep 2013 18:52:09 +0200
Message-ID: <1380041541-17529-4-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Add support to navigate through the device tree and try to validate each node
which has an associated schema in the schema index. So far, only the framework
is added and no validation is really done yet.

Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 scripts/dtc/schema.c | 234 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index dd134d6..a797821 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -9,9 +9,21 @@ static const char *const SCHEMA_EXT = ".schema";
 static const char *const VALUE_PROPNAME = "value";
 static int exit_on_failure = 0;
 
+struct node_list {
+	struct node *n;
+	struct node_list *next;
+};
+
+struct prop_constraints {
+	const char *name;
+};
+
 struct node_constraints {
 	pcre *re_compat;
 	char *filepath;
+	struct boot_info *bi;
+	struct node *dt;
+
 	const char *compatible;
 };
 
@@ -54,6 +66,34 @@ static int get_next_string_offset(struct property *p, int offset)
 	return -1;
 }
 
+static struct property *get_property_matching_pattern(struct property **list,
+						      const char *pattern)
+{
+	struct property *p;
+	pcre *re;
+	int is_matching;
+
+	assert(list);
+	assert(pattern);
+
+	re = compile_pattern(pattern);
+	if (!re)
+		die("Invalid pattern: %s\n", pattern);
+
+	for (p = *list; p; p = p->next) {
+		assert(p->name);
+		is_matching = pcre_exec(re, 0, p->name, strlen(p->name),
+					0, 0, NULL, 0) >= 0;
+		if (is_matching) {
+			*list = p->next;
+			break;
+		}
+	}
+
+	pcre_free(re);
+	return p;
+}
+
 static int is_prop_value(const char *p)
 {
 	int is_value = 1;
@@ -70,12 +110,203 @@ static int is_prop_value(const char *p)
 
 /** Schema Validation */
 
+static void free_property_constraints(struct prop_constraints *pc)
+{
+	if (!pc)
+		return;
+
+	free(pc);
+}
+
+static struct prop_constraints*
+load_property_constraints(struct node *schema)
+{
+	struct property *p;
+	struct prop_constraints *pc;
+
+	assert(schema);
+
+	pc = xmalloc(sizeof(*pc));
+	memset(pc, 0, sizeof(*pc));
+
+	p = get_property(schema, "name");
+	if (p)
+		pc->name = p->val.val;
+
+	return pc;
+}
+
+static int validate_properties(struct node *n,
+			       struct node *schema,
+			       struct node_list *path);
+
+static int validate_property(struct node *n,
+			     struct property *p,
+			     struct prop_constraints *pc,
+			     struct node *schema,
+			     struct node_list *path)
+{
+	int ret = 1;
+
+	assert(n);
+	assert(schema);
+	assert(pc);
+	assert(path);
+
+	free_property_constraints(pc);
+	return ret;
+}
+
+static int validate_properties(struct node *n,
+			       struct node *schema,
+			       struct node_list *path)
+{
+	struct property *p;
+	struct property *iter;
+	struct prop_constraints *pc;
+	int ret = 1;
+
+	assert(n);
+	assert(schema);
+	assert(path);
+
+	pc = load_property_constraints(schema);
+	assert(pc);
+
+	iter = n->proplist;
+	p = get_property_matching_pattern(&iter, pc->name ?: schema->name);
+	ret &= validate_property(n, p, pc, schema, path);
+
+	/* if other properties match the pattern */
+	while (iter && p) {
+		p = get_property_matching_pattern(&iter, schema->name);
+		if (p)
+			ret &= validate_property(n, p, pc, schema, path);
+		else
+			break;
+	}
+
+	return ret;
+}
+
+static int validate_node(struct node *n,
+			 struct node_constraints *nc,
+			 struct node_list *path)
+{
+	struct node *iter;
+	int ret = 1;
+
+	assert(n);
+	assert(path);
+	assert(nc);
+	assert(nc->dt);
+
+	for (iter = nc->dt->children; iter; iter = iter->next_sibling)
+		ret &= validate_properties(n, iter, path);
+
+	return ret;
+}
+
+static struct node_constraints *get_node_constraints_of(struct schema_db *db,
+							const char *compat,
+							int *i)
+{
+	int has_match;
+	struct node_constraints *n;
+
+	assert(db);
+	assert(compat);
+	assert(i);
+
+	for (; *i < db->size; (*i)++) {
+		n = &db->buffer[*i];
+
+		has_match = pcre_exec(n->re_compat, 0, compat,
+				      strlen(compat), 0, 0, NULL, 0) >= 0;
+		if (!has_match)
+			continue;
+
+		if (!n->bi) {
+			n->bi = dt_from_source(n->filepath);
+			n->dt = n->bi->dt;
+		}
+		(*i)++;
+		return n;
+	}
+
+	return NULL;
+}
+
+static int for_each_compatible_validate(struct schema_db *db,
+					struct property *p,
+					struct node *node,
+					struct node_list *path)
+{
+	struct node_constraints *nc;
+	int i;
+	int offset = 0;
+	int ret = 1;
+
+	assert(db);
+	assert(node);
+	assert(p);
+
+	while (offset >= 0 && offset < p->val.len) {
+		i = 0;
+		while ((nc = get_node_constraints_of(db, p->val.val + offset,
+						     &i)) != NULL) {
+			ret &= validate_node(node, nc, path);
+		}
+
+		offset = get_next_string_offset(p, offset);
+	}
+
+	return ret;
+}
+
+static int validate_nodes(struct schema_db *db,
+			  struct node *n,
+			  struct node_list *path)
+{
+	struct property *p;
+	struct node *iter;
+	struct node_list *head_path = NULL;
+	int ret = 1;
+
+	assert(db);
+
+	if (!n)
+		return ret;
+
+	head_path = xmalloc(sizeof(*iter));
+	head_path->next = path;
+
+	for (iter = n; iter; iter = iter->next_sibling) {
+		/* Build the path to this node */
+		head_path->n = iter;
+
+		/* Validate children nodes */
+		ret &= validate_nodes(db, iter->children, head_path);
+
+		p = get_property(iter, "compatible");
+		if (!p)
+			continue;
+
+		/* Validate node */
+		ret &= for_each_compatible_validate(db, p, iter, head_path);
+	}
+
+	free(head_path);
+	return ret;
+}
+
 int validate_dt(struct schema_db *db, struct boot_info *bi)
 {
 	assert(bi);
+	assert(bi->dt);
 	assert(db);
 
-	return 1;
+	return validate_nodes(db, bi->dt, NULL);
 }
 
 void exit_on_schema_validation_failure(int exit)
@@ -270,6 +501,7 @@ static void free_node_constraints(struct node_constraints *nc)
 		return;
 
 	pcre_free(nc->re_compat);
+	free_dt(nc->bi);
 	free(nc->filepath);
 }
 
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
