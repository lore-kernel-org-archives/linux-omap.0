From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 2/2] OMAP3: GPIO: Removed a couple of unneeded registers from context save/restore
Date: Fri,  6 Mar 2009 13:46:26 +0200
Message-ID: <1236339986-29506-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1236339986-29506-1-git-send-email-tero.kristo@nokia.com>
 <1236339986-29506-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54992 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbZCFMEB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 07:04:01 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n26C3sdq020643
	for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2009 06:03:58 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n26C3fE4012362
	for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2009 14:03:44 +0200
In-Reply-To: <1236339986-29506-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

setwkuena and setdataout are covered already by wake_en and dataout fields.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/gpio.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 5d44dcf..10107e9 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -239,8 +239,6 @@ struct omap3_gpio_regs {
 	u32 risingdetect;
 	u32 fallingdetect;
 	u32 dataout;
-	u32 setwkuena;
-	u32 setdataout;
 };
 
 static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
@@ -1873,10 +1871,6 @@ void omap3_gpio_save_context(void)
 			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		gpio_context[i].dataout =
 			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
-		gpio_context[i].setwkuena =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
-		gpio_context[i].setdataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
 	}
 	pad = gpio_pads;
 
@@ -1946,10 +1940,6 @@ void omap3_gpio_restore_context(void)
 				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(gpio_context[i].dataout,
 				bank->base + OMAP24XX_GPIO_DATAOUT);
-		__raw_writel(gpio_context[i].setwkuena,
-				bank->base + OMAP24XX_GPIO_SETWKUENA);
-		__raw_writel(gpio_context[i].setdataout,
-				bank->base + OMAP24XX_GPIO_SETDATAOUT);
 		__raw_writel(gpio_context[i].oe,
 				bank->base + OMAP24XX_GPIO_OE);
 	}
-- 
1.5.4.3

