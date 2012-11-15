From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/32] OMAPDSS: DISPC: Remove blocking code from dispc_wb_enable()
Date: Thu, 15 Nov 2012 17:58:14 +0200
Message-ID: <1352995120-3288-7-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52163 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768185Ab2KOP7S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:18 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

WB will not be used with compat-mode, i.e. from omapfb. This means we
don't need the current complex dispc_wb_enable function, but can have a
simple register write version of the function.

This patch removes all the extra code from dispc_wb_enable()

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0972bd3..0dca3ff 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2804,43 +2804,12 @@ void dispc_mgr_disable_sync(enum omap_channel channel)
 
 void dispc_wb_enable(bool enable)
 {
-	enum omap_plane plane = OMAP_DSS_WB;
-	struct completion frame_done_completion;
-	bool is_on;
-	int r;
-	u32 irq;
-
-	is_on = REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
-	irq = DISPC_IRQ_FRAMEDONEWB;
-
-	if (!enable && is_on) {
-		init_completion(&frame_done_completion);
-
-		r = omap_dispc_register_isr(dispc_mgr_disable_isr,
-				&frame_done_completion, irq);
-		if (r)
-			DSSERR("failed to register FRAMEDONEWB isr\n");
-	}
-
-	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 0, 0);
-
-	if (!enable && is_on) {
-		if (!wait_for_completion_timeout(&frame_done_completion,
-					msecs_to_jiffies(100)))
-			DSSERR("timeout waiting for FRAMEDONEWB\n");
-
-		r = omap_dispc_unregister_isr(dispc_mgr_disable_isr,
-				&frame_done_completion, irq);
-		if (r)
-			DSSERR("failed to unregister FRAMEDONEWB isr\n");
-	}
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(OMAP_DSS_WB), enable ? 1 : 0, 0, 0);
 }
 
 bool dispc_wb_is_enabled(void)
 {
-	enum omap_plane plane = OMAP_DSS_WB;
-
-	return REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
+	return REG_GET(DISPC_OVL_ATTRIBUTES(OMAP_DSS_WB), 0, 0);
 }
 
 static void dispc_lcd_enable_signal_polarity(bool act_high)
-- 
1.7.10.4

