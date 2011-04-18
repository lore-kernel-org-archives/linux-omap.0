From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 4/7] OMAP: GPIO: handle save/restore ctx in GPIO driver
Date: Mon, 18 Apr 2011 20:36:54 +0530
Message-ID: <1303139217-10285-5-git-send-email-charu@ti.com>
References: <no>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43006 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab1DRPDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 11:03:53 -0400
In-Reply-To: <no>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, paul@pwsan.com, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Modify omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle()
functions to handle save context & restore context respectively in the
OMAP GPIO driver itself instead of calling these functions from pm specific
files. For this, in gpio_prepare_for_idle(), use
omap_device_get_context_loss_count() and in gpio_resume_after_idle()
call it again. If the count is different, do restore context.

context lost count is modified in omap_sram_idle() path when
pwrdm_post_transition() is called. But pwrdm_post_transition() is called
only after omap_gpio_resume_after_idle() is called. Hence correct this
so that context lost count is modified before calling
omap_gpio_resume_after_idle().

omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle()
do nothing if none of the GPIOs in a bank is being used.

Also remove usage of cpu_is_* checks from the above mentioned
functions and fix the multi-line comment style

Signed-off-by: Charulatha V <charu@ti.com>
---
Note that the usage of bank->method checks would be re-addressed
during OMAP GPIO cleanup series which would follow this patch series

 arch/arm/mach-omap2/pm34xx.c           |   22 +---
 arch/arm/plat-omap/gpio.c              |  226 ++++++++++++++++---------------
 arch/arm/plat-omap/include/plat/gpio.h |    2 -
 3 files changed, 122 insertions(+), 128 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0c5e3a4..682d147 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -91,16 +91,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
 
-static inline void omap3_per_save_context(void)
-{
-	omap_gpio_save_context();
-}
-
-static inline void omap3_per_restore_context(void)
-{
-	omap_gpio_restore_context();
-}
-
 static void omap3_enable_io_chain(void)
 {
 	int timeout = 0;
@@ -395,8 +385,10 @@ void omap_sram_idle(void)
 	if (!is_suspending())
 		if (per_next_state < PWRDM_POWER_ON ||
 		    core_next_state < PWRDM_POWER_ON)
-			if (!console_trylock())
+			if (!console_trylock()) {
+				pwrdm_post_transition();
 				goto console_still_active;
+			}
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -404,8 +396,6 @@ void omap_sram_idle(void)
 		omap_uart_prepare_idle(2);
 		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_going_off);
-		if (per_next_state == PWRDM_POWER_OFF)
-				omap3_per_save_context();
 	}
 
 	/* CORE */
@@ -467,12 +457,12 @@ void omap_sram_idle(void)
 	}
 	omap3_intc_resume_idle();
 
+	pwrdm_post_transition();
+
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
 		omap2_gpio_resume_after_idle();
-		if (per_prev_state == PWRDM_POWER_OFF)
-			omap3_per_restore_context();
 		omap_uart_resume_idle(2);
 		omap_uart_resume_idle(3);
 	}
@@ -490,8 +480,6 @@ console_still_active:
 		omap3_disable_io_chain();
 	}
 
-	pwrdm_post_transition();
-
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index e68da08..5d4ed6c 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -24,6 +24,8 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 
+#include <plat/omap_device.h>
+
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <mach/irqs.h>
@@ -173,6 +175,7 @@ struct gpio_bank {
 	bool dbck_flag;
 	int stride;
 	bool looses_context;
+	u32 ctx_lost_cnt_before;
 };
 
 /*
@@ -1852,6 +1855,8 @@ static struct sys_device omap_gpio_device = {
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
+static void omap_gpio_save_context(struct gpio_bank *bank);
+static void omap_gpio_restore_context(struct gpio_bank *bank);
 
 static int workaround_enabled;
 
@@ -1861,9 +1866,14 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
+		struct platform_device *pdev;
 		u32 l1 = 0, l2 = 0;
 		int j;
 
+		/* If the gpio bank is not used, do nothing */
+		if (!bank->mod_usage)
+			continue;
+
 		if (!bank->looses_context)
 			continue;
 
@@ -1873,22 +1883,22 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		if (!off_mode)
 			continue;
 
-		/* If going to OFF, remove triggering for all
+		/*
+		 * If going to OFF, remove triggering for all
 		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
-		 * generated.  See OMAP2420 Errata item 1.101. */
+		 * generated.  See OMAP2420 Errata item 1.101.
+		 */
 		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
