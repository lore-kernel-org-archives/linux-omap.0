From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 08/10] gpio/omap: Adapt GPIO driver to DT
Date: Wed, 24 Aug 2011 15:09:14 +0200
Message-ID: <1314191356-10963-9-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53856 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab1HXNLX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 09:11:23 -0400
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Charulatha V <charu@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Adapt the GPIO driver to retrieve information from a DT file.
Note that since the driver is currently under cleanup, some hacks
will have to be removed after.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Charulatha V <charu@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |  103 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0599854..96d19d7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_platform.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -521,7 +522,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	unsigned long flags;
 
 	if (bank->non_wakeup_gpios & gpio_bit) {
-		dev_err(bank->dev, 
+		dev_err(bank->dev,
 			"Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
 		return -EINVAL;
 	}
@@ -1150,6 +1151,8 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 	irq_set_handler_data(bank->irq, bank);
 }
 
+static const struct of_device_id omap_gpio_match[];
+
 static int __devinit omap_gpio_probe(struct platform_device *pdev)
 {
 	static int gpio_init_done;
@@ -1157,11 +1160,25 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	int id;
 	struct gpio_bank *bank;
+	struct device_node *node = pdev->dev.of_node;
+	const struct of_device_id *match;
+
+	match = of_match_device(omap_gpio_match, &pdev->dev);
+	if (match) {
+		pdata = match->data;
+		/* XXX: big hack until the bank_count is removed */
+		of_property_read_u32(node, "bank_count", &gpio_bank_count);
+		if (of_property_read_u32(node, "id", &id))
+			return -EINVAL;
+		/* XXX: maybe the id in DT should be zero based to avoid that */
+		id -= 1;
+	} else {
+		if (!pdev->dev.platform_data)
+			return -EINVAL;
 
-	if (!pdev->dev.platform_data)
-		return -EINVAL;
-
-	pdata = pdev->dev.platform_data;
+		pdata = pdev->dev.platform_data;
+		id = pdev->id;
+	}
 
 	if (!gpio_init_done) {
 		int ret;
@@ -1171,7 +1188,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	id = pdev->id;
 	bank = &gpio_bank[id];
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -1181,12 +1197,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	bank->irq = res->start;
-	bank->virtual_irq_start = pdata->virtual_irq_start;
 	bank->method = pdata->bank_type;
 	bank->dev = &pdev->dev;
-	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
-	bank->width = pdata->bank_width;
+	if (match) {
+		of_property_read_u32(node, "bank_width", &bank->width);
+		if (of_get_property(node, "debounce", NULL))
+			bank->dbck_flag = true;
+		bank->virtual_irq_start = IH_GPIO_BASE + 32 * id;
+	} else {
+		bank->width = pdata->bank_width;
+		bank->dbck_flag = pdata->dbck_flag;
+		bank->virtual_irq_start = pdata->virtual_irq_start;
+	}
 
 	bank->regs = pdata->regs;
 
@@ -1559,10 +1582,72 @@ void omap_gpio_restore_context(void)
 }
 #endif
 
+
+static struct omap_gpio_reg_offs omap2_gpio_regs = {
+	.revision =		OMAP24XX_GPIO_REVISION,
+	.direction =		OMAP24XX_GPIO_OE,
+	.datain =		OMAP24XX_GPIO_DATAIN,
+	.dataout =		OMAP24XX_GPIO_DATAOUT,
+	.set_dataout =		OMAP24XX_GPIO_SETDATAOUT,
+	.clr_dataout =		OMAP24XX_GPIO_CLEARDATAOUT,
+	.irqstatus =		OMAP24XX_GPIO_IRQSTATUS1,
+	.irqstatus2 =		OMAP24XX_GPIO_IRQSTATUS2,
+	.irqenable =		OMAP24XX_GPIO_IRQENABLE1,
+	.set_irqenable =	OMAP24XX_GPIO_SETIRQENABLE1,
+	.clr_irqenable =	OMAP24XX_GPIO_CLEARIRQENABLE1,
+	.debounce =		OMAP24XX_GPIO_DEBOUNCE_VAL,
+	.debounce_en =		OMAP24XX_GPIO_DEBOUNCE_EN,
+};
+
+static struct omap_gpio_platform_data omap2_pdata = {
+	.bank_type = METHOD_GPIO_24XX,
+	.regs = &omap2_gpio_regs,
+};
+
+static struct omap_gpio_reg_offs omap4_gpio_regs = {
+	.revision =		OMAP4_GPIO_REVISION,
+	.direction =		OMAP4_GPIO_OE,
+	.datain =		OMAP4_GPIO_DATAIN,
+	.dataout =		OMAP4_GPIO_DATAOUT,
+	.set_dataout =		OMAP4_GPIO_SETDATAOUT,
+	.clr_dataout =		OMAP4_GPIO_CLEARDATAOUT,
+	.irqstatus =		OMAP4_GPIO_IRQSTATUS1,
+	.irqstatus2 =		OMAP4_GPIO_IRQSTATUS2,
+	.irqenable =		OMAP4_GPIO_IRQENABLE1,
+	.set_irqenable =	OMAP4_GPIO_SETIRQENABLE1,
+	.clr_irqenable =	OMAP4_GPIO_CLEARIRQENABLE1,
+	.debounce =		OMAP4_GPIO_DEBOUNCINGTIME,
+	.debounce_en =		OMAP4_GPIO_DEBOUNCENABLE,
+};
+
+static struct omap_gpio_platform_data omap4_pdata = {
+	.bank_type = METHOD_GPIO_44XX,
+	.regs = &omap4_gpio_regs,
+};
+
+
+#if defined(CONFIG_OF)
+	static const struct of_device_id omap_gpio_match[] = {
+	{
+		.compatible = "ti,omap4-gpio",
+		.data = &omap4_pdata,
+	},
+	{
+		.compatible = "ti,omap2-gpio",
+		.data = &omap2_pdata,
+	},
+	{},
+}
+MODULE_DEVICE_TABLE(of, omap_gpio_match);
+#else
+#define omap_gpio_match NULL
+#endif
+
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.driver		= {
 		.name	= "omap_gpio",
+		.of_match_table = omap_gpio_match,
 	},
 };
 
-- 
1.7.0.4

