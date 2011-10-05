From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v8 19/24] gpio/omap: cleanup prepare_for_idle and resume_after_idle
Date: Wed, 5 Oct 2011 14:03:08 +0530
Message-ID: <1317803593-12259-20-git-send-email-tarun.kanti@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60724 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933596Ab1JEIdu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Oct 2011 04:33:50 -0400
In-Reply-To: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

Since *_prepare_for_idle() and *_resume_after_idle() are called
with interrupts disabled they should be kept as simple as possible.
So, moving most of the stuff to *_runtime_suspend/resume() callbacks.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |  237 +++++++++++++++++++++++++--------------------
 1 files changed, 132 insertions(+), 105 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d101438..4339815 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1147,136 +1147,159 @@ static int omap_gpio_resume(struct device *dev)
 static void omap_gpio_save_context(struct gpio_bank *bank);
 static void omap_gpio_restore_context(struct gpio_bank *bank);
 
-void omap2_gpio_prepare_for_idle(int off_mode)
+static int omap_gpio_runtime_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
-
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 l1 = 0, l2 = 0;
-
-		if (!bank->loses_context)
-			continue;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	u32 l1 = 0, l2 = 0;
+	unsigned long flags;
 
-		if (!off_mode) {
-			_gpio_dbck_disable(bank);
-			continue;
-		}
+	if (!bank->loses_context)
+		return 0;
 
-		/* If going to OFF, remove triggering for all
-		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101. */
-		if (!(bank->enabled_non_wakeup_gpios))
-			goto save_gpio_context;
+	spin_lock_irqsave(&bank->lock, flags);
+	/*
+	 * If going to OFF, remove triggering for all
+	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+	 * generated.  See OMAP2420 Errata item 1.101.
+	 */
+	if (!(bank->enabled_non_wakeup_gpios))
+		goto save_gpio_context;
 
-		bank->saved_datain = __raw_readl(bank->base +
-							bank->regs->datain);
-		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
-		l2 = __raw_readl(bank->base + bank->regs->risingdetect);
+	bank->saved_datain = __raw_readl(bank->base +
+						bank->regs->datain);
+	l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
+	l2 = __raw_readl(bank->base + bank->regs->risingdetect);
 
-		bank->saved_fallingdetect = l1;
-		bank->saved_risingdetect = l2;
-		l1 &= ~bank->enabled_non_wakeup_gpios;
-		l2 &= ~bank->enabled_non_wakeup_gpios;
+	bank->saved_fallingdetect = l1;
+	bank->saved_risingdetect = l2;
+	l1 &= ~bank->enabled_non_wakeup_gpios;
+	l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		__raw_writel(l1, bank->base + bank->regs->fallingdetect);
-		__raw_writel(l2, bank->base + bank->regs->risingdetect);
+	__raw_writel(l1, bank->base + bank->regs->fallingdetect);
+	__raw_writel(l2, bank->base + bank->regs->risingdetect);
 
 save_gpio_context:
-		if (bank->get_context_loss_count)
-			bank->context_loss_count =
+	if (bank->get_context_loss_count)
+		bank->context_loss_count =
 				bank->get_context_loss_count(bank->dev);
 
-		omap_gpio_save_context(bank);
+	omap_gpio_save_context(bank);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
-		if (!pm_runtime_suspended(bank->dev)) {
-			pm_runtime_put_sync(bank->dev);
-			_gpio_dbck_disable(bank);
-		}
-	}
+	return 0;
 }
 
-void omap2_gpio_resume_after_idle(void)
+static int omap_gpio_runtime_resume(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	u32 context_lost_cnt_after;
+	u32 l = 0, gen, gen0, gen1;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 context_lost_cnt_after;
-		u32 l = 0, gen, gen0, gen1;
+	if (!bank->loses_context)
+		return 0;
 
-		if (!bank->loses_context)
-			continue;
+	spin_lock_irqsave(&bank->lock, flags);
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
 
-		_gpio_dbck_enable(bank);
+	if (!(bank->enabled_non_wakeup_gpios)) {
+		spin_unlock_irqrestore(&bank->lock, flags);
+		return 0;
+	}
 
-		if (pm_runtime_suspended(bank->dev))
-			pm_runtime_get_sync(bank->dev);
+	__raw_writel(bank->saved_fallingdetect,
+			bank->base + bank->regs->fallingdetect);
+	__raw_writel(bank->saved_risingdetect,
+			bank->base + bank->regs->risingdetect);
+	l = __raw_readl(bank->base + bank->regs->datain);
 
-		if (bank->get_context_loss_count) {
-			context_lost_cnt_after =
-				bank->get_context_loss_count(bank->dev);
-			if (context_lost_cnt_after != bank->context_loss_count
-				|| !context_lost_cnt_after)
-				omap_gpio_restore_context(bank);
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
 		}
 
-		if (!(bank->enabled_non_wakeup_gpios))
+		if (cpu_is_omap44xx()) {
+			old0 |= l;
+			old1 |= l;
+		}
+		__raw_writel(old0, bank->base + bank->regs->leveldetect0);
+		__raw_writel(old1, bank->base + bank->regs->leveldetect1);
+	}
+
+save_gpio_context:
+	if (bank->get_context_loss_count)
+		bank->context_loss_count =
+			bank->get_context_loss_count(bank->dev);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
+void omap2_gpio_prepare_for_idle(int off_mode)
+{
+	struct gpio_bank *bank;
+
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		if (!bank->mod_usage)
 			continue;
 
-		__raw_writel(bank->saved_fallingdetect,
-				bank->base + bank->regs->fallingdetect);
-		__raw_writel(bank->saved_risingdetect,
-				bank->base + bank->regs->risingdetect);
-		l = __raw_readl(bank->base + bank->regs->datain);
+		_gpio_dbck_disable(bank);
+	}
+}
 
-		/* Check if any of the non-wakeup interrupt GPIOs have changed
-		 * state.  If so, generate an IRQ by software.  This is
-		 * horribly racy, but it's the best we can do to work around
-		 * this silicon bug. */
-		l ^= bank->saved_datain;
-		l &= bank->enabled_non_wakeup_gpios;
+void omap2_gpio_resume_after_idle(void)
+{
+	struct gpio_bank *bank;
 
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
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		if (!bank->mod_usage)
+			continue;
+
+		_gpio_dbck_enable(bank);
 	}
 }
 
@@ -1323,10 +1346,14 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
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

