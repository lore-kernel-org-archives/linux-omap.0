From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 02/14] GPIO: OMAP: remove MPUIO handling from _clear_gpio_irqbank()
Date: Fri, 20 May 2011 17:14:45 +0200
Message-ID: <1305904497-26013-3-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36852 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933408Ab1ETPPI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:08 -0400
Received: by mail-wy0-f177.google.com with SMTP id 28so3403769wyb.8
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:07 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Remove the OMAP1 #ifdef and MPUIO special case for _clear_gpio_irqbank()

The MPUIOs do not need a register access to ack/clear the IRQ status,
since reading the IRQ status clears it.  In addition, the MPUIO
irq_chip has an empty ack method, so _clear_gpio_irqbank() is never
used for MPUIOs.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index b414644..6fcee66 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -665,12 +665,6 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
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
1.7.3.4

