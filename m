From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 07/11] regulator: Make fixed regulator driver extract data from DT
Date: Thu, 15 Sep 2011 16:52:03 +0530
Message-ID: <1316085727-15023-8-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59753 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933317Ab1IOLWh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:37 -0400
In-Reply-To: <1316085727-15023-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Modify the fixed regulator driver to extract fixed_voltage_config from
device tree when passed, instead of getting it through platform_data
structures (on non-DT builds)

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/fixed.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 2fe9d99..a214b30 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -26,6 +26,8 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_regulator.h>
 
 struct fixed_voltage_data {
 	struct regulator_desc desc;
@@ -104,10 +106,15 @@ static struct regulator_ops fixed_voltage_ops = {
 
 static int __devinit reg_fixed_voltage_probe(struct platform_device *pdev)
 {
-	struct fixed_voltage_config *config = pdev->dev.platform_data;
+	struct fixed_voltage_config *config;
 	struct fixed_voltage_data *drvdata;
 	int ret;
 
+	if (pdev->dev.of_node)
+		config = of_get_fixed_voltage_config(pdev->dev.of_node);
+	else
+		config = pdev->dev.platform_data;
+
 	drvdata = kzalloc(sizeof(struct fixed_voltage_data), GFP_KERNEL);
 	if (drvdata == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate device data\n");
@@ -216,12 +223,23 @@ static int __devexit reg_fixed_voltage_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id fixed_of_match[] __devinitconst = {
+	{ .compatible = "regulator-fixed", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fixed_of_match);
+#else
+#define fixed_of_match NULL
+#endif
+
 static struct platform_driver regulator_fixed_voltage_driver = {
 	.probe		= reg_fixed_voltage_probe,
 	.remove		= __devexit_p(reg_fixed_voltage_remove),
 	.driver		= {
 		.name		= "reg-fixed-voltage",
 		.owner		= THIS_MODULE,
+		.of_match_table = fixed_of_match,
 	},
 };
 
-- 
1.7.1

