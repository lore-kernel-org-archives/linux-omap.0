From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v8 16/24] gpio/omap: use pm-runtime framework
Date: Wed, 5 Oct 2011 14:03:05 +0530
Message-ID: <1317803593-12259-17-git-send-email-tarun.kanti@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42266 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933225Ab1JEIdo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Oct 2011 04:33:44 -0400
In-Reply-To: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
for enabling/disabling clocks appropriately. Remove syscore_ops and
instead use SET_RUNTIME_PM_OPS macro.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/gpio.c |    2 -
 drivers/gpio/gpio-omap.c   |   67 +++++++++++++++++++++++++++++---------------
 2 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 5ae1cf3..a992802 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -146,8 +146,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return PTR_ERR(od);
 	}
 
-	omap_device_disable_idle_on_suspend(od);
-
 	return 0;
 }
 
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0a05562..fa6c9c5 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -79,6 +80,8 @@ struct gpio_bank {
 	struct omap_gpio_reg_offs *regs;
 };
 
+static void omap_gpio_mod_init(struct gpio_bank *bank);
+
 #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
 #define GPIO_MOD_CTRL_BIT	BIT(0)
@@ -478,8 +481,14 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	/*
+	 * If this is the first gpio_request for the bank,
+	 * enable the bank module.
+	 */
+	if (!bank->mod_usage)
+		pm_runtime_get_sync(bank->dev);
 
+	spin_lock_irqsave(&bank->lock, flags);
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type().
 	 */
@@ -535,6 +544,13 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
+
+	/*
+	 * If this is the last gpio to be freed in the bank,
+	 * disable the bank module.
+	 */
+	if (!bank->mod_usage)
+		pm_runtime_put_sync(bank->dev);
 }
 
 /*
@@ -560,6 +576,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 	bank = irq_get_handler_data(irq);
 	isr_reg = bank->base + bank->regs->irqstatus;
+	pm_runtime_get_sync(bank->dev);
 
 	if (WARN_ON(!isr_reg))
 		goto exit;
@@ -620,6 +637,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 exit:
 	if (!unmasked)
 		chained_irq_exit(chip, desc);
+	pm_runtime_put(bank->dev);
 }
 
 static void gpio_irq_shutdown(struct irq_data *d)
@@ -1026,6 +1044,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(bank->dev);
+	pm_runtime_irq_safe(bank->dev);
 	pm_runtime_get_sync(bank->dev);
 
 	if (bank->is_mpuio)
@@ -1035,6 +1054,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
+	pm_runtime_put_sync(bank->dev);
+
 	list_add_tail(&bank->node, &omap_gpio_list);
 
 	return ret;
@@ -1045,7 +1066,9 @@ err_exit:
 	return ret;
 }
 
-static int omap_gpio_suspend(void)
+#ifdef CONFIG_ARCH_OMAP2PLUS
+
+static int omap_gpio_suspend(struct device *dev)
 {
 	struct gpio_bank *bank;
 
@@ -1068,7 +1091,7 @@ static int omap_gpio_suspend(void)
 	return 0;
 }
 
-static void omap_gpio_resume(void)
+static int omap_gpio_resume(struct device *dev)
 {
 	struct gpio_bank *bank;
 
@@ -1077,20 +1100,16 @@ static void omap_gpio_resume(void)
 		unsigned long flags;
 
 		if (!bank->regs->wkup_en)
-			return;
+			return 0;
 
 		spin_lock_irqsave(&bank->lock, flags);
 		_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
-}
 
-static struct syscore_ops omap_gpio_syscore_ops = {
-	.suspend	= omap_gpio_suspend,
-	.resume		= omap_gpio_resume,
-};
+	return 0;
+}
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
 
 static void omap_gpio_save_context(struct gpio_bank *bank);
 static void omap_gpio_restore_context(struct gpio_bank *bank);
@@ -1132,11 +1151,15 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		__raw_writel(l2, bank->base + bank->regs->risingdetect);
 
 save_gpio_context:
+
 		if (bank->get_context_loss_count)
 			bank->context_loss_count =
 				bank->get_context_loss_count(bank->dev);
 
 		omap_gpio_save_context(bank);
+
+		if (!pm_runtime_suspended(bank->dev))
+			pm_runtime_put_sync(bank->dev);
 	}
 }
 
@@ -1155,6 +1178,9 @@ void omap2_gpio_resume_after_idle(void)
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
+		if (pm_runtime_suspended(bank->dev))
+			pm_runtime_get_sync(bank->dev);
+
 		if (bank->get_context_loss_count) {
 			context_lost_cnt_after =
 				bank->get_context_loss_count(bank->dev);
@@ -1264,12 +1290,20 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 				bank->base + bank->regs->fallingdetect);
 	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
 }
+#else
+#define omap_gpio_suspend NULL
+#define omap_gpio_resume NULL
 #endif
 
+static const struct dev_pm_ops gpio_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(omap_gpio_suspend, omap_gpio_resume)
+};
+
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.driver		= {
 		.name	= "omap_gpio",
+		.pm	= &gpio_pm_ops,
 	},
 };
 
@@ -1283,16 +1317,3 @@ static int __init omap_gpio_drv_reg(void)
 	return platform_driver_register(&omap_gpio_driver);
 }
 postcore_initcall(omap_gpio_drv_reg);
-
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
1.7.0.4

