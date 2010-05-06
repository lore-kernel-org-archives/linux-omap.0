From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] OMAP3: wait on IDLEST after enabling USBTLL fclk
Date: Thu,  6 May 2010 11:58:08 +0530
Message-ID: <1273127288-21590-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49360 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab0EFG2Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 02:28:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>

We need to wait on the IDLEST bit after the clocks are enabled
before attempting to access any register.

Currently, the USBTLL i-clock ops uses the clkops_omap2_dflt_wait,
while the USBTLL f-clock ops uses clkops_omap2_dflt. If the
i-clock is enabled first, the clkops_omap2_dflt_wait is
short-circuited as the companion f-clock is not enabled.
This can cause a data abort if the IDLEST has not transitioned,
and we try to access a USBTLL register.

Since the USBTLL i-clock and f-clock could be enabled in any order,
this is a bug. Fix it by changing the clkops for the f-clock.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---

 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock3xxx_data.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock3xxx_data.c
+++ linux-omap-2.6/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1484,7 +1484,7 @@ static struct clk ts_fck = {
 
 static struct clk usbtll_fck = {
 	.name		= "usbtll_fck",
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll5_m2_ck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
