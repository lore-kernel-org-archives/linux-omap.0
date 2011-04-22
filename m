From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 01/15] OMAP: GPIO: _clear_gpio_irqbank: fix flushing of posted write
Date: Fri, 22 Apr 2011 16:01:53 -0700
Message-ID: <1303513327-14532-2-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50740 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754333Ab1DVXAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:04 -0400
Received: by mail-pw0-f53.google.com with SMTP id 7so626197pwj.26
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:03 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

