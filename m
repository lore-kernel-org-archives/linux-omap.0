From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: Fixes for suspend / resume GPIO wake-up handling
Date: Wed, 26 Nov 2008 13:47:10 +0200
Message-ID: <1227700030-28295-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24049 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYKZLvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 06:51:50 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAQBpPrh026071
	for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 13:51:47 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAQBp4vr002189
	for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 13:51:05 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f4ec3af..62349fd 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1585,7 +1585,7 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		case METHOD_GPIO_24XX:
-			wake_status = bank->base + OMAP24XX_GPIO_SETWKUENA;
+			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
 			break;
@@ -1608,7 +1608,7 @@ static int omap_gpio_resume(struct sys_device *dev)
 {
 	int i;
 
-	if (!cpu_is_omap24xx() && !cpu_is_omap16xx())
+	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
 		return 0;
 
 	for (i = 0; i < gpio_bank_count; i++) {
-- 
1.5.4.3

