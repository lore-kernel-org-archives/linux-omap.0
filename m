From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/3] ARM: OMAP3: clock data: treat all AM35x devices the same
Date: Mon, 30 Apr 2012 16:30:03 -0700
Message-ID: <1335828604-18795-3-git-send-email-khilman@ti.com>
References: <1335828604-18795-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39086 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757423Ab2D3X3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 19:29:09 -0400
Received: by pbbrp2 with SMTP id rp2so1459489pbb.28
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 16:29:08 -0700 (PDT)
In-Reply-To: <1335828604-18795-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The init for 3505/3517 specific clocks depends on the ordering of
cpu_is checks, is error prone and confusing (there are 2 separate
checks for cpu_is_omap3505()).

Remove the 3505-specific checking since CK_3505 flag is not used, and
treat all AM35x clocks the same.

This means that the SGX clock (the only AM35x clkdev not currently
flagged for 3505) will now be registered on 3505, but that is
harmless.  That can be cleaned up when the clkdev nodes are removed in
favor of them being registered by hwmod.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index ce0cbd8..5e64b33 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3513,21 +3513,9 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = 0;
 
-	/*
-	 * 3505 must be tested before 3517, since 3517 returns true
-	 * for both AM3517 chips and AM3517 family chips, which
-	 * includes 3505.  Unfortunately there's no obvious family
-	 * test for 3517/3505 :-(
-	 */
-	if (cpu_is_omap3505()) {
-		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_3505;
-	} else if (cpu_is_omap3517()) {
+	if (cpu_is_omap3517()) {
 		cpu_mask = RATE_IN_34XX;
 		cpu_clkflg = CK_3517;
-	} else if (cpu_is_omap3505()) {
-		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_3505;
 	} else if (cpu_is_omap3630()) {
 		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
 		cpu_clkflg = CK_36XX;
-- 
1.7.9.2

