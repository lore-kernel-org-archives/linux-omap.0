From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [RFC 09/15] scripts/dtc: check value of properties
Date: Tue, 24 Sep 2013 18:52:15 +0200
Message-ID: <1380041541-17529-10-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Add the ability to check whether a property has a given value or not.
Add as well 7 test files for this feature.

abc {
   prop1 = <0 1 2 3>;
   prop2 = "value0", "value1", "value3";
};

====

To check whether an integer array contains value from a given range
use the following constraint:
    prop1 {
        type = "integer";
        value = <0x0 0xF>;
    };

To check whether a string array contains value that match a given pattern
use the following constraint:
    prop2 {
        type = "string";
        value = "value[0-9]";
    };

To check whether a particular element of an array has the correct value one
can use the following constraint:
    prop1 {
        type = "integer";
        value@2 = <2>;
    };

or

    prop2 {
        type = "string";
        value@1 = "value1";
    };

Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 scripts/dtc/schema-test.c                          |  20 ++
 scripts/dtc/schema.c                               | 288 +++++++++++++++++++++
 scripts/dtc/tests/schemas/integer-array-1.schema   |  16 ++
 scripts/dtc/tests/schemas/integer-array-2.schema   |   9 +
 scripts/dtc/tests/schemas/integer-array-3.schema   |   8 +
 .../dtc/tests/schemas/pattern-matching-1.schema    |  10 +
 .../dtc/tests/schemas/pattern-matching-2.schema    |  10 +
 scripts/dtc/tests/schemas/string-array-1.schema    |  20 ++
 scripts/dtc/tests/schemas/string-array-2.schema    |   9 +
 scripts/dtc/tests/test1.dts                        |   4 +
 10 files changed, 394 insertions(+)
 create mode 100644 scripts/dtc/tests/schemas/integer-array-1.schema
 create mode 100644 scripts/dtc/tests/schemas/integer-array-2.schema
 create mode 100644 scripts/dtc/tests/schemas/integer-array-3.schema
 create mode 100644 scripts/dtc/tests/schemas/pattern-matching-1.schema
 create mode 100644 scripts/dtc/tests/schemas/pattern-matching-2.schema
 create mode 100644 scripts/dtc/tests/schemas/string-array-1.schema
 create mode 100644 scripts/dtc/tests/schemas/string-array-2.schema

diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
index bfc9e43..a8a5664 100644
--- a/scripts/dtc/schema-test.c
+++ b/scripts/dtc/schema-test.c
@@ -45,6 +45,26 @@ static struct schema_test tests[] = {
 	 "tests/schemas/array-size-3.schema", 0},
 	{"Array Size #4", "tests/test1.dts",
 	 "tests/schemas/array-size-4.schema", 0},
+
+	/* String Array */
+	{"String Array Values #1", "tests/test1.dts",
+	 "tests/schemas/string-array-1.schema", 1},
+	{"String Array Values #2", "tests/test1.dts",
+	 "tests/schemas/string-array-2.schema", 0},
+
+	/* Integer Array */
+	{"Integer Array Values #1", "tests/test1.dts",
+	 "tests/schemas/integer-array-1.schema", 1},
+	{"Integer Array Values #2", "tests/test1.dts",
+	 "tests/schemas/integer-array-2.schema", 0},
+	{"Integer Array Values #3", "tests/test1.dts",
+	 "tests/schemas/integer-array-3.schema", 0},
+
+	/* Pattern Matching */
+	{"Pattern Matching #1", "tests/test1.dts",
+	 "tests/schemas/pattern-matching-1.schema", 1},
+	{"Pattern Matching #2", "tests/test1.dts",
+	 "tests/schemas/pattern-matching-2.schema", 0},
 };
 
 int main(void)
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index 95ad925..d96129f 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -7,6 +7,26 @@
 #include <stdio.h>
 #include <limits.h>
 