+			goto save_gpio_ctx;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		if (bank->method == METHOD_GPIO_24XX) {
 			bank->saved_datain = __raw_readl(bank->base +
 					OMAP24XX_GPIO_DATAIN);
 			l1 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_FALLINGDETECT);
 			l2 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_RISINGDETECT);
-		}
-
-		if (cpu_is_omap44xx()) {
+		} else if (bank->method == METHOD_GPIO_44XX) {
 			bank->saved_datain = __raw_readl(bank->base +
 						OMAP4_GPIO_DATAIN);
 			l1 = __raw_readl(bank->base +
@@ -1902,19 +1912,23 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		if (bank->method == METHOD_GPIO_24XX) {
 			__raw_writel(l1, bank->base +
 					OMAP24XX_GPIO_FALLINGDETECT);
 			__raw_writel(l2, bank->base +
 					OMAP24XX_GPIO_RISINGDETECT);
-		}
-
-		if (cpu_is_omap44xx()) {
+		} else if (bank->method == METHOD_GPIO_44XX) {
 			__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
 			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
 		}
 
 		c++;
+
+save_gpio_ctx:
+		pdev = to_platform_device(bank->dev);
+		bank->ctx_lost_cnt_before =
+				omap_device_get_context_loss_count(pdev);
+		omap_gpio_save_context(bank);
 	}
 	if (!c) {
 		workaround_enabled = 0;
@@ -1926,33 +1940,43 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 void omap2_gpio_resume_after_idle(void)
 {
 	int i;
+	u32 ctx_lost_cnt_after;
 
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
+		struct platform_device *pdev;
 		u32 l = 0, gen, gen0, gen1;
 		int j;
 
+		/* If the gpio bank is not used, do nothing */
+		if (!bank->mod_usage)
+			continue;
+
 		if (!bank->looses_context)
 			continue;
 
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
-		if (!workaround_enabled)
+		pdev = to_platform_device(bank->dev);
+		ctx_lost_cnt_after = omap_device_get_context_loss_count(pdev);
+
+		if (ctx_lost_cnt_after == bank->ctx_lost_cnt_before)
 			continue;
 
+		if (!workaround_enabled)
+			goto restore_gpio_ctx;
+
 		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
+			goto restore_gpio_ctx;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		if (bank->method == METHOD_GPIO_24XX) {
 			__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 			__raw_writel(bank->saved_risingdetect,
 				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
 			l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
-		}
-
-		if (cpu_is_omap44xx()) {
+		} else if (bank->method == METHOD_GPIO_44XX) {
 			__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP4_GPIO_FALLINGDETECT);
 			__raw_writel(bank->saved_risingdetect,
@@ -1960,10 +1984,12 @@ void omap2_gpio_resume_after_idle(void)
 			l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
 		}
 
-		/* Check if any of the non-wakeup interrupt GPIOs have changed
+		/*
+		 * Check if any of the non-wakeup interrupt GPIOs have changed
 		 * state.  If so, generate an IRQ by software.  This is
 		 * horribly racy, but it's the best we can do to work around
-		 * this silicon bug. */
+		 * this silicon bug.
+		 */
 		l ^= bank->saved_datain;
 		l &= bank->enabled_non_wakeup_gpios;
 
@@ -1986,7 +2012,7 @@ void omap2_gpio_resume_after_idle(void)
 		if (gen) {
 			u32 old0, old1;
 
-			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			if (bank->method == METHOD_GPIO_24XX) {
 				old0 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
 				old1 = __raw_readl(bank->base +
@@ -1999,9 +2025,7 @@ void omap2_gpio_resume_after_idle(void)
 					OMAP24XX_GPIO_LEVELDETECT0);
 				__raw_writel(old1, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			}
-
-			if (cpu_is_omap44xx()) {
+			} else if (bank->method == METHOD_GPIO_44XX) {
 				old0 = __raw_readl(bank->base +
 						OMAP4_GPIO_LEVELDETECT0);
 				old1 = __raw_readl(bank->base +
@@ -2016,123 +2040,107 @@ void omap2_gpio_resume_after_idle(void)
 						OMAP4_GPIO_LEVELDETECT1);
 			}
 		}
+
+restore_gpio_ctx:
+		omap_gpio_restore_context(bank);
 	}
 
 }
 
-#endif
-
-void omap_gpio_save_context(void)
+void omap_gpio_save_context(struct gpio_bank *bank)
 {
-	int i;
-
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
-
-		if (!bank->looses_context)
-			continue;
-
-		if (bank->method == METHOD_GPIO_24XX) {
-			bank->context.irqenable1 = __raw_readl(
+	if (bank->method == METHOD_GPIO_24XX) {
+		bank->context.irqenable1 = __raw_readl(
 					bank->base + OMAP24XX_GPIO_IRQENABLE1);
-			bank->context.irqenable2 = __raw_readl(
+		bank->context.irqenable2 = __raw_readl(
 					bank->base + OMAP24XX_GPIO_IRQENABLE2);
-			bank->context.wake_en = __raw_readl(
+		bank->context.wake_en = __raw_readl(
 					bank->base + OMAP24XX_GPIO_WAKE_EN);
-			bank->context.ctrl = __raw_readl(
+		bank->context.ctrl = __raw_readl(
 					bank->base + OMAP24XX_GPIO_CTRL);
-			bank->context.oe = __raw_readl(
+		bank->context.oe = __raw_readl(
 					bank->base + OMAP24XX_GPIO_OE);
-			bank->context.leveldetect0 = __raw_readl(bank->base +
+		bank->context.leveldetect0 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-			bank->context.leveldetect1 = __raw_readl(bank->base +
+		bank->context.leveldetect1 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			bank->context.risingdetect = __raw_readl(bank->base +
+		bank->context.risingdetect = __raw_readl(bank->base +
 					OMAP24XX_GPIO_RISINGDETECT);
-			bank->context.fallingdetect = __raw_readl(bank->base +
+		bank->context.fallingdetect = __raw_readl(bank->base +
 					OMAP24XX_GPIO_FALLINGDETECT);
-			bank->context.dataout = __raw_readl(
+		bank->context.dataout = __raw_readl(
 					bank->base + OMAP24XX_GPIO_DATAOUT);
-		} else if (bank->method == METHOD_GPIO_44XX) {
-			bank->context.irqenable1 = __raw_readl(
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		bank->context.irqenable1 = __raw_readl(
 					bank->base + OMAP4_GPIO_IRQSTATUSSET0);
-			bank->context.irqenable2 = __raw_readl(
+		bank->context.irqenable2 = __raw_readl(
 					bank->base + OMAP4_GPIO_IRQSTATUSSET1);
-			bank->context.wake_en = __raw_readl(
+		bank->context.wake_en = __raw_readl(
 					bank->base + OMAP4_GPIO_IRQWAKEN0);
-			bank->context.ctrl = __raw_readl(
+		bank->context.ctrl = __raw_readl(
 					bank->base + OMAP4_GPIO_CTRL);
-			bank->context.oe = __raw_readl(
+		bank->context.oe = __raw_readl(
 					bank->base + OMAP24XX_GPIO_OE);
-			bank->context.leveldetect0 = __raw_readl(bank->base +
+		bank->context.leveldetect0 = __raw_readl(bank->base +
 					OMAP4_GPIO_LEVELDETECT0);
-			bank->context.leveldetect1 = __raw_readl(bank->base +
+		bank->context.leveldetect1 = __raw_readl(bank->base +
 					OMAP4_GPIO_LEVELDETECT1);
-			bank->context.risingdetect = __raw_readl(bank->base +
+		bank->context.risingdetect = __raw_readl(bank->base +
 					OMAP4_GPIO_RISINGDETECT);
-			bank->context.fallingdetect = __raw_readl(bank->base +
+		bank->context.fallingdetect = __raw_readl(bank->base +
 					OMAP4_GPIO_FALLINGDETECT);
-			bank->context.dataout = __raw_readl(
+		bank->context.dataout = __raw_readl(
 					bank->base + OMAP4_GPIO_DATAOUT);
-		}
 	}
 }
 
-void omap_gpio_restore_context(void)
+void omap_gpio_restore_context(struct gpio_bank *bank)
 {
-	int i;
-
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
-
-		if (!bank->looses_context)
-			continue;
-
-		if (bank->method == METHOD_GPIO_24XX) {
-			__raw_writel(bank->context.irqenable1, bank->base +
-						OMAP24XX_GPIO_IRQENABLE1);
-			__raw_writel(bank->context.irqenable2, bank->base +
-						OMAP24XX_GPIO_IRQENABLE2);
-			__raw_writel(bank->context.wake_en, bank->base +
-						OMAP24XX_GPIO_WAKE_EN);
-			__raw_writel(bank->context.ctrl, bank->base +
-						OMAP24XX_GPIO_CTRL);
-			__raw_writel(bank->context.oe, bank->base +
-						OMAP24XX_GPIO_OE);
-			__raw_writel(bank->context.leveldetect0, bank->base +
-						OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(bank->context.leveldetect1, bank->base +
-						OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(bank->context.risingdetect, bank->base +
-						OMAP24XX_GPIO_RISINGDETECT);
-			__raw_writel(bank->context.fallingdetect, bank->base +
-						OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(bank->context.dataout, bank->base +
-						OMAP24XX_GPIO_DATAOUT);
-		} else if (bank->method == METHOD_GPIO_44XX) {
-			__raw_writel(bank->context.irqenable1, bank->base +
-						OMAP4_GPIO_IRQSTATUSSET0);
-			__raw_writel(bank->context.irqenable2, bank->base +
-						OMAP4_GPIO_IRQSTATUSSET1);
-			__raw_writel(bank->context.wake_en, bank->base +
-						OMAP4_GPIO_IRQWAKEN0);
-			__raw_writel(bank->context.ctrl, bank->base +
-						OMAP4_GPIO_CTRL);
-			__raw_writel(bank->context.oe, bank->base +
-						OMAP24XX_GPIO_OE);
-			__raw_writel(bank->context.leveldetect0, bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-			__raw_writel(bank->context.leveldetect1, bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-			__raw_writel(bank->context.risingdetect, bank->base +
-						OMAP4_GPIO_RISINGDETECT);
-			__raw_writel(bank->context.fallingdetect, bank->base +
-						OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(bank->context.dataout, bank->base +
-						OMAP4_GPIO_DATAOUT);
-		}
+	if (bank->method == METHOD_GPIO_24XX) {
+		__raw_writel(bank->context.irqenable1, bank->base +
+					OMAP24XX_GPIO_IRQENABLE1);
+		__raw_writel(bank->context.irqenable2, bank->base +
+					OMAP24XX_GPIO_IRQENABLE2);
+		__raw_writel(bank->context.wake_en, bank->base +
+					OMAP24XX_GPIO_WAKE_EN);
+		__raw_writel(bank->context.ctrl, bank->base +
+					OMAP24XX_GPIO_CTRL);
+		__raw_writel(bank->context.oe, bank->base +
+					OMAP24XX_GPIO_OE);
+		__raw_writel(bank->context.leveldetect0, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+		__raw_writel(bank->context.leveldetect1, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
+		__raw_writel(bank->context.risingdetect, bank->base +
+					OMAP24XX_GPIO_RISINGDETECT);
+		__raw_writel(bank->context.fallingdetect, bank->base +
+					OMAP24XX_GPIO_FALLINGDETECT);
+		__raw_writel(bank->context.dataout, bank->base +
+					OMAP24XX_GPIO_DATAOUT);
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		__raw_writel(bank->context.irqenable1, bank->base +
+					OMAP4_GPIO_IRQSTATUSSET0);
+		__raw_writel(bank->context.irqenable2, bank->base +
+					OMAP4_GPIO_IRQSTATUSSET1);
+		__raw_writel(bank->context.wake_en, bank->base +
+					OMAP4_GPIO_IRQWAKEN0);
+		__raw_writel(bank->context.ctrl, bank->base +
+					OMAP4_GPIO_CTRL);
+		__raw_writel(bank->context.oe, bank->base +
+					OMAP24XX_GPIO_OE);
+		__raw_writel(bank->context.leveldetect0, bank->base +
+					OMAP4_GPIO_LEVELDETECT0);
+		__raw_writel(bank->context.leveldetect1, bank->base +
+					OMAP4_GPIO_LEVELDETECT1);
+		__raw_writel(bank->context.risingdetect, bank->base +
+					OMAP4_GPIO_RISINGDETECT);
+		__raw_writel(bank->context.fallingdetect, bank->base +
+					OMAP4_GPIO_FALLINGDETECT);
+		__raw_writel(bank->context.dataout, bank->base +
+					OMAP4_GPIO_DATAOUT);
 	}
 }
+#endif
 
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 15aeb71..84b9106 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -87,8 +87,6 @@ extern void omap2_gpio_prepare_for_idle(int off_mode);
 extern void omap2_gpio_resume_after_idle(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
-extern void omap_gpio_save_context(void);
-extern void omap_gpio_restore_context(void);
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure
-- 
1.7.1

