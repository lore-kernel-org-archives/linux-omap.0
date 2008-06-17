From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 2/8] PRCM: Workaround for pwrdn_x control
Date: Tue, 17 Jun 2008 10:30:56 +0300
Message-ID: <1213687856-29932-1-git-send-email-jouni.hogander@nokia.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33379 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbYFQHbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:31:07 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5H7UlYR014158
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 10:31:05 +0300
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5H7UuIa018927
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 10:30:57 +0300
In-Reply-To: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Clock path should be powered down only after all it's clients are
properly disabled. Generally we don't have working implementation for
checking wether some clock is enabled or disabled.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ed15868..9099ba6 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -329,6 +329,9 @@ void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
 		_omap2_clk_disable(clk);
+		/* XXX Currently we don't have working code for
+		 * checking wether clock is really disabled */
+		udelay(10);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
 		if (clk->clkdm)
@@ -974,6 +977,12 @@ void omap2_clk_disable_unused(struct clk *clk)
 		return;
 
 	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
-	_omap2_clk_disable(clk);
+	/* XXX In case of omap3 we need to make sure that sequence is
+	 * correct when disabling clocks */
+	if (cpu_is_omap34xx()) {
+		omap2_clk_enable(clk);
+		omap2_clk_disable(clk);
+	} else
+		_omap2_clk_disable(clk);
 }
 #endif
-- 
1.5.5

