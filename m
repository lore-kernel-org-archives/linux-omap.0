From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] OMAP: GPIO: Avoid generating extra IRQs
Date: Fri,  3 Jul 2009 09:26:33 +0300
Message-ID: <1246602393-8812-1-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36483 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbZGCG1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jul 2009 02:27:05 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n636Pvmx001583
	for <linux-omap@vger.kernel.org>; Fri, 3 Jul 2009 01:27:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

It is possible for GPIO IRQ lines configured with
falling edge triggering only to get IRQs at the
rising edge upon the exit of offmode. And vice
versa. Prevent such IRQs to arrive by generating
the IRQ obeying the detection scheme.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/plat-omap/gpio.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 26b387c..7a270c0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1804,7 +1804,7 @@ void omap2_gpio_resume_after_retention(void)
 		return;
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l;
+		u32 l, gen, gen0, gen1;
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
@@ -1825,14 +1825,33 @@ void omap2_gpio_resume_after_retention(void)
 #endif
 		l ^= bank->saved_datain;
 		l &= bank->non_wakeup_gpios;
-		if (l) {
+
+		/*
+		 * No need to generate IRQs for the rising edge for gpio IRQs
+		 * configured with falling edge only; and vice versa.
+		 */
+		gen0 = l & bank->saved_fallingdetect;
+		gen0 &= bank->saved_datain;
+
+		gen1 = l & bank->saved_risingdetect;
+		gen1 &= ~(bank->saved_datain);
+
+		/* FIXME: Consider GPIO IRQs with level detections properly! */
+		gen = l & (~(bank->saved_fallingdetect) &
+				~(bank->saved_risingdetect));
+		/* Consider all GPIO IRQs needed to be updated */
+		gen |= gen0 | gen1;
+
+		if (gen) {
 			u32 old0, old1;
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
 			defined(CONFIG_ARCH_OMAP4)
 			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+			__raw_writel(old0 | gen, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+			__raw_writel(old1 | gen, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			__raw_writel(old1, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 #endif
-- 
1.6.0.4

