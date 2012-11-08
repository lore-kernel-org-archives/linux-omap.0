From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH] ARM: OMAP2+: clockdomain: disabling unused clks
Date: Thu, 8 Nov 2012 15:31:56 -0800
Message-ID: <1352417516-15213-1-git-send-email-mturquette@ti.com>
References: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36032 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab2KHXco (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 18:32:44 -0500
In-Reply-To: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>

The OMAP port to the common clk framework[1] resulted in spurious WARNs
while disable unused clocks.  This is due to _clkdm_clk_hwmod_disable
catching clkdm->usecount's with a value of zero.  Even less desirable it
would not allow the clkdm_clk_disable function pointer to get called due
to an early return of -ERANGE.

This patch adds a check for such a corner case by skipping the WARN and
early return in the event that clkdm->usecount and clk->enable_usecount
are both zero.  Presumably this could only happen during the check for
unused clocks at boot-time.

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/88824

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 64e5046..b0c0ce6 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -947,16 +947,22 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	return 0;
 }
 
-static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
+static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm,
+		struct clk *clk)
 {
 	unsigned long flags;
+	int clk_enable_count = 1;
 
 	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
 		return -EINVAL;
 
 	spin_lock_irqsave(&clkdm->lock, flags);
 
-	if (atomic_read(&clkdm->usecount) == 0) {
+	/* corner case: disabling unused clocks */
+	if (clk)
+		clk_enable_count = __clk_get_enable_count(clk);
+
+	if (atomic_read(&clkdm->usecount) == 0 && clk_enable_count) {
 		spin_unlock_irqrestore(&clkdm->lock, flags);
 		WARN_ON(1); /* underflow */
 		return -ERANGE;
@@ -1026,7 +1032,7 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	if (!clk)
 		return -EINVAL;
 
-	return _clkdm_clk_hwmod_disable(clkdm);
+	return _clkdm_clk_hwmod_disable(clkdm, clk);
 }
 
 /**
@@ -1089,6 +1095,6 @@ int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	return _clkdm_clk_hwmod_disable(clkdm);
+	return _clkdm_clk_hwmod_disable(clkdm, NULL);
 }
 
-- 
1.7.9.5

