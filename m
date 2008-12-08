From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] OMAP: Fix dpll4_m4_ck clk_set_rate()
Date: Mon,  8 Dec 2008 15:16:49 +0200
Message-ID: <1228742209-23540-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40106 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYLHNRK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 08:17:10 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB8DGvvJ011307
	for <linux-omap@vger.kernel.org>; Mon, 8 Dec 2008 15:17:07 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

This fixes commit e42218d45afbc3e654e289e021e6b80c657b16c2. The commit
was based on old kernel tree, and with bad luck applied ok but to wrong
position, modifying dpll4_m6_ck instead of dpll4_m4_ck.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 1c2b49f..5357507 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -825,6 +825,8 @@ static struct clk dpll4_m4_ck = {
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
@@ -879,8 +881,6 @@ static struct clk dpll4_m6_ck = {
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
-	.set_rate	= &omap2_clksel_set_rate,
-	.round_rate	= &omap2_clksel_round_rate,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-- 
1.6.0.3

