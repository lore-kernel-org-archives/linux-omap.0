From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 18/18] GPIO: OMAP2+: Clean prepare_for_idle and resume_after_idle
Date: Wed, 15 Jun 2011 09:53:26 +0530
Message-ID: <1308111806-29152-9-git-send-email-tarun.kanti@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42093 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab1FOEXC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 00:23:02 -0400
In-Reply-To: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

Simplify  omap2_gpio_prepare_for_idle() and omap2_gpio_resume_after_idle()
by moving most of the stuff to *_pm_runtime_suspend() and *_pm_runtime_resume().
Also, omap_gpio_suspend() and omap_gpio_resume() optimized to operate per
GPIO bank instead of operating on entire list every time.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/gpio/gpio-omap.c |  306 ++++++++++++++++++++++++----------------------
 1 files changed, 159 insertions(+), 147 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f5bb469..320a169 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1154,6 +1154,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	platform_set_drvdata(pdev, bank);
+
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
@@ -1186,116 +1188,199 @@ err_exit:
 
 static int omap_gpio_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *wake_status;
+	void __iomem *wake_clear;
+	void __iomem *wake_set;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *wake_status;
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
-		unsigned long flags;
-
-		if (!bank->suspend_support)
-			return 0;
-
-		wake_status = bank->base + bank->regs->wkup_status;
-		wake_clear = bank->base + bank->regs->wkup_clear;
-		wake_set = bank->base + bank->regs->wkup_set;
-
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->suspend_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	if (!bank->suspend_support)
+		return 0;
+
+	wake_status = bank->base + bank->regs->wkup_status;
+	wake_clear = bank->base + bank->regs->wkup_clear;
+	wake_set = bank->base + bank->regs->wkup_set;
+
+	pm_runtime_get_sync(dev);
+
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wake_status);
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->suspend_wakeup, wake_set);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	pm_runtime_put_sync(dev);
 
 	return 0;
 }
 
 static int omap_gpio_resume(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *wake_clear;
+	void __iomem *wake_set;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
-		unsigned long flags;
+	if (!bank->suspend_support)
+		return 0;
 
-		if (!bank->suspend_support)
-			return 0;
+	wake_clear = bank->base + bank->regs->wkup_clear;
+	wake_set = bank->base + bank->regs->wkup_set;
 
-		wake_clear = bank->base + bank->regs->wkup_clear;
-		wake_set = bank->base + bank->regs->wkup_set;
+	pm_runtime_get_sync(dev);
+
+	spin_lock_irqsave(&bank->lock, flags);
+	__raw_writel(0xffffffff, wake_clear);
+	__raw_writel(bank->saved_wakeup, wake_set);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	pm_runtime_put_sync(dev);
 
-		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
+static void omap_gpio_save_context(struct gpio_bank *bank);
+static void omap_gpio_restore_context(struct gpio_bank *bank);
+#endif
+
 static int omap_gpio_pm_runtime_suspend(struct device *dev)
 {
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	u32 l1 = 0, l2 = 0;
+	int j;
+
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_disable(bank->dbck);
+
+	/* If going to OFF, remove triggering for all
+	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+	 * generated.  See OMAP2420 Errata item 1.101. */
+	if (!(bank->enabled_non_wakeup_gpios))
+		goto save_gpio_ctx;
+
+	bank->saved_datain = __raw_readl(bank->base +
+						bank->regs->datain);
+	l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
+	l2 = __raw_readl(bank->base + bank->regs->risingdetect);
+
+	bank->saved_fallingdetect = l1;
+	bank->saved_risingdetect = l2;
+	l1 &= ~bank->enabled_non_wakeup_gpios;
+	l2 &= ~bank->enabled_non_wakeup_gpios;
+
+	__raw_writel(l1, bank->base + bank->regs->fallingdetect);
+	__raw_writel(l2, bank->base + bank->regs->risingdetect);
+
+save_gpio_ctx:
+	if (bank->get_context_loss_count)
+		bank->ctx_loss_count = bank->get_context_loss_count(bank->dev);
+	omap_gpio_save_context(bank);
+#endif
 	return 0;
 }
 
 static int omap_gpio_pm_runtime_resume(struct device *dev)
 {
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	u32 ctx_lost_cnt_after;
+	u32 l = 0, gen, gen0, gen1;
+	int j;
+
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_enable(bank->dbck);
+
+	if (bank->get_context_loss_count) {
+		ctx_lost_cnt_after =
+			bank->get_context_loss_count(bank->dev);
+		if (ctx_lost_cnt_after != bank->ctx_loss_count)
+			omap_gpio_restore_context(bank);
+	}
+
+	if (!(bank->enabled_non_wakeup_gpios))
+		return 0;
+
+	__raw_writel(bank->saved_fallingdetect,
+			bank->base + bank->regs->fallingdetect);
+	__raw_writel(bank->saved_risingdetect,
+			bank->base + bank->regs->risingdetect);
+	l = __raw_readl(bank->base + bank->regs->datain);
+
+	/* Check if any of the non-wakeup interrupt GPIOs have changed
+	 * state.  If so, generate an IRQ by software.  This is
+	 * horribly racy, but it's the best we can do to work around
+	 * this silicon bug. */
+	l ^= bank->saved_datain;
+	l &= bank->enabled_non_wakeup_gpios;
+
+	/*
+	 * No need to generate IRQs for the rising edge for gpio IRQs
+	 * configured with falling edge only; and vice versa.
+	 */
+	gen0 = l & bank->saved_fallingdetect;
+	gen0 &= bank->saved_datain;
+	gen1 = l & bank->saved_risingdetect;
+	gen1 &= ~(bank->saved_datain);
+
+	/* FIXME: Consider GPIO IRQs with level detections properly! */
+	gen = l & (~(bank->saved_fallingdetect) &
+			~(bank->saved_risingdetect));
+	/* Consider all GPIO IRQs needed to be updated */
+	gen |= gen0 | gen1;
+
+	if (gen) {
+		u32 old0, old1;
+
+		old0 = __raw_readl(bank->base +
+					bank->regs->leveldetect0);
+		old1 = __raw_readl(bank->base +
+					bank->regs->leveldetect1);
+
+		__raw_writel(old0, bank->base +
+					bank->regs->leveldetect0);
+		__raw_writel(old1, bank->base +
+					bank->regs->leveldetect1);
+		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			old0 |= gen;
+			old1 |= gen;
+		}
+
+		if (cpu_is_omap44xx()) {
+			old0 |= l;
+			old1 |= l;
+		}
+		__raw_writel(old0, bank->base +
+					bank->regs->leveldetect0);
+		__raw_writel(old1, bank->base +
+					bank->regs->leveldetect1);
+	}
+#endif
 	return 0;
 }
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
-static void omap_gpio_save_context(struct gpio_bank *bank);
-static void omap_gpio_restore_context(struct gpio_bank *bank);
-
 void omap2_gpio_prepare_for_idle(int off_mode)
 {
 	struct gpio_bank *bank;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 l1 = 0, l2 = 0;
-		int j;
-
-		if (!bank->loses_context)
-			continue;
-
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_disable(bank->dbck);
+	if (!off_mode)
+		return;
 
-		if (!off_mode)
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		if (!bank->mod_usage || !bank->loses_context)
 			continue;
 
 		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0))
 			dev_err(bank->dev, "%s: GPIO bank %d "
 					"pm_runtime_put_sync failed\n",
 					__func__, bank->id);
