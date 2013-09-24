From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [RFC 08/15] scripts/dtc: check array size
Date: Tue, 24 Sep 2013 18:52:14 +0200
Message-ID: <1380041541-17529-9-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Add constraints on array size:
    - length: specify the exact length that an array must have.
    - min-length: specify the minimum number of elements an array must have.
    - max-length: specify the maximum number of elements an array must have.

Add as well four test files for the feature.

Usage example:
node {
    compatible = "array_size";
    myarray = <0 1 2 3 4>;
};

Schema:
/dts-v1/;
/ {
    compatible = "array_size";

    myarray {
        length = <5>;
    };
};

Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 scripts/dtc/data.c                            |  5 +++
 scripts/dtc/dtc.h                             |  1 +
 scripts/dtc/schema-test.c                     | 10 ++++++
 scripts/dtc/schema.c                          | 52 +++++++++++++++++++++++++++
 scripts/dtc/tests/schemas/array-size-1.schema | 13 +++++++
 scripts/dtc/tests/schemas/array-size-2.schema |  8 +++++
 scripts/dtc/tests/schemas/array-size-3.schema |  8 +++++
 scripts/dtc/tests/schemas/array-size-4.schema |  8 +++++
 8 files changed, 105 insertions(+)
 create mode 100644 scripts/dtc/tests/schemas/array-size-1.schema
 create mode 100644 scripts/dtc/tests/schemas/array-size-2.schema
 create mode 100644 scripts/dtc/tests/schemas/array-size-3.schema
 create mode 100644 scripts/dtc/tests/schemas/array-size-4.schema

diff --git a/scripts/dtc/data.c b/scripts/dtc/data.c
index 9e03718..5284936 100644
--- a/scripts/dtc/data.c
+++ b/scripts/dtc/data.c
@@ -76,6 +76,7 @@ struct data data_copy_escape_string(const char *s, int len)
 
 	d = data_grow_for(empty_data, strlen(s)+1);
 	d.type = STRING;
+	d.array_size++;
 
 	q = d.val;
 	while (i < len) {
@@ -95,6 +96,7 @@ struct data data_copy_file(FILE *f, size_t maxlen)
 {
 	struct data d = empty_data;
 	d.type = STRING;
+	d.array_size++;
 
 	while (!feof(f) && (d.len < maxlen)) {
 		size_t chunksize, ret;
@@ -159,6 +161,7 @@ struct data data_merge(struct data d1, struct data d2)
 	struct marker *m2 = d2.markers;
 
 	d = data_append_markers(data_append_data(d1, d2.val, d2.len), m2);
+	d.array_size += d2.array_size;
 	d.type = d2.type ? d2.type : d1.type;
 
 	/* Adjust for the length of d1 */
@@ -204,6 +207,7 @@ struct data data_append_integer(struct data d, uint64_t value, int bits)
 	}
 
 	d.type = INTEGER;
+	d.array_size++;
 	return d;
 }
 
@@ -231,6 +235,7 @@ struct data data_append_byte(struct data d, uint8_t byte)
 {
 	d = data_append_data(d, &byte, 1);
 	d.type = INTEGER;
+	d.array_size++;
 	return d;
 }
 
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index a9b8602..64fdc8a 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -95,6 +95,7 @@ struct data {
 	struct marker *markers;
 
 	enum datatype type;
+	size_t array_size;
 };
 
 
diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
index 99a4142..bfc9e43 100644
--- a/scripts/dtc/schema-test.c
+++ b/scripts/dtc/schema-test.c
@@ -35,6 +35,16 @@ static struct schema_test tests[] = {
 	 "tests/schemas/types-1.schema", 1},
 	{"Types #2", "tests/test1.dts",
 	 "tests/schemas/types-2.schema", 0},
+
+	/* Array Size */
+	{"Array Size #1", "tests/test1.dts",
+	 "tests/schemas/array-size-1.schema", 1},
+	{"Array Size #2", "tests/test1.dts",
+	 "tests/schemas/array-size-2.schema", 0},
+	{"Array Size #3", "tests/test1.dts",
+	 "tests/schemas/array-size-3.schema", 0},
+	{"Array Size #4", "tests/test1.dts",
+	 "tests/schemas/array-size-4.schema", 0},
 };
 
 int main(void)
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index 95fc44b..95ad925 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -5,6 +5,7 @@
 #include <dirent.h>
 #include <pcre.h>
 #include <stdio.h>
