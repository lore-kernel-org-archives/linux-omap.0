From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 07/15] OMAP: GPIO: handle save/restore ctx in GPIO driver
Date: Tue, 24 May 2011 19:54:46 +0530
Message-ID: <1306247094-25372-8-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43545 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932147Ab1EXOZZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:25 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

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
 arch/arm/mach-omap2/pm34xx.c           |   22 +----
 arch/arm/plat-omap/include/plat/gpio.h |    2 -
 drivers/gpio/gpio_omap.c               |  138 +++++++++++++++++---------------
 3 files changed, 78 insertions(+), 84 deletions(-)

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
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 64b1ee7..5718a45 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -209,8 +209,6 @@ extern void omap2_gpio_prepare_for_idle(int off_mode);
 extern void omap2_gpio_resume_after_idle(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
-extern void omap_gpio_save_context(void);
-extern void omap_gpio_restore_context(void);
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 9d55b7d..bc02ec5 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 
+#include <plat/omap_device.h>
+
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <mach/irqs.h>
@@ -72,6 +74,7 @@ struct gpio_bank {
 	bool loses_context;
 	int stride;
 	u32 width;
+	u32 ctx_lost_cnt_before;
 	u16 id;
 
 	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
@@ -1310,6 +1313,9 @@ static struct sys_device omap_gpio_device = {
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
+static void omap_gpio_save_context(struct gpio_bank *bank);
+static void omap_gpio_restore_context(struct gpio_bank *bank);
+
 static int workaround_enabled;
 
 void omap2_gpio_prepare_for_idle(int off_mode)
@@ -1318,6 +1324,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
+		struct platform_device *pdev;
 		u32 l1 = 0, l2 = 0;
 		int j;
 
@@ -1334,7 +1341,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
 		 * generated.  See OMAP2420 Errata item 1.101. */
 		if (!(bank->enabled_non_wakeup_gpios))
-			continue;
+			goto save_gpio_ctx;
 
 		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 			bank->saved_datain = __raw_readl(bank->base +
@@ -1372,6 +1379,12 @@ void omap2_gpio_prepare_for_idle(int off_mode)
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
@@ -1385,6 +1398,8 @@ void omap2_gpio_resume_after_idle(void)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
+		u32 ctx_lost_cnt_after;
+		struct platform_device *pdev;
 		u32 l = 0, gen, gen0, gen1;
 		int j;
 
@@ -1394,11 +1409,17 @@ void omap2_gpio_resume_after_idle(void)
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
 
 		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 			__raw_writel(bank->saved_fallingdetect,
@@ -1472,117 +1493,104 @@ void omap2_gpio_resume_after_idle(void)
 						OMAP4_GPIO_LEVELDETECT1);
 			}
 		}
+
+restore_gpio_ctx:
+		omap_gpio_restore_context(bank);
 	}
 
 }
 
-void omap_gpio_save_context(void)
+void omap_gpio_save_context(struct gpio_bank *bank)
 {
-	struct gpio_bank *bank;
-
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-
-		if (!bank->loses_context)
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
-	struct gpio_bank *bank;
-
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-
-		if (!bank->loses_context)
-			continue;
-
-		if (bank->method == METHOD_GPIO_24XX) {
-			__raw_writel(bank->context.irqenable1, bank->base +
+	if (bank->method == METHOD_GPIO_24XX) {
+		__raw_writel(bank->context.irqenable1, bank->base +
 						OMAP24XX_GPIO_IRQENABLE1);
-			__raw_writel(bank->context.irqenable2, bank->base +
+		__raw_writel(bank->context.irqenable2, bank->base +
 						OMAP24XX_GPIO_IRQENABLE2);
-			__raw_writel(bank->context.wake_en, bank->base +
+		__raw_writel(bank->context.wake_en, bank->base +
 						OMAP24XX_GPIO_WAKE_EN);
-			__raw_writel(bank->context.ctrl, bank->base +
+		__raw_writel(bank->context.ctrl, bank->base +
 						OMAP24XX_GPIO_CTRL);
-			__raw_writel(bank->context.oe, bank->base +
+		__raw_writel(bank->context.oe, bank->base +
 						OMAP24XX_GPIO_OE);
-			__raw_writel(bank->context.leveldetect0, bank->base +
+		__raw_writel(bank->context.leveldetect0, bank->base +
 						OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(bank->context.leveldetect1, bank->base +
+		__raw_writel(bank->context.leveldetect1, bank->base +
 						OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(bank->context.risingdetect, bank->base +
+		__raw_writel(bank->context.risingdetect, bank->base +
 						OMAP24XX_GPIO_RISINGDETECT);
-			__raw_writel(bank->context.fallingdetect, bank->base +
+		__raw_writel(bank->context.fallingdetect, bank->base +
 						OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(bank->context.dataout, bank->base +
+		__raw_writel(bank->context.dataout, bank->base +
 						OMAP24XX_GPIO_DATAOUT);
-		} else if (bank->method == METHOD_GPIO_44XX) {
-			__raw_writel(bank->context.irqenable1, bank->base +
+	} else if (bank->method == METHOD_GPIO_44XX) {
+		__raw_writel(bank->context.irqenable1, bank->base +
 						OMAP4_GPIO_IRQSTATUSSET0);
-			__raw_writel(bank->context.irqenable2, bank->base +
+		__raw_writel(bank->context.irqenable2, bank->base +
 						OMAP4_GPIO_IRQSTATUSSET1);
-			__raw_writel(bank->context.wake_en, bank->base +
+		__raw_writel(bank->context.wake_en, bank->base +
 						OMAP4_GPIO_IRQWAKEN0);
-			__raw_writel(bank->context.ctrl, bank->base +
+		__raw_writel(bank->context.ctrl, bank->base +
 						OMAP4_GPIO_CTRL);
-			__raw_writel(bank->context.oe, bank->base +
+		__raw_writel(bank->context.oe, bank->base +
 						OMAP24XX_GPIO_OE);
-			__raw_writel(bank->context.leveldetect0, bank->base +
+		__raw_writel(bank->context.leveldetect0, bank->base +
 						OMAP4_GPIO_LEVELDETECT0);
-			__raw_writel(bank->context.leveldetect1, bank->base +
+		__raw_writel(bank->context.leveldetect1, bank->base +
 						OMAP4_GPIO_LEVELDETECT1);
-			__raw_writel(bank->context.risingdetect, bank->base +
+		__raw_writel(bank->context.risingdetect, bank->base +
 						OMAP4_GPIO_RISINGDETECT);
-			__raw_writel(bank->context.fallingdetect, bank->base +
+		__raw_writel(bank->context.fallingdetect, bank->base +
 						OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(bank->context.dataout, bank->base +
+		__raw_writel(bank->context.dataout, bank->base +
 						OMAP4_GPIO_DATAOUT);
-		}
 	}
 }
 
-- 
1.6.0.4

