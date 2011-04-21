From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/9] OMAP: GPIO: remove MPUIO handling from _clear_gpio_irqbank()
Date: Thu, 21 Apr 2011 13:35:20 -0700
Message-ID: <1303418127-4310-3-git-send-email-khilman@ti.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40703 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918Ab1DUUdf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 16:33:35 -0400
Received: by mail-pz0-f53.google.com with SMTP id 3so61790pzk.12
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 13:33:33 -0700 (PDT)
In-Reply-To: <1303418127-4310-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
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

