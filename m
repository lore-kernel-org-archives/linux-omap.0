From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: GPIO fixes for off-mode
Date: Mon, 22 Dec 2008 14:27:12 +0200
Message-ID: <1229948832-26695-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43289 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbYLVMe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 07:34:59 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBMCXJwQ011372
	for <linux-omap@vger.kernel.org>; Mon, 22 Dec 2008 06:34:57 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBMCYZHo026721
	for <linux-omap@vger.kernel.org>; Mon, 22 Dec 2008 14:34:35 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Off mode is now using the omap2 retention fix code for scanning GPIOs
during off-mode transitions. All the *non_wakeup_gpios variables
are now used for off-mode transition tracking on OMAP3. This patch fixes
cases where GPIO state changes are missed during off-mode.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   10 ++++++----
 arch/arm/plat-omap/gpio.c    |   29 ++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c67d770..66f2b22 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -330,14 +330,15 @@ void omap_sram_idle(void)
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
 
@@ -411,9 +412,10 @@ void omap_sram_idle(void)
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
index 83a5953..db40037 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -540,7 +540,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 		else
 			__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_CLEARWKUENA);
-	} else {
+	}
+	/* This part needs to be executed always for OMAP34xx */
+	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
 		if (trigger != 0)
 			bank->enabled_non_wakeup_gpios |= gpio_bit;
 		else
@@ -1456,7 +1458,8 @@ static int __init _omap_gpio_init(void)
 
 			/* Initialize interface clock ungated, module enabled */
 			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
-			if (i < ARRAY_SIZE(non_wakeup_gpios))
+			if (cpu_is_omap24xx() &&
+			    i < ARRAY_SIZE(non_wakeup_gpios))
 				bank->non_wakeup_gpios = non_wakeup_gpios[i];
 			gpio_count = 32;
 		}
@@ -1626,10 +1629,13 @@ static int workaround_enabled;
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
 
@@ -1644,10 +1650,12 @@ void omap2_gpio_prepare_for_retention(void)
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
-#endif
+		if (cpu_is_omap24xx()) {
+			__raw_writel(l1, bank->base +
+					OMAP24XX_GPIO_FALLINGDETECT);
+			__raw_writel(l2, bank->base +
+					OMAP24XX_GPIO_RISINGDETECT);
+		}
 		c++;
 	}
 	if (!c) {
@@ -1660,10 +1668,13 @@ void omap2_gpio_prepare_for_retention(void)
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
 		u32 l;
 
@@ -1683,7 +1694,7 @@ void omap2_gpio_resume_after_retention(void)
 		l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 #endif
 		l ^= bank->saved_datain;
-		l &= bank->non_wakeup_gpios;
+		l &= bank->enabled_non_wakeup_gpios;
 		if (l) {
 			u32 old0, old1;
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-- 
1.5.4.3

