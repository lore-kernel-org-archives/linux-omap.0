From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 10/15] OMAP: GPIO: cleanup prepare/resume idle functions
Date: Tue, 24 May 2011 19:54:49 +0530
Message-ID: <1306247094-25372-11-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43535 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622Ab1EXOZU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:20 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

By adding level and edge detection register offsets and then initializing them
correctly according to OMAP versions during device registrations we can now remove
lot of revision checks in these functions.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    8 ++
 arch/arm/plat-omap/include/plat/gpio.h |    4 +
 drivers/gpio/gpio_omap.c               |  116 ++++++++++----------------------
 3 files changed, 48 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 7e79999..0f8782f 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -111,6 +111,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
 		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
+		pdata->regs->leveldetect0 = OMAP24XX_GPIO_LEVELDETECT0;
+		pdata->regs->leveldetect1 = OMAP24XX_GPIO_LEVELDETECT1;
+		pdata->regs->risingdetect = OMAP24XX_GPIO_RISINGDETECT;
+		pdata->regs->fallingdetect = OMAP24XX_GPIO_FALLINGDETECT;
 		pdata->regs->wkupstatus = OMAP24XX_GPIO_WAKE_EN;
 		pdata->regs->wkupclear = OMAP24XX_GPIO_CLEARWKUENA;
 		pdata->regs->wkupset = OMAP24XX_GPIO_SETWKUENA;
@@ -131,6 +135,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
 		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
 		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
+		pdata->regs->leveldetect0 = OMAP4_GPIO_LEVELDETECT0;
+		pdata->regs->leveldetect1 = OMAP4_GPIO_LEVELDETECT1;
+		pdata->regs->risingdetect = OMAP4_GPIO_RISINGDETECT;
+		pdata->regs->fallingdetect = OMAP4_GPIO_FALLINGDETECT;
 		pdata->regs->wkupstatus = OMAP4_GPIO_IRQWAKEN0;
 		pdata->regs->wkupclear = OMAP4_GPIO_IRQWAKEN0;
 		pdata->regs->wkupset = OMAP4_GPIO_IRQWAKEN0;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 2d1a5d6..7712e97 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -189,6 +189,10 @@ struct omap_gpio_reg_offs {
 	u16 debounce;
 	u16 debounce_en;
 	u16 ctrl;
+	u16 leveldetect0;
+	u16 leveldetect1;
+	u16 risingdetect;
+	u16 fallingdetect;
 	u16 wkupstatus;
 	u16 wkupclear;
 	u16 wkupset;
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index c189416..28390a9 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -267,15 +267,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
 
-	if (cpu_is_omap44xx()) {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT1);
-	} else {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-	}
+	bank->level_mask =
+		__raw_readl(bank->base + bank->regs->leveldetect0) |
+		__raw_readl(bank->base + bank->regs->leveldetect1);
 }
 #endif
 
@@ -1181,9 +1175,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	 * values every time in suspend/resume functions and for all the
 	 * gpio banks.
 	 */
-	bank->wake_status = bank->base + bank->regs->wkupstatus;
-	bank->wake_clear = bank->base + bank->regs->wkupclear;
-	bank->wake_set = bank->base + bank->regs->wkupset;
+	if (bank->regs->wkupstatus != USHRT_MAX) {
+		bank->wake_status = bank->base + bank->regs->wkupstatus;
+		bank->wake_clear = bank->base + bank->regs->wkupclear;
+		bank->wake_set = bank->base + bank->regs->wkupset;
+	}
 
 	pm_runtime_enable(bank->dev);
 	pm_runtime_get_sync(bank->dev);
@@ -1284,40 +1280,18 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		if (!(bank->enabled_non_wakeup_gpios))
 			goto save_gpio_ctx;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
-					OMAP24XX_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		}
-
-		if (cpu_is_omap44xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
-						OMAP4_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-						OMAP4_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-						OMAP4_GPIO_RISINGDETECT);
-		}
+		bank->saved_datain = __raw_readl(bank->base +
+							bank->regs->datain);
+		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
+		l2 = __raw_readl(bank->base + bank->regs->risingdetect);
 
 		bank->saved_fallingdetect = l1;
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(l1, bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		}
-
-		if (cpu_is_omap44xx()) {
-			__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
-		}
+		__raw_writel(l1, bank->base + bank->regs->fallingdetect);
+		__raw_writel(l2, bank->base + bank->regs->risingdetect);
 
 		bank->off_mode_wkup_wa_enabled = true;
 
@@ -1357,21 +1331,11 @@ void omap2_gpio_resume_after_idle(void)
 		if (!(bank->enabled_non_wakeup_gpios))
 			goto restore_gpio_ctx;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(bank->saved_fallingdetect,
-				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
-				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
-		}
-
-		if (cpu_is_omap44xx()) {
-			__raw_writel(bank->saved_fallingdetect,
-				 bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
-				 bank->base + OMAP4_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
-		}
+		__raw_writel(bank->saved_fallingdetect,
+				bank->base + bank->regs->fallingdetect);
+		__raw_writel(bank->saved_risingdetect,
+				bank->base + bank->regs->risingdetect);
+		l = __raw_readl(bank->base + bank->regs->datain);
 
 		/* Check if any of the non-wakeup interrupt GPIOs have changed
 		 * state.  If so, generate an IRQ by software.  This is
@@ -1399,42 +1363,34 @@ void omap2_gpio_resume_after_idle(void)
 		if (gen) {
 			u32 old0, old1;
 
+			old0 = __raw_readl(bank->base +
+						bank->regs->leveldetect0);
+			old1 = __raw_readl(bank->base +
+						bank->regs->leveldetect1);
+
+			__raw_writel(old0, bank->base +
+						bank->regs->leveldetect0);
+			__raw_writel(old1, bank->base +
+						bank->regs->leveldetect1);
 			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-				old0 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				old1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-				__raw_writel(old0 | gen, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				__raw_writel(old1 | gen, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-				__raw_writel(old0, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				__raw_writel(old1, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
+				old0 |= gen;
+				old1 |= gen;
 			}
 
 			if (cpu_is_omap44xx()) {
-				old0 = __raw_readl(bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				old1 = __raw_readl(bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-				__raw_writel(old0 | l, bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				__raw_writel(old1 | l, bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-				__raw_writel(old0, bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				__raw_writel(old1, bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
+				old0 |= l;
+				old1 |= l;
 			}
+			__raw_writel(old0, bank->base +
+						bank->regs->leveldetect0);
+			__raw_writel(old1, bank->base +
+						bank->regs->leveldetect1);
 		}
 
 restore_gpio_ctx:
 		bank->off_mode_wkup_wa_enabled = false;
 		omap_gpio_restore_context(bank);
 	}
-
 }
 
 void omap_gpio_save_context(struct gpio_bank *bank)
-- 
1.6.0.4

