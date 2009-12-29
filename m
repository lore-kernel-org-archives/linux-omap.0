From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.34 2/9] arm: omap: musb: we can use clk framework
Date: Wed, 30 Dec 2009 00:59:20 +0200
Message-ID: <1262127567-15202-3-git-send-email-felipe.balbi@nokia.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50509 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbZL2W7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 17:59:38 -0500
In-Reply-To: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org

... in order to handle musb's clock. Let's start
removing the old musb-only set_clock function.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 57589ff..4fbb7bc 100644
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
@@ -81,7 +60,6 @@ static struct musb_hdrc_config musb_config = {
 
 static struct musb_hdrc_platform_data musb_plat = {
 	/* .clock is set dynamically */
-	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
 	/* .power	= DYNAMIC, */
 	/* .mode	= DYNAMIC, */
-- 
1.6.6.35.g1d85d

