From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/7] omap: clock: Check for enable/disable ops support
Date: Tue,  8 Feb 2011 15:40:32 +0530
Message-ID: <1297159838-30282-2-git-send-email-rnayak@ti.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56872 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681Ab1BHKKv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Feb 2011 05:10:51 -0500
In-Reply-To: <1297159838-30282-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Check if enable/disable operations are supported for a given
clock node before attempting to call them.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 2a2f152..e0f017d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -261,7 +261,8 @@ void omap2_clk_disable(struct clk *clk)
 
 	pr_debug("clock: %s: disabling in hardware\n", clk->name);
 
-	clk->ops->disable(clk);
+	if (clk->ops && clk->ops->disable)
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
1.7.0.4

