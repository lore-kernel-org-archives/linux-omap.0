From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH] OMAP2: Fix a cpu type check problem.
Date: Tue, 10 Aug 2010 20:36:37 +0800
Message-ID: <1281443797-7062-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56184 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab0HJMW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 08:22:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

cpu_is_omap3517() and cpu_is_omap3505() are the subgroups of cpu_is_omap34xx(),
so we should check cpu_is_omap3517() and cpu_is_omap3505() first, then check
cpu_is_omap34xx().

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 138646d..dfdce2d 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3417,7 +3417,13 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = CK_3XXX;
 
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap3517()) {
+		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
+		cpu_clkflg |= CK_3517;
+	} else if (cpu_is_omap3505()) {
+		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
+		cpu_clkflg |= CK_3505;
+	} else if (cpu_is_omap34xx()) {
 		cpu_mask = RATE_IN_3XXX;
 		cpu_clkflg |= CK_343X;
 
@@ -3432,12 +3438,6 @@ int __init omap3xxx_clk_init(void)
 			cpu_mask |= RATE_IN_3430ES2PLUS;
 			cpu_clkflg |= CK_3430ES2;
 		}
-	} else if (cpu_is_omap3517()) {
-		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
-		cpu_clkflg |= CK_3517;
-	} else if (cpu_is_omap3505()) {
-		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
-		cpu_clkflg |= CK_3505;
 	}
 
 	if (omap3_has_192mhz_clk())
-- 
1.5.4.3

