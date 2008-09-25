From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 clock: fix dss1_alwon_fck
Date: Thu, 25 Sep 2008 08:08:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809250807330.14535@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48439 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYIYOIX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 10:08:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, Tero.Kristo@nokia.com


Commit a63efb1547ac35dcb0f007090396a3c7510eb691 broke the dss1_alwon_fck
clock enable on 3430ES2+.  The clock code was not waiting for the module
to come out of idle.

Problem reported by Rajendra Nayak <rnayak@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 8ce7097..4722277 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2304,7 +2304,7 @@ static struct clk dss1_alwon_fck_3430es1 = {
 	.prcm_mod	= OMAP3430_DSS_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm		= { .name = "dss_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2317,7 +2317,7 @@ static struct clk dss1_alwon_fck_3430es2 = {
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
 	.idlest_bit	= OMAP3430ES2_ST_DSS_IDLE_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "dss_clkdm" },
 	.recalc		= &followparent_recalc,
 };
