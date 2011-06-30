From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 5/5] OMAP: I2C: Convert I2C driver to use device tree
Date: Thu, 30 Jun 2011 15:07:27 +0500
Message-ID: <1309426647-31587-6-git-send-email-manjugk@ti.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
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
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org


The OMAP I2C driver is modified to use platform_device data from
device tree data structures.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ae1545b..d4ccc52 100644
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
@@ -972,6 +976,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
+static const struct of_device_id omap_i2c_of_match[];
 static int __devinit
 omap_i2c_probe(struct platform_device *pdev)
 {
@@ -979,10 +984,15 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
+	const struct of_device_id *match;
 	irq_handler_t isr;
 	int r;
 	u32 speed = 0;
 
+	match = of_match_device(omap_i2c_of_match, &pdev->dev);
+	if (!match)
+		dev_err(&pdev->dev, "DT: i2c device match not found.......\n");
+
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -1007,10 +1017,19 @@ omap_i2c_probe(struct platform_device *pdev)
 		r = -ENOMEM;
 		goto err_release_region;
 	}
-
+	/* I2C device without DT might use this */
 	if (pdata != NULL) {
 		speed = pdata->clkrate;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
+	} else if (pdev->dev.of_node) {
+		const unsigned int *prop;
+		prop = of_get_property(pdev->dev.of_node,
+				"clock-frequency", NULL);
+		if (prop)
+			speed = be32_to_cpup(prop);
+		else
+			speed = 100;
+		dev->set_mpu_wkup_lat = NULL;
 	} else {
 		speed = 100;	/* Default speed */
 		dev->set_mpu_wkup_lat = NULL;
@@ -1045,6 +1064,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
+
 	if (dev->rev <= OMAP_I2C_REV_ON_3430)
 		dev->errata |= I2C_OMAP3_1P153;
 
@@ -1073,6 +1093,7 @@ omap_i2c_probe(struct platform_device *pdev)
 				       (1000 * speed / 8);
 	}
 
+
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
@@ -1162,6 +1183,12 @@ static int omap_i2c_resume(struct device *dev)
 	return 0;
 }
 
+static const struct of_device_id omap_i2c_of_match[] = {
+	{.compatible = "ti,omap_i2c", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
+
 static struct dev_pm_ops omap_i2c_pm_ops = {
 	.suspend = omap_i2c_suspend,
 	.resume = omap_i2c_resume,
@@ -1178,6 +1205,7 @@ static struct platform_driver omap_i2c_driver = {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
 		.pm	= OMAP_I2C_PM_OPS,
+		.of_match_table = omap_i2c_of_match,
 	},
 };
 
-- 
1.7.4.1
