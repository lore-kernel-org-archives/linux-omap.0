From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 02/15] OMAP: GPIO: remove MPUIO handling from _clear_gpio_irqbank()
Date: Fri, 22 Apr 2011 16:01:54 -0700
Message-ID: <1303513327-14532-3-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53590 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754267Ab1DVXAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:08 -0400
Received: by pvc12 with SMTP id 12so210169pvc.28
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:05 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

Remove the OMAP1 #ifdef and MPUIO special case for _clear_gpio_irqbank()

The MPUIOs do not need a register access to ack/clear the IRQ status,
since reading the IRQ status clears it.  In addition, the MPUIO
irq_chip has an empty ack method, so _clear_gpio_irqbank() is never
used for MPUIOs.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index fe6971a..8b5ca6e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -770,12 +770,6 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	void __iomem *reg = bank->base;
 
 	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		/* MPUIO irqstatus is reset by reading the status register,
-		 * so do nothing here */
-		return;
-#endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_STATUS;
-- 
1.7.4

