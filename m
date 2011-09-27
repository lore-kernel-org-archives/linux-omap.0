From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 REPOST 20/24] gpio/omap: remove omap_gpio_save_context overhead
Date: Tue, 27 Sep 2011 05:44:16 +0530
Message-ID: <1317082460-31706-21-git-send-email-tarun.kanti@ti.com>
References: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51048 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230Ab1I0AOm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 20:14:42 -0400
In-Reply-To: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Context is now saved dynamically in respective functions whenever and
whichever registers are modified. This avoid overhead of saving all
registers context in the runtime suspend callback.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   62 ++++++++++++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8eb59c3..ad37379 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -98,6 +98,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 	else
 		l &= ~(1 << gpio);
 	__raw_writel(l, reg);
+	bank->context.oe = l;
 }
 
 
@@ -128,6 +129,7 @@ static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
 	else
 		l &= ~gpio_bit;
 	__raw_writel(l, reg);
+	bank->context.dataout = l;
 }
 
 static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
@@ -217,9 +219,20 @@ static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
 	_gpio_rmw(base, bank->regs->fallingdetect, gpio_bit,
 		  trigger & IRQ_TYPE_EDGE_FALLING);
 
-	if (likely(!(bank->non_wakeup_gpios & gpio_bit)))
+	bank->context.leveldetect0 =
+			__raw_readl(bank->base + bank->regs->leveldetect0);
+	bank->context.leveldetect1 =
+			__raw_readl(bank->base + bank->regs->leveldetect1);
+	bank->context.risingdetect =
+			__raw_readl(bank->base + bank->regs->risingdetect);
+	bank->context.fallingdetect =
+			__raw_readl(bank->base + bank->regs->fallingdetect);
+	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
 		_gpio_rmw(base, bank->regs->wkup_en, gpio_bit,
 			trigger != 0);
+		bank->context.wake_en =
+			__raw_readl(bank->base + bank->regs->wkup_en);
+	}
 
 	/* This part needs to be executed always for OMAP{34xx, 44xx} */
 	if (cpu_is_omap34xx() || cpu_is_omap44xx() ||
@@ -306,6 +319,8 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 
 		/* Enable wake-up during idle for dynamic tick */
 		_gpio_rmw(base, bank->regs->wkup_en, 1 << gpio, trigger);
+		bank->context.wake_en =
+			__raw_readl(bank->base + bank->regs->wkup_en);
 		__raw_writel(l, reg);
 	}
 	return 0;
@@ -398,6 +413,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	}
 
 	__raw_writel(l, reg);
+	bank->context.irqenable1 = l;
 }
 
 static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
@@ -418,6 +434,7 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	}
 
 	__raw_writel(l, reg);
+	bank->context.irqenable1 = l;
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
@@ -509,6 +526,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		/* Module is enabled, clocks are not gated */
 		ctrl &= ~GPIO_MOD_CTRL_BIT;
 		__raw_writel(ctrl, reg);
+		bank->context.ctrl = ctrl;
 	}
 
 	bank->mod_usage |= 1 << offset;
@@ -526,9 +544,12 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 	spin_lock_irqsave(&bank->lock, flags);
 
-	if (bank->regs->wkup_en)
+	if (bank->regs->wkup_en) {
 		/* Disable wake-up during idle for dynamic tick */
 		_gpio_rmw(base, bank->regs->wkup_en, 1 << offset, 0);
+		bank->context.wake_en =
+			__raw_readl(bank->base + bank->regs->wkup_en);
+	}
 
 	bank->mod_usage &= ~(1 << offset);
 
@@ -540,6 +561,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		/* Module is disabled, clocks are gated */
 		ctrl |= GPIO_MOD_CTRL_BIT;
 		__raw_writel(ctrl, reg);
+		bank->context.ctrl = ctrl;
 	}
 
 	_reset_gpio(bank, bank->chip.base + offset);
@@ -900,6 +922,8 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 					bank->regs->irqenable_inv == false);
 	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->debounce_en != 0);
 	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->ctrl != 0);