-
-		/* If going to OFF, remove triggering for all
-		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101. */
-		if (!(bank->enabled_non_wakeup_gpios))
-			goto save_gpio_ctx;
-
-		bank->saved_datain = __raw_readl(bank->base +
-							bank->regs->datain);
-		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
-		l2 = __raw_readl(bank->base + bank->regs->risingdetect);
-
-		bank->saved_fallingdetect = l1;
-		bank->saved_risingdetect = l2;
-		l1 &= ~bank->enabled_non_wakeup_gpios;
-		l2 &= ~bank->enabled_non_wakeup_gpios;
-
-		__raw_writel(l1, bank->base + bank->regs->fallingdetect);
-		__raw_writel(l2, bank->base + bank->regs->risingdetect);
-
-save_gpio_ctx:
-		if (bank->get_context_loss_count)
-			bank->ctx_loss_count =
-				bank->get_context_loss_count(bank->dev);
-
-		omap_gpio_save_context(bank);
 	}
 }
 
@@ -1304,86 +1389,13 @@ void omap2_gpio_resume_after_idle(void)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 ctx_lost_cnt_after;
-		u32 l = 0, gen, gen0, gen1;
-		int j;
-
-		if (!bank->loses_context)
+		if (!bank->mod_usage || !bank->loses_context)
 			continue;
 
 		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0))
 			dev_err(bank->dev, "%s: GPIO bank %d "
 					"pm_runtime_get_sync failed\n",
 					__func__, bank->id);
-
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_enable(bank->dbck);
-
-		if (bank->get_context_loss_count) {
-			ctx_lost_cnt_after =
-				bank->get_context_loss_count(bank->dev);
-			if (ctx_lost_cnt_after != bank->ctx_loss_count)
-				omap_gpio_restore_context(bank);
-		}
-
-		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
-
-		__raw_writel(bank->saved_fallingdetect,
-				bank->base + bank->regs->fallingdetect);
-		__raw_writel(bank->saved_risingdetect,
-				bank->base + bank->regs->risingdetect);
-		l = __raw_readl(bank->base + bank->regs->datain);
-
-		/* Check if any of the non-wakeup interrupt GPIOs have changed
-		 * state.  If so, generate an IRQ by software.  This is
-		 * horribly racy, but it's the best we can do to work around
-		 * this silicon bug. */
-		l ^= bank->saved_datain;
-		l &= bank->enabled_non_wakeup_gpios;
-
-		/*
-		 * No need to generate IRQs for the rising edge for gpio IRQs
-		 * configured with falling edge only; and vice versa.
-		 */
-		gen0 = l & bank->saved_fallingdetect;
-		gen0 &= bank->saved_datain;
-
-		gen1 = l & bank->saved_risingdetect;
-		gen1 &= ~(bank->saved_datain);
-
-		/* FIXME: Consider GPIO IRQs with level detections properly! */
-		gen = l & (~(bank->saved_fallingdetect) &
-				~(bank->saved_risingdetect));
-		/* Consider all GPIO IRQs needed to be updated */
-		gen |= gen0 | gen1;
-
-		if (gen) {
-			u32 old0, old1;
-
-			old0 = __raw_readl(bank->base +
-						bank->regs->leveldetect0);
-			old1 = __raw_readl(bank->base +
-						bank->regs->leveldetect1);
-
-			__raw_writel(old0, bank->base +
-						bank->regs->leveldetect0);
-			__raw_writel(old1, bank->base +
-						bank->regs->leveldetect1);
-			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-				old0 |= gen;
-				old1 |= gen;
-			}
-
-			if (cpu_is_omap44xx()) {
-				old0 |= l;
-				old1 |= l;
-			}
-			__raw_writel(old0, bank->base +
-						bank->regs->leveldetect0);
-			__raw_writel(old1, bank->base +
-						bank->regs->leveldetect1);
-		}
 	}
 }
 
-- 
1.6.0.4

