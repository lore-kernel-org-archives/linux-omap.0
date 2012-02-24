From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 3/6] gpio/omap: Add DT support to GPIO driver
Date: Fri, 24 Feb 2012 23:21:28 +0100
Message-ID: <1330122091-28113-4-git-send-email-b-cousson@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42780 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758178Ab2BXWWT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 17:22:19 -0500
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Adapt the GPIO driver to retrieve information from a DT file.

Allocate the irq_base dynamically and rename bank->virtual_irq_start
to bank->irq_base.
Change irq_base type to int instead of u16 to match irq_alloc_descs
output.

Add documentation for GPIO properties specific to OMAP.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 .../devicetree/bindings/gpio/gpio-omap.txt         |   36 ++++++
 drivers/gpio/gpio-omap.c                           |  121 ++++++++++++++++++--
 2 files changed, 148 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
new file mode 100644
index 0000000..bff51a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -0,0 +1,36 @@
+OMAP GPIO controller bindings
+
+Required properties:
+- compatible:
+  - "ti,omap2-gpio" for OMAP2 controllers
+  - "ti,omap3-gpio" for OMAP3 controllers
+  - "ti,omap4-gpio" for OMAP4 controllers
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (unused)
+- gpio-controller : Marks the device node as a GPIO controller.
+- #interrupt-cells : Should be 2.
+- interrupt-controller: Mark the device node as an interrupt controller
+  The first cell is the GPIO number.
+  The second cell is used to specify flags:
+    bits[3:0] trigger type and level flags:
+      1 = low-to-high edge triggered.
+      2 = high-to-low edge triggered.
+      4 = active high level-sensitive.
+      8 = active low level-sensitive.
+
+OMAP specific properties:
+- ti,hwmods: Name of the hwmod associated to the GPIO:
+  "gpio<X>", <X> being the 1-based instance number from the HW spec
+
+
+Example:
+
+gpio4: gpio4 {
+    compatible = "ti,omap4-gpio";
+    ti,hwmods = "gpio4";
+    #gpio-cells = <2>;
+    gpio-controller;
+    #interrupt-cells = <2>;
+    interrupt-controller;
+};
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c3a9dc8..bc2bd69 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -22,6 +22,9 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -52,7 +55,8 @@ struct gpio_bank {
 	struct list_head node;
 	void __iomem *base;
 	u16 irq;
-	u16 virtual_irq_start;
+	int irq_base;
+	struct irq_domain *domain;
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
@@ -669,7 +673,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		if (!isr)
 			break;
 
-		gpio_irq = bank->virtual_irq_start;
+		gpio_irq = bank->irq_base;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
 			gpio_index = GPIO_INDEX(bank, irq_to_gpio(gpio_irq));
 
@@ -915,7 +919,7 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	return bank->virtual_irq_start + offset;
+	return bank->irq_base + offset;
 }
 
 /*---------------------------------------------------------------------*/
@@ -1028,8 +1032,7 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 
 	gpiochip_add(&bank->chip);
 
