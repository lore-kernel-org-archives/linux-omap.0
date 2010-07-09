From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH resend 1/2] OMAP3: musb: remove unneeded inits in musb_plat
Date: Fri,  9 Jul 2010 13:52:05 +0530
Message-ID: <1278663726-27689-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab0GIIWQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 04:22:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Removed unneeded 'power' and 'mode' field from musb_config as
they are now getting updated by the values provided from board
files at usb_musb_init().

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 33a5cde..03ddf64 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -54,21 +54,8 @@ static struct musb_hdrc_config musb_config = {
 };
 
 static struct musb_hdrc_platform_data musb_plat = {
-#ifdef CONFIG_USB_MUSB_OTG
-	.mode		= MUSB_OTG,
-#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
-	.mode		= MUSB_HOST,
-#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
-	.mode		= MUSB_PERIPHERAL,
-#endif
 	/* .clock is set dynamically */
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

