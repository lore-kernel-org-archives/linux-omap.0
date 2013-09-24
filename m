From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [RFC 10/15] scripts/dtc: add count limit on nodes
Date: Tue, 24 Sep 2013 18:52:16 +0200
Message-ID: <1380041541-17529-11-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Add the possibility to specify in a schema a count limit for the nodes matching
the schema:
    - count: if there is a match between a dts and a schema then there must
    be exactly X match between the dts and the schema at the end of the
    validation process.
    - max-count: if there is a match between a dts and a schema then there must
    be at most X match between the dts and the schema at the end of the
    validation process.
This can be used to check if a specific node appears the right amount of time
in the dts.

Add as well four test files for this feature.

/ {
    timer1 {
        compatible = "ti,omap-4430-timer";
        ...
    };

    timer2 {
        compatible = "ti,omap-4430-timer";
        ...
    };
};

If in the above dts there must be exactly two timer one can check this
constraints with the following schema:

/ {
    compatible = "ti,omap-4430-timer";
    count = <2>;
};

Note: If the dts doesn't specify any timer the dts will still be valid. To
ensure that the timer is really present 2 times one should might wants to
specify constraints on then children of a node, but this feature is not
yet available.

Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 scripts/dtc/schema-test.c                      | 10 ++++
 scripts/dtc/schema.c                           | 63 ++++++++++++++++++++++++--
 scripts/dtc/tests/schemas/nodes-count-1.schema |  5 ++
 scripts/dtc/tests/schemas/nodes-count-2.schema |  5 ++
 scripts/dtc/tests/schemas/nodes-count-3.schema |  5 ++
 scripts/dtc/tests/schemas/nodes-count-4.schema |  5 ++
 6 files changed, 89 insertions(+), 4 deletions(-)
 create mode 100644 scripts/dtc/tests/schemas/nodes-count-1.schema
 create mode 100644 scripts/dtc/tests/schemas/nodes-count-2.schema
 create mode 100644 scripts/dtc/tests/schemas/nodes-count-3.schema
 create mode 100644 scripts/dtc/tests/schemas/nodes-count-4.schema

diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
index a8a5664..128a265 100644
--- a/scripts/dtc/schema-test.c
+++ b/scripts/dtc/schema-test.c
@@ -65,6 +65,16 @@ static struct schema_test tests[] = {
 	 "tests/schemas/pattern-matching-1.schema", 1},
 	{"Pattern Matching #2", "tests/test1.dts",
 	 "tests/schemas/pattern-matching-2.schema", 0},
+
+	/* Nodes Count */
+	{"Nodes Count #1", "tests/test1.dts",
+	 "tests/schemas/nodes-count-1.schema", 1},
+	{"Nodes Count #2", "tests/test1.dts",
+	 "tests/schemas/nodes-count-2.schema", 1},
+	{"Nodes Count #3", "tests/test1.dts",
+	 "tests/schemas/nodes-count-3.schema", 0},
+	{"Nodes Count #4", "tests/test1.dts",
+	 "tests/schemas/nodes-count-4.schema", 0},
 };
 
 int main(void)
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index d96129f..b7cfb37 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -88,7 +88,10 @@ struct node_constraints {
 	struct boot_info *bi;
 	struct node *dt;
 
-	const char *compatible;
+	char *compatible;
+	uint32_t count_requested;
+	uint32_t count;
+	uint32_t max_count;
 };
 
 struct schema_db {
@@ -657,6 +660,23 @@ static int validate_properties(struct node *n,
 	return ret;
 }
 
+static void load_node_constraints(struct node_constraints *nc,
+				  struct node *n)
+{
+	struct property *p;
+
+	assert(n);
+	assert(nc);
+
+	nc->count = 0;
+
+	p = get_property(n, "count");
+	nc->count_requested = p ? prop_val_to_uint32(p, 0) : 0;
+
+	p = get_property(n, "max-count");
+	nc->max_count = p ? prop_val_to_uint32(p, 0) : ULONG_MAX;
+}
+
 static int validate_node(struct node *n,
 			 struct node_constraints *nc,
 			 struct node_list *path)
@@ -698,6 +718,7 @@ static struct node_constraints *get_node_constraints_of(struct schema_db *db,
 			n->bi = dt_from_source(n->filepath);
 			n->dt = n->bi->dt;
 		}
+		n->count++;
 		(*i)++;
 		return n;
 	}
@@ -705,6 +726,33 @@ static struct node_constraints *get_node_constraints_of(struct schema_db *db,
 	return NULL;
 }
 
