From: Charulatha V <charu@ti.com>
Subject: [PATCH 4/5] OMAP: GPIO: call save/restore ctxt from GPIO driver
Date: Mon, 28 Feb 2011 16:27:49 +0530
Message-ID: <1298890670-5481-5-git-send-email-charu@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54289 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab1B1K4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 05:56:33 -0500
In-Reply-To: <1298890670-5481-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Make gpio_prepare_for_idle() & gpio_resume_after_idle() functions
handle save context & restore context respectively in OMAP GPIO driver
instead of calling these functions directly from pm layer. This would
be useful while modifying the OMAP GPIO driver to use PM runtime framework.

Also modfiy gpio_prepare_for_idle() & gpio_resume_after_idle()
to do nothing if none of the GPIOs in a bank is being used.

Also remove usage of cpu_is_* checks from the above mentioned
functions

Signed-off-by: Charulatha V <charu@ti.com>

Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
(2430-SDP testing)
---
 arch/arm/mach-omap2/pm24xx.c           |    2 +-
 arch/arm/mach-omap2/pm34xx.c           |   20 +---
 arch/arm/plat-omap/gpio.c              |  218 ++++++++++++++++----------------
 arch/arm/plat-omap/include/plat/gpio.h |    4 +-
 4 files changed, 113 insertions(+), 131 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 97feb3a..b71072d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -162,7 +162,7 @@ no_sleep:
 		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
 		omap2_pm_dump(0, 1, tmp);
 	}
-	omap2_gpio_resume_after_idle();
+	omap2_gpio_resume_after_idle(0);
 
 	clk_enable(osc_ck);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2f864e4..07af07e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -90,16 +90,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
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
@@ -408,8 +398,6 @@ void omap_sram_idle(void)
 		omap_uart_prepare_idle(2);
 		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_going_off);
-		if (per_next_state == PWRDM_POWER_OFF)
-				omap3_per_save_context();
 	}
 
 	/* CORE */
@@ -473,10 +461,12 @@ void omap_sram_idle(void)
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
+		int is_per_prev_state_off;
+
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
-		omap2_gpio_resume_after_idle();
-		if (per_prev_state == PWRDM_POWER_OFF)
-			omap3_per_restore_context();
+		is_per_prev_state_off = (per_prev_state ==
+						PWRDM_POWER_OFF) ? 1 : 0;
+		omap2_gpio_resume_after_idle(is_per_prev_state_off);
 		omap_uart_resume_idle(2);
 		omap_uart_resume_idle(3);
 	}
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 1da3233..10792b6 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -175,6 +175,9 @@ struct gpio_bank {
 	const char *pwrdm_name;
 };
 
+static void omap_gpio_save_context(struct gpio_bank *bank);
+static void omap_gpio_restore_context(struct gpio_bank *bank);
+
 /*
  * TODO: Cleanup gpio_bank usage as it is having information
  * related to all instances of the device
@@ -1860,8 +1863,6 @@ static struct sys_device omap_gpio_device = {
 
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
 static int workaround_enabled;
 
 void omap2_gpio_prepare_for_idle(int off_mode)
@@ -1873,6 +1874,10 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		u32 l1 = 0, l2 = 0;
 		int j;
 
+		/* If the gpio bank is not used, do nothing */
+		if (!bank->mod_usage)
+			continue;
+
 		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
 			continue;
 
@@ -1882,22 +1887,22 @@ void omap2_gpio_prepare_for_idle(int off_mode)
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
@@ -1911,19 +1916,20 @@ void omap2_gpio_prepare_for_idle(int off_mode)
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
+		omap_gpio_save_context(bank);
 	}
 	if (!c) {
 		workaround_enabled = 0;
@@ -1932,7 +1938,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 	workaround_enabled = 1;
 }
 
-void omap2_gpio_resume_after_idle(void)
+void omap2_gpio_resume_after_idle(int off_mode)
 {
 	int i;
 
@@ -1941,27 +1947,32 @@ void omap2_gpio_resume_after_idle(void)
 		u32 l = 0, gen, gen0, gen1;
 		int j;
 
+		/* If the gpio bank is not used, do nothing */
+		if (!bank->mod_usage)
+			continue;
+
 		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
 			continue;
 
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
-		if (!workaround_enabled)
+		if (!off_mode)
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
@@ -1969,10 +1980,12 @@ void omap2_gpio_resume_after_idle(void)
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
 
@@ -1995,7 +2008,7 @@ void omap2_gpio_resume_after_idle(void)
 		if (gen) {
 			u32 old0, old1;
 
-			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			if (bank->method == METHOD_GPIO_24XX) {
 				old0 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
 				old1 = __raw_readl(bank->base +
@@ -2008,9 +2021,7 @@ void omap2_gpio_resume_after_idle(void)
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
@@ -2025,121 +2036,104 @@ void omap2_gpio_resume_after_idle(void)
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
-		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
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
-		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
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
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 2c46caa..00a9d02 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -84,11 +84,9 @@ struct omap_gpio_platform_data {
 extern int gpio_bank_count;
 
 extern void omap2_gpio_prepare_for_idle(int off_mode);
-extern void omap2_gpio_resume_after_idle(void);
+extern void omap2_gpio_resume_after_idle(int off_mode);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
-extern void omap_gpio_save_context(void);
-extern void omap_gpio_restore_context(void);
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure
-- 
1.7.1

