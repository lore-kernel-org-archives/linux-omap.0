From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 02/13] i2c: OMAP: Add DT support for i2c controller
Date: Thu, 1 Sep 2011 19:21:18 +0200
Message-ID: <1314897689-17791-3-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35297 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab1IARWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 13:22:30 -0400
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

From: G, Manjunath Kondaiah <manjugk@ti.com>

Add initial DT support to retrieve the frequency using a
DT attribute instead of the pdata pointer if CONFIG_OF is enabled.

These changes will not affect non DT builds and existing functionality
is retained.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
[b-cousson@ti.com: fix the wrong freq calculation]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2a072ff..4052279 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -38,6 +38,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of_i2c.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
@@ -972,6 +973,16 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id omap_i2c_of_match[] = {
+	{.compatible = "ti,omap-i2c", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
+#else
+#define omap_i2c_of_match NULL
+#endif
+
 static int __devinit
 omap_i2c_probe(struct platform_device *pdev)
 {
@@ -1008,12 +1019,17 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
+	speed = 100;	/* Default speed */
 	if (pdata != NULL) {
 		speed = pdata->clkrate;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
-	} else {
-		speed = 100;	/* Default speed */
-		dev->set_mpu_wkup_lat = NULL;
+#if defined(CONFIG_OF)
+	} else if (pdev->dev.of_node) {
+		u32 prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+					  &prop))
+			speed = prop / 1000; /* convert Hz into kHz */
+#endif
 	}
 
 	dev->speed = speed;
@@ -1178,6 +1194,7 @@ static struct platform_driver omap_i2c_driver = {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
 		.pm	= OMAP_I2C_PM_OPS,
+		.of_match_table = omap_i2c_of_match,
 	},
 };
 
-- 
1.7.0.4

