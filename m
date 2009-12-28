From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/8] arm: omap: musb: we can use clk framework
Date: Mon, 28 Dec 2009 13:09:44 +0200
Message-ID: <1261998590-6639-3-git-send-email-felipe.balbi@nokia.com>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61561 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZL1LLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 06:11:55 -0500
In-Reply-To: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

... in order to handle musb's clock. Let's start
removing the old musb-only set_clock function.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index de7ae49..5a55c12 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -47,27 +47,6 @@ static struct resource musb_resources[] = {
 	},
 };
 
-static int clk_on;
-
-static int musb_set_clock(struct clk *clk, int state)
-{
-	if (state) {
-		if (clk_on > 0)
-			return -ENODEV;
-
-		clk_enable(clk);
-		clk_on = 1;
-	} else {
-		if (clk_on == 0)
-			return -ENODEV;
-
-		clk_disable(clk);
-		clk_on = 0;
-	}
-
-	return 0;
-}
-
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
 	.dyn_fifo	= 1,
@@ -88,7 +67,6 @@ static struct musb_hdrc_platform_data musb_plat = {
 	.mode		= MUSB_PERIPHERAL,
 #endif
 	/* .clock is set dynamically */
-	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
 
 	/* REVISIT charge pump on TWL4030 can supply up to
-- 
1.6.6.rc0

