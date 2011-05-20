From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 04/14] GPIO: OMAP: _get_gpio_irqbank_mask: replace hard-coded mask with bank->width
Date: Fri, 20 May 2011 17:14:47 +0200
Message-ID: <1305904497-26013-5-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42676 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933376Ab1ETPPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:15 -0400
Received: by mail-wy0-f171.google.com with SMTP id 32so4130069wyb.16
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:14 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Replace hard-coded mask values with bank->width which is already coming
from platform_data.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 4691ed8..1b7896e 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -718,46 +718,40 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 	void __iomem *reg = bank->base;
 	int inv = 0;
 	u32 l;
-	u32 mask;
+	u32 mask = (1 << bank->width) - 1;
 
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_MASKIT / bank->stride;
-		mask = 0xffff;
 		inv = 1;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_MASK;
-		mask = 0xffff;
 		inv = 1;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_IRQENABLE1;
-		mask = 0xffff;
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_7XX:
 		reg += OMAP7XX_GPIO_INT_MASK;
-		mask = 0xffffffff;
 		inv = 1;
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
-		mask = 0xffffffff;
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_44XX:
 		reg += OMAP4_GPIO_IRQSTATUSSET0;
-		mask = 0xffffffff;
 		break;
 #endif
 	default:
-- 
1.7.3.4