+#define sorted_list_add(x, e) \
+	do { \
+		typeof(x) prev, i; \
+		if (!x) {\
+			x = e; \
+			break; \
+		} \
+		for (prev = x, i = x->next; \
+			 i && i->id < e->id; \
+			 prev = i, i = i->next) \
+			; \
+		e->next = i; \
+		prev->next = e; \
+	} while (0)
+
+#define for_each_safe(list, iter, iter_next) \
+	for (iter = list, iter_next = list ? list->next : NULL;\
+	     iter; \
+	     iter = iter_next, iter_next = iter_next ? iter_next->next : NULL)
+
 #define DT_ERROR(path, p, format, ...) \
 	do { \
 		dt_error(path, p, format, ##__VA_ARGS__); \
@@ -32,6 +52,21 @@ struct node_list {
 	struct node_list *next;
 };
 
+struct range {
+	uint32_t low;
+	uint32_t high;
+	int id;
+
+	struct range *next;
+};
+
+struct pattern {
+	const char *text;
+	int id;
+
+	struct pattern *next;
+};
+
 struct prop_constraints {
 	const char *name;
 	char *type;
@@ -39,6 +74,12 @@ struct prop_constraints {
 	int can_be_inherited;
 	size_t min_length;
 	size_t max_length;
+
+	union {
+		struct pattern *patterns;
+		struct range *ranges;
+	} value;
+	enum datatype value_type;
 };
 
 struct node_constraints {
@@ -207,11 +248,139 @@ static void dt_error(struct node_list *path,
 		exit(1);
 }
 
+static void load_property_value_constraints(struct prop_constraints *pc,
+					    struct node *schema)
+{
+	struct property *p;
+	struct pattern *pattern;
+	struct range *r;
+	uint32_t low;
+	uint32_t high;
+	int offset;
+
+	assert(pc);
+	assert(schema);
+
+	p = get_property(schema, "value");
+	if (p) {
+		switch (p->val.type) {
+		case STRING:
+			pc->value.patterns = xmalloc(sizeof(*pattern));
+			memset(pc->value.patterns, 0,
+			       sizeof(*pc->value.patterns));
+			pc->value.patterns->text = p->val.val;
+			pc->value.patterns->id = -1;
+			pc->value_type = STRING;
+			break;
+
+		case INTEGER:
+			/**
+			 * Constraints:
+			 * value = <0x0 0xFF>;
+			 *
+			 * The value for each element of the cells
+			 * must be between 0x0 and 0xFF.
+			 */
+			assert(p->val.array_size <= 2);
+
+			low = prop_val_to_uint32(p, 0);
+			high = p->val.array_size == 2
+				   ? prop_val_to_uint32(p, 1)
+				   : low;
+
+			pc->value.ranges = xmalloc(sizeof(*r));
+			memset(pc->value.ranges, 0, sizeof(*pc->value.ranges));
+			pc->value.ranges->low = low;
+			pc->value.ranges->high = high;
+			pc->value_type = INTEGER;
+			pc->value.ranges->id = -1;
+			break;
+
+		default:
+			die("Reach unreachable\n");
+		}
+	}
+
+	/**
+	 * One can put a constraints on a specific cell without
+	 * having to put this constraint on all the cells
+	 *
+	 * This can also be used to override a constraint that has
+	 * been put on on cells.
+	 *
+	 * Ex:
+	 * value = <0x0 0xFF>;
+	 * value@1 = <0x24>;
+	 *
+	 * This will only accept cell that have a value between
+	 * 0x0 and 0xFF, and will require that the second element
+	 * to be equal to 0x24
+	 * Ex:
+	 *  - This is valid:   myprop = <0x13 0x24 0x6F 0x2D>;
+	 *  - This is invalid: myprop = <0x13 0xFE 0x6F 0x2D>;
+	 */
+	for (p = schema->proplist; p; p = p->next) {
+		assert(p->name);
+
+		if (strstr(p->name, "value@") != p->name)
+			continue;
+
+		if (sscanf(p->name, "value@%u", &offset) != 1)
+			continue;
+
+		if (offset >= pc->max_length) {
+			die("Value offset must be lower to the "
+				"number of elements in the array.");
+		}
+
+		if (p->val.type == INTEGER) {
+			assert(pc->value_type == INTEGER
+			       || pc->value_type == UNDEFINED);
+			assert(p->val.array_size <= 2);
+
+			pc->value_type = INTEGER;
+
+			low = prop_val_to_uint32(p, 0);
+			high = p->val.array_size == 2
+			       ? prop_val_to_uint32(p, 1)
+			       : low;
+
+			r = xmalloc(sizeof(*r));
+			memset(r, 0, sizeof(*r));
+			r->low = low;
+			r->high = high;
+			r->id = offset;
+			sorted_list_add(pc->value.ranges, r);
+		} else if (p->val.type == STRING) {
+			assert(pc->value_type == STRING
+			       || pc->value_type == UNDEFINED);
+
+			pc->value_type = STRING;
+			pattern = xmalloc(sizeof(*pattern));
+			memset(pattern, 0, sizeof(*pattern));
+			pattern->text = p->val.val;
+			pattern->id = offset;
+			sorted_list_add(pc->value.patterns, pattern);
+		}
+	}
+}
+
 static void free_property_constraints(struct prop_constraints *pc)
 {
+	struct pattern *p, *p_next;
+	struct range *r, *r_next;
+
 	if (!pc)
 		return;
 
+	if (pc->value_type == STRING) {
+		for_each_safe(pc->value.patterns, p, p_next)
+			free(p);
+	} else if (pc->value_type == INTEGER) {
+		for_each_safe(pc->value.ranges, r, r_next)
+			free(r);
+	}
+
 	free(pc);
 }
 
@@ -256,6 +425,7 @@ load_property_constraints(struct node *schema)
 		pc->max_length = prop_val_to_uint32(p, 0);
 	}
 
+	load_property_value_constraints(pc, schema);
 	return pc;
 }
 
@@ -287,6 +457,121 @@ static int check_types(struct property *p, struct prop_constraints *pc)
 	return 0;
 }
 
+static inline struct range*
+find_range_for_elem_num(struct prop_constraints *pc, int num)
+{
+	struct range *r;
+
+	assert(pc);
+	assert(pc->value_type == INTEGER);
+	assert(pc->value.ranges);
+
+	for (r = pc->value.ranges; r && r->id != num; r = r->next)
+		;
+
+	if (!r && pc->value.ranges->id == -1)
+		r = pc->value.ranges;
+
+	return r;
+}
+
+static int check_integer_value(struct property *p, struct prop_constraints *pc)
+{
+	int i;
+	struct range *r;
+	uint32_t int_value;
+
+	assert(p);
+	assert(pc);
+	assert(p->val.type == INTEGER);
+	assert(pc->value_type == INTEGER);
+	assert(pc->value.ranges);
+
+	for (i = 0; i < p->val.array_size; i++, r = r->next) {
+		r = find_range_for_elem_num(pc, i);
+		if (!r)
+			break;
+
+		int_value = prop_val_to_uint32(p, i);
+		if (int_value < r->low || int_value > r->high)
+			return 0;
+	}
+
+	return 1;
+}
+
+static inline struct pattern*
+find_pattern_for_elem_num(struct prop_constraints *pc, int num)
+{
+	struct pattern *pattern;
+
+	assert(pc);
+	assert(pc->value_type == STRING);
+	assert(pc->value.patterns);
+
+	for (pattern = pc->value.patterns;
+	     pattern && pattern->id != num;
+	     pattern = pattern->next)
+		;
+
+	if (!pattern && pc->value.patterns->id == -1)
+		pattern = pc->value.patterns;
+
+	return pattern;
+}
+
+static int check_string_value(struct property *p, struct prop_constraints *pc)
+{
+	pcre *re;
+	struct pattern *pattern;
+	int i;
+	int str_offset = 0;
+	int res;
+
+	assert(p);
+	assert(pc);
+	assert(p->val.type == STRING);
+
+	for (i = 0; i < p->val.array_size; i++) {
+		pattern = find_pattern_for_elem_num(pc, i);
+		if (!pattern)
+			break;
+
+		assert(pattern->text);
+		re = compile_pattern(pattern->text);
+		if (!re)
+			die("Invalid pattern '%s' in schema\n", pattern->text);
+
+		assert(str_offset >= 0);
+		res = pcre_exec(re, 0, p->val.val + str_offset,
+				strlen(p->val.val + str_offset),
+				0, 0, NULL, 0) >= 0;
+		pcre_free(re);
+
+		str_offset = get_next_string_offset(p, str_offset);
+		if (!res)
+			return 0;
+	}
+
+	return 1;
+}
+
+static int check_value(struct property *p, struct prop_constraints *pc)
+{
+	assert(p);
+	assert(pc);
+
+	if (pc->value_type == UNDEFINED)
+		return 1;
+
+	if (p->val.type == STRING)
+		return check_string_value(p, pc);
+	else if (p->val.type == INTEGER)
+		return check_integer_value(p, pc);
+
+	return 1;
+}
+
 static int validate_properties(struct node *n,
 			       struct node *schema,
 			       struct node_list *path);
@@ -332,6 +617,9 @@ static int validate_property(struct node *n,
 			 pc->max_length, p->val.array_size);
 	}
 
