From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 5/6] OMAP3: GPIO: Removed a couple of unneeded registers from context save/restore
Date: Tue, 11 May 2010 16:30:51 -0700
Message-ID: <1273620652-15927-6-git-send-email-khilman@deeprootsystems.com>
References: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39468 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab0EKXbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:31:07 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so2565614pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:31:07 -0700 (PDT)
In-Reply-To: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

setwkuena and setdataout are covered already by wake_en and dataout fields.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c6e1de5..b895cc9 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -305,8 +305,6 @@ struct omap3_gpio_regs {
 	u32 risingdetect;
 	u32 fallingdetect;
 	u32 dataout;
-	u32 setwkuena;
-	u32 setdataout;
 };
 
 static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
@@ -2241,10 +2239,6 @@ void omap_gpio_save_context(void)
 			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		gpio_context[i].dataout =
 			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
-		gpio_context[i].setwkuena =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
-		gpio_context[i].setdataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
 	}
 }
 
@@ -2277,10 +2271,6 @@ void omap_gpio_restore_context(void)
 				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(gpio_context[i].dataout,
 				bank->base + OMAP24XX_GPIO_DATAOUT);
-		__raw_writel(gpio_context[i].setwkuena,
-				bank->base + OMAP24XX_GPIO_SETWKUENA);
-		__raw_writel(gpio_context[i].setdataout,
-				bank->base + OMAP24XX_GPIO_SETDATAOUT);
 	}
 }
 #endif
-- 
1.7.0.2