-	for (j = bank->virtual_irq_start;
-		     j < bank->virtual_irq_start + bank->width; j++) {
+	for (j = bank->irq_base; j < bank->irq_base + bank->width; j++) {
 		irq_set_lockdep_class(j, &gpio_lock_class);
 		irq_set_chip_data(j, bank);
 		if (bank->is_mpuio) {
@@ -1044,15 +1047,22 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 	irq_set_handler_data(bank->irq, bank);
 }
 
+static const struct of_device_id omap_gpio_match[];
+
 static int __devinit omap_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	const struct of_device_id *match;
 	struct omap_gpio_platform_data *pdata;
 	struct resource *res;
 	struct gpio_bank *bank;
 	int ret = 0;
 
-	if (!dev->platform_data)
+	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
+
+	pdata = match ? match->data : dev->platform_data;
+	if (!pdata)
 		return -EINVAL;
 
 	bank = devm_kzalloc(&pdev->dev, sizeof(struct gpio_bank), GFP_KERNEL);
@@ -1068,9 +1078,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	bank->irq = res->start;
-
-	pdata = pdev->dev.platform_data;
-	bank->virtual_irq_start = pdata->virtual_irq_start;
 	bank->dev = dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
@@ -1080,6 +1087,18 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->loses_context = pdata->loses_context;
 	bank->get_context_loss_count = pdata->get_context_loss_count;
 	bank->regs = pdata->regs;
+#ifdef CONFIG_OF_GPIO
+	bank->chip.of_node = of_node_get(node);
+#endif
+
+	bank->irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
+	if (bank->irq_base < 0) {
+		dev_err(dev, "Couldn't allocate IRQ numbers\n");
+		return -ENODEV;
+	}
+
+	bank->domain = irq_domain_add_legacy(node, bank->width, bank->irq_base,
+					     0, &irq_domain_simple_ops, NULL);
 
 	if (bank->regs->set_dataout && bank->regs->clr_dataout)
 		bank->set_dataout = _set_gpio_dataout_reg;
@@ -1387,11 +1406,95 @@ static const struct dev_pm_ops gpio_pm_ops = {
 									NULL)
 };
 
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
+	.irqenable2 =		OMAP24XX_GPIO_IRQENABLE2,
+	.set_irqenable =	OMAP24XX_GPIO_SETIRQENABLE1,
+	.clr_irqenable =	OMAP24XX_GPIO_CLEARIRQENABLE1,
+	.debounce =		OMAP24XX_GPIO_DEBOUNCE_VAL,
+	.debounce_en =		OMAP24XX_GPIO_DEBOUNCE_EN,
+	.ctrl =			OMAP24XX_GPIO_CTRL,
+	.wkup_en =		OMAP24XX_GPIO_WAKE_EN,
+	.leveldetect0 =		OMAP24XX_GPIO_LEVELDETECT0,
+	.leveldetect1 =		OMAP24XX_GPIO_LEVELDETECT1,
+	.risingdetect =		OMAP24XX_GPIO_RISINGDETECT,
+	.fallingdetect =	OMAP24XX_GPIO_FALLINGDETECT,
+};
+
+static struct omap_gpio_reg_offs omap4_gpio_regs = {
+	.revision =		OMAP4_GPIO_REVISION,
+	.direction =		OMAP4_GPIO_OE,
+	.datain =		OMAP4_GPIO_DATAIN,
+	.dataout =		OMAP4_GPIO_DATAOUT,
+	.set_dataout =		OMAP4_GPIO_SETDATAOUT,
+	.clr_dataout =		OMAP4_GPIO_CLEARDATAOUT,
+	.irqstatus =		OMAP4_GPIO_IRQSTATUS0,
+	.irqstatus2 =		OMAP4_GPIO_IRQSTATUS1,
+	.irqenable =		OMAP4_GPIO_IRQSTATUSSET0,
+	.irqenable2 =		OMAP4_GPIO_IRQSTATUSSET1,
+	.set_irqenable =	OMAP4_GPIO_IRQSTATUSSET0,
+	.clr_irqenable =	OMAP4_GPIO_IRQSTATUSCLR0,
+	.debounce =		OMAP4_GPIO_DEBOUNCINGTIME,
+	.debounce_en =		OMAP4_GPIO_DEBOUNCENABLE,
+	.ctrl =			OMAP4_GPIO_CTRL,
+	.wkup_en =		OMAP4_GPIO_IRQWAKEN0,
+	.leveldetect0 =		OMAP4_GPIO_LEVELDETECT0,
+	.leveldetect1 =		OMAP4_GPIO_LEVELDETECT1,
+	.risingdetect =		OMAP4_GPIO_RISINGDETECT,
+	.fallingdetect =	OMAP4_GPIO_FALLINGDETECT,
+};
+
+static struct omap_gpio_platform_data omap2_pdata = {
+	.regs = &omap2_gpio_regs,
+	.bank_width = 32,
+	.dbck_flag = false,
+};
+
+static struct omap_gpio_platform_data omap3_pdata = {
+	.regs = &omap2_gpio_regs,
+	.bank_width = 32,
+	.dbck_flag = true,
+};
+
+static struct omap_gpio_platform_data omap4_pdata = {
+	.regs = &omap4_gpio_regs,
+	.bank_width = 32,
+	.dbck_flag = true,
+};
+
+static const struct of_device_id omap_gpio_match[] = {
+	{
+		.compatible = "ti,omap4-gpio",
+		.data = &omap4_pdata,
+	},
+	{
+		.compatible = "ti,omap3-gpio",
+		.data = &omap3_pdata,
+	},
+	{
+		.compatible = "ti,omap2-gpio",
+		.data = &omap2_pdata,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, omap_gpio_match);
+#endif
+
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.driver		= {
 		.name	= "omap_gpio",
 		.pm	= &gpio_pm_ops,
+		.of_match_table = of_match_ptr(omap_gpio_match),
 	},
 };
 
-- 
1.7.0.4

