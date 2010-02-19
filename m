From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/11] arm: omap: musb: we can use clk framework
Date: Fri, 19 Feb 2010 15:30:27 -0800
Message-ID: <20100219233027.10559.69690.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52189 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290Ab0BSX3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:29:33 -0500
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>

... in order to handle musb's clock. Let's start
removing the old musb-only set_clock function.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-musb.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 7e2ee01..c7d98a9 100644
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

