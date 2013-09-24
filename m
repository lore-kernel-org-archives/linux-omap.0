From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC 07/15] scripts/dtc: can inherit properties
Date: Tue, 24 Sep 2013 18:52:13 +0200
Message-ID: <1380041541-17529-8-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:42674 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab3IXQw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 12:52:58 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so4961567wgh.29
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 09:52:56 -0700 (PDT)
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>

From: Fabien Parent <fparent@baylibre.com>

Sometimes one may want a property to be required but the property could be
defined in a particular node or it could be defined in any of its parents node.
The concept of property inheritence has been added to fill this need. One can
specify that a property must be present in a node or in any of its parents by
using the constraint 'can-be-inherited' in addition to 'is-required'.

Add as well two test files for this feature.

twl {
    interrupt-controller;

    rtc {
        compatible = "ti,twl4030-rtc";
        interrupts = <0xc>;
    };
}

In the case of the rtc above the interrupt-controller is not present,
but it is present in its parent. If inheriting the property from the parent
makes senses like here one can specify in the schema that interrupt-controller
is required in the rtc node and that the property can be inherited
from a parent.

/dts-v1/;
/ {
    compatible = "ti,twl[0-9]+-rtc";
    interrupt-controller {
        is-required;
        can-be-inherited;
    };
};

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 scripts/dtc/schema-test.c                      |  6 ++++++
 scripts/dtc/schema.c                           | 15 +++++++++++++--
 scripts/dtc/tests/schemas/inheritence-1.schema |  7 +++++++
 scripts/dtc/tests/schemas/inheritence-2.schema |  8 ++++++++
 scripts/dtc/tests/test1.dts                    |  4 ++++
 5 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 scripts/dtc/tests/schemas/inheritence-1.schema
 create mode 100644 scripts/dtc/tests/schemas/inheritence-2.schema

diff --git a/scripts/dtc/schema-test.c b/scripts/dtc/schema-test.c
index 8ac4f58..99a4142 100644
--- a/scripts/dtc/schema-test.c
+++ b/scripts/dtc/schema-test.c
@@ -24,6 +24,12 @@ static struct schema_test tests[] = {
 	{"Required Property #2", "tests/test1.dts",
 	 "tests/schemas/required-property-2.schema", 1},
 
+	/* Inheritence */
+	{"Required Property Inheritence #1", "tests/test1.dts",
+	 "tests/schemas/inheritence-1.schema", 0},
+	{"Required Property Inheritence #2", "tests/test1.dts",
+	 "tests/schemas/inheritence-2.schema", 1},
+
 	/* Types */
 	{"Types #1", "tests/test1.dts",
 	 "tests/schemas/types-1.schema", 1},
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index 97ea5b0..95fc44b 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -35,6 +35,7 @@ struct prop_constraints {
 	const char *name;
 	char *type;
 	int is_required;
+	int can_be_inherited;
 };
 
 struct node_constraints {
@@ -201,6 +202,7 @@ load_property_constraints(struct node *schema)
 	memset(pc, 0, sizeof(*pc));
 
 	pc->is_required = get_property(schema, "is-required") != NULL;
+	pc->can_be_inherited = get_property(schema, "can-be-inherited") != NULL;
 
 	p = get_property(schema, "name");
 	if (p)
@@ -258,8 +260,17 @@ static int validate_property(struct node *n,
 	assert(pc);
 	assert(path);
 
-	if (pc->is_required && !p)
-		DT_ERROR(path, NULL, "Missing property '%s'\n", schema->name);
+	if (pc->is_required && !p) {
+		if (pc->can_be_inherited && path->next) {
+			assert(path->next->n);
+			ret &= validate_properties(path->next->n,
+						   schema,
+						   path->next);
+		} else {
+			DT_ERROR(path, NULL, "Missing property '%s'\n",
+				 schema->name);
+		}
+	}
 
 	if (!p)
 		goto end;
diff --git a/scripts/dtc/tests/schemas/inheritence-1.schema b/scripts/dtc/tests/schemas/inheritence-1.schema
new file mode 100644
index 0000000..2a64ea7
--- /dev/null
+++ b/scripts/dtc/tests/schemas/inheritence-1.schema
@@ -0,0 +1,7 @@
+/dts-v1/;
+/ {
+	compatible = "compat2";
+	mypropstr {
+		is-required;
+	};
+};
diff --git a/scripts/dtc/tests/schemas/inheritence-2.schema b/scripts/dtc/tests/schemas/inheritence-2.schema
new file mode 100644
index 0000000..3da0f64
--- /dev/null
+++ b/scripts/dtc/tests/schemas/inheritence-2.schema
@@ -0,0 +1,8 @@
+/dts-v1/;
+/ {
+	compatible = "compat2";
+	mypropstr {
+		is-required;
+		can-be-inherited;
+	};
+};
diff --git a/scripts/dtc/tests/test1.dts b/scripts/dtc/tests/test1.dts
index 9a950da..a296591 100644
--- a/scripts/dtc/tests/test1.dts
+++ b/scripts/dtc/tests/test1.dts
@@ -6,5 +6,9 @@
 		compatible = "compat1";
 		mypropint = <0 2 4 6>;
 		mypropstr = "value0", "value1", "value2";
+
+		subnode1 {
+			compatible = "compat2";
+		};
 	};
 };
-- 
1.8.1.2

