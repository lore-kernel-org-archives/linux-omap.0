From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH] omap: fix the cpu type check in clock3xxx_data.c
Date: Tue, 22 Jun 2010 14:26:23 +0800
Message-ID: <1277187983-26142-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50631 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab0FVGNy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 02:13:54 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o5M6DsqQ010195
	for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 23:13:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

omap3517 and omap3505 belong to OMAP3 architecture, so the cpu_is_omap34xx
will be true. Therefore, if the cpu omap3517 is a exception, we should check
whether it is omap3517 before check whether it is omap34xx.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 41b155a..6766612 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3412,7 +3412,13 @@ int __init omap3xxx_clk_init(void)
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
 
@@ -3427,12 +3433,6 @@ int __init omap3xxx_clk_init(void)
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

