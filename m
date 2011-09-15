From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 05/11] TWL: regulator: Make twl-regulator driver extract data from DT
Date: Thu, 15 Sep 2011 16:52:01 +0530
Message-ID: <1316085727-15023-6-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56962 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933261Ab1IOLWg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:36 -0400
In-Reply-To: <1316085727-15023-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Modify the twl regulator driver to extract the regulator_init_data from
device tree when passed, instead of getting it through platform_data
structures (on non-DT builds)

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/twl-regulator.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index ee8747f..df1b95a 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -17,6 +17,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
+#include <linux/of.h>
+#include <linux/of_regulator.h>
 
 
 /*
@@ -1011,6 +1013,9 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
 
+	if (pdev->dev.of_node)
+		of_property_read_u32(pdev->dev.of_node, "ti,reg-id", &pdev->id);
+
 	for (i = 0, info = NULL; i < ARRAY_SIZE(twl_regs); i++) {
 		if (twl_regs[i].desc.id != pdev->id)
 			continue;
@@ -1020,7 +1025,11 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENODEV;
 
-	initdata = pdev->dev.platform_data;
+	if (pdev->dev.of_node)
+		initdata = of_get_regulator_init_data(pdev->dev.of_node);
+	else
+		initdata = pdev->dev.platform_data;
+
 	if (!initdata)
 		return -EINVAL;
 
@@ -1101,14 +1110,27 @@ static int __devexit twlreg_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:twl_reg");
 
+#if defined(CONFIG_OF)
+static const struct of_device_id twl_of_match[] __devinitconst = {
+	{ .compatible = "ti,twl-reg", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, twl_of_match);
+#else
+#define twl_of_match NULL
+#endif
+
 static struct platform_driver twlreg_driver = {
 	.probe		= twlreg_probe,
 	.remove		= __devexit_p(twlreg_remove),
 	/* NOTE: short name, to work around driver model truncation of
 	 * "twl_regulator.12" (and friends) to "twl_regulator.1".
 	 */
-	.driver.name	= "twl_reg",
-	.driver.owner	= THIS_MODULE,
+	.driver  = {
+		.name  = "twl_reg",
+		.owner = THIS_MODULE,
+		.of_match_table = twl_of_match,
+	},
 };
 
 static int __init twlreg_init(void)
-- 
1.7.1

