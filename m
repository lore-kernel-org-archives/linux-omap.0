From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/3] gpio: Add basic support for TWL6040 GPOs
Date: Thu, 16 Aug 2012 15:13:15 +0300
Message-ID: <1345119195-7490-4-git-send-email-peter.ujfalusi@ti.com>
References: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52445 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753855Ab2HPMNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:13:10 -0400
Received: by obbuo13 with SMTP id uo13so4143677obb.33
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 05:13:09 -0700 (PDT)
In-Reply-To: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, peter.ujfalusi@ti.com, Sergio Aguirre <saaguirre@ti.com>

TWL6040 provides GPO lines to be used for controlling external devices.The number
of lines different between versions: twl6040 have 3 GPO while TWL6041 have 1.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig        |    7 ++
 drivers/gpio/Makefile       |    1 +
 drivers/gpio/gpio-twl6040.c |  137 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/gpio-twl6040.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b16c8a7..f74633e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -402,6 +402,13 @@ config GPIO_TWL4030
 	  Say yes here to access the GPIO signals of various multi-function
 	  power management chips from Texas Instruments.
 
+config GPIO_TWL6040
+	tristate "TWL6040 GPO"
+	depends on TWL6040_CORE
+	help
+	  Say yes here to access the GPO signals of twl6040
+	  audio chip from Texas Instruments.
+
 config GPIO_WM831X
 	tristate "WM831x GPIOs"
 	depends on MFD_WM831X
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 153cace..f857b46 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_GPIO_TPS6586X)	+= gpio-tps6586x.o
 obj-$(CONFIG_GPIO_TPS65910)	+= gpio-tps65910.o
 obj-$(CONFIG_GPIO_TPS65912)	+= gpio-tps65912.o
 obj-$(CONFIG_GPIO_TWL4030)	+= gpio-twl4030.o
+obj-$(CONFIG_GPIO_TWL6040)	+= gpio-twl6040.o
 obj-$(CONFIG_GPIO_UCB1400)	+= gpio-ucb1400.o
 obj-$(CONFIG_GPIO_VR41XX)	+= gpio-vr41xx.o
 obj-$(CONFIG_GPIO_VX855)	+= gpio-vx855.o
diff --git a/drivers/gpio/gpio-twl6040.c b/drivers/gpio/gpio-twl6040.c
new file mode 100644
index 0000000..dd58e8b
--- /dev/null
+++ b/drivers/gpio/gpio-twl6040.c
@@ -0,0 +1,137 @@
+/*
+ * Access to GPOs on TWL6040 chip
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *
+ * Authors:
+ *	Sergio Aguirre <saaguirre@ti.com>
+ *	Peter Ujfalusi <peter.ujfalusi@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#include <linux/mfd/twl6040.h>
+
+static struct gpio_chip twl6040gpo_chip;
+
+static int twl6040gpo_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct twl6040 *twl6040 = dev_get_drvdata(chip->dev->parent);
+	int ret = 0;
+
+	ret = twl6040_reg_read(twl6040, TWL6040_REG_GPOCTL);
+	if (ret < 0)
+		return ret;
+
+	return (ret >> offset) & 1;
+}
+
+static int twl6040gpo_direction_out(struct gpio_chip *chip, unsigned offset,
+				    int value)
+{
+	/* This only drives GPOs, and can't change direction */
+	return 0;
+}
+
+static void twl6040gpo_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct twl6040 *twl6040 = dev_get_drvdata(chip->dev->parent);
+	int ret;
+	u8 gpoctl;
+
+	ret = twl6040_reg_read(twl6040, TWL6040_REG_GPOCTL);
+	if (ret < 0)
+		return;
+
+	if (value)
+		gpoctl = ret | (1 << offset);
+	else
+		gpoctl = ret & ~(1 << offset);
+
+	twl6040_reg_write(twl6040, TWL6040_REG_GPOCTL, gpoctl);
+}
+
+static struct gpio_chip twl6040gpo_chip = {
+	.label			= "twl6040",
+	.owner			= THIS_MODULE,
+	.get			= twl6040gpo_get,
+	.direction_output	= twl6040gpo_direction_out,
+	.set			= twl6040gpo_set,
+	.can_sleep		= 1,
+};
+
+/*----------------------------------------------------------------------*/
+
+static int __devinit gpo_twl6040_probe(struct platform_device *pdev)
+{
+	struct twl6040_gpo_data *pdata = pdev->dev.platform_data;
+	struct device *twl6040_core_dev = pdev->dev.parent;
+	struct twl6040 *twl6040 = dev_get_drvdata(twl6040_core_dev);
+	int ret;
+
+	if (pdata)
+		twl6040gpo_chip.base = pdata->gpio_base;
+	else
+		twl6040gpo_chip.base = -1;
+
+	if (twl6040_get_revid(twl6040) < TWL6041_REV_ES2_0)
+		twl6040gpo_chip.ngpio = 3; /* twl6040 have 3 GPO */
+	else
+		twl6040gpo_chip.ngpio = 1; /* twl6041 have 1 GPO */
+
+	twl6040gpo_chip.dev = &pdev->dev;
+#ifdef CONFIG_OF_GPIO
+	twl6040gpo_chip.of_node = twl6040_core_dev->of_node;
+#endif
+
+	ret = gpiochip_add(&twl6040gpo_chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
+		twl6040gpo_chip.ngpio = 0;
+	}
+
+	return ret;
+}
+
+static int __devexit gpo_twl6040_remove(struct platform_device *pdev)
+{
+	return gpiochip_remove(&twl6040gpo_chip);
+}
+
+/* Note:  this hardware lives inside an I2C-based multi-function device. */
+MODULE_ALIAS("platform:twl6040-gpo");
+
+static struct platform_driver gpo_twl6040_driver = {
+	.driver = {
+		.name	= "twl6040-gpo",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= gpo_twl6040_probe,
+	.remove		= gpo_twl6040_remove,
+};
+
+module_platform_driver(gpo_twl6040_driver);
+
+MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_DESCRIPTION("GPO interface for TWL6040");
+MODULE_LICENSE("GPL");
-- 
1.7.8.6

