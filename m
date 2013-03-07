From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 1/4] retu-mfd: support also Tahvo
Date: Thu,  7 Mar 2013 16:40:18 +0200
Message-ID: <1362667221-30659-2-git-send-email-aaro.koskinen@iki.fi>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:45770 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384Ab3CGOkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 09:40:47 -0500
In-Reply-To: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Samuel Ortiz <sameo@linux.intel.com>

Tahvo is a multi-function device on Nokia 770, implementing USB
transceiver and charge/battery control.

It's so close to Retu that a single driver can support both.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/Kconfig      |    6 +--
 drivers/mfd/retu-mfd.c   |   95 +++++++++++++++++++++++++++++++++++++++-------
 include/linux/mfd/retu.h |    8 +++-
 3 files changed, 92 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 671f5b1..0c3bdae 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1101,13 +1101,13 @@ config MFD_VIPERBOARD
 	  The drivers do not support all features the board exposes.
 
 config MFD_RETU
-	tristate "Support for Retu multi-function device"
+	tristate "Support for Retu and Tahvo multi-function devices"
 	select MFD_CORE
 	depends on I2C && GENERIC_HARDIRQS
 	select REGMAP_IRQ
 	help
-	  Retu is a multi-function device found on Nokia Internet Tablets
-	  (770, N800 and N810).
+	  Retu and Tahvo are multi-function devices found on Nokia
+	  Internet Tablets (770, N800 and N810).
 
 config MFD_AS3711
 	bool "Support for AS3711"
diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index 3ba0486..fa0204b 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -1,5 +1,5 @@
 /*
- * Retu MFD driver
+ * Retu/Tahvo MFD driver
  *
  * Copyright (C) 2004, 2005 Nokia Corporation
  *
@@ -29,11 +29,15 @@
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
 
+#define RETU_ID			0
+#define TAHVO_ID		1
+
 /* Registers */
 #define RETU_REG_ASICR		0x00		/* ASIC ID and revision */
 #define RETU_REG_ASICR_VILMA	(1 << 7)	/* Bit indicating Vilma */
 #define RETU_REG_IDR		0x01		/* Interrupt ID */
-#define RETU_REG_IMR		0x02		/* Interrupt mask */
+#define RETU_REG_IMR		0x02		/* Interrupt mask (Retu) */
+#define TAHVO_REG_IMR		0x03		/* Interrupt mask (Tahvo) */
 
 /* Interrupt sources */
 #define RETU_INT_PWR		0		/* Power button */
