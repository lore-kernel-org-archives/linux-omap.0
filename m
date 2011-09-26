From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 05/13] i2c: OMAP: Add DT support for i2c controller
Date: Mon, 26 Sep 2011 18:50:13 +0200
Message-ID: <1317055821-20652-6-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab1IZQvV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 12:51:21 -0400
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Ben Dooks <ben-linux@fluff.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Add initial DT support to retrieve the frequency using a
DT attribute instead of the pdata pointer if of_node exist.

Add documentation for omap i2c controller binding.

Based on original patches from Manju and Grant.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++++++++++++++++
 drivers/i2c/busses/i2c-omap.c                      |   26 +++++++++++++++--
 2 files changed, 53 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/omap-i2c.txt b/Documentation/devicetree/bindings/i2c/omap-i2c.txt
new file mode 100644
index 0000000..d21f4d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/omap-i2c.txt
@@ -0,0 +1,30 @@
+I2C for OMAP platforms
+
+Required properties :
+- compatible : Must be "ti,omap3-i2c"
+- ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Recommended properties :
+- clock-frequency : Desired I2C bus clock frequency in Hz. Otherwise
+  the default 100 kHz frequency will be used.
+
+Optional properties:
+- Child nodes conforming to i2c bus binding
+
+Note: Current implementation will fetch base address, irq and dma
+from omap hwmod data base during device registration.
+Future plan is to migrate hwmod data base contents into device tree
+blob so that, all the required data will be used from device tree dts
+file.
+
+Examples :
+
+i2c1: i2c@0 {
+    compatible = "ti,omap3-i2c";
+    #address-cells = <1>;
+    #size-cells = <0>;
+    ti,hwmods = "i2c1";
+    clock-frequency = <400000>;
+};
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 155b32f..aee5bfa 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -37,6 +37,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of_i2c.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
@@ -969,6 +971,16 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id omap_i2c_of_match[] = {
+	{.compatible = "ti,omap3-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
+#else
+#define omap_i2c_of_match NULL
+#endif
+
 static int __devinit
 omap_i2c_probe(struct platform_device *pdev)
 {
@@ -1005,12 +1017,16 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
+	speed = 100;	/* Default speed */
 	if (pdata != NULL) {
 		speed = pdata->clkrate;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
-	} else {
-		speed = 100;	/* Default speed */
-		dev->set_mpu_wkup_lat = NULL;
+	} else if (pdev->dev.of_node) {
+		u32 prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+					  &prop))
+			/* convert DT value in Hz into kHz */
+			speed = prop / 1000;
 	}
 
 	dev->speed = speed;
@@ -1093,6 +1109,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
+	adap->dev.of_node = pdev->dev.of_node;
 
 	/* i2c device drivers may be active on return from add_adapter() */
 	adap->nr = pdev->id;
@@ -1102,6 +1119,8 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
+	of_i2c_register_devices(adap);
+
 	return 0;
 
 err_free_irq:
@@ -1143,6 +1162,7 @@ static struct platform_driver omap_i2c_driver = {
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
+		.of_match_table = omap_i2c_of_match,
 	},
 };
 
-- 
1.7.0.4

