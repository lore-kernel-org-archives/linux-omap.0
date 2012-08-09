From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: [PATCH v2] backlight: Add TPS65217 WLED driver
Date: Thu, 9 Aug 2012 22:42:31 +0200
Message-ID: <20120809204231.GF30282@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:32813 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab2HIUn0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 16:43:26 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The TPS65217 chip contains a boost converter and current sinks which can be
used to drive LEDs for use as backlights. Expose this functionality via the
backlight API.

Tested on an AM335x based custom board with a single WLED string, using
different values for ISEL and FDIM (though it would be hard to tell the
difference except for the value in WLEDCTRL1). Both instantiation through the
device tree and by passing platform data have been tested. Testing has been
done with an Androidized 3.2 kernel from the rowboat project

This patch is based on the mfd tree, it also applies on linux-next (20120809)

Changes since v1:

 * addressed review comments
 * moved device tree parsing to the backlight driver

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
 drivers/mfd/tps65217.c                |   32 +++
 drivers/video/backlight/Kconfig       |    7 +
 drivers/video/backlight/Makefile      |    1 +
 drivers/video/backlight/tps65217_bl.c |  343 +++++++++++++++++++++++++++++++++
 include/linux/mfd/tps65217.h          |   25 ++-
 5 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/backlight/tps65217_bl.c

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 61c097a..a79902d 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -174,6 +174,10 @@ static struct tps65217_board *tps65217_parse_dt(struct i2c_client *client)
 		pdata->of_node[i] = reg_matches[i].of_node;
 	}
 
+	node = of_find_node_by_name(node, "backlight");
+	if (node)
+		pdata->of_node[TPS65217_SUBDEV_BL] = node;
+
 	return pdata;
 }
 
@@ -250,7 +254,32 @@ static int __devinit tps65217_probe(struct i2c_client *client,
 		platform_device_add(pdev);
 	}
 
+	if (pdata->bl_pdata || pdata->of_node[TPS65217_SUBDEV_BL]) {
+		tps->bl_pdev = platform_device_alloc("tps65217-bl", 0);
+		if (!tps->bl_pdev) {
+			dev_err(tps->dev, "Cannot create backlight platform device\n");
+			ret = -ENOMEM;
+			goto err_alloc_bl_pdev;
+		}
+
+		tps->bl_pdev->dev.parent = tps->dev;
+
+		if (pdata->bl_pdata)
+			tps->bl_pdev->dev.platform_data = pdata->bl_pdata;
+		else
+			tps->bl_pdev->dev.of_node =
+				pdata->of_node[TPS65217_SUBDEV_BL];
+
+		platform_device_add(tps->bl_pdev);
+	}
+
 	return 0;
+
+err_alloc_bl_pdev:
+	for (i = 0; i < TPS65217_NUM_REGULATOR; i++)
+		platform_device_unregister(tps->regulator_pdev[i]);
+
+	return ret;
 }
 
 static int __devexit tps65217_remove(struct i2c_client *client)
@@ -258,6 +287,9 @@ static int __devexit tps65217_remove(struct i2c_client *client)
 	struct tps65217 *tps = i2c_get_clientdata(client);
 	int i;
 
+	if (tps->bl_pdev)
+		platform_device_unregister(tps->bl_pdev);
+
 	for (i = 0; i < TPS65217_NUM_REGULATOR; i++)
 		platform_device_unregister(tps->regulator_pdev[i]);
 
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index cf28276..e1884bb 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -373,6 +373,13 @@ config BACKLIGHT_PANDORA
 	  If you have a Pandora console, say Y to enable the
 	  backlight driver.
 
+config BACKLIGHT_TPS65217
+	tristate "Backlight driver for TI TPS65217 using WLED"
+	depends on BACKLIGHT_CLASS_DEVICE && MFD_TPS65217
+	help
+	  If you have a Texas Instruments TPS65217 say Y to enable the
+	  backlight driver.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endif # BACKLIGHT_LCD_SUPPORT
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index a2ac9cf..00223a6 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -43,3 +43,4 @@ obj-$(CONFIG_BACKLIGHT_88PM860X) += 88pm860x_bl.o
 obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
 obj-$(CONFIG_BACKLIGHT_AAT2870) += aat2870_bl.o
 obj-$(CONFIG_BACKLIGHT_OT200) += ot200_bl.o
