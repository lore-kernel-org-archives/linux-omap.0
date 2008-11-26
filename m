From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Fixes for suspend / resume GPIO wake-up handling
Date: Wed, 26 Nov 2008 15:32:03 -0800
Message-ID: <20081126233203.GQ11997@atomide.com>
References: <20081126232707.GN11997@atomide.com> <20081126232833.GO11997@atomide.com> <20081126233042.GP11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64801 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbYKZXcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 18:32:04 -0500
Content-Disposition: inline
In-Reply-To: <20081126233042.GP11997@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

>From 723fdb781abfe78d8ba7d911abbb581722348aa7 Mon Sep 17 00:00:00 2001
From: Tero Kristo <tero.kristo@nokia.com>
Date: Wed, 26 Nov 2008 14:35:16 -0800
Subject: [PATCH] ARM: OMAP: Fixes for suspend / resume GPIO wake-up handling

Use the correct wake-up enable register, and make it
work with 34xx also.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8679fbc..424049d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -101,6 +101,7 @@
 #define OMAP24XX_GPIO_IRQSTATUS2	0x0028
 #define OMAP24XX_GPIO_IRQENABLE2	0x002c
 #define OMAP24XX_GPIO_IRQENABLE1	0x001c
+#define OMAP24XX_GPIO_WAKE_EN		0x0020
 #define OMAP24XX_GPIO_CTRL		0x0030
 #define OMAP24XX_GPIO_OE		0x0034
 #define OMAP24XX_GPIO_DATAIN		0x0038
@@ -1551,7 +1552,7 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		case METHOD_GPIO_24XX:
-			wake_status = bank->base + OMAP24XX_GPIO_SETWKUENA;
+			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
 			break;
@@ -1574,7 +1575,7 @@ static int omap_gpio_resume(struct sys_device *dev)
 {
 	int i;
 
-	if (!cpu_is_omap24xx() && !cpu_is_omap16xx())
+	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
 		return 0;
 
 	for (i = 0; i < gpio_bank_count; i++) {
-- 
1.5.6.rc3.21.g8c6b5

