From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [RFC PATCH v2 1/4] retu-mfd: support also Tahvo
Date: Tue,  9 Apr 2013 22:51:25 +0300
Message-ID: <1365537088-23199-2-git-send-email-aaro.koskinen@iki.fi>
References: <1365537088-23199-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365537088-23199-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tahvo is a multi-function device on Nokia 770, implementing USB
transceiver and charge/battery control.

It's so close to Retu that a single driver can support both.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/mfd/Kconfig      |    6 ++--
 drivers/mfd/retu-mfd.c   |   85 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/mfd/retu.h |    8 ++++-
 3 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c346941..8628955 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1102,13 +1102,13 @@ config MFD_VIPERBOARD
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
index 3ba0486..a183098 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -1,5 +1,5 @@
 /*
- * Retu MFD driver
+ * Retu/Tahvo MFD driver
  *
  * Copyright (C) 2004, 2005 Nokia Corporation
  *
@@ -33,7 +33,8 @@
 #define RETU_REG_ASICR		0x00		/* ASIC ID and revision */
 #define RETU_REG_ASICR_VILMA	(1 << 7)	/* Bit indicating Vilma */
 #define RETU_REG_IDR		0x01		/* Interrupt ID */
-#define RETU_REG_IMR		0x02		/* Interrupt mask */
+#define RETU_REG_IMR		0x02		/* Interrupt mask (Retu) */
+#define TAHVO_REG_IMR		0x03		/* Interrupt mask (Tahvo) */
 
 /* Interrupt sources */
 #define RETU_INT_PWR		0		/* Power button */
@@ -84,6 +85,62 @@ static struct regmap_irq_chip retu_irq_chip = {
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
+static const struct retu_data {
+	char			*chip_name;
+	char			*companion_name;
+	struct regmap_irq_chip	*irq_chip;
+	struct mfd_cell		*children;
+	int			nchildren;
+} retu_data[] = {
+	[0] = {
+		.chip_name	= "Retu",
+		.companion_name	= "Vilma",
+		.irq_chip	= &retu_irq_chip,
+		.children	= retu_devs,
+		.nchildren	= ARRAY_SIZE(retu_devs),
+	},
+	[1] = {
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
@@ -173,9 +230,14 @@ static struct regmap_config retu_config = {
 
 static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 {
+	struct retu_data const *rdat;
 	struct retu_dev *rdev;
 	int ret;
 
+	if (i2c->addr > ARRAY_SIZE(retu_data))
+		return -ENODEV;
+	rdat = &retu_data[i2c->addr - 1];
+
 	rdev = devm_kzalloc(&i2c->dev, sizeof(*rdev), GFP_KERNEL);
 	if (rdev == NULL)
 		return -ENOMEM;
@@ -190,25 +252,27 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 
 	ret = retu_read(rdev, RETU_REG_ASICR);
 	if (ret < 0) {
-		dev_err(rdev->dev, "could not read Retu revision: %d\n", ret);
+		dev_err(rdev->dev, "could not read %s revision: %d\n",
+			rdat->chip_name, ret);
 		return ret;
 	}
 
-	dev_info(rdev->dev, "Retu%s v%d.%d found\n",
-		 (ret & RETU_REG_ASICR_VILMA) ? " & Vilma" : "",
+	dev_info(rdev->dev, "%s%s%s v%d.%d found\n", rdat->chip_name,
+		 (ret & RETU_REG_ASICR_VILMA) ? " & " : "",
+		 (ret & RETU_REG_ASICR_VILMA) ? rdat->companion_name : "",
 		 (ret >> 4) & 0x7, ret & 0xf);
 
-	/* Mask all RETU interrupts. */
-	ret = retu_write(rdev, RETU_REG_IMR, 0xffff);
+	/* Mask all interrupts. */
+	ret = retu_write(rdev, rdat->irq_chip->mask_base, 0xffff);
 	if (ret < 0)
 		return ret;
 
 	ret = regmap_add_irq_chip(rdev->regmap, i2c->irq, IRQF_ONESHOT, -1,
-				  &retu_irq_chip, &rdev->irq_data);
+				  rdat->irq_chip, &rdev->irq_data);
 	if (ret < 0)
 		return ret;
 
-	ret = mfd_add_devices(rdev->dev, -1, retu_devs, ARRAY_SIZE(retu_devs),
+	ret = mfd_add_devices(rdev->dev, -1, rdat->children, rdat->nchildren,
 			      NULL, regmap_irq_chip_get_base(rdev->irq_data),
 			      NULL);
 	if (ret < 0) {
@@ -216,7 +280,7 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 		return ret;
 	}
 
-	if (!pm_power_off) {
+	if (i2c->addr == 1 && !pm_power_off) {
 		retu_pm_power_off = rdev;
 		pm_power_off	  = retu_power_off;
 	}
@@ -240,6 +304,7 @@ static int retu_remove(struct i2c_client *i2c)
 
 static const struct i2c_device_id retu_id[] = {
 	{ "retu-mfd", 0 },
+	{ "tahvo-mfd", 0 },
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
