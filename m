From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC 11/15] scripts/dtc: check for children nodes
Date: Tue, 24 Sep 2013 18:52:17 +0200
Message-ID: <1380041541-17529-12-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37919 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab3IXQxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 12:53:04 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so4937058wgg.10
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 09:53:03 -0700 (PDT)
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>

From: Fabien Parent <fparent@baylibre.com>

Add the ability to check if a node has some required children nodes.
Add as well two test files for this feature.

node {
    compatible = "comp";

    subnode1 {
    };

    subnode2 {
    };

    abc {
    };
};

One can check if 'node' has the following subnode 'subnode1', 'subnode2', and
'abc' with the schema below:

/dts-v1/;
/ {
    compatible = "comp";
    children = "abc", "subnode[0-9]";
};

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 scripts/dtc/schema-test.c                         |  6 +++
 scripts/dtc/schema.c                              | 47 +++++++++++++++++++++++
 scripts/dtc/tests/schemas/children-nodes-1.schema |  5 +++
 scripts/dtc/tests/schemas/children-nodes-2.schema |  5 +++
 scripts/dtc/tests/test1.dts                       |  4 ++
 5 files changed, 67 insertions(+)
 create mode 100644 scripts/dtc/tests/schemas/children-nodes-1.schema
 create mode 100644 scripts/dtc/tests/schemas/children-nodes-2.schema

diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
index 128a265..9f1ce31 100644
--- a/scripts/dtc/schema-test.c
+++ b/scripts/dtc/schema-test.c
@@ -75,6 +75,12 @@ static struct schema_test tests[] = {
 	 "tests/schemas/nodes-count-3.schema", 0},
 	{"Nodes Count #4", "tests/test1.dts",
 	 "tests/schemas/nodes-count-4.schema", 0},
+
+	/* Children nodes */
+	{"Children Nodes #1", "tests/test1.dts",
+	 "tests/schemas/children-nodes-1.schema", 1},
+	{"Children Nodes #2", "tests/test1.dts",
+	 "tests/schemas/children-nodes-2.schema", 0},
 };
 
 int main(void)
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index b7cfb37..a454a19 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -47,6 +47,11 @@ static const char *const SCHEMA_EXT = ".schema";
 static const char *const VALUE_PROPNAME = "value";
 static int exit_on_failure = 0;
 
+struct str_list {
+	char *str;
+	struct str_list *next;
+};
+
 struct node_list {
 	struct node *n;
 	struct node_list *next;
@@ -92,6 +97,7 @@ struct node_constraints {
 	uint32_t count_requested;
 	uint32_t count;
 	uint32_t max_count;
+	struct str_list *children;
 };
 
 struct schema_db {
@@ -664,6 +670,8 @@ static void load_node_constraints(struct node_constraints *nc,
 				  struct node *n)
 {
 	struct property *p;
+	int i = 0;
+	struct str_list *iter;
 
 	assert(n);
 	assert(nc);
@@ -675,6 +683,15 @@ static void load_node_constraints(struct node_constraints *nc,
 
 	p = get_property(n, "max-count");
 	nc->max_count = p ? prop_val_to_uint32(p, 0) : ULONG_MAX;
+
+	p = get_property(n, "children");
+	while (p && i < p->val.len && i >= 0) {
+		iter = xmalloc(sizeof(*iter));
+		iter->str = xstrdup(p->val.val + i);
+		iter->next = nc->children;
+		nc->children = iter;
+		i = get_next_string_offset(p, i);
+	}
 }
 
 static int validate_node(struct node *n,
@@ -682,7 +699,10 @@ static int validate_node(struct node *n,
 			 struct node_list *path)
 {
 	struct node *iter;
+	struct str_list *pattern;
 	int ret = 1;
+	pcre *re;
+	int has_child;
 
 	assert(n);
 	assert(path);
@@ -692,6 +712,27 @@ static int validate_node(struct node *n,
 	for (iter = nc->dt->children; iter; iter = iter->next_sibling)
 		ret &= validate_properties(n, iter, path);
 
+	/* Check whether the node has all the required children nodes */
+	for (pattern = nc->children;
+	     pattern;
+	     pattern = pattern->next) {
+		re = compile_pattern(pattern->str);
+		if (!re)
+			die("Invalid pattern: %s\n", pattern->str);
+
+		has_child = 0;
+		for (iter = n->children; iter; iter = iter->next_sibling) {
+			has_child |= pcre_exec(re, 0, iter->name,
+					       strlen(iter->name), 0, 0,
+					       NULL, 0) >= 0;
+		}
+
+		pcre_free(re);
+		DT_ERROR_IF(!has_child, path, NULL,
+			    "Missing child node '%s'\n", pattern->str);
+	}
+
+end:
 	return ret;
 }
 
@@ -1021,9 +1062,15 @@ struct schema_db *build_schema_db(const char *dir)
 
 static void free_node_constraints(struct node_constraints *nc)
 {
+	struct str_list *iter, *iter_next;
+
 	if (!nc)
 		return;
 
+	for_each_safe(nc->children, iter, iter_next) {
+		free(iter->str);
+	}
+
 	pcre_free(nc->re_compat);
 	free_dt(nc->bi);
 	free(nc->filepath);
diff --git a/scripts/dtc/tests/schemas/children-nodes-1.schema b/scripts/dtc/tests/schemas/children-nodes-1.schema
new file mode 100644
index 0000000..8f1cf9a
--- /dev/null
+++ b/scripts/dtc/tests/schemas/children-nodes-1.schema
@@ -0,0 +1,5 @@
+/dts-v1/;
+/ {
+	compatible = "node";
+	children = "node1", "node2";
+};
diff --git a/scripts/dtc/tests/schemas/children-nodes-2.schema b/scripts/dtc/tests/schemas/children-nodes-2.schema
new file mode 100644
index 0000000..f0ee2f2
--- /dev/null
+++ b/scripts/dtc/tests/schemas/children-nodes-2.schema
@@ -0,0 +1,5 @@
+/dts-v1/;
+/ {
+	compatible = "node";
+	children = "node3";
+};
diff --git a/scripts/dtc/tests/test1.dts b/scripts/dtc/tests/test1.dts
index 7d8d745..c390050 100644
--- a/scripts/dtc/tests/test1.dts
+++ b/scripts/dtc/tests/test1.dts
@@ -15,4 +15,8 @@
 			compatible = "compat2";
 		};
 	};
+
+	node2 {
+		compatible = "compat3";
+	};
 };
-- 
1.8.1.2

