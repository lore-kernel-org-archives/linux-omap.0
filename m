From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 04/10] PRCM: Workaround for pwrdn_x control
Date: Fri, 16 May 2008 14:05:02 +0300
Message-ID: <1210935902-27979-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37491 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbYEPLFs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:48 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB4RlK031510
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 06:05:46 -0500
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

Clock path should be powered down only after all it's clients are
properly disabled. Generally we don't have working implementation for
checking wether some clock is enabled or disabled.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0742359..443924f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -328,6 +328,7 @@ void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
 		_omap2_clk_disable(clk);
+		udelay(10);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
 		if (clk->clkdm)
@@ -968,6 +969,10 @@ void omap2_clk_disable_unused(struct clk *clk)
 		return;
 
 	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
-	_omap2_clk_disable(clk);
+	if (cpu_is_omap34xx()) {
+		omap2_clk_enable(clk);
+		omap2_clk_disable(clk);
+	} else
+		_omap2_clk_disable(clk);
 }
 #endif
-- 
1.5.5

