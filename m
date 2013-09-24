From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [RFC 06/15] scripts/dtc: check for required properties
Date: Tue, 24 Sep 2013 18:52:12 +0200
Message-ID: <1380041541-17529-7-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Add the ability to specify inside a schema that a property is required to be
present in the validated node. By default a property can be missing but one can
require its presence inside a node via the 'is-required' property.

Add as well two test files for this feature.

timer1: timer@4a318000 {
    compatible = "ti,omap3430-timer";
    reg = <0x4a318000 0x80>;
    interrupts = <0x0 0x25 0x4>;
    ti,hwmods = "timer1";
    ti,timer-alwon;
};

To make the ti,hwmods a required property inside an omap timer, one can use the
following schema:
/dts-v1/;
/ {
    compatible = "ti,omap[0-9]+-timer";
    ti,hwmods {
        is-required;
    };
};

Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 scripts/dtc/schema-test.c                            | 6 ++++++
 scripts/dtc/schema.c                                 | 6 ++++++
 scripts/dtc/tests/schemas/required-property-1.schema | 7 +++++++
 scripts/dtc/tests/schemas/required-property-2.schema | 7 +++++++
 4 files changed, 26 insertions(+)
 create mode 100644 scripts/dtc/tests/schemas/required-property-1.schema
 create mode 100644 scripts/dtc/tests/schemas/required-property-2.schema

diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
index 57c86d0..8ac4f58 100644
--- a/scripts/dtc/schema-test.c
+++ b/scripts/dtc/schema-test.c
@@ -18,6 +18,12 @@ struct schema_test {
 };
 
 static struct schema_test tests[] = {
+	/* Required Properties */
+	{"Required Property #1", "tests/test1.dts",
+	 "tests/schemas/required-property-1.schema", 0},
+	{"Required Property #2", "tests/test1.dts",
+	 "tests/schemas/required-property-2.schema", 1},
+
 	/* Types */
 	{"Types #1", "tests/test1.dts",
 	 "tests/schemas/types-1.schema", 1},
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index c01cdee..97ea5b0 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -34,6 +34,7 @@ struct node_list {
 struct prop_constraints {
 	const char *name;
 	char *type;
+	int is_required;
 };
 
 struct node_constraints {
@@ -199,6 +200,8 @@ load_property_constraints(struct node *schema)
 	pc = xmalloc(sizeof(*pc));
 	memset(pc, 0, sizeof(*pc));
 
+	pc->is_required = get_property(schema, "is-required") != NULL;
+
 	p = get_property(schema, "name");
 	if (p)
 		pc->name = p->val.val;
@@ -255,6 +258,9 @@ static int validate_property(struct node *n,
 	assert(pc);
 	assert(path);
 
+	if (pc->is_required && !p)
+		DT_ERROR(path, NULL, "Missing property '%s'\n", schema->name);
+
 	if (!p)
 		goto end;
 
diff --git a/scripts/dtc/tests/schemas/required-property-1.schema b/scripts/dtc/tests/schemas/required-property-1.schema
new file mode 100644
index 0000000..469fa5b
--- /dev/null
+++ b/scripts/dtc/tests/schemas/required-property-1.schema
@@ -0,0 +1,7 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+	abc {
+		is-required;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/required-property-2.schema b/scripts/dtc/tests/schemas/required-property-2.schema
new file mode 100644
index 0000000..35bdde1
--- /dev/null
+++ b/scripts/dtc/tests/schemas/required-property-2.schema
@@ -0,0 +1,7 @@
+/dts-v1/;
+/ {
+	compatible = "compat1";
+	mypropstr {
+		is-required;
+	};
+};
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
