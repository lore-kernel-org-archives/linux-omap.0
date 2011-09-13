From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 19/26] gpio/omap: cleanup prepare_for_idle and resume_after_idle
Date: Tue, 13 Sep 2011 18:32:52 +0530
Message-ID: <1315918979-26173-20-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44267 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab1IMNDW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Sep 2011 09:03:22 -0400
In-Reply-To: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

Since *_prepare_for_idle() and *_resume_after_idle() are called
with interrupts disabled they should be kept as simple as possible.
So, moving most of the stuff to *_runtime_suspend/resume() callbacks.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |  236 +++++++++++++++++++++++++--------------------
 1 files changed, 131 insertions(+), 105 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 6249b8f..8ec9f68 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1114,135 +1114,157 @@ static int omap_gpio_resume(struct device *dev)
 static void omap_gpio_save_context(struct gpio_bank *bank);
 static void omap_gpio_restore_context(struct gpio_bank *bank);
 
-void omap2_gpio_prepare_for_idle(int off_mode)
+static int omap_gpio_runtime_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	u32 l1 = 0, l2 = 0;
+	int j;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 l1 = 0, l2 = 0;
-		int j;
+	spin_lock_irqsave(&bank->lock, flags);
+	/*
+	 * If going to OFF, remove triggering for all
+	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+	 * generated.  See OMAP2420 Errata item 1.101.
+	 */
+	if (!(bank->enabled_non_wakeup_gpios))
+		goto save_gpio_context;
 
-		if (!bank->loses_context)
-			continue;
+	bank->saved_datain = __raw_readl(bank->base +
+						bank->regs->datain);
+	l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
+	l2 = __raw_readl(bank->base + bank->regs->risingdetect);
 
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_disable(bank->dbck);
+	bank->saved_fallingdetect = l1;
+	bank->saved_risingdetect = l2;
+	l1 &= ~bank->enabled_non_wakeup_gpios;
+	l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		if (!off_mode)
-			continue;
+	__raw_writel(l1, bank->base + bank->regs->fallingdetect);
+	__raw_writel(l2, bank->base + bank->regs->risingdetect);
 
-		/* If going to OFF, remove triggering for all
-		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101. */
-		if (!(bank->enabled_non_wakeup_gpios))
-			goto save_gpio_context;
+save_gpio_context:
+	if (bank->get_context_loss_count)
+		bank->context_loss_count =
+				bank->get_context_loss_count(bank->dev);
 
-		bank->saved_datain = __raw_readl(bank->base +
-							bank->regs->datain);
-		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
-		l2 = __raw_readl(bank->base + bank->regs->risingdetect);
+	omap_gpio_save_context(bank);
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_disable(bank->dbck);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	return 0;
+}
 
-		bank->saved_fallingdetect = l1;
-		bank->saved_risingdetect = l2;
-		l1 &= ~bank->enabled_non_wakeup_gpios;
-		l2 &= ~bank->enabled_non_wakeup_gpios;
+static int omap_gpio_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	u32 context_lost_cnt_after;
+	u32 l = 0, gen, gen0, gen1;
+	int j;
+	unsigned long flags;
 
-		__raw_writel(l1, bank->base + bank->regs->fallingdetect);
-		__raw_writel(l2, bank->base + bank->regs->risingdetect);
+	spin_lock_irqsave(&bank->lock, flags);
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_enable(bank->dbck);
 
-save_gpio_context:
-		if (bank->get_context_loss_count)
-			bank->context_loss_count =
-				bank->get_context_loss_count(bank->dev);
+	if (bank->get_context_loss_count) {
+		context_lost_cnt_after =
+			bank->get_context_loss_count(bank->dev);
+		if (context_lost_cnt_after != bank->context_loss_count ||
+						!context_lost_cnt_after) {
+			omap_gpio_restore_context(bank);
+		} else {
+			spin_unlock_irqrestore(&bank->lock, flags);
+			return 0;
+		}
+	}
 
-		omap_gpio_save_context(bank);
-		pm_runtime_put(bank->dev);
+	if (!(bank->enabled_non_wakeup_gpios)) {
+		spin_unlock_irqrestore(&bank->lock, flags);
+		return 0;
 	}
+
+	__raw_writel(bank->saved_fallingdetect,
+			bank->base + bank->regs->fallingdetect);
+	__raw_writel(bank->saved_risingdetect,
+			bank->base + bank->regs->risingdetect);
+	l = __raw_readl(bank->base + bank->regs->datain);
+
+	/*
+	 * Check if any of the non-wakeup interrupt GPIOs have changed
+	 * state.  If so, generate an IRQ by software.  This is
+	 * horribly racy, but it's the best we can do to work around
+	 * this silicon bug.
+	 */
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
+	gen = l & (~(bank->saved_fallingdetect) & ~(bank->saved_risingdetect));
+	/* Consider all GPIO IRQs needed to be updated */
+	gen |= gen0 | gen1;
+
+	if (gen) {
+		u32 old0, old1;
+
+		old0 = __raw_readl(bank->base + bank->regs->leveldetect0);
+		old1 = __raw_readl(bank->base + bank->regs->leveldetect1);
+
+		__raw_writel(old0, bank->base + bank->regs->leveldetect0);
+		__raw_writel(old1, bank->base + bank->regs->leveldetect1);
+		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			old0 |= gen;
+			old1 |= gen;
+		}
+
+		if (cpu_is_omap44xx()) {
+			old0 |= l;
+			old1 |= l;
+		}
+		__raw_writel(old0, bank->base + bank->regs->leveldetect0);
+		__raw_writel(old1, bank->base + bank->regs->leveldetect1);
+	}
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	return 0;
 }
 
-void omap2_gpio_resume_after_idle(void)
+void omap2_gpio_prepare_for_idle(int off_mode)
 {
 	struct gpio_bank *bank;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 context_lost_cnt_after;
-		u32 l = 0, gen, gen0, gen1;
-		int j;
+	if (!off_mode)
+		return;
 
-		if (!bank->loses_context)
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		if (!bank->mod_usage || !bank->loses_context)
 			continue;
 
-		pm_runtime_get_sync(bank->dev);
-
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_enable(bank->dbck);
+		pm_runtime_put(bank->dev);
+	}
+}
 
-		if (bank->get_context_loss_count) {
-			context_lost_cnt_after =
-				bank->get_context_loss_count(bank->dev);
-			if (context_lost_cnt_after != bank->context_loss_count
-				|| !context_lost_cnt_after)
-				omap_gpio_restore_context(bank);
-		}
+void omap2_gpio_resume_after_idle(void)
+{
+	struct gpio_bank *bank;
 
-		if (!(bank->enabled_non_wakeup_gpios))
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		if (!bank->mod_usage || !bank->loses_context)
 			continue;
 
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
+		pm_runtime_get_sync(bank->dev);
 	}
 }
 
@@ -1289,10 +1311,14 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 #else
 #define omap_gpio_suspend NULL
 #define omap_gpio_resume NULL
+#define omap_gpio_runtime_suspend NULL
+#define omap_gpio_runtime_resume NULL
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_gpio_suspend, omap_gpio_resume)
+	SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
+									NULL)
 };
 
 static struct platform_driver omap_gpio_driver = {
-- 
1.7.0.4

