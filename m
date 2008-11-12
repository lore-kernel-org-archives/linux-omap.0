From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] PM: OMAP3: Make sure clk_disable_unused() order is correct
Date: Wed, 12 Nov 2008 11:42:10 +0200
Message-ID: <1226482930-32017-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61766 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYKLJoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 04:44:30 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAC9i2oO027561
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 11:44:27 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAC9iBpD028853
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 11:44:12 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Current implementation will disable clocks in the order defined in clock34xx.h,
at least DPLL4_M2X2 will hang in certain cases (and prevent retention / off)
if clocks are not disabled in correct order. This patch makes sure the parent
clocks will be active when disabling a clock.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index dbbc7c8..522ce6f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1012,7 +1012,11 @@ void omap2_clk_disable_unused(struct clk *clk)
 		return;
 
 	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
-	_omap2_clk_disable(clk);
+	if (cpu_is_omap34xx()) {
+		omap2_clk_enable(clk);
+		omap2_clk_disable(clk);
+	} else
+		_omap2_clk_disable(clk);
 	if (clk->clkdm.ptr != NULL)
 		pwrdm_clkdm_state_switch(clk->clkdm.ptr);
 }
-- 
1.5.4.3

