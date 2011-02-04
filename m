From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 4/9] omap: clocks: Add checks to see if enable/disable ops are supported
Date: Fri,  4 Feb 2011 15:28:59 +0530
Message-ID: <1296813544-25170-5-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50473 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab1BDJ7R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 04:59:17 -0500
In-Reply-To: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Check if enable/disable operations are supported for a given
clock node before attempting to call them.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 2a2f152..5c08c18 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -261,7 +261,8 @@ void omap2_clk_disable(struct clk *clk)
 
 	pr_debug("clock: %s: disabling in hardware\n", clk->name);
 
-	clk->ops->disable(clk);
+	if (clk->ops && clk->ops->enable)
+		clk->ops->disable(clk);
 
 	if (clk->clkdm)
 		omap2_clkdm_clk_disable(clk->clkdm, clk);
@@ -312,10 +313,13 @@ int omap2_clk_enable(struct clk *clk)
 		}
 	}
 
-	ret = clk->ops->enable(clk);
-	if (ret) {
-		WARN(1, "clock: %s: could not enable: %d\n", clk->name, ret);
-		goto oce_err3;
+	if (clk->ops && clk->ops->enable) {
+		ret = clk->ops->enable(clk);
+		if (ret) {
+			WARN(1, "clock: %s: could not enable: %d\n",
+			     clk->name, ret);
+			goto oce_err3;
+		}
 	}
 
 	return 0;
-- 
1.6.0.4

