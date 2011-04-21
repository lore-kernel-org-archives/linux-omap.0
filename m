From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/9] OMAP: GPIO: _clear_gpio_irqbank: fix flushing of posted write
Date: Thu, 21 Apr 2011 13:35:19 -0700
Message-ID: <1303418127-4310-2-git-send-email-khilman@ti.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:45847 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753421Ab1DUUde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 16:33:34 -0400
Received: by mail-px0-f169.google.com with SMTP id 9so64502pxi.14
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 13:33:31 -0700 (PDT)
In-Reply-To: <1303418127-4310-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com

In commit 78a1a6d3411de1a8b0dc1cb92754b5f12f251912 (ARM: OMAP4: Update
the GPIO support) braces were mistakenly added to included the
register read-back inside the cpu_is_* checking.

Remove the braces, ensuring that a register read-back is done, even
when the IRQSTATUS2 register is not written.

Note that the register read-back might be IRQSTATUS1 or IRQSTATUS2
depending on the CPU, but a read-back of any register in that region
will cause a flush of the posted writes.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d2adcdd..fe6971a 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -813,12 +813,11 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	else if (cpu_is_omap44xx())
 		reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
 		__raw_writel(gpio_mask, reg);
 
 	/* Flush posted write for the irq status to avoid spurious interrupts */
 	__raw_readl(reg);
-	}
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
-- 
1.7.4

