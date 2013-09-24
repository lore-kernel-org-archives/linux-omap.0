From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC 12/15] scripts/dtc: check constraints on parents
Date: Tue, 24 Sep 2013 18:52:18 +0200
Message-ID: <1380041541-17529-13-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:58674 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab3IXQxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 12:53:06 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so4805384wgh.4
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 09:53:05 -0700 (PDT)
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>

From: Fabien Parent <fparent@baylibre.com>

Add the ability to specify constraints on the parents of a node.
Add as well seven test files for this feature.

node {
    compatible = "abcomp";
    abc = "abc";

    subnode {
        compatible = "comp";
        abc = "def";
    };
};

The schema below tests whether 'subnode' has a parent named 'node' and whether
it has a compatible property equal to "abcomp" and a 'abc' property equal to
"abc". In the case of the node above the constraints couldn't be check by
inheriting the properties via 'can-be-inherited' since they are overwritten
by the node 'subnode'.

/dts-v1/;
/ {
    compatible = "comp";

    parents {
        node {
            compatible {
                type = "string";
                value = "abcomp";
            };

            abc {
                type = "string";
                value = "abc";
            };
        };
    };
};

It is possible to set conditional constraints on parents of the following form:
    if (node_compatible == "compat1")
        check_this_parent_constraints();
    else if (node_compatible == "compat2")
        check_that_parent_constraints();

To do this one should put the parent constraints at the same place as the
compatible definition in a schema file.

/dts-v1/;
/ {
    compatible {
        value@0 {
            value = "compat1";
            parents {
                node {
                    myprop {
                        type = "int";
                        value@0 = <0xf>;
                    };
                };
            };
        };

        value@1 {
            value = "compat2";
            parents {
                node {
                    myprop {
                        type = "int";
                        value@0 = <0xa>;
                    };
                };
            };
        };
    };
};

This schema will check that if the compatible of a node is "compat1" then it
must have a parent node "node" which has an integer array property "myprop"
which has as first element the value 0xf, otherwise if the node has the
compatible "compat2" then the first element of the same property must have the
value 0xa.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 scripts/dtc/schema-test.c                       |  16 +++
 scripts/dtc/schema.c                            | 126 +++++++++++++++++++++++-
 scripts/dtc/tests/schemas/parent-nodes-1.schema |  23 +++++
 scripts/dtc/tests/schemas/parent-nodes-2.schema |  12 +++
 scripts/dtc/tests/schemas/parent-nodes-3.schema |  14 +++
 scripts/dtc/tests/schemas/parent-nodes-4.schema |  27 +++++
 scripts/dtc/tests/schemas/parent-nodes-5.schema |  15 +++
 scripts/dtc/tests/schemas/parent-nodes-6.schema |  13 +++
 scripts/dtc/tests/schemas/parent-nodes-7.schema |  13 +++
 9 files changed, 257 insertions(+), 2 deletions(-)
 create mode 100644 scripts/dtc/tests/schemas/parent-nodes-1.schema
 create mode 100644 scripts/dtc/tests/schemas/parent-nodes-2.schema
 create mode 100644 scripts/dtc/tests/schemas/parent-nodes-3.schema
 create mode 100644 scripts/dtc/tests/schemas/parent-nodes-4.schema
 create mode 100644 scripts/dtc/tests/schemas/parent-nodes-5.schema
 create mode 100644 scripts/dtc/tests/schemas/parent-nodes-6.schema
 create mode 100644 scripts/dtc/tests/schemas/parent-nodes-7.schema

diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
index 9f1ce31..5075c24 100644
--- a/scripts/dtc/schema-test.c
+++ b/scripts/dtc/schema-test.c
@@ -81,6 +81,22 @@ static struct schema_test tests[] = {
 	 "tests/schemas/children-nodes-1.schema", 1},
 	{"Children Nodes #2", "tests/test1.dts",
 	 "tests/schemas/children-nodes-2.schema", 0},
