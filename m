From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] of/platform: Allow secondary compatible match in of_dev_lookup
Date: Fri,  1 Apr 2016 14:35:04 -0700
Message-ID: <1459546504-32668-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We currently try to match of_dev_auxdata based on compatible,
IO address, and device name. But in some cases we have multiple
instances of drivers that can use the same auxdata.

Let's add an additional secondary lookup for generic compatible
match for auxdata if no device specific match is found. This does
not change the existing matching, and still allows adding device
specific auxdata.

This simplifies things as specifying the IO address and device
name is prone errors as it requires maintaining an in kernel
database for each SoC.

To specify a generic match, all that is needed is to add a
OF_DEV_AUXDATA entry with no device instance specified:

OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),

As the auxdata is already initialized only for the booted SoC,
there's not much of a chance of getting things wrong.

Let's also fix two checkpatch warnings while at it to add a
space before parenthesis in the for loop, and remove a comparison
to NULL by using !auxdata->compatible.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/of/platform.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 8d103e4..16e8daf 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -297,19 +297,37 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *lookup,
 				 struct device_node *np)
 {
+	const struct of_dev_auxdata *auxdata;
 	struct resource res;
+	int compatible = 0;
 
 	if (!lookup)
 		return NULL;
 
-	for(; lookup->compatible != NULL; lookup++) {
-		if (!of_device_is_compatible(np, lookup->compatible))
+	auxdata = lookup;
+	for (; auxdata->compatible; auxdata++) {
+		if (!of_device_is_compatible(np, auxdata->compatible))
 			continue;
+		compatible++;
 		if (!of_address_to_resource(np, 0, &res))
-			if (res.start != lookup->phys_addr)
+			if (res.start != auxdata->phys_addr)
 				continue;
-		pr_debug("%s: devname=%s\n", np->full_name, lookup->name);
-		return lookup;
+		pr_debug("%s: devname=%s\n", np->full_name, auxdata->name);
+		return auxdata;
+	}
+
+	if (!compatible)
+		return NULL;
+
+	/* Try compatible match if no phys_addr and name are specified */
+	auxdata = lookup;
+	for (; auxdata->compatible; auxdata++) {
+		if (!of_device_is_compatible(np, auxdata->compatible))
+			continue;
+		if (!auxdata->phys_addr && !auxdata->name) {
+			pr_debug("%s: compatible match\n", np->full_name);
+			return auxdata;
+		}
 	}
 
 	return NULL;
-- 
2.7.0
