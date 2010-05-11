From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/6] OMAP3: GPIO fixes for off-mode
Date: Tue, 11 May 2010 16:30:47 -0700
Message-ID: <1273620652-15927-2-git-send-email-khilman@deeprootsystems.com>
References: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35206 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab0EKXa5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:30:57 -0400
Received: by mail-pv0-f174.google.com with SMTP id 11so99806pvh.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:30:57 -0700 (PDT)
In-Reply-To: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

Off mode is now using the omap2 retention fix code for scanning GPIOs
during off-mode transitions. All the *non_wakeup_gpios variables
are now used for off-mode transition tracking on OMAP3. This patch fixes
cases where GPIO state changes are missed during off-mode.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   10 ++++++----
 arch/arm/plat-omap/gpio.c    |   19 ++++++++++++++-----
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ea0000b..5de07db 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -376,14 +376,15 @@ void omap_sram_idle(void)
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
-		omap2_gpio_prepare_for_retention();
 		if (per_next_state == PWRDM_POWER_OFF) {
 			if (core_next_state == PWRDM_POWER_ON) {
 				per_next_state = PWRDM_POWER_RET;
 				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
 				per_state_modified = 1;
-			} else
+			} else {
+				omap2_gpio_prepare_for_retention();
 				omap3_per_save_context();
+			}
 		}
 	}
 
@@ -454,9 +455,10 @@ void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
-		if (per_prev_state == PWRDM_POWER_OFF)
+		if (per_prev_state == PWRDM_POWER_OFF) {
 			omap3_per_restore_context();
-		omap2_gpio_resume_after_retention();
+			omap2_gpio_resume_after_retention();
+		}
 		omap_uart_resume_idle(2);
 		if (per_state_modified)
 			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 45a225d..6216f4f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -731,7 +731,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 				__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_CLEARWKUENA);
 		}
-	} else {
+	}
+	/* This part needs to be executed always for OMAP34xx */
+	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
 		if (trigger != 0)
 			bank->enabled_non_wakeup_gpios |= gpio_bit;
 		else
@@ -1845,7 +1847,8 @@ static int __init _omap_gpio_init(void)
 				__raw_writel(0, bank->base +
 						OMAP24XX_GPIO_CTRL);
 			}
-			if (i < ARRAY_SIZE(non_wakeup_gpios))
+			if (cpu_is_omap24xx() &&
+			    i < ARRAY_SIZE(non_wakeup_gpios))
 				bank->non_wakeup_gpios = non_wakeup_gpios[i];
 			gpio_count = 32;
 		}
@@ -2031,10 +2034,13 @@ static int workaround_enabled;
 void omap2_gpio_prepare_for_retention(void)
 {
 	int i, c = 0;
+	int min = 0;
 
+	if (cpu_is_omap34xx())
+		min = 1;
 	/* Remove triggering for all non-wakeup GPIOs.  Otherwise spurious
 	 * IRQs will be generated.  See OMAP2420 Errata item 1.101. */
-	for (i = 0; i < gpio_bank_count; i++) {
+	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l1, l2;
 
@@ -2088,10 +2094,13 @@ void omap2_gpio_prepare_for_retention(void)
 void omap2_gpio_resume_after_retention(void)
 {
 	int i;
+	int min = 0;
 
 	if (!workaround_enabled)
 		return;
-	for (i = 0; i < gpio_bank_count; i++) {
+	if (cpu_is_omap34xx())
+		min = 1;
+	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l, gen, gen0, gen1;
 
@@ -2119,7 +2128,7 @@ void omap2_gpio_resume_after_retention(void)
 		 * horribly racy, but it's the best we can do to work around
 		 * this silicon bug. */
 		l ^= bank->saved_datain;
-		l &= bank->non_wakeup_gpios;
+		l &= bank->enabled_non_wakeup_gpios;
 
 		/*
 		 * No need to generate IRQs for the rising edge for gpio IRQs
-- 
1.7.0.2

