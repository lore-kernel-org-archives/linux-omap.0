From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 2/2] ARM: omap: dmtimer: set non-posted mode if iclk less than 4*fck
Date: Fri, 11 May 2012 19:23:18 +0530
Message-ID: <1336744398-23803-3-git-send-email-tarun.kanti@ti.com>
References: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34632 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759847Ab2EKNxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 09:53:34 -0400
In-Reply-To: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com, santosh.shilimkar@ti.com, khilman@ti.com, b-cousson@ti.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Timers in PER domain periodically report old time from TCRR in
posted mode if ick < 4*fck. Therefore, set timer to non-posted
whenever ick < 4*fck for all timers.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 15e7882..a81b85e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -378,6 +378,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
 	struct dmtimer_platform_data *pdata;
+	struct clk *iclk;
 
 	if (unlikely(!timer))
 		return -EINVAL;
@@ -388,6 +389,17 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 		return -EINVAL;
 
 	ret = pdata->set_timer_src(timer->pdev, source);
+	/*
+	 * Timers in PER domain periodically report old time
+	 * from TCRR in posted mode if ick < 4*fck. Hence,
+	 * when this condition is satisfied setting the timer
+	 * to non-posted mode, instead.
+	 */
+	if (!IS_ERR(&ret)) {
+		iclk = clk_get(&timer->pdev->dev, "ick");
+		if (clk_get_rate(iclk) < (4 * clk_get_rate(timer->fclk)))
+			timer->posted = 0;
+	}
 
 	return ret;
 }
-- 
1.7.0.4

