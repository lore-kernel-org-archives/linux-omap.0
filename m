From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 18/20] gpio/omap: use pm-runtime framework
Date: Wed, 13 Jul 2011 19:24:17 +0530
Message-ID: <1310565259-31267-19-git-send-email-tarun.kanti@ti.com>
References: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35275 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715Ab1GMNzP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 09:55:15 -0400
In-Reply-To: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Charulatha V <charu@ti.com>

Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
for enabling/disabling clocks appropriately. Remove syscore_ops and
instead use dev_pm_ops now.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   99 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 78 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4191555..3f1b992 100644
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
@@ -479,6 +481,22 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
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
 	spin_lock_irqsave(&bank->lock, flags);
 
 	/* Set trigger to none. You need to enable the desired trigger with
@@ -536,6 +554,18 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
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
 }
 
 /*
@@ -560,6 +590,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	bank = irq_get_handler_data(irq);
+
+	pm_runtime_get_sync(bank->dev);
+
 	isr_reg = bank->base + bank->regs->irqstatus;
 
 	if (WARN_ON(!isr_reg))
@@ -622,6 +655,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 exit:
 	if (!unmasked)
 		chained_irq_exit(chip, desc);
+
+	pm_runtime_put_sync(bank->dev);
 }
 
 static void gpio_irq_shutdown(struct irq_data *d)
@@ -1028,12 +1063,25 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
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
@@ -1044,10 +1092,12 @@ err_exit:
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
@@ -1065,30 +1115,33 @@ static int omap_gpio_suspend(void)
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
 
@@ -1112,6 +1165,11 @@ void omap2_gpio_prepare_for_idle(int off_mode)
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
@@ -1152,6 +1210,11 @@ void omap2_gpio_resume_after_idle(void)
 		if (!bank->loses_context)
 			continue;
 
+		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0))
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_get_sync failed\n",
+					__func__, bank->id);
+
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
@@ -1267,10 +1330,16 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
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
 
@@ -1285,15 +1354,3 @@ static int __init omap_gpio_drv_reg(void)
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

