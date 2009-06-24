From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH -pm] OMAP3: GPIO: Only enable WAKEUPEN for edge detection GPIOs
Date: Wed, 24 Jun 2009 10:13:39 -0700
Message-ID: <1245863619-1222-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:53802 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZFXRNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 13:13:42 -0400
Received: by pzk27 with SMTP id 27so775544pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 24 Jun 2009 10:13:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Chunqiu Wang <cqwang@motorola.com>

From: Chunqiu Wang <cqwang@motorola.com>

According to the GPIO 'Wakeup and Interrupt' section of the TRM[1],
wake-up requests can only be generated on edge transitions.

Also for OMAP3, only edge GPIOs may lose interrupts when PER enters
RET/OFF state, this is addressed by gpio prepare|resume idle functions

[1] Section 25.5.3.1 OMAP34xx_ES3.1_TRM_V_Q

Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8e6f511..de61a13 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -684,7 +684,11 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 		trigger & IRQ_TYPE_EDGE_FALLING);
 
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		if (trigger != 0)
+		/*
+		 * GPIO wakeup request can only be generated on edge
+		 * transitions
+		 */
+		if (trigger & IRQ_TYPE_EDGE_BOTH)
 			__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_SETWKUENA);
 		else
@@ -693,7 +697,13 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 	}
 	/* This part needs to be executed always for OMAP34xx */
 	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
-		if (trigger != 0)
+		/*
+		 * Log the edge gpio and manually trigger the IRQ
+		 * after resume if the input level changes
+		 * to avoid irq lost during PER RET/OFF mode
+		 * Applies for omap2 non-wakeup gpio and all omap3 gpios
+		 */
+		if (trigger & IRQ_TYPE_EDGE_BOTH)
 			bank->enabled_non_wakeup_gpios |= gpio_bit;
 		else
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
-- 
1.6.3.2

