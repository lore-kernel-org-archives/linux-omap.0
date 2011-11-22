From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/65] OMAPDSS: separate overlay channel from ovl_setup
Date: Tue, 22 Nov 2011 11:21:12 +0200
Message-ID: <1321953724-6350-14-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48084 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757425Ab1KVJXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:02 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Overlay channel is configured with ovl_setup, with all the other overlay
attriutes. This patch separates overlay channel setup so that we can
later configure the channel only when needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   40 ++++++++++++++++++++++++++++++++++--
 drivers/video/omap2/dss/dss.h     |    2 +-
 drivers/video/omap2/dss/manager.c |    4 ++-
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 55cfbc9..ab86a78 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -922,6 +922,39 @@ void dispc_ovl_set_channel_out(enum omap_plane plane, enum omap_channel channel)
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
+static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
+{
+	int shift;
+	u32 val;
+	enum omap_channel channel;
+
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		shift = 8;
+		break;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+	case OMAP_DSS_VIDEO3:
+		shift = 16;
+		break;
+	default:
+		BUG();
+	}
+
+	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
+
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		if (FLD_GET(val, 31, 30) == 0)
+			channel = FLD_GET(val, shift, shift);
+		else
+			channel = OMAP_DSS_CHANNEL_LCD2;
+	} else {
+		channel = FLD_GET(val, shift, shift);
+	}
+
+	return channel;
+}
+
 static void dispc_ovl_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
@@ -1769,7 +1802,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 }
 
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, enum omap_channel channel, bool replication)
+		bool ilace, bool replication)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	bool five_taps = false;
@@ -1781,6 +1814,9 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	u16 frame_height = oi->height;
 	unsigned int field_offset = 0;
 	u16 outw, outh;
+	enum omap_channel channel;
+
+	channel = dispc_ovl_get_channel_out(plane);
 
 	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
 		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d repl %d\n",
@@ -1892,8 +1928,6 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	dispc_ovl_set_pre_mult_alpha(plane, oi->pre_mult_alpha);
 	dispc_ovl_setup_global_alpha(plane, oi->global_alpha);
 
-	dispc_ovl_set_channel_out(plane, channel);
-
 	dispc_ovl_enable_replication(plane, replication);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 61001c3..bc1b2cc 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -397,7 +397,7 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
 u32 dispc_ovl_get_burst_size(enum omap_plane plane);
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, enum omap_channel channel, bool replication);
+		bool ilace, bool replication);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index b47c1fa..42740d3 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -777,7 +777,9 @@ static int configure_overlay(enum omap_plane plane)
 
 	ilace = ovl->manager->device->type == OMAP_DISPLAY_TYPE_VENC;
 
-	r = dispc_ovl_setup(plane, oi, ilace, c->channel, replication);
+	dispc_ovl_set_channel_out(plane, c->channel);
+
+	r = dispc_ovl_setup(plane, oi, ilace, replication);
 	if (r) {
 		/* this shouldn't happen */
 		DSSERR("dispc_ovl_setup failed for ovl %d\n", plane);
-- 
1.7.4.1

