From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH] OMAP3 clock: Access only available clock bits
Date: Fri, 20 Mar 2009 12:15:24 +0900
Message-ID: <4d34a0a70903192015j4ea44b1fn4f7bb045da32d218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:51866 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZCTDP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 23:15:26 -0400
Received: by wf-out-1314.google.com with SMTP id 29so987660wff.4
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2009 20:15:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, kyungmin.park@samsung.com, Tony Lindgren <tony@atomide.com>, bhmin@samsung.com

Hi All,

I found a problem on PM Branch with OMAP3430 ES3.1 Board when enabling
OMAP_RESET_CLOCKS feature.
In clk_disable_unsed() function, as soon as sad2d_ick is disabled,
prcm interrupt is generated and its handler can't exit loop at next
statement!

while (prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET));

I also found that sad2d_ick is available only OMAP3430 ES1. I fixed
this problem with below patch.

Your better solutions or comments appreciated.

Sincerely,
Kyuwon
--
This patch prevents setting or clearing reserved bits of 'Clock Enable
Register', in the clk_disable_unused() function. Especially, this
patch prevents using the sad2d_ick which doesn't exist in OMAP3430
ES2+.

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 arch/arm/plat-omap/clock.c      |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index e0dd7f3..039f7dd 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1279,7 +1279,7 @@ static struct clk sad2d_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_SAD2D_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm		= { .name = "d2d_clkdm" },
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 2eed047..b16c6c3 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -775,6 +775,16 @@ static int __init clk_disable_unused(void)
 		if (cpu_class_is_omap1() && ck->enable_reg == 0)
 			continue;

+		if (cpu_is_omap34xx()) {
+			if ((omap_rev() == OMAP3430_REV_ES1_0) &&
+					(ck->flags & CLOCK_IN_OMAP3430ES2))
+				continue;
+
+			/* In this case, board Rev. is greater then ES1 */
+			if (ck->flags & CLOCK_IN_OMAP3430ES1)
+				continue;
+		}
+
 		spin_lock_irqsave(&clockfw_lock, flags);
 		if (arch_clock->clk_disable_unused)
 			arch_clock->clk_disable_unused(ck);
-- 
1.5.2.5
