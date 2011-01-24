From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v10 01/18] OMAP2,3: DSS2: remove forced clk-disable from omap_dss_remove
Date: Mon, 24 Jan 2011 11:51:48 +0530
Message-ID: <1295850125-21405-2-git-send-email-sumit.semwal@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45496 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1AXGWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 01:22:25 -0500
In-Reply-To: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sumit Semwal <sumit.semwal@ti.com>

As part of omap hwmod changes, DSS will not be the only controller of its
clocks. hwmod initialization also enables the interface clocks, and
manages them.
So, when DSS is built as a module, omap_dss_remove doesn't try to disable
all clocks that have a higher usecount.

Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 drivers/video/omap2/dss/core.c |   46 ++++++---------------------------------
 1 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8e89f60..ee56859 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -623,7 +623,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int i;
-	int c;
 
 	dss_uninitialize_debugfs();
 
@@ -638,44 +637,13 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dss_exit();
 
-	/* these should be removed at some point */
-	c = core.dss_ick->usecount;
-	if (c > 0) {
-		DSSERR("warning: dss_ick usecount %d, disabling\n", c);
-		while (c-- > 0)
-			clk_disable(core.dss_ick);
-	}
-
-	c = core.dss1_fck->usecount;
-	if (c > 0) {
-		DSSERR("warning: dss1_fck usecount %d, disabling\n", c);
-		while (c-- > 0)
-			clk_disable(core.dss1_fck);
-	}
-
-	c = core.dss2_fck->usecount;
-	if (c > 0) {
-		DSSERR("warning: dss2_fck usecount %d, disabling\n", c);
-		while (c-- > 0)
-			clk_disable(core.dss2_fck);
-	}
-
-	c = core.dss_54m_fck->usecount;
-	if (c > 0) {
-		DSSERR("warning: dss_54m_fck usecount %d, disabling\n", c);
-		while (c-- > 0)
-			clk_disable(core.dss_54m_fck);
-	}
-
-	if (core.dss_96m_fck) {
-		c = core.dss_96m_fck->usecount;
-		if (c > 0) {
-			DSSERR("warning: dss_96m_fck usecount %d, disabling\n",
-					c);
-			while (c-- > 0)
-				clk_disable(core.dss_96m_fck);
-		}
-	}
+	/*
+	 * As part of hwmod changes, DSS is not the only controller of dss
+	 * clocks; hwmod framework itself will also enable clocks during hwmod
+	 * init for dss, and autoidle is set in h/w for DSS. Hence, there's no
+	 * need to disable clocks if their usecounts > 1.
+	 */
+	WARN_ON(core.num_clks_enabled > 0);
 
 	dss_put_clocks();
 
-- 
1.7.1