+#include <limits.h>
 
 #define DT_ERROR(path, p, format, ...) \
 	do { \
@@ -36,6 +37,8 @@ struct prop_constraints {
 	char *type;
 	int is_required;
 	int can_be_inherited;
+	size_t min_length;
+	size_t max_length;
 };
 
 struct node_constraints {
@@ -73,6 +76,28 @@ static pcre *compile_pattern(const char *pattern)
 	return re;
 }
 
+static uint32_t prop_val_to_uint32(struct property *p, int i)
+{
+	assert(p);
+	assert(i >= 0);
+
+	switch (p->val.len / p->val.array_size) {
+	case 1:
+		return ((uint8_t *) p->val.val)[i];
+
+	case 2:
+		return fdt16_to_cpu(((uint16_t *) p->val.val)[i]);
+
+	case 4:
+		return fdt32_to_cpu(((uint32_t *) p->val.val)[i]);
+
+	default:
+		die("reach unreachable.");
+	}
+
+	return 0;
+}
+
 static int get_next_string_offset(struct property *p, int offset)
 {
 	assert(p);
@@ -203,6 +228,7 @@ load_property_constraints(struct node *schema)
 
 	pc->is_required = get_property(schema, "is-required") != NULL;
 	pc->can_be_inherited = get_property(schema, "can-be-inherited") != NULL;
+	pc->max_length = ULONG_MAX;
 
 	p = get_property(schema, "name");
 	if (p)
@@ -212,6 +238,24 @@ load_property_constraints(struct node *schema)
 	if (p)
 		pc->type = p->val.val;
 
+	p = get_property(schema, "length");
+	if (p) {
+		assert(p->val.type == INTEGER);
+		pc->min_length = pc->max_length = prop_val_to_uint32(p, 0);
+	}
+
+	p = get_property(schema, "min-length");
+	if (p) {
+		assert(p->val.type == INTEGER);
+		pc->min_length = prop_val_to_uint32(p, 0);
+	}
+
+	p = get_property(schema, "max-length");
+	if (p) {
+		assert(p->val.type == INTEGER);
+		pc->max_length = prop_val_to_uint32(p, 0);
+	}
+
 	return pc;
 }
 
@@ -280,6 +324,14 @@ static int validate_property(struct node *n,
 				  "the following type: '%s'\n", pc->type);
 	}
 
+	if (p->val.array_size < pc->min_length
+		|| p->val.array_size > pc->max_length) {
+		DT_ERROR(path, p, "Incorrect number of elements.\n"
+			 "\tShould have between %zu and %zu "
+			 "but has %zu elements.\n", pc->min_length,
+			 pc->max_length, p->val.array_size);
+	}
+
 end:
 	free_property_constraints(pc);
 	return ret;
diff --git a/scripts/dtc/tests/schemas/array-size-1.schema b/scripts/dtc/tests/schemas/array-size-1.schema
new file mode 100644
index 0000000..b495090
--- /dev/null
+++ b/scripts/dtc/tests/schemas/array-size-1.schema
@@ -0,0 +1,13 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+
+	mypropstr {
+		length = <3>;
+	};
+
+	mypropstr {
+		min-length = <2>;
+		max-length = <3>;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/array-size-2.schema b/scripts/dtc/tests/schemas/array-size-2.schema
new file mode 100644
index 0000000..cd49361
--- /dev/null
+++ b/scripts/dtc/tests/schemas/array-size-2.schema
@@ -0,0 +1,8 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+
+	mypropstr {
+		length = <4>;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/array-size-3.schema b/scripts/dtc/tests/schemas/array-size-3.schema
new file mode 100644
index 0000000..c9cf285
--- /dev/null
+++ b/scripts/dtc/tests/schemas/array-size-3.schema
@@ -0,0 +1,8 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+
+	mypropint {
+		max-length = <2>;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/array-size-4.schema b/scripts/dtc/tests/schemas/array-size-4.schema
new file mode 100644
index 0000000..e3a9775
--- /dev/null
+++ b/scripts/dtc/tests/schemas/array-size-4.schema
@@ -0,0 +1,8 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+
+	mypropint {
+		min-length = <7>;
+	};
+};
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