+	bank->context.irqenable1 =
+			__raw_readl(bank->base + bank->regs->irqenable);
 }
 
 static __init void
@@ -1090,6 +1114,7 @@ static int omap_gpio_suspend(struct device *dev)
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->saved_wakeup = __raw_readl(wake_status);
 	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
+	bank->context.wake_en = __raw_readl(bank->base + bank->regs->wkup_en);
 	spin_unlock_irqrestore(&bank->lock, flags);
 	pm_runtime_put_sync(dev);
 	return 0;
@@ -1111,13 +1136,13 @@ static int omap_gpio_resume(struct device *dev)
 	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
+	bank->context.wake_en = __raw_readl(bank->base + bank->regs->wkup_en);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
 
 
-static void omap_gpio_save_context(struct gpio_bank *bank);
 static void omap_gpio_restore_context(struct gpio_bank *bank);
 
 static int omap_gpio_runtime_suspend(struct device *dev)
@@ -1135,7 +1160,7 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	 * generated.  See OMAP2420 Errata item 1.101.
 	 */
 	if (!(bank->enabled_non_wakeup_gpios))
-		goto save_gpio_context;
+		goto update_gpio_context_count;
 
 	bank->saved_datain = __raw_readl(bank->base +
 						bank->regs->datain);
@@ -1149,13 +1174,14 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 
 	__raw_writel(l1, bank->base + bank->regs->fallingdetect);
 	__raw_writel(l2, bank->base + bank->regs->risingdetect);
+	bank->context.fallingdetect = l1;
+	bank->context.risingdetect = l2;
 
-save_gpio_context:
+update_gpio_context_count:
 	if (bank->get_context_loss_count)
 		bank->context_loss_count =
 				bank->get_context_loss_count(bank->dev);
 
-	omap_gpio_save_context(bank);
 	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 		clk_disable(bank->dbck);
 
@@ -1197,6 +1223,8 @@ static int omap_gpio_runtime_resume(struct device *dev)
 			bank->base + bank->regs->fallingdetect);
 	__raw_writel(bank->saved_risingdetect,
 			bank->base + bank->regs->risingdetect);
+	bank->context.fallingdetect = bank->saved_fallingdetect;
+	bank->context.risingdetect = bank->saved_risingdetect;
 	l = __raw_readl(bank->base + bank->regs->datain);
 
 	/*
@@ -1241,6 +1269,8 @@ static int omap_gpio_runtime_resume(struct device *dev)
 		}
 		__raw_writel(old0, bank->base + bank->regs->leveldetect0);
 		__raw_writel(old1, bank->base + bank->regs->leveldetect1);
+		bank->context.leveldetect0 = old0;
+		bank->context.leveldetect1 = old1;
 	}
 
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -1274,26 +1304,6 @@ void omap2_gpio_resume_after_idle(void)
 	}
 }
 
-static void omap_gpio_save_context(struct gpio_bank *bank)
-{
-	bank->context.irqenable1 =
-			__raw_readl(bank->base + bank->regs->irqenable);
-	bank->context.irqenable2 =
-			__raw_readl(bank->base + bank->regs->irqenable2);
-	bank->context.wake_en =
-			__raw_readl(bank->base + bank->regs->wkup_en);
-	bank->context.ctrl = __raw_readl(bank->base + bank->regs->ctrl);
-	bank->context.oe = __raw_readl(bank->base + bank->regs->direction);
-	bank->context.leveldetect0 =
-			__raw_readl(bank->base + bank->regs->leveldetect0);
-	bank->context.leveldetect1 =
-			__raw_readl(bank->base + bank->regs->leveldetect1);
-	bank->context.risingdetect =
-			__raw_readl(bank->base + bank->regs->risingdetect);
-	bank->context.fallingdetect =
-	bank->context.dataout = __raw_readl(bank->base + bank->regs->dataout);
-}
-
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
 	__raw_writel(bank->context.irqenable1,
-- 
1.7.0.4

