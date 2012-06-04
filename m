From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 06/12] ARM: OMAP1: Fix dmtimer support
Date: Mon, 4 Jun 2012 14:41:43 -0500
Message-ID: <1338838909-25356-7-git-send-email-jon-hunter@ti.com>
References: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59988 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab2FDTmJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 15:42:09 -0400
In-Reply-To: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

OMAP1 dmtimer support is currently broken. When a dmtimer is requested by the
omap_dm_timer_request() function fails to allocate a dmtimer because the call
to clk_get() inside omap_dm_timer_prepare fails. The clk_get() fails simply
because the clock data for the OMAP1 dmtimers is not present.

Ideally this should be fixed by moving OMAP1 dmtimers to use the clock
framework. For now simply fix this by using the "TIMER_NEEDS_RESET" flag to
identify an OMAP1 device and avoid calling clk_get(). Although this is not
the ideal fix and should be corrected, this flag has already been use for the
same purpose in omap_dm_timer_stop().

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 30742d8e6..d284b5d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -137,11 +137,17 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 	int ret;
 
-	timer->fclk = clk_get(&timer->pdev->dev, "fck");
-	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
-		timer->fclk = NULL;
-		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
-		return -EINVAL;
+	/*
+	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
+	 * do not call clk_get() for these devices.
+	 */
+	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
+		timer->fclk = clk_get(&timer->pdev->dev, "fck");
+		if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+			timer->fclk = NULL;
+			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
+			return -EINVAL;
+		}
 	}
 
 	if (pdata->needs_manual_reset)
-- 
1.7.9.5

