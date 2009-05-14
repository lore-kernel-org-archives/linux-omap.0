From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: PM: Force USB to standby if not used
Date: Thu, 14 May 2009 15:09:40 +0300
Message-ID: <1242302980-4082-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45640 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760721AbZENMgT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 08:36:19 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4ECZgEx023185
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 07:36:21 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n4ECaAhO005847
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 15:36:10 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This patch will allow device to enter sleep mode while a USB cable is
connected and USB is either disabled or built as a module from kernel
config.

Applies on top of PM branch.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 12a9b0a..dd51d2f 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -32,7 +32,9 @@
 #include <mach/usb.h>
 
 #define AUTOIDLE        (1 << 0)
+#define FORCESTDBY	(1 << 0)
 #define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
+#define OTG_FORCESTDBY	(OMAP34XX_HSUSB_OTG_BASE + 0x414)
 
 static struct resource musb_resources[] = {
 	[0] = { /* start and end set dynamically */
@@ -185,7 +187,11 @@ void __init usb_musb_init(void)
 		return;
 	}
 
-	/* Enable smartidle on MUSB to improve C1 wakeup latency */
-	if (cpu_is_omap34xx())
+#if !defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+	/* Force MUSB to standby if not used */
+	if (cpu_is_omap34xx()) {
 		omap_writel(AUTOIDLE, OTG_SYSCONFIG);
+		omap_writel(FORCESTDBY, OTG_FORCESTDBY);
+	}
+#endif
 }
-- 
1.5.4.3

