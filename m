From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] omap: musb: remove unneeded init code
Date: Thu, 18 Aug 2011 14:42:44 +0530
Message-ID: <1313658764-28907-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42655 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab1HRJMu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Aug 2011 05:12:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7I9CkXa024549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 04:12:49 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7I9Ck9s001487
	for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 14:42:46 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

The .power and .mode parameter of 'musb_plat' is also now set dynamically
in usb_musb_init() so remove them.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a65145b..de48106 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -41,21 +41,8 @@ static struct musb_hdrc_config musb_config = {
 };
 
 static struct musb_hdrc_platform_data musb_plat = {
-#ifdef CONFIG_USB_MUSB_OTG
-	.mode		= MUSB_OTG,
-#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
-	.mode		= MUSB_HOST,
-#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
-	.mode		= MUSB_PERIPHERAL,
-#endif
-	/* .clock is set dynamically */
+	/* .clock, .mode and .power is set dynamically */
 	.config		= &musb_config,
-
-	/* REVISIT charge pump on TWL4030 can supply up to
-	 * 100 mA ... but this value is board-specific, like
-	 * "mode", and should be passed to usb_musb_init().
-	 */
-	.power		= 50,			/* up to 100 mA */
 };
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
-- 
1.6.2.4

