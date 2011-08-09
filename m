From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 14/14] dt: omap3: enable dt support for i2c1 controller
Date: Tue, 09 Aug 2011 19:10:32 +0500
Message-ID: <1312897232-4792-15-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Adapt dt for omap i2c1 controller and remove legacy i2c
initilization in omap3 generic board file.

Tested on omap3 beagle board for dt and non-dt builds.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3-soc.dtsi     |    6 ++--
 arch/arm/mach-omap2/board-omap3-dt.c |   14 +++++-----
 drivers/i2c/busses/i2c-omap.c        |   23 ++++++++++++++++--
 drivers/of/platform.c                |   41 +++++++++++++++++++++++++++++++++-
 4 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/omap3-soc.dtsi
index 85de92f..bcff63b 100644
--- a/arch/arm/boot/dts/omap3-soc.dtsi
+++ b/arch/arm/boot/dts/omap3-soc.dtsi
@@ -31,7 +31,7 @@
 		i2c1: i2c@70000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "ti,omap3-i2c";
+			compatible = "ti,omap3-i2c", "ti,omap3-device";
 			reg = <0x70000 0x100>;
 			interrupts = < 88 >;
 		};
@@ -39,7 +39,7 @@
 		i2c2: i2c@72000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "ti,omap3-i2c";
+			compatible = "ti,omap3-i2c", "ti,omap3-device";
 			reg = <0x72000 0x100>;
 			interrupts = < 89 >;
 		};
@@ -47,7 +47,7 @@
 		i2c3: i2c@60000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "ti,omap3-i2c";
+			compatible = "ti,omap3-i2c", "ti,omap3-device";
 			reg = <0x60000 0x100>;
 			interrupts = < 93 >;
 		};
diff --git a/arch/arm/mach-omap2/board-omap3-dt.c b/arch/arm/mach-omap2/board-omap3-dt.c
index 4b76e19..16cf283 100644
--- a/arch/arm/mach-omap2/board-omap3-dt.c
+++ b/arch/arm/mach-omap2/board-omap3-dt.c
@@ -36,11 +36,11 @@ static struct twl4030_platform_data beagle_twldata = {
 	/* platform_data for children goes here */
 };
 
-static int __init omap3_beagle_i2c_init(void)
-{
-	omap3_pmic_init("twl4030", &beagle_twldata);
-	return 0;
-}
+struct of_dev_auxdata omap3_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA_ID_PDSIZE("ti,omap3-i2c", 0x48070000, "i2c1", 1,\
+				&beagle_twldata, sizeof(beagle_twldata)),
+	{}
+};
 
 static void __init omap3_init_early(void)
 {
@@ -70,11 +70,11 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 
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
index ae1545b..5167737 100644
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
+	{.compatible = "ti,omap3-i2c", },
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
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 4b27286..4d8a2fa 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -24,6 +24,10 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
+#include <plat/omap_device.h>
+#endif
+
 const struct of_device_id of_default_bus_match_table[] = {
 	{ .compatible = "simple-bus", },
 #ifdef CONFIG_ARM_AMBA
@@ -544,6 +548,36 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
 	return NULL;
 }
 
+static struct omap_device_pm_latency omap_device_latency[] = {
+	[0] = {
+		.deactivate_func	= omap_device_idle_hwmods,
+		.activate_func		= omap_device_enable_hwmods,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+int of_omap_device_create(struct device_node *np, const char *name, int id,
+							void *platform_data,
+							int pd_size)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+
+	oh = omap_hwmod_lookup(name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", name);
+		return -EEXIST;
+	}
+
+	pdev = omap_device_build_dt(np, name, id, oh, platform_data,
+				sizeof(platform_data), omap_device_latency,
+				ARRAY_SIZE(omap_device_latency), 0);
+	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
+
+	pr_info("DT: omap_device build for %s is successful\n", name);
+	return PTR_ERR(pdev);
+}
+
 /**
  * of_platform_bus_create() - Create a device for a node and its children.
  * @bus: device node of the bus to instantiate
@@ -565,7 +599,7 @@ static int of_platform_bus_create(struct device_node *bus,
 	struct platform_device *dev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
-	int pd_size;
+	int pd_size = 0;
 	int id = -1;
 	int rc = 0;
 
@@ -597,6 +631,11 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
+	if (of_device_is_compatible(bus, "ti,omap3-device")) {
+		of_omap_device_create(bus, bus_id, id, platform_data, pd_size);
+		return 0;
+	}
+
 	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
 
 	/* override the id if auxdata gives an id */
-- 
1.7.1
