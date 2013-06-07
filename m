From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] pinctrl: single: Prepare for supporting SoC specific
 features
Date: Fri, 07 Jun 2013 13:50:37 -0700
Message-ID: <20130607205037.16513.84242.stgit@localhost>
References: <20130607203936.16513.57494.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21498 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab3FGUuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 16:50:40 -0400
In-Reply-To: <20130607203936.16513.57494.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linus.walleij@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

Let's replace is_pinconf with flags and add struct pcs_soc so we
can support also other features like pin wake-up events. Let's
export the probe so the SoC specific modules can pass their
SoC specific data to pinctrl-single if needed.

Done in collaboration with Roger Quadros <rogerq@ti.com>.

Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinctrl-single.c |   53 +++++++++++++++++++++++++++-----------
 drivers/pinctrl/pinctrl-single.h |   15 +++++++++++
 2 files changed, 52 insertions(+), 16 deletions(-)
 create mode 100644 drivers/pinctrl/pinctrl-single.h

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index b9fa046..0f178d1 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -26,6 +26,7 @@
 
 #include "core.h"
 #include "pinconf.h"
+#include "pinctrl-single.h"
 
 #define DRIVER_NAME			"pinctrl-single"
 #define PCS_MUX_PINS_NAME		"pinctrl-single,pins"
@@ -162,7 +163,7 @@ struct pcs_name {
  * @fshift:	function register shift
  * @foff:	value to turn mux off
  * @fmax:	max number of functions in fmask
- * @is_pinconf:	whether supports pinconf
+ * @flags:	supported features
  * @names:	array of register names for pins
  * @pins:	physical pins on the SoC
  * @pgtree:	pingroup index radix tree
@@ -175,6 +176,7 @@ struct pcs_name {
  * @desc:	pin controller descriptor
  * @read:	register read function to use
  * @write:	register write function to use
+ * @soc:	SoC glue
  */
 struct pcs_device {
 	struct resource *res;
@@ -189,7 +191,7 @@ struct pcs_device {
 	unsigned foff;
 	unsigned fmax;
 	bool bits_per_mux;
-	bool is_pinconf;
+	unsigned flags;
 	struct pcs_name *names;
 	struct pcs_data pins;
 	struct radix_tree_root pgtree;
@@ -202,6 +204,7 @@ struct pcs_device {
 	struct pinctrl_desc desc;
 	unsigned (*read)(void __iomem *reg);
 	void (*write)(unsigned val, void __iomem *reg);
+	const struct pcs_soc *soc;
 };
 
 static int pcs_pinconf_get(struct pinctrl_dev *pctldev, unsigned pin,
@@ -1026,7 +1029,7 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 	};
 
 	/* If pinconf isn't supported, don't parse properties in below. */
-	if (!pcs->is_pinconf)
+	if (!(pcs->flags & PCS_HAS_PINCONF))
 		return 0;
 
 	/* cacluate how much properties are supported in current node */
@@ -1165,7 +1168,7 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	(*map)->data.mux.group = np->name;
 	(*map)->data.mux.function = np->name;
 
-	if (pcs->is_pinconf) {
+	if (pcs->flags & PCS_HAS_PINCONF) {
 		res = pcs_parse_pinconf(pcs, np, function, map);
 		if (res)
 			goto free_pingroups;
@@ -1346,18 +1349,14 @@ static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
 	return ret;
 }
 
-static int pcs_probe(struct platform_device *pdev)
+int pinctrl_single_probe(struct platform_device *pdev,
+			 const struct pcs_soc *soc)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct resource *res;
 	struct pcs_device *pcs;
 	int ret;
 
-	match = of_match_device(pcs_of_match, &pdev->dev);
-	if (!match)
-		return -EINVAL;
-
 	pcs = devm_kzalloc(&pdev->dev, sizeof(*pcs), GFP_KERNEL);
 	if (!pcs) {
 		dev_err(&pdev->dev, "could not allocate\n");
@@ -1368,7 +1367,8 @@ static int pcs_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
 	INIT_LIST_HEAD(&pcs->gpiofuncs);
-	pcs->is_pinconf = match->data;
+	pcs->flags = soc->flags;
+	pcs->soc = soc;
 
 	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
 			 "register width not specified\n");
@@ -1437,7 +1437,7 @@ static int pcs_probe(struct platform_device *pdev)
 	pcs->desc.name = DRIVER_NAME;
 	pcs->desc.pctlops = &pcs_pinctrl_ops;
 	pcs->desc.pmxops = &pcs_pinmux_ops;
-	if (pcs->is_pinconf)
+	if (pcs->flags & PCS_HAS_PINCONF)
 		pcs->desc.confops = &pcs_pinconf_ops;
 	pcs->desc.owner = THIS_MODULE;
 
@@ -1466,8 +1466,20 @@ free:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pinctrl_single_probe);
+
+static int pcs_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+
+	match = of_match_device(pcs_of_match, &pdev->dev);
+	if (!match)
+		return -EINVAL;
+
+	return pinctrl_single_probe(pdev, (struct pcs_soc *)match->data);
+}
 
-static int pcs_remove(struct platform_device *pdev)
+int pinctrl_single_remove(struct platform_device *pdev)
 {
 	struct pcs_device *pcs = platform_get_drvdata(pdev);
 
@@ -1478,17 +1490,26 @@ static int pcs_remove(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pinctrl_single_remove);
+
+static struct pcs_soc pinctrl_single = {
+	.flags = 0,
+};
+
+static struct pcs_soc pinconf_single = {
+	.flags = PCS_HAS_PINCONF,
+};
 
 static struct of_device_id pcs_of_match[] = {
-	{ .compatible = "pinctrl-single", .data = (void *)false },
-	{ .compatible = "pinconf-single", .data = (void *)true },
+	{ .compatible = "pinctrl-single", .data = &pinctrl_single },
+	{ .compatible = "pinconf-single", .data = &pinconf_single },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pcs_of_match);
 
 static struct platform_driver pcs_driver = {
 	.probe		= pcs_probe,
-	.remove		= pcs_remove,
+	.remove		= pinctrl_single_remove,
 	.driver = {
 		.owner		= THIS_MODULE,
 		.name		= DRIVER_NAME,
diff --git a/drivers/pinctrl/pinctrl-single.h b/drivers/pinctrl/pinctrl-single.h
new file mode 100644
index 0000000..18f3205
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-single.h
@@ -0,0 +1,15 @@
+#define PCS_HAS_PINCONF         (1 << 0)
+
+/**
+ * struct pcs_soc - SoC specific interface to pinctrl-single
+ * @data:	SoC specific data pointer
+ * @flags:	mask of PCS_HAS_xxx values
+ */
+struct pcs_soc {
+	void *data;
+	unsigned flags;
+};
+
+extern int pinctrl_single_probe(struct platform_device *pdev,
+				const struct pcs_soc *soc);
+extern int pinctrl_single_remove(struct platform_device *pdev);

