From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 3/7] ARM: OMAP3: clock data: treat all AM35x devices the same
Date: Wed,  4 Jan 2012 17:16:42 -0800
Message-ID: <1325726206-11199-4-git-send-email-khilman@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:58431 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757459Ab2AEBQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 20:16:56 -0500
Received: by mail-gy0-f177.google.com with SMTP id r15so14645ghr.22
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 17:16:55 -0800 (PST)
In-Reply-To: <1325726206-11199-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

The init for 3505/3517 specific clocks depends on the ordering of
cpu_is checks, is error prone and confusing (there are 2 separate
checks for cpu_is_omap3505()).

Remove the 3505-specific checking since CK_3505 flag is not used, and
treat all AM35x clocks the same.

This means that the SGX clock (the only AM35x clkdev not currently
flagged for 3505) will now be registered on 3505, but that is
harmless.  That can be cleaned up when the clkdev nodes are removed in
favor of them being registered by hwmod.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index e09e506..26fb4d9 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3505,21 +3505,9 @@ int __init omap3xxx_clk_init(void)
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
1.7.8.2