+
+	/* Parent nodes */
+	{"Parent Nodes #1", "tests/test1.dts",
+	 "tests/schemas/parent-nodes-1.schema", 1},
+	{"Parent Nodes #2", "tests/test1.dts",
+	 "tests/schemas/parent-nodes-2.schema", 0},
+	{"Parent Nodes #3", "tests/test1.dts",
+	 "tests/schemas/parent-nodes-3.schema", 0},
+	{"Parent Nodes #4", "tests/test1.dts",
+	 "tests/schemas/parent-nodes-4.schema", 1},
+	{"Parent Nodes #5", "tests/test1.dts",
+	 "tests/schemas/parent-nodes-5.schema", 0},
+	{"Parent Nodes #6", "tests/test1.dts",
+	 "tests/schemas/parent-nodes-6.schema", 0},
+	{"Parent Nodes #7", "tests/test1.dts",
+	 "tests/schemas/parent-nodes-7.schema", 1},
 };
 
 int main(void)
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index a454a19..e349e01 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -694,6 +694,123 @@ static void load_node_constraints(struct node_constraints *nc,
 	}
 }
 
+static struct node *find_parent_node(struct node *schema,
+				     struct node_list *path)
+{
+	struct property *p;
+	char *name;
+
+	if (!path)
+		return NULL;
+
+	assert(schema);
+	assert(path->n);
+
+	p = get_property(schema, "name");
+	if (p) {
+		assert(p->val.type == STRING);
+		name = p->val.val;
+	} else {
+		name = schema->name;
+	}
+
+	if (!strcmp(name, path->n->name))
+		return path->n;
+	else
+		return find_parent_node(schema, path->next);
+}
+
+static int validate_node(struct node *n,
+			 struct node_constraints *nc,
+			 struct node_list *path);
+
+static void free_node_constraints(struct node_constraints *nc);
+
+static int validate_parents(struct node *schema,
+			    struct node_list *path)
+{
+	struct node *n;
+	struct node_constraints *nc;
+	int ret = 1;
+
+	assert(schema);
+	assert(path);
+
+	nc = xmalloc(sizeof(*nc));
+
+	for (schema = schema->children; schema; schema = schema->next_sibling) {
+		n = find_parent_node(schema, path);
+		DT_ERROR_IF(!n, path, NULL,
+			    "Missing parent node '%s'\n", schema->name);
+
+		memset(nc, 0, sizeof(*nc));
+		load_node_constraints(nc, schema);
+		nc->dt = schema;
+		ret &= validate_node(n, nc, path);
+		free_node_constraints(nc);
+	}
+
+end:
+	free(nc);
+	return ret;
+}
+
+static struct node *find_current_compatible_node(struct node_constraints *nc)
+{
+	pcre *re;
+	struct node *n;
+	struct property *p;
+
+	assert(nc);
+	assert(nc->compatible);
+	assert(nc->bi);
+	assert(nc->bi->dt);
+
+	n = get_subnode(nc->bi->dt, "compatible");
+	if (!n)
+		return NULL;
+
+	re = compile_pattern(nc->compatible);
+	assert(re);
+
+	for (n = n->children; n; n = n->next_sibling) {
+		if (!is_prop_value(n->name))
+			continue;
+
+		p = get_property(n, "value");
+		if (!p)
+			continue;
+
+		assert(p->val.type == STRING);
+		if (pcre_exec(re, 0, p->val.val, strlen(p->val.val),
+			      0, 0, NULL, 0) >= 0)
+			break;
+	}
+
+	pcre_free(re);
+	return n;
+}
+
+static int validate_compatible(struct node_constraints *nc,
+			       struct node_list *path)
+{
+	int ret = 1;
+	struct node *n;
+
+	assert(nc);
+	assert(path);
+
+	n = find_current_compatible_node(nc);
+	if (!n)
+		return ret;
+
+	n = get_subnode(n, "parents");
+	if (!n)
+		return ret;
+
+	return ret & validate_parents(n, path);
+}
+
 static int validate_node(struct node *n,
 			 struct node_constraints *nc,
 			 struct node_list *path)
