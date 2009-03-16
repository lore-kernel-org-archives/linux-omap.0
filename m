From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Add name for musb clocks
Date: Mon, 16 Mar 2009 15:42:44 -0700
Message-ID: <20090316224243.GO19229@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211628.16425.55120.stgit@localhost> <20090315161446.GG10786@n2100.arm.linux.org.uk> <200903151146.02132.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tZCmRiovzb4sxAVa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51361 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZCPWmw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 18:42:52 -0400
Content-Disposition: inline
In-Reply-To: <200903151146.02132.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>, linux-arm-kernel@lists.arm.linux.org.uk, Ajay Kumar Gupta <ajay.gupta@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org


--tZCmRiovzb4sxAVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* David Brownell <david-b@pacbell.net> [090315 11:46]:
> On Sunday 15 March 2009, Russell King - ARM Linux wrote:
> > clkdev removes the need for this sort of crap.
> 
> And once it, or its equivalent, works on all the platforms
> supportihg the musb_hdrc driver, then the driver can switch.

Yeah, I added a REVISIT comment to remove the "ick" name in the
low-level init code once all the musb platforms use clkdev.

Russell, here's a patch you might want to merge into your omap-clks3
branch for musb.

Also tested musb on omap-clks3 + omap-upstream + omap3-upstream +
omap3-boards patches. 

Regards,

Tony

--tZCmRiovzb4sxAVa
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-clks3-musb.patch"

>From 8fb4be02dd5fdbcf71708d7cb5d42751aee42190 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 16 Mar 2009 15:28:41 -0700
Subject: [PATCH] ARM: OMAP: Add name for musb clocks

This allows musb_core.c to register clock with name "ick".

Once all the platforms using the musb driver have been converted
to use clockdev, the clock name does not need to be passed
from the low-level init code.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 1e839c5..f58ad06 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -205,7 +205,7 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"usbhs_ick",	&usbhs_ick,	CK_243X),
+	CLK("musb_hdrc",	"ick",	&usbhs_ick,	CK_243X),
 	CLK("mmci-omap-hs.0", "ick",	&mmchs1_ick,	CK_243X),
 	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
 	CLK("mmci-omap-hs.1", "ick",	&mmchs2_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 0a14dca..a057539 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -157,7 +157,7 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck,	CK_343X),
 	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck,	CK_343X),
 	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_343X),
-	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick,	CK_343X),
+	CLK("musb_hdrc",	"ick",	&hsotgusb_ick,	CK_343X),
 	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_343X),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_343X),
 	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),

--tZCmRiovzb4sxAVa--
