From: Archit Taneja <archit@ti.com>
Subject: [PATCH 20/21] OMAPDSS: DISPC: Add manager like functions for writeback
Date: Thu, 13 Sep 2012 17:45:04 +0530
Message-ID: <1347538505-25359-21-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39529 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757976Ab2IMMQD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:16:03 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add functions to enable writeback, and set/check state of GO bit. These bits are
identical in behaviour with the corresponding overlay manager bits. Configure
them in a similar way to mgr_enable() and mgr_go_* functions. Add a helper to
get the FRAMEDONE irq corresponding to writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   70 +++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h   |    5 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6068271..1623c9b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -535,6 +535,11 @@ u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
 	return mgr_desc[channel].framedone_irq;
 }
 
+u32 dispc_wb_get_framedone_irq(void)
+{
+	return DISPC_IRQ_FRAMEDONEWB;
+}
+
 bool dispc_mgr_go_busy(enum omap_channel channel)
 {
 	return mgr_fld_read(channel, DISPC_MGR_FLD_GO) == 1;
@@ -562,6 +567,30 @@ void dispc_mgr_go(enum omap_channel channel)
 	mgr_fld_write(channel, DISPC_MGR_FLD_GO, 1);
 }
 
+bool dispc_wb_go_busy(void)
+{
+	return REG_GET(DISPC_CONTROL2, 6, 6) == 1;
+}
+
+void dispc_wb_go(void)
+{
+	enum omap_plane plane = OMAP_DSS_WB;
+	bool enable, go;
+
+	enable = REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0) == 1;
+
+	if (!enable)
+		return;
+
+	go = REG_GET(DISPC_CONTROL2, 6, 6) == 1;
+	if (go) {
+		DSSERR("GO bit not down for WB\n");
+		return;
+	}
+
+	REG_FLD_MOD(DISPC_CONTROL2, 1, 6, 6);
+}
+
 static void dispc_plane_write_firh_reg(enum omap_plane plane, int reg,
 		u32 value)
 {
@@ -2678,6 +2707,47 @@ void dispc_mgr_enable(enum omap_channel channel, bool enable)
 		BUG();
 }
 
+void dispc_wb_enable(bool enable)
+{
+	enum omap_plane plane = OMAP_DSS_WB;
+	struct completion frame_done_completion;
+	bool is_on;
+	int r;
+	u32 irq;
+
+	is_on = REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
+	irq = DISPC_IRQ_FRAMEDONEWB;
+
+	if (!enable && is_on) {
+		init_completion(&frame_done_completion);
+
+		r = omap_dispc_register_isr(dispc_disable_isr,
+				&frame_done_completion, irq);
+		if (r)
+			DSSERR("failed to register FRAMEDONEWB isr\n");
+	}
+
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 0, 0);
+
+	if (!enable && is_on) {
+		if (!wait_for_completion_timeout(&frame_done_completion,
+					msecs_to_jiffies(100)))
+			DSSERR("timeout waiting for FRAMEDONEWB\n");
+
+		r = omap_dispc_unregister_isr(dispc_disable_isr,
+				&frame_done_completion, irq);
+		if (r)
+			DSSERR("failed to unregister FRAMEDONEWB isr\n");
+	}
+}
+
+bool dispc_wb_is_enabled(void)
+{
+	enum omap_plane plane = OMAP_DSS_WB;
+
+	return REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
+}
+
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
 	if (!dss_has_feature(FEAT_LCDENABLEPOL))
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c49c054..59ea86a 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -481,6 +481,11 @@ int dispc_mgr_get_clock_div(enum omap_channel channel,
 void dispc_mgr_setup(enum omap_channel channel,
 		struct omap_overlay_manager_info *info);
 
+u32 dispc_wb_get_framedone_irq(void);
+bool dispc_wb_go_busy(void);
+void dispc_wb_go(void);
+void dispc_wb_enable(bool enable);
+bool dispc_wb_is_enabled(void);
 void dispc_wb_set_channel_in(enum dss_writeback_channel channel);
 int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
 		bool mem_to_mem, const struct omap_video_timings *timings);
-- 
1.7.9.5

