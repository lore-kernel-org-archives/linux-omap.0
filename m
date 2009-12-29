From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.34 8/9] arm: omap: musb: do not pass clock name to driver
Date: Wed, 30 Dec 2009 00:59:26 +0200
Message-ID: <1262127567-15202-9-git-send-email-felipe.balbi@nokia.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50536 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbZL2W7y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 17:59:54 -0500
In-Reply-To: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org

we are using clkdev and the driver can use whatever
name it wants.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index ec8869a..f102d5a 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -55,7 +55,6 @@ static struct musb_hdrc_config musb_config = {
 };
 
 static struct musb_hdrc_platform_data musb_plat = {
-	/* .clock is set dynamically */
 	.config		= &musb_config,
 	/* .power	= DYNAMIC, */
 	/* .mode	= DYNAMIC, */
@@ -83,11 +82,6 @@ void __init usb_musb_init(enum musb_mode mode, unsigned power)
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
 	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
-	/*
-	 * REVISIT: This line can be removed once all the platforms using
-	 * musb_core.c have been converted to use use clkdev.
-	 */
-	musb_plat.clock = "ick";
 	musb_plat.power = power >> 1;
 	musb_plat.mode = mode;
 
-- 
1.6.6.35.g1d85d

