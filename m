From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC 05/15] scripts/dtc: check type on properties
Date: Tue, 24 Sep 2013 18:52:11 +0200
Message-ID: <1380041541-17529-6-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:52674 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab3IXQwy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 12:52:54 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so4212398wid.14
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 09:52:53 -0700 (PDT)
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>

From: Fabien Parent <fparent@baylibre.com>

Add the ability to check if a property has the correct type. Right now dtc only
handles the two trivial types: integer array, string array. Since at the end
everything is an array of byte which may or may not be terminated by a null
byte this was enough.

A nice thing to add for the future would be to be able to specify the types
more precisely.

Add as well two test files for this feature.

/ {
    compatible = "abc";

    abc = <0xa 0xb 0xc>;
    def = "def", gef;
};

To check that the property abc is an integer array and that the property def
is a string array for the dts above one can use the following schema:

/ {
    compatible = "abc";

    abc {
        type = "integer";
    };

    def {
        type = "string";
    };
};

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 scripts/dtc/data.c                       | 22 ++++++++++++----
 scripts/dtc/dtc.h                        |  9 +++++++
 scripts/dtc/schema-test.c                |  5 ++++
 scripts/dtc/schema.c                     | 44 ++++++++++++++++++++++++++++++++
 scripts/dtc/tests/schemas/types-1.schema | 12 +++++++++
 scripts/dtc/tests/schemas/types-2.schema |  7 +++++
 scripts/dtc/tests/test1.dts              | 10 ++++++++
 7 files changed, 104 insertions(+), 5 deletions(-)
 create mode 100644 scripts/dtc/tests/schemas/types-1.schema
 create mode 100644 scripts/dtc/tests/schemas/types-2.schema
 create mode 100644 scripts/dtc/tests/test1.dts

diff --git a/scripts/dtc/data.c b/scripts/dtc/data.c
index 4a40c5b..9e03718 100644
--- a/scripts/dtc/data.c
+++ b/scripts/dtc/data.c
@@ -75,6 +75,7 @@ struct data data_copy_escape_string(const char *s, int len)
 	char *q;
 
 	d = data_grow_for(empty_data, strlen(s)+1);