@@ -709,8 +826,12 @@ static int validate_node(struct node *n,
 	assert(nc);
 	assert(nc->dt);
 
-	for (iter = nc->dt->children; iter; iter = iter->next_sibling)
-		ret &= validate_properties(n, iter, path);
+	for (iter = nc->dt->children; iter; iter = iter->next_sibling) {
+		if (!strcmp(iter->name, "parents"))
+			ret &= validate_parents(iter, path);
+		else
+			ret &= validate_properties(n, iter, path);
+	}
 
 	/* Check whether the node has all the required children nodes */
 	for (pattern = nc->children;
@@ -814,6 +935,7 @@ static int for_each_compatible_validate(struct schema_db *db,
 		while ((nc = get_node_constraints_of(db, p->val.val + offset,
 						     &i)) != NULL) {
 			ret &= validate_node(node, nc, path);
+			ret &= validate_compatible(nc, path);
 		}
 
 		offset = get_next_string_offset(p, offset);
diff --git a/scripts/dtc/tests/schemas/parent-nodes-1.schema b/scripts/dtc/tests/schemas/parent-nodes-1.schema
new file mode 100644
index 0000000..95d3b50
--- /dev/null
+++ b/scripts/dtc/tests/schemas/parent-nodes-1.schema
@@ -0,0 +1,23 @@
+/dts-v1/;
+/ {
+	compatible = "compat2";
+
+	parents {
+		root {
+			name = "";
+			everywhere {
+				type = "integer";
+				value@0 = <0xf>;
+				value@1 = <0xa>;
+				value@2 = <0xb>;
+			};
+		};
+
+		node1 {
+			mypropstr {
+				type = "string";
+				value = "value[0-9]";
+			};
+		};
+	};
+};
diff --git a/scripts/dtc/tests/schemas/parent-nodes-2.schema b/scripts/dtc/tests/schemas/parent-nodes-2.schema
new file mode 100644
index 0000000..a2f2b80
--- /dev/null
+++ b/scripts/dtc/tests/schemas/parent-nodes-2.schema
@@ -0,0 +1,12 @@
+/dts-v1/;
+/ {
+	compatible = "compat2";
+
+	parents {
+		abc {
+			def {
+				type = "string";
+			};
+		};
+	};
+};
diff --git a/scripts/dtc/tests/schemas/parent-nodes-3.schema b/scripts/dtc/tests/schemas/parent-nodes-3.schema
new file mode 100644
index 0000000..11c327c
--- /dev/null
+++ b/scripts/dtc/tests/schemas/parent-nodes-3.schema
@@ -0,0 +1,14 @@
+/dts-v1/;
+/ {
+	compatible = "compat2";
+
+	parents {
+		root {
+			name = "";
+			abc {
+				type = "integer";
+				is-required;
+			};
+		};
+	};
+};
diff --git a/scripts/dtc/tests/schemas/parent-nodes-4.schema b/scripts/dtc/tests/schemas/parent-nodes-4.schema
new file mode 100644
index 0000000..ba67ae5
--- /dev/null
+++ b/scripts/dtc/tests/schemas/parent-nodes-4.schema
@@ -0,0 +1,27 @@
+/dts-v1/;
+/ {
+	compatible {
+		value@0 {
+			value = "compat1";
+			parents {
+				root {
+					name = "";
+					everywhere {
+						is-required;
+					};
+				};
+			};
+		};
+
+		value@1 {
+			value = "compat2";
+			parents {
+				node1 {
+					mypropstr {
+						is-required;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/scripts/dtc/tests/schemas/parent-nodes-5.schema b/scripts/dtc/tests/schemas/parent-nodes-5.schema
new file mode 100644
index 0000000..6e83ac5
--- /dev/null
+++ b/scripts/dtc/tests/schemas/parent-nodes-5.schema
@@ -0,0 +1,15 @@
+/dts-v1/;
+/ {
+	compatible {
+		value@0 {
+			value = "compat1";
+			parents {
+				root {
+					myprop {
+						is-required;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/scripts/dtc/tests/schemas/parent-nodes-6.schema b/scripts/dtc/tests/schemas/parent-nodes-6.schema
new file mode 100644
index 0000000..cc1531d
--- /dev/null
+++ b/scripts/dtc/tests/schemas/parent-nodes-6.schema
@@ -0,0 +1,13 @@
+/dts-v1/;
+/ {
+	compatible = "compat2";
+
+	parents {
+		node1 {
+			compatible {
+				type = "string";
+				value = "compat3";
+			};
+		};
+	};
+};
diff --git a/scripts/dtc/tests/schemas/parent-nodes-7.schema b/scripts/dtc/tests/schemas/parent-nodes-7.schema
new file mode 100644
index 0000000..0d45d09
--- /dev/null
+++ b/scripts/dtc/tests/schemas/parent-nodes-7.schema
@@ -0,0 +1,13 @@
+/dts-v1/;
+/ {
+	compatible = "compat2";
+
+	parents {
+		node1 {
+			compatible {
+				type = "string";
+				value = "compat1";
+			};
+		};
+	};
+};
-- 
1.8.1.2