+	if (!check_value(p, pc))
+		DT_ERROR(path, p, "Incorrect value.\n");
+
 end:
 	free_property_constraints(pc);
 	return ret;
diff --git a/scripts/dtc/tests/schemas/integer-array-1.schema b/scripts/dtc/tests/schemas/integer-array-1.schema
new file mode 100644
index 0000000..b7de822
--- /dev/null
+++ b/scripts/dtc/tests/schemas/integer-array-1.schema
@@ -0,0 +1,16 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+
+	mypropint {
+		type = "integer";
+		value@0 = <0>;
+		value@1 = <2>;
+		value@2 = <4>;
+	};
+
+	mypropint2 {
+		type = "integer";
+		value = <0 5>;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/integer-array-2.schema b/scripts/dtc/tests/schemas/integer-array-2.schema
new file mode 100644
index 0000000..a6e7628
--- /dev/null
+++ b/scripts/dtc/tests/schemas/integer-array-2.schema
@@ -0,0 +1,9 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+	mypropint {
+		type = "integer";
+		value@0 = <0>;
+		value@1 = <3>;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/integer-array-3.schema b/scripts/dtc/tests/schemas/integer-array-3.schema
new file mode 100644
index 0000000..b9ccc1c
--- /dev/null
+++ b/scripts/dtc/tests/schemas/integer-array-3.schema
@@ -0,0 +1,8 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+	mypropint {
+		type = "integer";
+		value = <0 3>;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/pattern-matching-1.schema b/scripts/dtc/tests/schemas/pattern-matching-1.schema
new file mode 100644
index 0000000..093851e
--- /dev/null
+++ b/scripts/dtc/tests/schemas/pattern-matching-1.schema
@@ -0,0 +1,10 @@
+/dts-v1/;
+/ {
+	compatible = "compat[0-9]";
+
+	abc {
+		name = "every.+";
+		is-required;
+		can-be-inherited;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/pattern-matching-2.schema b/scripts/dtc/tests/schemas/pattern-matching-2.schema
new file mode 100644
index 0000000..0d73a15
--- /dev/null
+++ b/scripts/dtc/tests/schemas/pattern-matching-2.schema
@@ -0,0 +1,10 @@
+/dts-v1/;
+/ {
+	compatible = "compat[0-9]";
+
+	abc {
+		name = "never.+";
+		is-required;
+		can-be-inherited;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/string-array-1.schema b/scripts/dtc/tests/schemas/string-array-1.schema
new file mode 100644
index 0000000..3d753e2
--- /dev/null
+++ b/scripts/dtc/tests/schemas/string-array-1.schema
@@ -0,0 +1,20 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+
+	mypropstr {
+		type = "string";
+		value = "value[0-9]+";
+	};
+
+	mypropstr2 {
+		type = "string";
+		value = "value[0-9]+";
+		value@1 = "test";
+	};
+
+	mypropstr3 {
+		type = "string";
+		value@0 = "test";
+	};
+};
diff --git a/scripts/dtc/tests/schemas/string-array-2.schema b/scripts/dtc/tests/schemas/string-array-2.schema
new file mode 100644
index 0000000..ee1f441
--- /dev/null
+++ b/scripts/dtc/tests/schemas/string-array-2.schema
@@ -0,0 +1,9 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+
+	mypropstr2 {
+		type = "string";
+		value = "value[0-9]+";
+	};
+};
diff --git a/scripts/dtc/tests/test1.dts b/scripts/dtc/tests/test1.dts
index a296591..7d8d745 100644
--- a/scripts/dtc/tests/test1.dts
+++ b/scripts/dtc/tests/test1.dts
@@ -1,11 +1,15 @@
 /dts-v1/;
 / {
 	compatible = "root", "node";
+	everywhere = <0xf 0xa 0xb>;
 
 	node1 {
 		compatible = "compat1";
 		mypropint = <0 2 4 6>;
+		mypropint2 = <1 2 3>;
 		mypropstr = "value0", "value1", "value2";
+		mypropstr2 = "value0", "test", "value2";
+		mypropstr3 = "test", "toto", "tata";
 
 		subnode1 {
 			compatible = "compat2";
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
