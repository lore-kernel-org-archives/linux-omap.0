From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
Date: Mon, 26 Sep 2011 18:50:10 +0200
Message-ID: <1317055821-20652-3-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43297 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab1IZQvG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 12:51:06 -0400
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Charulatha V <charu@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Adapt the GPIO driver to retrieve information from a DT file.
Note that since the driver is currently under cleanup, some hacks
will have to be removed after.

Add documentation for GPIO properties specific to OMAP.

Remove an un-needed whitespace.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Charulatha V <charu@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 .../devicetree/bindings/gpio/gpio-omap.txt         |   33 ++++++
 drivers/gpio/gpio-omap.c                           |  108 ++++++++++++++++++--
 2 files changed, 132 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
new file mode 100644
index 0000000..bdd63de
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -0,0 +1,33 @@
+OMAP GPIO controller
+
+Required properties:
+- compatible:
+  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
+  - "ti,omap4-gpio" for OMAP4 controller
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (unused)
+- gpio-controller : Marks the device node as a GPIO controller.
+
+OMAP specific properties:
+- ti,hwmods: Name of the hwmod associated to the GPIO
+- id: 32 bits to identify the id (1 based index)
+- bank-width: number of pin supported by the controller (16 or 32)
+- debounce: set if the controller support the debouce funtionnality
+- bank-count: number of controller support by the SoC. This is a temporary
+  hack until the bank_count is removed from the driver.
+
+
+Example:
+
+gpio4: gpio4 {
+    compatible = "ti,omap4-gpio", "ti,omap-gpio";
+    ti,hwmods = "gpio4";
+    id = <4>;
+    bank-width = <32>;
+    debounce;
+    no_idle_on_suspend;
+    #gpio-cells = <2>;
+    gpio-controller;
+};
+
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0599854..f878fa4 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -21,6 +21,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -521,7 +523,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	unsigned long flags;
 
 	if (bank->non_wakeup_gpios & gpio_bit) {
-		dev_err(bank->dev, 
+		dev_err(bank->dev,
 			"Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
 		return -EINVAL;
 	}
@@ -1150,6 +1152,8 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 	irq_set_handler_data(bank->irq, bank);
 }
 
+static const struct of_device_id omap_gpio_match[];
+
 static int __devinit omap_gpio_probe(struct platform_device *pdev)
 {
 	static int gpio_init_done;
@@ -1157,11 +1161,31 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
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
+		of_property_read_u32(node, "bank-count", &gpio_bank_count);
+		if (of_property_read_u32(node, "id", &id))
+			return -EINVAL;
+		/*
+		 * In an ideal world, the id should not be needed, but since
+		 * the OMAP TRM consider the multiple GPIO controllers as
+		 * multiple banks, the GPIO number is based on the whole set
+		 * of banks. Hence the need to provide an id in order to
+		 * respect the order and the correct GPIO number.
+		 */
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
@@ -1171,7 +1195,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	id = pdev->id;
 	bank = &gpio_bank[id];
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -1181,12 +1204,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	bank->irq = res->start;
-	bank->virtual_irq_start = pdata->virtual_irq_start;
 	bank->method = pdata->bank_type;
 	bank->dev = &pdev->dev;
-	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
-	bank->width = pdata->bank_width;
+	if (match) {
+		of_property_read_u32(node, "bank-width", &bank->width);
+		if (of_get_property(node, "debounce", NULL))
+			bank->dbck_flag = true;
+		bank->virtual_irq_start = IH_GPIO_BASE + 32 * id;
+	} else {
+		bank->width = pdata->bank_width;
+		bank->dbck_flag = pdata->dbck_flag;
+		bank->virtual_irq_start = pdata->virtual_irq_start;
+	}
 
 	bank->regs = pdata->regs;
 
@@ -1559,10 +1589,70 @@ void omap_gpio_restore_context(void)
 }
 #endif
 
+#if defined(CONFIG_OF)
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
+static const struct of_device_id omap_gpio_match[] = {
+	{
+		.compatible = "ti,omap4-gpio",
+		.data = &omap4_pdata,
+	},
+	{
+		.compatible = "ti,omap2-gpio",
+		.data = &omap2_pdata,
+	},
+	{},
+};
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

