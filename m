From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] dt: i2c-omap: Convert i2c driver to use device tree
Date: Thu, 14 Jul 2011 03:06:15 +0500
Message-ID: <1310592975-25773-5-git-send-email-manjugk@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
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
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


The i2c-omap driver is converted for supporting both
dt and non dt builds and driver is modified to use dt
data partially.

Tested on OMAP3 beagle board.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   48 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ae1545b..6d11a13 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -38,9 +38,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of_i2c.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <plat/i2c.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_REV_2			0x20
@@ -972,6 +976,10 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id omap_i2c_of_match[];
+#endif
+
 static int __devinit
 omap_i2c_probe(struct platform_device *pdev)
 {
@@ -979,10 +987,17 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
+#if defined(CONFIG_OF)
+	const struct of_device_id *match;
+#endif
 	irq_handler_t isr;
 	int r;
 	u32 speed = 0;
 
+#if defined(CONFIG_OF)
+	match = of_match_device(omap_i2c_of_match, &pdev->dev);
+#endif
+
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -1011,11 +1026,25 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (pdata != NULL) {
 		speed = pdata->clkrate;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
+#if defined(CONFIG_OF)
+	} else if (pdev->dev.of_node) {
+		u32 prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+									&prop))
+			speed = prop/100;
+		else
+			speed = 100;
+#else
 	} else {
 		speed = 100;	/* Default speed */
-		dev->set_mpu_wkup_lat = NULL;
+#endif
 	}
 
+#if defined(CONFIG_OF)
+	/* TODO: remove this after DT depencies with hwmod are resolved */
+	if (match)
+		return 0;
+#endif
 	dev->speed = speed;
 	dev->idle = 1;
 	dev->dev = &pdev->dev;
@@ -1096,7 +1125,9 @@ omap_i2c_probe(struct platform_device *pdev)
 	strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
+#if defined(CONFIG_OF)
 	adap->dev.of_node = pdev->dev.of_node;
+#endif
 
 	/* i2c device drivers may be active on return from add_adapter() */
 	adap->nr = pdev->id;
@@ -1106,7 +1137,9 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
+#if defined(CONFIG_OF)
 	of_i2c_register_devices(adap);
+#endif
 
 	return 0;
 
@@ -1162,6 +1195,16 @@ static int omap_i2c_resume(struct device *dev)
 	return 0;
 }
 
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
 static struct dev_pm_ops omap_i2c_pm_ops = {
 	.suspend = omap_i2c_suspend,
 	.resume = omap_i2c_resume,
@@ -1178,6 +1221,9 @@ static struct platform_driver omap_i2c_driver = {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
 		.pm	= OMAP_I2C_PM_OPS,
+#if defined(CONFIG_OF)
+		.of_match_table = omap_i2c_of_match,
+#endif
 	},
 };
 
-- 
1.7.4.1
