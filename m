From: Abhijit Pagare <abhijitpagare@ti.com>
Subject: [PATCH] ARM: OMAP4 clock framework: Remove the checks preventing OMAP4 clockdomain validation
Date: Wed, 30 Dec 2009 21:39:46 +0530
Message-ID: <1262189386-22239-1-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32980 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbZL3QJ6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Dec 2009 11:09:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>, Paul Walmsley <paul@pwsan.com>

The clockdomain related code being in place, it is not necessary to have
some part of the clock code commented out. This would help the validation of
the clockdomain functions using the clock level interfaces.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
Re-submitting with proper subject line.

Compiled and Boot Tested on OMAP4430 simulator, ES1 Chip & OMAP3430 SDP.
And also Compiled for OMAP2430 and OMAP2420

This patch has a dependency on the earlier set of OMAP4 clock-domain patches.

 arch/arm/mach-omap2/clock.c          |    8 --------
 arch/arm/mach-omap2/clock44xx_data.c |    2 --
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 759c72a..a6d570a 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -181,7 +181,6 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
  * clockdomain pointer, and save it into the struct clk.  Intended to be
  * called during clk_register().  No return value.
  */
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
@@ -199,7 +198,6 @@ void omap2_init_clk_clkdm(struct clk *clk)
 			 "clkdm %s\n", clk->name, clk->clkdm_name);
 	}
 }
-#endif
 
 /**
  * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
@@ -476,10 +474,8 @@ void omap2_clk_disable(struct clk *clk)
 		_omap2_clk_disable(clk);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_disable(clk->clkdm, clk);
-#endif
 
 	}
 }
@@ -489,10 +485,8 @@ int omap2_clk_enable(struct clk *clk)
 	int ret = 0;
 
 	if (clk->usecount++ == 0) {
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_enable(clk->clkdm, clk);
-#endif
 
 		if (clk->parent) {
 			ret = omap2_clk_enable(clk->parent);
@@ -511,10 +505,8 @@ int omap2_clk_enable(struct clk *clk)
 	return ret;
 
 err:
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 	if (clk->clkdm)
 		omap2_clkdm_clk_disable(clk->clkdm, clk);
-#endif
 	clk->usecount--;
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2210e22..f47ba9e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2749,9 +2749,7 @@ int __init omap2_clk_init(void)
 		if (c->cpu & cpu_clkflg) {
 			clkdev_add(&c->lk);
 			clk_register(c->lk.clk);
-			/* TODO
 			omap2_init_clk_clkdm(c->lk.clk);
-			*/
 		}
 
 	recalculate_root_clocks();
-- 
1.5.4.7

