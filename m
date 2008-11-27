From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: GPIO fixes for off-mode
Date: Thu, 27 Nov 2008 13:54:55 +0200
Message-ID: <1227786895-8097-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57156 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYK0L7O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 06:59:14 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mARBx1EJ027088
	for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2008 13:59:11 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mARBwwxl002663
	for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2008 13:58:58 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Off mode is now using the omap2 retention fix code for scanning GPIOs
only during off-mode transitions. All the *non_wakeup_gpios variables
are now used for off-mode transition tracking on OMAP3. This patch fixes
cases where GPIO state changes are missed during off-mode.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   10 ++++++----
 arch/arm/plat-omap/gpio.c    |   18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5723240..2aaa631 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -321,9 +321,10 @@ void omap_sram_idle(void)
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
-		omap2_gpio_prepare_for_retention();
-		if (per_next_state == PWRDM_POWER_OFF)
+		if (per_next_state == PWRDM_POWER_OFF) {
+			omap2_gpio_prepare_for_retention();
 			omap3_per_save_context();
+		}
 	}
 
 	/* CORE */
@@ -396,9 +397,10 @@ void omap_sram_idle(void)
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
 	}
 
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 62349fd..b45bf9d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -556,7 +556,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 		else
 			__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_CLEARWKUENA);
+#ifdef CONFIG_ARCH_OMAP24XX
 	} else {
+#endif
 		if (trigger != 0)
 			bank->enabled_non_wakeup_gpios |= gpio_bit;
 		else
@@ -1485,9 +1487,11 @@ static int __init _omap_gpio_init(void)
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		if (bank->method == METHOD_GPIO_24XX) {
+#ifdef CONFIG_ARCH_OMAP24XX
 			static const u32 non_wakeup_gpios[] = {
 				0xe203ffc0, 0x08700040
 			};
+#endif
 
 			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
 			__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
@@ -1495,8 +1499,10 @@ static int __init _omap_gpio_init(void)
 
 			/* Initialize interface clock ungated, module enabled */
 			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
+#ifdef CONFIG_ARCH_OMAP24XX
 			if (i < ARRAY_SIZE(non_wakeup_gpios))
 				bank->non_wakeup_gpios = non_wakeup_gpios[i];
+#endif
 			gpio_count = 32;
 		}
 #endif
@@ -1666,7 +1672,11 @@ void omap2_gpio_prepare_for_retention(void)
 
 	/* Remove triggering for all non-wakeup GPIOs.  Otherwise spurious
 	 * IRQs will be generated.  See OMAP2420 Errata item 1.101. */
+#ifdef CONFIG_ARCH_OMAP24XX
 	for (i = 0; i < gpio_bank_count; i++) {
+#else
+	for (i = 1; i < gpio_bank_count; i++) {
+#endif
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l1, l2;
 
@@ -1681,7 +1691,7 @@ void omap2_gpio_prepare_for_retention(void)
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX)
 		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
@@ -1700,7 +1710,11 @@ void omap2_gpio_resume_after_retention(void)
 
 	if (!workaround_enabled)
 		return;
+#ifdef CONFIG_ARCH_OMAP24XX
 	for (i = 0; i < gpio_bank_count; i++) {
+#else
+	for (i = 1; i < gpio_bank_count; i++) {
+#endif
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l;
 
@@ -1720,7 +1734,7 @@ void omap2_gpio_resume_after_retention(void)
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