+	d.type = STRING;
 
 	q = d.val;
 	while (i < len) {
@@ -93,6 +94,7 @@ struct data data_copy_escape_string(const char *s, int len)
 struct data data_copy_file(FILE *f, size_t maxlen)
 {
 	struct data d = empty_data;
+	d.type = STRING;
 
 	while (!feof(f) && (d.len < maxlen)) {
 		size_t chunksize, ret;
@@ -157,6 +159,7 @@ struct data data_merge(struct data d1, struct data d2)
 	struct marker *m2 = d2.markers;
 
 	d = data_append_markers(data_append_data(d1, d2.val, d2.len), m2);
+	d.type = d2.type ? d2.type : d1.type;
 
 	/* Adjust for the length of d1 */
 	for_each_marker(m2)
@@ -178,23 +181,30 @@ struct data data_append_integer(struct data d, uint64_t value, int bits)
 	switch (bits) {
 	case 8:
 		value_8 = value;
-		return data_append_data(d, &value_8, 1);
+		d = data_append_data(d, &value_8, 1);
+		break;
 
 	case 16:
 		value_16 = cpu_to_fdt16(value);
-		return data_append_data(d, &value_16, 2);
+		d = data_append_data(d, &value_16, 2);
+		break;
 
 	case 32:
 		value_32 = cpu_to_fdt32(value);
-		return data_append_data(d, &value_32, 4);
+		d = data_append_data(d, &value_32, 4);
+		break;
 
 	case 64:
 		value_64 = cpu_to_fdt64(value);
-		return data_append_data(d, &value_64, 8);
+		d = data_append_data(d, &value_64, 8);
+		break;
 
 	default:
 		die("Invalid literal size (%d)\n", bits);
 	}
+
+	d.type = INTEGER;
+	return d;
 }
 
 struct data data_append_re(struct data d, const struct fdt_reserve_entry *re)
@@ -219,7 +229,9 @@ struct data data_append_addr(struct data d, uint64_t addr)
 
 struct data data_append_byte(struct data d, uint8_t byte)
 {
-	return data_append_data(d, &byte, 1);
+	d = data_append_data(d, &byte, 1);
+	d.type = INTEGER;
+	return d;
 }
 
 struct data data_append_zeroes(struct data d, int len)
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index e61dde7..a9b8602 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -82,10 +82,19 @@ struct  marker {
 	struct marker *next;
 };
 
+enum datatype {
+	UNDEFINED,
+	BOOLEAN,
+	INTEGER,
+	STRING,
+};
+
 struct data {
 	int len;
 	char *val;
 	struct marker *markers;
+
+	enum datatype type;
 };
 
 
diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
index 0eb2499..57c86d0 100644
--- a/scripts/dtc/schema-test.c
+++ b/scripts/dtc/schema-test.c
@@ -18,6 +18,11 @@ struct schema_test {
 };
 
 static struct schema_test tests[] = {
+	/* Types */
+	{"Types #1", "tests/test1.dts",
+	 "tests/schemas/types-1.schema", 1},
+	{"Types #2", "tests/test1.dts",
+	 "tests/schemas/types-2.schema", 0},
 };
 
 int main(void)
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index b190241..c01cdee 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -33,6 +33,7 @@ struct node_list {
 
 struct prop_constraints {
 	const char *name;
+	char *type;
 };
 
 struct node_constraints {
@@ -202,9 +203,41 @@ load_property_constraints(struct node *schema)
 	if (p)
 		pc->name = p->val.val;
 
+	p = get_property(schema, "type");
+	if (p)
+		pc->type = p->val.val;
+
 	return pc;
 }
 
+static int check_types(struct property *p, struct prop_constraints *pc)
+{
+	assert(p);
+	assert(pc);
+
+	if (!pc->type)
+		return 1;
+
+	switch (p->val.type) {
+	case BOOLEAN:
+		return !strcmp(pc->type, "bool");
+
+	case STRING:
+		return !strcmp(pc->type, "string");
+
+	case INTEGER:
+		return !strcmp(pc->type, "integer");
+
+	case UNDEFINED:
+		return 1;
+
+	default:
+		die("We shouldn't reach this point.");
+	};
+
+	return 0;
+}
+
 static int validate_properties(struct node *n,
 			       struct node *schema,
 			       struct node_list *path);
@@ -222,6 +255,15 @@ static int validate_property(struct node *n,
 	assert(pc);
 	assert(path);
 
+	if (!p)
+		goto end;
+
+	if (!check_types(p, pc)) {
+		DT_ERROR(path, p, "Bad type for property, expecting a value of "
+				  "the following type: '%s'\n", pc->type);
+	}
+
+end:
 	free_property_constraints(pc);
 	return ret;
 }
@@ -319,6 +361,7 @@ static int for_each_compatible_validate(struct schema_db *db,
 	assert(db);
 	assert(node);
 	assert(p);
+	assert(p->val.type == STRING);
 
 	while (offset >= 0 && offset < p->val.len) {
 		i = 0;
@@ -455,6 +498,7 @@ static void add_to_schema_db_from_property(struct schema_db *db,
 	assert(db);
 	assert(file);
 	assert(p);
+	assert(p->val.type == STRING);
 
 	while (offset >= 0 && offset < p->val.len) {
 		add_compatible_to_schema_db(db, p->val.val + offset, file);
diff --git a/scripts/dtc/tests/schemas/types-1.schema b/scripts/dtc/tests/schemas/types-1.schema
new file mode 100644
index 0000000..71d09e7
--- /dev/null
+++ b/scripts/dtc/tests/schemas/types-1.schema
@@ -0,0 +1,12 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+
+	mypropint {
+		type = "integer";
+	};
+
+	mypropstr {
+		type = "string";
+	};
+};
diff --git a/scripts/dtc/tests/schemas/types-2.schema b/scripts/dtc/tests/schemas/types-2.schema
new file mode 100644
index 0000000..f0779e1
--- /dev/null
+++ b/scripts/dtc/tests/schemas/types-2.schema
@@ -0,0 +1,7 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+	mypropstr {
+		type = "integer";
+	};
+};
diff --git a/scripts/dtc/tests/test1.dts b/scripts/dtc/tests/test1.dts
new file mode 100644
index 0000000..9a950da
--- /dev/null
+++ b/scripts/dtc/tests/test1.dts
@@ -0,0 +1,10 @@
+/dts-v1/;
+/ {
+	compatible = "root", "node";
+
+	node1 {
+		compatible = "compat1";
+		mypropint = <0 2 4 6>;
+		mypropstr = "value0", "value1", "value2";
+	};
+};
-- 
1.8.1.2

