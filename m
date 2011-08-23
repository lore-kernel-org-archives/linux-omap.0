From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH v2 08/13] dt: omap: i2c: add dt support for i2c1 controller
Date: Tue, 23 Aug 2011 10:03:36 +0500
Message-ID: <1314074021-25186-9-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.64.96] ([117.192.64.96]:48675 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752230Ab1HWEq7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 00:46:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


The device tree support has been added to i2c1 controller and
corresponding i2c initilization in generic board file is cleaned
up so that platfom device is registered through dt and omap device
and not through board i2c initilization.

These changes will not affect non dt builds and existing functionality
is retained.

Tested with dt and non dt builds and boot tested on beagle board.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/mach-omap2/board-omap3-dt.c |   14 +++++++-------
 drivers/i2c/busses/i2c-omap.c        |   23 ++++++++++++++++++++---
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3-dt.c b/arch/arm/mach-omap2/board-omap3-dt.c
index 72c59a4..cd11224 100644
--- a/arch/arm/mach-omap2/board-omap3-dt.c
+++ b/arch/arm/mach-omap2/board-omap3-dt.c
@@ -35,11 +35,11 @@ static struct twl4030_platform_data beagle_twldata = {
 	/* platform_data for children goes here */
 };
 
-static int __init omap3_beagle_i2c_init(void)
-{
-	omap3_pmic_init("twl4030", &beagle_twldata);
-	return 0;
-}
+struct of_dev_auxdata omap3_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA_ID_PDSIZE("ti,omap-i2c", 0x48070000, "i2c1", 1,\
+				&beagle_twldata, sizeof(beagle_twldata)),
+	{}
+};
 
 static void __init omap3_init_early(void)
 {
@@ -61,11 +61,11 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 
 static void __init omap3_init(void)
 {
-	omap3_beagle_i2c_init();
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 
-	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+	of_platform_populate(NULL, omap_dt_match_table, omap3_auxdata_lookup,
+									 NULL);
 }
 
 static const char *omap3_dt_match[] __initdata = {
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2a072ff..9e98014 100644
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
+									&prop))
+			speed = prop/100;
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
1.7.4.1

