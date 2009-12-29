From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Remove set_clock for usb-musb.c
Date: Tue, 29 Dec 2009 11:31:04 -0800
Message-ID: <20091229193103.GB3512@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52439 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbZL2TbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 14:31:09 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Felipe, can you take a look at this patch? To me it seems
like it should be now OK to get rid of set_clock.

Regards,

Tony

--NU0Ex4SbNnrxsi6C
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-nuke-set-clock.patch"

>From 58c67fd38d9aa65cf35550f7b0e8c279d86afefe Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 29 Dec 2009 11:26:45 -0800
Subject: [PATCH] omap: Remove set_clock for usb-musb.c

This is no longer needed because of clkdev. We are
already using clk_enable/disable directly in musb_core.c
if set_clock is NULL.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a80441d..74c40ab 100644
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
 static struct musb_hdrc_eps_bits musb_eps[] = {
 	{	"ep1_tx", 10,	},
 	{	"ep1_rx", 10,	},
@@ -121,8 +100,6 @@ static struct musb_hdrc_platform_data musb_plat = {
 #elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
 	.mode		= MUSB_PERIPHERAL,
 #endif
-	/* .clock is set dynamically */
-	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
 
 	/* REVISIT charge pump on TWL4030 can supply up to

--NU0Ex4SbNnrxsi6C--
