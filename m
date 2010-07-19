From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/3] OMAP: DSS2: Zorder functions for DISPC
Date: Mon, 19 Jul 2010 17:40:06 +0530
Message-ID: <1279541407-17711-3-git-send-email-archit@ti.com>
References: <1279541407-17711-1-git-send-email-archit@ti.com>
 <1279541407-17711-2-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47259 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760638Ab0GSMKX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 08:10:23 -0400
In-Reply-To: <1279541407-17711-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Samreen <samreen@ti.com>, Archit Taneja <archit@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Adds OMAP4 Zorder support by introducing Zorder set and enable
functions in dispc.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   23 +++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h     |    3 +++
 drivers/video/omap2/dss/manager.c |    4 ++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f6f92d2..af96df9
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1174,6 +1174,29 @@ void dispc_set_burst_size(enum omap_plane plane,
 	enable_clocks(0);
 }
 
+void dispc_set_zorder(enum omap_plane plane,
+			enum omap_overlay_zorder zorder)
+{
+	u32 val;
+
+	if (!cpu_is_omap44xx())
+		return;
+	val = dispc_read_reg(dispc_reg_att[plane]);
+	val = FLD_MOD(val, zorder, 27, 26);
+	dispc_write_reg(dispc_reg_att[plane], val);
+}
+
+void dispc_enable_zorder(enum omap_plane plane, bool enable)
+{
+	u32 val;
+
+	if (!cpu_is_omap44xx())
+		return;
+	val = dispc_read_reg(dispc_reg_att[plane]);
+	val = FLD_MOD(val, enable, 25, 25);
+	dispc_write_reg(dispc_reg_att[plane], val);
+}
+
 static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 {
 	u32 val;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a954a55..c8cccd7
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -343,6 +343,9 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high);
 void dispc_enable_fifomerge(bool enable);
 void dispc_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size);
+void dispc_set_zorder(enum omap_plane plane,
+			enum omap_overlay_zorder zorder);
+void dispc_enable_zorder(enum omap_plane plane, bool enable);
 
 void dispc_set_plane_ba0(enum omap_plane plane, u32 paddr);
 void dispc_set_plane_ba1(enum omap_plane plane, u32 paddr);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 96073f5..80e56b7
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -417,6 +417,7 @@ struct overlay_cache_data {
 	u32 fifo_high;
 
 	bool manual_update;
+	enum omap_overlay_zorder zorder;
 };
 
 struct manager_cache_data {
@@ -864,6 +865,8 @@ static int configure_overlay(enum omap_plane plane)
 	dispc_enable_replication(plane, c->replication);
 
 	dispc_set_burst_size(plane, c->burst_size);
+	dispc_set_zorder(plane, c->zorder);
+	dispc_enable_zorder(plane, 1);
 	dispc_setup_plane_fifo(plane, c->fifo_low, c->fifo_high);
 
 	dispc_enable_plane(plane, 1);
@@ -1276,6 +1279,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		oc->out_width = ovl->info.out_width;
 		oc->out_height = ovl->info.out_height;
 		oc->global_alpha = ovl->info.global_alpha;
+		oc->zorder = ovl->info.zorder;
 
 		oc->replication =
 			dss_use_replication(dssdev, ovl->info.color_mode);
-- 
1.5.4.7

