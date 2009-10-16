From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: GPIO: Added dynamic control logic for pad wakeups
Date: Fri, 16 Oct 2009 15:23:44 +0300
Message-ID: <1255695824-17523-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27657 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZJPMit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 08:38:49 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GCbEIH023287
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 07:37:22 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GCbG8w032526
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 15:37:17 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Pad wakeups are now enabled if the corresponding GPIO interrupt is enabled.

Applies on top of PM branch.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/plat-omap/gpio.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index e242112..fa79db2 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -267,6 +267,7 @@ static struct gpio_bank gpio_bank_34xx[6] = {
 #define OMAP34XX_PAD_SAFE_MODE 0x7
 #define OMAP34XX_PAD_IN_PU_GPIO 0x11c
 #define OMAP34XX_PAD_IN_PD_GPIO 0x10c
+#define OMAP34XX_PAD_WAKE_EN (1 << 14)
 
 struct omap3_gpio_regs {
 	u32 sysconfig;
@@ -713,6 +714,8 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 {
 	void __iomem *base = bank->base;
 	u32 gpio_bit = 1 << gpio;
+	struct gpio_pad *pad;
+	int gpio_num;
 	u32 val;
 
 	if (cpu_is_omap44xx()) {
@@ -750,6 +753,23 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 			 * GPIO wakeup request can only be generated on edge
 			 * transitions
 			 */
+			pad = gpio_pads;
+
+			gpio_num = bank->virtual_irq_start - IH_GPIO_BASE +
+				gpio;
+			/* Find the pad corresponding the GPIO */
+			while (pad->gpio >= 0 && pad->gpio != gpio_num)
+				pad++;
+			/* Enable / disable pad wakeup */
+			if (pad->gpio == gpio_num) {
+				val = omap_ctrl_readw(pad->offset);
+				if (trigger & IRQ_TYPE_EDGE_BOTH)
+					val |= OMAP34XX_PAD_WAKE_EN;
+				else
+					val &= ~(u16)OMAP34XX_PAD_WAKE_EN;
+				omap_ctrl_writew(val, pad->offset);
+			}
+
 			if (trigger & IRQ_TYPE_EDGE_BOTH)
 				__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_SETWKUENA);
@@ -1654,7 +1674,7 @@ static int __init omap3_gpio_pads_init(void)
 	gpio_pads[gpio_amt].gpio = -1;
 	return 0;
 }
-late_initcall(omap3_gpio_pads_init);
+early_initcall(omap3_gpio_pads_init);
 #endif
 
 /* This lock class tells lockdep that GPIO irqs are in a different
-- 
1.5.4.3