+static int check_nodes_count(struct schema_db *db)
+{
+	int i;
+	int ret = 1;
+	struct node_constraints *n;
+
+	for (i = 0; i < db->size; i++) {
+		n = &db->buffer[i];
+
+		if (n->count_requested) {
+			DT_ERROR_IF(n->count != n->count_requested, NULL, NULL,
+				    "There is %u instance of %s instead "
+				    "of %u.\n",
+				    n->count,
+				    n->compatible,
+				    n->count_requested);
+		} else {
+			DT_ERROR_IF(n->count > n->max_count, NULL, NULL,
+				    "There is too much instance of %s.\n",
+				    n->compatible);
+		}
+	}
+
+end:
+	return ret;
+}
+
 static int for_each_compatible_validate(struct schema_db *db,
 					struct property *p,
 					struct node *node,
@@ -771,11 +819,15 @@ static int validate_nodes(struct schema_db *db,
 
 int validate_dt(struct schema_db *db, struct boot_info *bi)
 {
+	int ret = 1;
+
 	assert(bi);
 	assert(bi->dt);
 	assert(db);
 
-	return validate_nodes(db, bi->dt, NULL);
+	ret &= validate_nodes(db, bi->dt, NULL);
+	ret &= check_nodes_count(db);
+	return ret;
 }
 
 void exit_on_schema_validation_failure(int exit)
@@ -836,7 +888,7 @@ add_compatible_to_schema_db(struct schema_db *db,
 
 	nc = add_new_entry_to_schema_db(db);
 
-	nc->compatible = compatible;
+	nc->compatible = xstrdup(compatible);
 	nc->re_compat = compile_pattern(compatible);
 	if (!nc->re_compat)
 		die("Invalid regex for compatible in %s\n", file);
@@ -851,6 +903,7 @@ static void add_to_schema_db_from_property(struct schema_db *db,
 					   struct node *root)
 {
 	int offset = 0;
+	struct node_constraints *nc;
 
 	assert(db);
 	assert(file);
@@ -858,7 +911,8 @@ static void add_to_schema_db_from_property(struct schema_db *db,
 	assert(p->val.type == STRING);
 
 	while (offset >= 0 && offset < p->val.len) {
-		add_compatible_to_schema_db(db, p->val.val + offset, file);
+		nc = add_compatible_to_schema_db(db, p->val.val + offset, file);
+		load_node_constraints(nc, root);
 		offset = get_next_string_offset(p, offset);
 	}
 }
@@ -973,6 +1027,7 @@ static void free_node_constraints(struct node_constraints *nc)
 	pcre_free(nc->re_compat);
 	free_dt(nc->bi);
 	free(nc->filepath);
+	free(nc->compatible);
 }
 
 void free_schema_db(struct schema_db *db)
diff --git a/scripts/dtc/tests/schemas/nodes-count-1.schema b/scripts/dtc/tests/schemas/nodes-count-1.schema
new file mode 100644
index 0000000..2dc574f
--- /dev/null
+++ b/scripts/dtc/tests/schemas/nodes-count-1.schema
@@ -0,0 +1,5 @@
+/dts-v1/;
+/ {
+	compatible = "compat[1-2]";
+	count = <2>;
+};
diff --git a/scripts/dtc/tests/schemas/nodes-count-2.schema b/scripts/dtc/tests/schemas/nodes-count-2.schema
new file mode 100644
index 0000000..ca8bb4b
--- /dev/null
+++ b/scripts/dtc/tests/schemas/nodes-count-2.schema
@@ -0,0 +1,5 @@
+/dts-v1/;
+/ {
+	compatible = "compat[1-2]";
+	max-count = <5>;
+};
diff --git a/scripts/dtc/tests/schemas/nodes-count-3.schema b/scripts/dtc/tests/schemas/nodes-count-3.schema
new file mode 100644
index 0000000..bcbded0
--- /dev/null
+++ b/scripts/dtc/tests/schemas/nodes-count-3.schema
@@ -0,0 +1,5 @@
+/dts-v1/;
+/ {
+	compatible = "compat[1-2]";
+	count = <3>;
+};
diff --git a/scripts/dtc/tests/schemas/nodes-count-4.schema b/scripts/dtc/tests/schemas/nodes-count-4.schema
new file mode 100644
index 0000000..04408f9
--- /dev/null
+++ b/scripts/dtc/tests/schemas/nodes-count-4.schema
@@ -0,0 +1,5 @@
+/dts-v1/;
+/ {
+	compatible = "compat[1-2]";
+	max-count = <1>;
+};
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