@@ -84,6 +88,62 @@ static struct regmap_irq_chip retu_irq_chip = {
 /* Retu device registered for the power off. */
 static struct retu_dev *retu_pm_power_off;
 
+static struct resource tahvo_usb_res[] = {
+	{
+		.name	= "tahvo-usb",
+		.start	= TAHVO_INT_VBUS,
+		.end	= TAHVO_INT_VBUS,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell tahvo_devs[] = {
+	{
+		.name		= "tahvo-usb",
+		.resources	= tahvo_usb_res,
+		.num_resources	= ARRAY_SIZE(tahvo_usb_res),
+	},
+};
+
+static struct regmap_irq tahvo_irqs[] = {
+	[TAHVO_INT_VBUS] = {
+		.mask = 1 << TAHVO_INT_VBUS,
+	}
+};
+
+static struct regmap_irq_chip tahvo_irq_chip = {
+	.name		= "TAHVO",
+	.irqs		= tahvo_irqs,
+	.num_irqs	= ARRAY_SIZE(tahvo_irqs),
+	.num_regs	= 1,
+	.status_base	= RETU_REG_IDR,
+	.mask_base	= TAHVO_REG_IMR,
+	.ack_base	= RETU_REG_IDR,
+};
+
+static const struct {
+	char			*chip_name;
+	char			*companion_name;
+	struct regmap_irq_chip	*irq_chip;
+	struct mfd_cell		*children;
+	int			nchildren;
+} retu_data[] = {
+	[RETU_ID] = {
+		.chip_name	= "Retu",
+		.companion_name	= "Vilma",
+		.irq_chip	= &retu_irq_chip,
+		.children	= retu_devs,
+		.nchildren	= ARRAY_SIZE(retu_devs),
+	},
+	[TAHVO_ID] = {
+		.chip_name	= "Tahvo",
+		.companion_name	= "Betty",
+		.irq_chip	= &tahvo_irq_chip,
+		.children	= tahvo_devs,
+		.nchildren	= ARRAY_SIZE(tahvo_devs),
+	}
+};
+
 int retu_read(struct retu_dev *rdev, u8 reg)
 {
 	int ret;
@@ -173,9 +233,13 @@ static struct regmap_config retu_config = {
 
 static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 {
+	int chip = id->driver_data;
 	struct retu_dev *rdev;
 	int ret;
 
+	if (chip >= ARRAY_SIZE(retu_data))
+		return -EINVAL;
+
 	rdev = devm_kzalloc(&i2c->dev, sizeof(*rdev), GFP_KERNEL);
 	if (rdev == NULL)
 		return -ENOMEM;
@@ -190,33 +254,37 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 
 	ret = retu_read(rdev, RETU_REG_ASICR);
 	if (ret < 0) {
-		dev_err(rdev->dev, "could not read Retu revision: %d\n", ret);
+		dev_err(rdev->dev, "could not read %s revision: %d\n",
+			retu_data[chip].chip_name, ret);
 		return ret;
 	}
 
-	dev_info(rdev->dev, "Retu%s v%d.%d found\n",
-		 (ret & RETU_REG_ASICR_VILMA) ? " & Vilma" : "",
+	dev_info(rdev->dev, "%s%s%s v%d.%d found\n",
+		 retu_data[chip].chip_name,
+		 (ret & RETU_REG_ASICR_VILMA) ? " & " : "",
+		 (ret & RETU_REG_ASICR_VILMA) ?
+			retu_data[chip].companion_name : "",
 		 (ret >> 4) & 0x7, ret & 0xf);
 
-	/* Mask all RETU interrupts. */
-	ret = retu_write(rdev, RETU_REG_IMR, 0xffff);
+	/* Mask all interrupts. */
+	ret = retu_write(rdev, retu_data[chip].irq_chip->mask_base, 0xffff);
 	if (ret < 0)
 		return ret;
 
 	ret = regmap_add_irq_chip(rdev->regmap, i2c->irq, IRQF_ONESHOT, -1,
-				  &retu_irq_chip, &rdev->irq_data);
+				  retu_data[chip].irq_chip, &rdev->irq_data);
 	if (ret < 0)
 		return ret;
 
-	ret = mfd_add_devices(rdev->dev, -1, retu_devs, ARRAY_SIZE(retu_devs),
-			      NULL, regmap_irq_chip_get_base(rdev->irq_data),
-			      NULL);
+	ret = mfd_add_devices(rdev->dev, -1, retu_data[chip].children,
+			      retu_data[chip].nchildren, NULL,
+			      regmap_irq_chip_get_base(rdev->irq_data), NULL);
 	if (ret < 0) {
 		regmap_del_irq_chip(i2c->irq, rdev->irq_data);
 		return ret;
 	}
 
-	if (!pm_power_off) {
+	if (chip == RETU_ID && !pm_power_off) {
 		retu_pm_power_off = rdev;
 		pm_power_off	  = retu_power_off;
 	}
@@ -239,7 +307,8 @@ static int retu_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id retu_id[] = {
-	{ "retu-mfd", 0 },
+	{ "retu-mfd", RETU_ID },
+	{ "tahvo-mfd", TAHVO_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, retu_id);
diff --git a/include/linux/mfd/retu.h b/include/linux/mfd/retu.h
index 1e2715d..65471c4 100644
--- a/include/linux/mfd/retu.h
+++ b/include/linux/mfd/retu.h
@@ -1,5 +1,5 @@
 /*
- * Retu MFD driver interface
+ * Retu/Tahvo MFD driver interface
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License. See the file "COPYING" in the main directory of this
@@ -19,4 +19,10 @@ int retu_write(struct retu_dev *, u8, u16);
 #define RETU_REG_CC1		0x0d		/* Common control register 1 */
 #define RETU_REG_STATUS		0x16		/* Status register */
 
+/* Interrupt sources */
+#define TAHVO_INT_VBUS		0		/* VBUS state */
+
+/* Interrupt status */
+#define TAHVO_STAT_VBUS		(1 << TAHVO_INT_VBUS)
+
 #endif /* __LINUX_MFD_RETU_H */
-- 
1.7.10.4

