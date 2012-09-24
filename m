From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: [PATCH v4 1/2] backlight: Add TPS65217 WLED driver
Date: Mon, 24 Sep 2012 22:25:28 +0200
Message-ID: <20120924202528.GE26600@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36848 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947Ab2IXU0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 16:26:08 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>
Cc: "Koen Kooi <koen@dominion.thruhere.net>, linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The TPS65217 chip contains a boost converter and current sinks which can be
used to drive LEDs for use as backlights. Expose this functionality via the
backlight API.

Tested on an AM335x based custom board with a single WLED string, using
different values for ISEL and FDIM (though it would be hard to tell the
difference except for the value in WLEDCTRL1). Both instantiation through the
device tree and by passing platform data have been tested. Testing has been
done with an Androidized 3.2 kernel from the rowboat project. Koen Kooi
reported the driver to be working on a Beaglebone board with LCD3 cape

This patch is based on the mfd branch (20120924)

Changes since v3:

 * split in two patches, one for the driver another for adding the mfd
   subdevice
 * renamed variable "on" to "is_enabled" and changed type to boolean

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
 drivers/video/backlight/Kconfig       |    7 +
 drivers/video/backlight/Makefile      |    1 +
 drivers/video/backlight/tps65217_bl.c |  352 +++++++++++++++++++++++++++++++++
 include/linux/mfd/tps65217.h          |   18 ++
 4 files changed, 378 insertions(+)
 create mode 100644 drivers/video/backlight/tps65217_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index cf28276..63cee2e 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -373,6 +373,13 @@ config BACKLIGHT_PANDORA
 	  If you have a Pandora console, say Y to enable the
 	  backlight driver.
 
+config BACKLIGHT_TPS65217
+	tristate "TPS65217 Backlight"
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
index 0000000..29aae58
--- /dev/null
+++ b/drivers/video/backlight/tps65217_bl.c
@@ -0,0 +1,352 @@
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
+	bool is_enabled;
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
+	tps65217_bl->is_enabled = true;
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
+	tps65217_bl->is_enabled = false;
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
+		if (!tps65217_bl->is_enabled)
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
+tps65217_bl_parse_dt(struct platform_device *pdev)
+{
+	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device_node *node = of_node_get(tps->dev->of_node);
+	struct tps65217_bl_pdata *pdata, *err;
+	u32 val;
+
+	node = of_find_node_by_name(node, "backlight");
+	if (!node)
+		return ERR_PTR(-ENODEV);
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(&pdev->dev, "failed to allocate platform data\n");
+		err = ERR_PTR(-ENOMEM);
+		goto err;
+	}
+
+	pdata->isel = TPS65217_BL_ISET1;
+	if (!of_property_read_u32(node, "isel", &val)) {
+		if (val < TPS65217_BL_ISET1 ||
+			val > TPS65217_BL_ISET2) {
+			dev_err(&pdev->dev,
+				"invalid 'isel' value in the device tree\n");
+			err = ERR_PTR(-EINVAL);
+			goto err;
+		}
+
+		pdata->isel = val;
+	}
+
+	pdata->fdim = TPS65217_BL_FDIM_200HZ;
+	if (!of_property_read_u32(node, "fdim", &val)) {
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
+			dev_err(&pdev->dev,
+				"invalid 'fdim' value in the device tree\n");
+			err = ERR_PTR(-EINVAL);
+			goto err;
+		}
+	}
+
+	of_node_put(node);
+
+	return pdata;
+
+err:
+	of_node_put(node);
+
+	return err;
+}
+#else
+static struct tps65217_bl_pdata *
+tps65217_bl_parse_dt(struct platform_device *pdev)
+{
+	return NULL;
+}
+#endif
+
+static int tps65217_bl_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct tps65217_bl *tps65217_bl;
+	struct tps65217_bl_pdata *pdata;
+	struct backlight_properties bl_props;
+
+	if (tps->dev->of_node) {
+		pdata = tps65217_bl_parse_dt(pdev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	} else {
+		if (!pdev->dev.platform_data) {
+			dev_err(&pdev->dev, "no platform data provided\n");
+			return -EINVAL;
+		}
+
+		pdata = pdev->dev.platform_data;
+	}
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
+	tps65217_bl->is_enabled = false;
+
+	rc = tps65217_bl_hw_init(tps65217_bl, pdata);
+	if (rc)
+		return rc;
+
+	memset(&bl_props, 0, sizeof(struct backlight_properties));
+	bl_props.type = BACKLIGHT_RAW;
+	bl_props.max_brightness = 100;
+
+	tps65217_bl->bl = backlight_device_register(pdev->name,
+						tps65217_bl->dev, tps65217_bl,
+						&tps65217_bl_ops, &bl_props);
+	if (IS_ERR(tps65217_bl->bl)) {
+		dev_err(tps65217_bl->dev,
+			"registration of backlight device failed: %d\n", rc);
+		return PTR_ERR(tps65217_bl->bl);
+	}
+
+	tps65217_bl->bl->props.brightness = 0;
+
+	return 0;
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
index 7cd83d8..290762f 100644
--- a/include/linux/mfd/tps65217.h
+++ b/include/linux/mfd/tps65217.h
@@ -213,6 +213,23 @@ enum tps65217_regulator_id {
 /* Number of total regulators available */
 #define TPS65217_NUM_REGULATOR		(TPS65217_NUM_DCDC + TPS65217_NUM_LDO)
 
+enum tps65217_bl_isel {
+	TPS65217_BL_ISET1 = 1,
+	TPS65217_BL_ISET2,
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
+
 /**
  * struct tps65217_board - packages regulator init data
  * @tps65217_regulator_data: regulator initialization values
@@ -222,6 +239,7 @@ enum tps65217_regulator_id {
 struct tps65217_board {
 	struct regulator_init_data *tps65217_init_data[TPS65217_NUM_REGULATOR];
 	struct device_node *of_node[TPS65217_NUM_REGULATOR];
+	struct tps65217_bl_pdata *bl_pdata;
 };
 
 /**
-- 
1.7.10

