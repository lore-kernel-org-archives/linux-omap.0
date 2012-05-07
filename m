From: Archit Taneja <archit@ti.com>
Subject: [PATCH 5/6] OMAPDSS: Fix DSI_FCLK clock source selection
Date: Mon, 7 May 2012 16:51:35 +0530
Message-ID: <1336389696-21636-6-git-send-email-archit@ti.com>
References: <1336389696-21636-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58543 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755567Ab2EGLWl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 07:22:41 -0400
In-Reply-To: <1336389696-21636-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The wrong bit field was being updated in DSS_CTRL when trying to configure the
clock source of DSI2 functional clock. Use the correct bit field based on the
dsi module number.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index e731aa4..e212acb 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -335,7 +335,7 @@ void dss_select_dsi_clk_source(int dsi_module,
 		enum omap_dss_clk_source clk_src)
 {
 	struct platform_device *dsidev;
-	int b;
+	int b, pos;
 
 	switch (clk_src) {
 	case OMAP_DSS_CLK_SRC_FCK:
@@ -357,7 +357,8 @@ void dss_select_dsi_clk_source(int dsi_module,
 		BUG();
 	}
 
-	REG_FLD_MOD(DSS_CONTROL, b, 1, 1);	/* DSI_CLK_SWITCH */
+	pos = dsi_module == 0 ? 1 : 10;
+	REG_FLD_MOD(DSS_CONTROL, b, pos, pos);	/* DSIx_CLK_SWITCH */
 
 	dss.dsi_clk_source[dsi_module] = clk_src;
 }
-- 
1.7.5.4

