From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 20/22] gpio/omap: cleanup prepare_for_idle and resume_after_idle
Date: Thu, 4 Aug 2011 16:34:51 +0530
Message-ID: <1312455893-14922-21-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41584 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377Ab1HDLFU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 07:05:20 -0400
In-Reply-To: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

Simplify  omap2_gpio_prepare_for_idle() and omap2_gpio_resume_after_idle()
by moving most of the stuff to *_runtime_suspend() and *_runtime_resume().

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/gpio/gpio-omap.c |  230 ++++++++++++++++++++++++----------------------
 1 files changed, 121 insertions(+), 109 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ce93898..ba743f5 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1132,142 +1132,149 @@ static int omap_gpio_resume(struct device *dev)
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
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 l1 = 0, l2 = 0;
-		int j;
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_disable(bank->dbck);
 
-		if (!bank->loses_context)
-			continue;
+	/* If going to OFF, remove triggering for all
+	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+	 * generated.  See OMAP2420 Errata item 1.101. */
+	if (!(bank->enabled_non_wakeup_gpios))
+		goto save_gpio_ctx;
 
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_disable(bank->dbck);
+	bank->saved_datain = __raw_readl(bank->base +
+						bank->regs->datain);
+	l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
+	l2 = __raw_readl(bank->base + bank->regs->risingdetect);
 
-		if (!off_mode)
-			continue;
+	bank->saved_fallingdetect = l1;
+	bank->saved_risingdetect = l2;
+	l1 &= ~bank->enabled_non_wakeup_gpios;
+	l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0))
-			dev_err(bank->dev, "%s: GPIO bank %d "
-					"pm_runtime_put_sync failed\n",
-					__func__, bank->id);
+	__raw_writel(l1, bank->base + bank->regs->fallingdetect);
+	__raw_writel(l2, bank->base + bank->regs->risingdetect);
+
+save_gpio_ctx:
+	if (bank->get_context_loss_count)
+		bank->ctx_loss_count = bank->get_context_loss_count(bank->dev);
+	omap_gpio_save_context(bank);
+
+	return 0;
+}
+
+static int omap_gpio_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	u32 ctx_lost_cnt_after;
+	u32 l = 0, gen, gen0, gen1;
+	int j;
+
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_enable(bank->dbck);
 
-		/* If going to OFF, remove triggering for all
-		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101. */
-		if (!(bank->enabled_non_wakeup_gpios))
-			goto save_gpio_ctx;
+	if (bank->get_context_loss_count) {
+		ctx_lost_cnt_after =
+			bank->get_context_loss_count(bank->dev);
+		if (ctx_lost_cnt_after != bank->ctx_loss_count ||
+						!ctx_lost_cnt_after)
+			omap_gpio_restore_context(bank);
+		else
+			return 0;
+	}
 
-		bank->saved_datain = __raw_readl(bank->base +
-							bank->regs->datain);
-		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
-		l2 = __raw_readl(bank->base + bank->regs->risingdetect);
+	if (!(bank->enabled_non_wakeup_gpios))
+		return 0;
 
-		bank->saved_fallingdetect = l1;
-		bank->saved_risingdetect = l2;
-		l1 &= ~bank->enabled_non_wakeup_gpios;
-		l2 &= ~bank->enabled_non_wakeup_gpios;
+	__raw_writel(bank->saved_fallingdetect,
+			bank->base + bank->regs->fallingdetect);
+	__raw_writel(bank->saved_risingdetect,
+			bank->base + bank->regs->risingdetect);
+	l = __raw_readl(bank->base + bank->regs->datain);
 
-		__raw_writel(l1, bank->base + bank->regs->fallingdetect);
-		__raw_writel(l2, bank->base + bank->regs->risingdetect);
+	/* Check if any of the non-wakeup interrupt GPIOs have changed
+	 * state.  If so, generate an IRQ by software.  This is
+	 * horribly racy, but it's the best we can do to work around
+	 * this silicon bug. */
+	l ^= bank->saved_datain;
+	l &= bank->enabled_non_wakeup_gpios;
 
-save_gpio_ctx:
-		if (bank->get_context_loss_count)
-			bank->ctx_loss_count =
-				bank->get_context_loss_count(bank->dev);
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
+		old0 = __raw_readl(bank->base + bank->regs->leveldetect0);
+		old1 = __raw_readl(bank->base + bank->regs->leveldetect1);
+
+		__raw_writel(old0, bank->base + bank->regs->leveldetect0);
+		__raw_writel(old1, bank->base + bank->regs->leveldetect1);
+		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			old0 |= gen;
+			old1 |= gen;
+		}
 
-		omap_gpio_save_context(bank);
+		if (cpu_is_omap44xx()) {
+			old0 |= l;
+			old1 |= l;
+		}
+		__raw_writel(old0, bank->base + bank->regs->leveldetect0);
+		__raw_writel(old1, bank->base + bank->regs->leveldetect1);
 	}
+
+	return 0;
 }
 
-void omap2_gpio_resume_after_idle(void)
+void omap2_gpio_prepare_for_idle(int off_mode)
 {
 	struct gpio_bank *bank;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		u32 ctx_lost_cnt_after;
-		u32 l = 0, gen, gen0, gen1;
-		int j;
+	if (!off_mode)
+		return;
 
-		if (!bank->loses_context)
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		if (!bank->mod_usage || !bank->loses_context)
 			continue;
 
-		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0))
+		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0))
 			dev_err(bank->dev, "%s: GPIO bank %d "
-					"pm_runtime_get_sync failed\n",
+					"pm_runtime_put_sync failed\n",
 					__func__, bank->id);
+	}
+}
 
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_enable(bank->dbck);
-
-		if (bank->get_context_loss_count) {
-			ctx_lost_cnt_after =
-				bank->get_context_loss_count(bank->dev);
-			if (ctx_lost_cnt_after != bank->ctx_loss_count ||
-				!ctx_lost_cnt_after)
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
+		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0))
+			dev_err(bank->dev, "%s: GPIO bank %d "
+					"pm_runtime_get_sync failed\n",
+					__func__, bank->id);
 	}
 }
 
@@ -1311,9 +1318,14 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 				bank->base + bank->regs->fallingdetect);
 	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
 }
+#else
+#define omap_gpio_runtime_suspend NULL
+#define omap_gpio_runtime_resume NULL
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
+	.runtime_suspend	= omap_gpio_runtime_suspend,
+	.runtime_resume		= omap_gpio_runtime_resume,
 	.suspend		= omap_gpio_suspend,
 	.resume			= omap_gpio_resume,
 };
-- 
1.7.0.4