+obj-$(CONFIG_BACKLIGHT_TPS65217) += tps65217_bl.o
diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
new file mode 100644
index 0000000..6c537bf
--- /dev/null
+++ b/drivers/video/backlight/tps65217_bl.c
@@ -0,0 +1,343 @@
+/*
+ * tps65217_bl.c
+ *
+ * TPS65217 backlight driver
+ *
+ * Copyright (C) 2012 Matthias Kaehlcke
+ * Author: Matthias Kaehlcke <matthias@kaehlcke.net>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/mfd/tps65217.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct tps65217_bl {
+	struct tps65217 *tps;
+	struct device *dev;
+	struct backlight_device *bl;
+	int on;
+};
+
+static int tps65217_bl_enable(struct tps65217_bl *tps65217_bl)
+{
+	int rc;
+
+	rc = tps65217_set_bits(tps65217_bl->tps, TPS65217_REG_WLEDCTRL1,
+			TPS65217_WLEDCTRL1_ISINK_ENABLE,
+			TPS65217_WLEDCTRL1_ISINK_ENABLE, TPS65217_PROTECT_NONE);
+	if (rc) {
+		dev_err(tps65217_bl->dev,
+			"failed to enable backlight: %d\n", rc);
+		return rc;
+	}
+
+	tps65217_bl->on = 1;
+
+	dev_dbg(tps65217_bl->dev, "backlight enabled\n");
+
+	return 0;
+}
+
+static int tps65217_bl_disable(struct tps65217_bl *tps65217_bl)
+{
+	int rc;
+
+	rc = tps65217_clear_bits(tps65217_bl->tps,
+				TPS65217_REG_WLEDCTRL1,
+				TPS65217_WLEDCTRL1_ISINK_ENABLE,
+				TPS65217_PROTECT_NONE);
+	if (rc) {
+		dev_err(tps65217_bl->dev,
+			"failed to disable backlight: %d\n", rc);
+		return rc;
+	}
+
+	tps65217_bl->on = 0;
+
+	dev_dbg(tps65217_bl->dev, "backlight disabled\n");
+
+	return 0;
+}
+
+static int tps65217_bl_update_status(struct backlight_device *bl)
+{
+	struct tps65217_bl *tps65217_bl = bl_get_data(bl);
+	int rc;
+	int brightness = bl->props.brightness;
+
+	if (bl->props.state & BL_CORE_SUSPENDED)
+		brightness = 0;
+
+	if ((bl->props.power != FB_BLANK_UNBLANK) ||
+		(bl->props.fb_blank != FB_BLANK_UNBLANK))
+		/* framebuffer in low power mode or blanking active */
+		brightness = 0;
+
+	if (brightness > 0) {
+		rc = tps65217_reg_write(tps65217_bl->tps,
+					TPS65217_REG_WLEDCTRL2,
+					brightness - 1,
+					TPS65217_PROTECT_NONE);
+		if (rc) {
+			dev_err(tps65217_bl->dev,
+				"failed to set brightness level: %d\n", rc);
+			return rc;
+		}
+
+		dev_dbg(tps65217_bl->dev, "brightness set to %d\n", brightness);
+
+		if (!tps65217_bl->on)
+			rc = tps65217_bl_enable(tps65217_bl);
+	} else {
+		rc = tps65217_bl_disable(tps65217_bl);
+	}
+
+	return rc;
+}
+
+static int tps65217_bl_get_brightness(struct backlight_device *bl)
+{
+	return bl->props.brightness;
+}
+
+static const struct backlight_ops tps65217_bl_ops = {
+	.options	= BL_CORE_SUSPENDRESUME,
+	.update_status	= tps65217_bl_update_status,
+	.get_brightness	= tps65217_bl_get_brightness
+};
+
+static int tps65217_bl_hw_init(struct tps65217_bl *tps65217_bl,
+			struct tps65217_bl_pdata *pdata)
+{
+	int rc;
+
+	rc = tps65217_bl_disable(tps65217_bl);
+	if (rc)
+		return rc;
+
+	switch (pdata->isel) {
+	case TPS65217_BL_ISET1:
+		/* select ISET_1 current level */
+		rc = tps65217_clear_bits(tps65217_bl->tps,
+					TPS65217_REG_WLEDCTRL1,
+					TPS65217_WLEDCTRL1_ISEL,
+					TPS65217_PROTECT_NONE);
+		if (rc) {
+			dev_err(tps65217_bl->dev,
+				"failed to select ISET1 current level: %d)\n",
+				rc);
+			return rc;
+		}
+
+		dev_dbg(tps65217_bl->dev, "selected ISET1 current level\n");
+
+		break;
+
+	case TPS65217_BL_ISET2:
+		/* select ISET2 current level */
+		rc = tps65217_set_bits(tps65217_bl->tps, TPS65217_REG_WLEDCTRL1,
+				TPS65217_WLEDCTRL1_ISEL,
+				TPS65217_WLEDCTRL1_ISEL, TPS65217_PROTECT_NONE);
+		if (rc) {
+			dev_err(tps65217_bl->dev,
+				"failed to select ISET2 current level: %d\n",
+				rc);
+			return rc;
+		}
+
+		dev_dbg(tps65217_bl->dev, "selected ISET2 current level\n");
+
+		break;
+
+	default:
+		dev_err(tps65217_bl->dev,
+			"invalid value for current level: %d\n", pdata->isel);
+		return -EINVAL;
+	}
+
+	/* set PWM frequency */
+	rc = tps65217_set_bits(tps65217_bl->tps,
+			TPS65217_REG_WLEDCTRL1,
+			TPS65217_WLEDCTRL1_FDIM_MASK,
+			pdata->fdim,
+			TPS65217_PROTECT_NONE);
+	if (rc) {
+		dev_err(tps65217_bl->dev,
+			"failed to select PWM dimming frequency: %d\n",
+			rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static struct tps65217_bl_pdata *
+tps65217_bl_parse_dt(struct tps65217_bl *tps65217_bl)
+{
+	struct device_node *np = tps65217_bl->dev->of_node;
+	struct tps65217_bl_pdata *pdata;
+	u32 val;
+
+	pdata = devm_kzalloc(tps65217_bl->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(tps65217_bl->dev, "failed to allocate platform data\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pdata->isel = TPS65217_BL_ISET1;
+	if (!of_property_read_u32(np, "isel", &val)) {
+		if (val < TPS65217_BL_ISET1 ||
+			val > TPS65217_BL_ISET2) {
+			dev_err(tps65217_bl->dev,
+				"invalid 'isel' value in the device tree\n");
+			goto err_einval;
+		}
+
+		pdata->isel = val;
+	}
+
+	pdata->fdim = TPS65217_BL_FDIM_200HZ;
+	if (!of_property_read_u32(np, "fdim", &val)) {
+		switch (val) {
+		case 100:
+			pdata->fdim = TPS65217_BL_FDIM_100HZ;
+			break;
+
+		case 200:
+			pdata->fdim = TPS65217_BL_FDIM_200HZ;
+			break;
+
+		case 500:
+			pdata->fdim = TPS65217_BL_FDIM_500HZ;
+			break;
+
+		case 1000:
+			pdata->fdim = TPS65217_BL_FDIM_1000HZ;
+			break;
+
+		default:
+			dev_err(tps65217_bl->dev,
+				"invalid 'fdim' value in the device tree\n");
+			goto err_einval;
+		}
+	}
+
+	return pdata;
+
+err_einval:
+	devm_kfree(tps65217_bl->dev, pdata);
+
+	return ERR_PTR(-EINVAL);
+}
+#else
+static struct tps65217_bl_pdata *
+tps65217_bl_parse_dt(struct tps65217_bl *tps65217_bl)
+{
+	return NULL;
+}
+#endif
+
+static int tps65217_bl_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct i2c_client *i2c_client = to_i2c_client(pdev->dev.parent);
+	struct tps65217 *tps = i2c_get_clientdata(i2c_client);
+	struct tps65217_bl *tps65217_bl;
+	struct tps65217_bl_pdata *pdata;
+	struct backlight_properties bl_props;
+
+	tps65217_bl = devm_kzalloc(&pdev->dev, sizeof(*tps65217_bl),
+				GFP_KERNEL);
+	if (tps65217_bl == NULL) {
+		dev_err(&pdev->dev, "allocation of struct tps65217_bl failed\n");
+		return -ENOMEM;
+	}
+
+	tps65217_bl->tps = tps;
+	tps65217_bl->dev = &pdev->dev;
+	tps65217_bl->on = 0;
+
+	if (tps65217_bl->dev->of_node)
+		pdata = tps65217_bl_parse_dt(tps65217_bl);
+	else
+		pdata = pdev->dev.platform_data;
+
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
+	rc = tps65217_bl_hw_init(tps65217_bl, pdata);
+	if (rc)
+		goto err_bl_hw_init;
+
+	memset(&bl_props, 0, sizeof(struct backlight_properties));
+	bl_props.type = BACKLIGHT_RAW;
+	bl_props.max_brightness = 100;
+
+	tps65217_bl->bl = backlight_device_register(pdev->name,
+						tps65217_bl->dev, tps65217_bl,
+						&tps65217_bl_ops, &bl_props);
+	if (IS_ERR(tps65217_bl->bl)) {
+		rc = PTR_ERR(tps65217_bl->bl);
+		dev_err(tps65217_bl->dev,
+			"registration of backlight device failed: %d\n", rc);
+		goto err_reg_bl;
+	}
+
+	tps65217_bl->bl->props.brightness = 0;
+
+	return 0;
+
+err_reg_bl:
+err_bl_hw_init:
+	return rc;
+}
+
+static int tps65217_bl_remove(struct platform_device *pdev)
+{
+	struct tps65217_bl *tps65217_bl = platform_get_drvdata(pdev);
+
+	backlight_device_unregister(tps65217_bl->bl);
+
+	return 0;
+}
+
+static struct platform_driver tps65217_bl_driver = {
+	.probe		= tps65217_bl_probe,
+	.remove		= tps65217_bl_remove,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "tps65217-bl",
+	},
+};
+
+static int __init tps65217_bl_init(void)
+{
+	return platform_driver_register(&tps65217_bl_driver);
+}
+
+static void __exit tps65217_bl_exit(void)
+{
+	platform_driver_unregister(&tps65217_bl_driver);
+}
+
+module_init(tps65217_bl_init);
+module_exit(tps65217_bl_exit);
+
+MODULE_DESCRIPTION("TPS65217 Backlight driver");
+MODULE_LICENSE("GPLv2");
+MODULE_AUTHOR("Matthias Kaehlcke <matthias@kaehlcke.net>");
diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
index 12c0687..0708b74 100644
--- a/include/linux/mfd/tps65217.h
+++ b/include/linux/mfd/tps65217.h
@@ -209,6 +209,27 @@ enum tps65217_regulator_id {
 #define TPS65217_NUM_LDO		4
 /* Number of total regulators available */
 #define TPS65217_NUM_REGULATOR		(TPS65217_NUM_DCDC + TPS65217_NUM_LDO)
+/* Number of subdevices (regulators + backlight) */
+#define TPS65217_NUM_SUBDEVS		(TPS65217_NUM_REGULATOR + 1)
+/* Index of the backlight subdevice */
+#define TPS65217_SUBDEV_BL		TPS65217_NUM_REGULATOR
+
+enum tps65217_bl_isel {
+	TPS65217_BL_ISET1 = 1,
+	TPS65217_BL_ISET2 = 2,
+};
+
+enum tps65217_bl_fdim {
+	TPS65217_BL_FDIM_100HZ,
+	TPS65217_BL_FDIM_200HZ,
+	TPS65217_BL_FDIM_500HZ,
+	TPS65217_BL_FDIM_1000HZ,
+};
+
+struct tps65217_bl_pdata {
+	enum tps65217_bl_isel isel;
+	enum tps65217_bl_fdim fdim;
+};
 
 /**
  * struct tps65217_board - packages regulator init data
@@ -218,7 +239,8 @@ enum tps65217_regulator_id {
  */
 struct tps65217_board {
 	struct regulator_init_data *tps65217_init_data[TPS65217_NUM_REGULATOR];
-	struct device_node *of_node[TPS65217_NUM_REGULATOR];
+	struct device_node *of_node[TPS65217_NUM_SUBDEVS];
+	struct tps65217_bl_pdata *bl_pdata;
 };
 
 /**
@@ -255,6 +277,7 @@ struct tps65217 {
 
 	/* Client devices */
 	struct platform_device *regulator_pdev[TPS65217_NUM_REGULATOR];
+	struct platform_device *bl_pdev;
 };
 
 static inline struct tps65217 *dev_to_tps65217(struct device *dev)
-- 
1.7.10

