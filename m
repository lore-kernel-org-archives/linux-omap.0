From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: Clock: Fixed dpll3_m2x2 rate calculation
Date: Wed, 28 Oct 2009 13:38:10 +0200
Message-ID: <1256729890-21920-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22264 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZJ1Lxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 07:53:52 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9SBrjTn005783
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 06:53:56 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9SBrII9025324
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 13:53:19 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Current calculation does not take into account any changes to M2 divisor, and
thus when we change VDD2 OPP, dpll3_m2x2 rate does not change. Fixed by
re-routing dpll3_m2x2 parent to dpll3_m2.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index a1b3de7..8fe1bcb 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -489,9 +489,9 @@ static struct clk core_ck = {
 static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
 	.ops		= &clkops_null,
-	.parent		= &dpll3_x2_ck,
+	.parent		= &dpll3_m2_ck,
 	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap3_clkoutx2_recalc,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-- 
1.5.4.3

