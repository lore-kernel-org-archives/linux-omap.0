From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] GPIO: OMAP: Fixed spurious IRQ issue for GPIO interrupts
Date: Fri, 03 Apr 2009 10:58:32 +0300
Message-ID: <49D5C1A8.5090606@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60902 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759522AbZDCH7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 03:59:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Fri, 3 Apr 2009 10:32:20 +0300
Subject: [PATCH] GPIO: OMAP: Fixed spurious IRQ issue for GPIO interrupts

Flush posted write to IRQSTATUS register in GPIO IRQ handler.
This eliminates the below error for all peripherals that use GPIO interrupts.

<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 31

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 210a1c0..17d7afe 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -758,8 +758,12 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+	reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		__raw_writel(gpio_mask, bank->base + OMAP24XX_GPIO_IRQSTATUS2);
+		__raw_writel(gpio_mask, reg);
+
+	/* Flush posted write for the irq status to avoid spurious interrupts */
+	__raw_readl(reg);
 #endif
 }
 
-- 
1.5.6.5


