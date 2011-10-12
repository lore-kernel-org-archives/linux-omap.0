From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v8 REPOST 17/24] gpio/omap: fix debounce clock handling
Date: Wed, 12 Oct 2011 18:01:37 +0530
Message-ID: <1318422697-22247-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54674 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023Ab1JLMb6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Oct 2011 08:31:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Currently debounce clock state is not tracked in the system. The bank->dbck
is enabled/disabled in suspend/idle paths irrespective of whether debounce
interval has been set or not. Ideally, it should be handled only for those
gpio banks where the debounce is enabled. In _set_gpio_debounce, enable
debounce clock before accessing registers.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
During further internal testing it was found that image was crashing within
_set_gpio_debounce(). It is observed that we are trying to access registers
without enabling debounce clock. This patch incorporates the change whereby
the debounce clock is enabled before accessing registers and disabled at the
end of the function.

 drivers/gpio/gpio-omap.c |   60 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index fa6c9c5..85e9c2a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -65,6 +65,7 @@ struct gpio_bank {
 	struct clk *dbck;
 	u32 mod_usage;
 	u32 dbck_enable_mask;
+	bool dbck_enabled;
 	struct device *dev;
 	bool is_mpuio;
 	bool dbck_flag;
@@ -156,6 +157,22 @@ static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 	__raw_writel(l, base + reg);
 }
 
+static inline void _gpio_dbck_enable(struct gpio_bank *bank)
+{
+	if (bank->dbck_enable_mask && !bank->dbck_enabled) {
+		clk_enable(bank->dbck);
+		bank->dbck_enabled = true;
+	}
+}
+
+static inline void _gpio_dbck_disable(struct gpio_bank *bank)
+{
+	if (bank->dbck_enable_mask && bank->dbck_enabled) {
+		clk_disable(bank->dbck);
+		bank->dbck_enabled = false;
+	}
+}
+
 /**
  * _set_gpio_debounce - low level gpio debounce time
  * @bank: the gpio bank we're acting upon
@@ -184,22 +201,22 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
 	l = GPIO_BIT(bank, gpio);
 
+	clk_enable(bank->dbck);
 	reg = bank->base + bank->regs->debounce;
 	__raw_writel(debounce, reg);
 
 	reg = bank->base + bank->regs->debounce_en;
 	val = __raw_readl(reg);
 
-	if (debounce) {
+	if (debounce)
 		val |= l;
-		clk_enable(bank->dbck);
-	} else {
+	else
 		val &= ~l;
-		clk_disable(bank->dbck);
-	}
+
 	bank->dbck_enable_mask = val;
 
 	__raw_writel(val, reg);
+	clk_disable(bank->dbck);
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
@@ -485,8 +502,10 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 * If this is the first gpio_request for the bank,
 	 * enable the bank module.
 	 */
-	if (!bank->mod_usage)
+	if (!bank->mod_usage) {
+		_gpio_dbck_enable(bank);
 		pm_runtime_get_sync(bank->dev);
+	}
 
 	spin_lock_irqsave(&bank->lock, flags);
 	/* Set trigger to none. You need to enable the desired trigger with
@@ -549,8 +568,10 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	 * If this is the last gpio to be freed in the bank,
 	 * disable the bank module.
 	 */
-	if (!bank->mod_usage)
+	if (!bank->mod_usage) {
 		pm_runtime_put_sync(bank->dev);
+		_gpio_dbck_disable(bank);
+	}
 }
 
 /*
@@ -829,8 +850,10 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 
 	if (!bank->dbck) {
 		bank->dbck = clk_get(bank->dev, "dbclk");
-		if (IS_ERR(bank->dbck))
+		if (IS_ERR(bank->dbck)) {
 			dev_err(bank->dev, "Could not get gpio dbck\n");
+			return -EINVAL;
+		}
 	}
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -1086,6 +1109,8 @@ static int omap_gpio_suspend(struct device *dev)
 		bank->saved_wakeup = __raw_readl(wake_status);
 		_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
 		spin_unlock_irqrestore(&bank->lock, flags);
+
+		_gpio_dbck_disable(bank);
 	}
 
 	return 0;
@@ -1102,6 +1127,8 @@ static int omap_gpio_resume(struct device *dev)
 		if (!bank->regs->wkup_en)
 			return 0;
 
+		_gpio_dbck_enable(bank);
+
 		spin_lock_irqsave(&bank->lock, flags);
 		_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
 		spin_unlock_irqrestore(&bank->lock, flags);
@@ -1120,16 +1147,14 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
 		u32 l1 = 0, l2 = 0;
-		int j;
 
 		if (!bank->loses_context)
 			continue;
 
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_disable(bank->dbck);
-
-		if (!off_mode)
+		if (!off_mode) {
+			_gpio_dbck_disable(bank);
 			continue;
+		}
 
 		/* If going to OFF, remove triggering for all
 		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
@@ -1151,15 +1176,16 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		__raw_writel(l2, bank->base + bank->regs->risingdetect);
 
 save_gpio_context:
-
 		if (bank->get_context_loss_count)
 			bank->context_loss_count =
 				bank->get_context_loss_count(bank->dev);
 
 		omap_gpio_save_context(bank);
 
-		if (!pm_runtime_suspended(bank->dev))
+		if (!pm_runtime_suspended(bank->dev)) {
 			pm_runtime_put_sync(bank->dev);
+			_gpio_dbck_disable(bank);
+		}
 	}
 }
 
@@ -1170,13 +1196,11 @@ void omap2_gpio_resume_after_idle(void)
 	list_for_each_entry(bank, &omap_gpio_list, node) {
 		u32 context_lost_cnt_after;
 		u32 l = 0, gen, gen0, gen1;
-		int j;
 
 		if (!bank->loses_context)
 			continue;
 
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_enable(bank->dbck);
+		_gpio_dbck_enable(bank);
 
 		if (pm_runtime_suspended(bank->dev))
 			pm_runtime_get_sync(bank->dev);
-- 
1.7.0.4

