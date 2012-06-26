From: Archit Taneja <archit@ti.com>
Subject: [PATCH 12/17] OMAPDSS: Add interlace parameter to omap_video_timings
Date: Tue, 26 Jun 2012 15:06:49 +0530
Message-ID: <1340703414-1915-14-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41561 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756173Ab2FZJjN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:39:13 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a parameter called interlace which tells whether the timings are in
interlaced or progressive mode. This aligns the omap_video_timings struct with
the Xorg modeline configuration.

It also removes the hack needed to write to divide the manager height by 2 if
the connected interface is VENC.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    6 +-----
 drivers/video/omap2/dss/venc.c  |    4 ++++
 include/video/omapdss.h         |    3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9b22563..92b6428 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2710,11 +2710,7 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 
 		DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
 	} else {
-		enum dss_hdmi_venc_clk_source_select source;
-
-		source = dss_get_hdmi_venc_clk_source();
-
-		if (source == DSS_VENC_TV_CLK)
+		if (t.interlace == true)
 			t.y_res /= 2;
 	}
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 3552305..494f763 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -272,6 +272,8 @@ const struct omap_video_timings omap_dss_pal_timings = {
 	.vsw		= 5,
 	.vfp		= 5,
 	.vbp		= 41,
+
+	.interlace	= true,
 };
 EXPORT_SYMBOL(omap_dss_pal_timings);
 
@@ -285,6 +287,8 @@ const struct omap_video_timings omap_dss_ntsc_timings = {
 	.vsw		= 6,
 	.vfp		= 6,
 	.vbp		= 31,
+
+	.interlace	= true,
 };
 EXPORT_SYMBOL(omap_dss_ntsc_timings);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5de5c9c..1498bb3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -390,6 +390,9 @@ struct omap_video_timings {
 	 * default value: OMAPDSS_SIG_ACTIVE_HIGH
 	 */
 	enum omap_dss_signal_level hsync_level;
+
+	/* Interlaced or Progressive timings */
+	bool interlace;
 	/*
 	 * Pixel clock edge to drive LCD data
 	 * default value: OMAPDSS_SIG_ACTIVE_HIGH
-- 
1.7.9.5

