From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/6] OMAP2/3: GPIO: generalize prepare for idle
Date: Tue, 11 May 2010 16:30:49 -0700
Message-ID: <1273620652-15927-4-git-send-email-khilman@deeprootsystems.com>
References: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39468 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab0EKXbC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:31:02 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so2565614pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:31:02 -0700 (PDT)
In-Reply-To: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Currently, the GPIO 'prepare' hook is only called when going to
off-mode, while the function is called 'prepare_for_retention.'  This
patch renames the function to 'prepare_for_idle' and calls it for any
powersate != PWRDM_POWER_ON passing in the powerstate.

The hook itself is then responsible for doing various preparation
based on the powerstate.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm24xx.c           |    4 ++--
 arch/arm/mach-omap2/pm34xx.c           |   10 ++++------
 arch/arm/plat-omap/gpio.c              |   19 +++++++++++++------
 arch/arm/plat-omap/include/plat/gpio.h |    4 ++--
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 374299e..7816c4e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -107,7 +107,7 @@ static void omap2_enter_full_retention(void)
 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
 	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
 
-	omap2_gpio_prepare_for_retention();
+	omap2_gpio_prepare_for_idle(PWRDM_POWER_RET);
 
 	if (omap2_pm_debug) {
 		omap2_pm_dump(0, 0, 0);
@@ -141,7 +141,7 @@ no_sleep:
 		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
 		omap2_pm_dump(0, 1, tmp);
 	}
-	omap2_gpio_resume_after_retention();
+	omap2_gpio_resume_after_idle();
 
 	clk_enable(osc_ck);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5de07db..468e1e3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -376,15 +376,14 @@ void omap_sram_idle(void)
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
+		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF) {
 			if (core_next_state == PWRDM_POWER_ON) {
 				per_next_state = PWRDM_POWER_RET;
 				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
 				per_state_modified = 1;
-			} else {
-				omap2_gpio_prepare_for_retention();
+			} else
 				omap3_per_save_context();
-			}
 		}
 	}
 
@@ -455,10 +454,9 @@ void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
-		if (per_prev_state == PWRDM_POWER_OFF) {
+		omap2_gpio_resume_after_idle();
+		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
-			omap2_gpio_resume_after_retention();
-		}
 		omap_uart_resume_idle(2);
 		if (per_state_modified)
 			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 2f185ff..1c81340 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -27,6 +27,7 @@
 #include <mach/irqs.h>
 #include <mach/gpio.h>
 #include <asm/mach/irq.h>
+#include <plat/powerdomain.h>
 
 /*
  * OMAP1510 GPIO registers
@@ -2041,19 +2042,24 @@ static struct sys_device omap_gpio_device = {
 
 static int workaround_enabled;
 
-void omap2_gpio_prepare_for_retention(void)
+void omap2_gpio_prepare_for_idle(int power_state)
 {
 	int i, c = 0;
 	int min = 0;
 
 	if (cpu_is_omap34xx())
 		min = 1;
-	/* Remove triggering for all non-wakeup GPIOs.  Otherwise spurious
-	 * IRQs will be generated.  See OMAP2420 Errata item 1.101. */
+
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l1, l2;
 
+		if (power_state > PWRDM_POWER_OFF)
+			continue;
+
+		/* If going to OFF, remove triggering for all
+		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
+		 * generated.  See OMAP2420 Errata item 1.101. */
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
 
@@ -2101,19 +2107,20 @@ void omap2_gpio_prepare_for_retention(void)
 	workaround_enabled = 1;
 }
 
-void omap2_gpio_resume_after_retention(void)
+void omap2_gpio_resume_after_idle(void)
 {
 	int i;
 	int min = 0;
 
-	if (!workaround_enabled)
-		return;
 	if (cpu_is_omap34xx())
 		min = 1;
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l, gen, gen0, gen1;
 
+		if (!workaround_enabled)
+			continue;
+
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index de7c547..de1c604 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -72,8 +72,8 @@
 				 IH_GPIO_BASE + (nr))
 
 extern int omap_gpio_init(void);	/* Call from board init only */
-extern void omap2_gpio_prepare_for_retention(void);
-extern void omap2_gpio_resume_after_retention(void);
+extern void omap2_gpio_prepare_for_idle(int power_state);
+extern void omap2_gpio_resume_after_idle(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
 extern void omap_gpio_save_context(void);
-- 
1.7.0.2

