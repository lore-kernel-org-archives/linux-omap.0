From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 13/18] OMAPDSS: DISPC: Add function to set channel in for writeback
Date: Tue, 25 Sep 2012 11:49:48 +0530
Message-ID: <1348553993-8083-14-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48604 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228Ab2IYGUg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:36 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback can take input from either one of the overlays, or one of the overlay
managers. Add an enum which represents the channel_in for writeback, and maps
to the register field programming.

Add a function to configure channel in for writeback. This will be used later in
APPLY.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    7 +++++++
 drivers/video/omap2/dss/dss.h   |   13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d9ca7bf..6d482f5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -983,6 +983,13 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 	return channel;
 }
 
+void dispc_wb_set_channel_in(enum dss_writeback_channel channel)
+{
+	enum omap_plane plane = OMAP_DSS_WB;
+
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), channel, 18, 16);
+}
+
 static void dispc_ovl_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 04a1eda..872e420 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -113,6 +113,17 @@ enum dss_dsi_content_type {
 	DSS_DSI_CONTENT_GENERIC,
 };
 
+enum dss_writeback_channel {
+	DSS_WB_LCD1_MGR =	0,
+	DSS_WB_LCD2_MGR =	1,
+	DSS_WB_TV_MGR =		2,
+	DSS_WB_OVL0 =		3,
+	DSS_WB_OVL1 =		4,
+	DSS_WB_OVL2 =		5,
+	DSS_WB_OVL3 =		6,
+	DSS_WB_LCD3_MGR =	7,
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
@@ -471,6 +482,8 @@ int dispc_mgr_get_clock_div(enum omap_channel channel,
 void dispc_mgr_setup(enum omap_channel channel,
 		struct omap_overlay_manager_info *info);
 
+void dispc_wb_set_channel_in(enum dss_writeback_channel channel);
+
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
 int venc_init_platform_driver(void) __init;
-- 
1.7.9.5

