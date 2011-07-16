From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 REPOST 18/20] gpio/omap: use pm-runtime framework
Date: Sat, 16 Jul 2011 13:45:50 +0530
Message-ID: <1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35804 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717Ab1GPIQl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Jul 2011 04:16:41 -0400
In-Reply-To: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
for enabling/disabling clocks appropriately. Remove syscore_ops and
instead use dev_pm_ops now.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |  100 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4191555..6f52395 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -79,6 +79,8 @@ struct gpio_bank {
 	struct omap_gpio_reg_offs *regs;
 };
 
+static void omap_gpio_mod_init(struct gpio_bank *bank);
+
 #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
 #define GPIO_MOD_CTRL_BIT	BIT(0)
@@ -481,6 +483,22 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 
 	spin_lock_irqsave(&bank->lock, flags);
 
+	/*
+	 * If this is the first gpio_request for the bank,
+	 * enable the bank module.
+	 */
+	if (!bank->mod_usage) {
+		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_get_sync failed\n",
+					__func__, bank->id);
+			return -EINVAL;
+		}
+
+		/* Initialize the gpio bank registers to init time value */
+		omap_gpio_mod_init(bank);
+	}
+
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type().
 	 */
@@ -517,7 +535,6 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-
 	if (bank->regs->wkup_status)
 		/* Disable wake-up during idle for dynamic tick */
 		_gpio_rmw(base, bank->regs->wkup_status, 1 << offset, 0);
@@ -535,6 +552,18 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	}
 
 	_reset_gpio(bank, bank->chip.base + offset);
+
+	/*
+	 * If this is the last gpio to be freed in the bank,
+	 * disable the bank module.
+	 */
+	if (!bank->mod_usage) {
+		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_put_sync failed\n",
+					__func__, bank->id);
+		}
+	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
@@ -560,6 +589,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	bank = irq_get_handler_data(irq);
+
+	pm_runtime_get_sync(bank->dev);
+
 	isr_reg = bank->base + bank->regs->irqstatus;
 
 	if (WARN_ON(!isr_reg))
@@ -622,6 +654,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 exit:
 	if (!unmasked)
 		chained_irq_exit(chip, desc);
+
+	pm_runtime_put_sync(bank->dev);
 }
 
 static void gpio_irq_shutdown(struct irq_data *d)
@@ -1028,12 +1062,25 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(bank->dev);
-	pm_runtime_get_sync(bank->dev);
+	pm_runtime_irq_safe(bank->dev);
+	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
+		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_get_sync "
+				"failed\n", __func__, bank->id);
+		iounmap(bank->base);
+		return -EINVAL;
+	}
 
 	omap_gpio_mod_init(bank);
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
+	if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
+		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_put_sync "
+				"failed\n", __func__, bank->id);
+		iounmap(bank->base);
+		return -EINVAL;
+	}
+
 	list_add_tail(&bank->node, &omap_gpio_list);
 
 	return ret;
@@ -1044,10 +1091,12 @@ err_exit:
 	return ret;
 }
 
-static int omap_gpio_suspend(void)
+static int omap_gpio_suspend(struct device *dev)
 {
 	struct gpio_bank *bank;
 
+	pm_runtime_get_sync(dev);
+
 	list_for_each_entry(bank, &omap_gpio_list, node) {
 		void __iomem *base = bank->base;
 		void __iomem *wake_status;
@@ -1065,30 +1114,33 @@ static int omap_gpio_suspend(void)
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
-static void omap_gpio_resume(void)
+static int omap_gpio_resume(struct device *dev)
 {
 	struct gpio_bank *bank;
 
+	pm_runtime_get_sync(dev);
+
 	list_for_each_entry(bank, &omap_gpio_list, node) {
 		void __iomem *base = bank->base;
 		unsigned long flags;
 
 		if (!bank->regs->wkup_status)
-			return;
+			return 0;
 
 		spin_lock_irqsave(&bank->lock, flags);
 		_gpio_rmw(base, bank->regs->wkup_status, bank->saved_wakeup, 1);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
-}
 
-static struct syscore_ops omap_gpio_syscore_ops = {
-	.suspend	= omap_gpio_suspend,
-	.resume		= omap_gpio_resume,
-};
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
@@ -1112,6 +1164,11 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		if (!off_mode)
 			continue;
 
+		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0))
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_put_sync failed\n",
+					__func__, bank->id);
+
 		/* If going to OFF, remove triggering for all
 		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
 		 * generated.  See OMAP2420 Errata item 1.101. */
@@ -1152,6 +1209,11 @@ void omap2_gpio_resume_after_idle(void)
 		if (!bank->loses_context)
 			continue;
 
+		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0))
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_get_sync failed\n",
+					__func__, bank->id);
+
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
@@ -1267,10 +1329,16 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 }
 #endif
 
+static const struct dev_pm_ops gpio_pm_ops = {
+	.suspend		= omap_gpio_suspend,
+	.resume			= omap_gpio_resume,
+};
+
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.driver		= {
 		.name	= "omap_gpio",
+		.pm	= &gpio_pm_ops,
 	},
 };
 
@@ -1285,15 +1353,3 @@ static int __init omap_gpio_drv_reg(void)
 }
 postcore_initcall(omap_gpio_drv_reg);
 
-static int __init omap_gpio_sysinit(void)
-{
-
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-	if (cpu_is_omap16xx() || cpu_class_is_omap2())
-		register_syscore_ops(&omap_gpio_syscore_ops);
-#endif
-
-	return 0;
-}
-
-arch_initcall(omap_gpio_sysinit);
-- 
1.6.0.4

