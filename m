From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 02/10] OMAP: DSS2: Pass overlay replication and fifo thresholds as arguments to dispc_ovl_setup()
Date: Wed, 14 Sep 2011 17:53:28 +0530
Message-ID: <1316003008-24192-3-git-send-email-archit@ti.com>
References: <1316003008-24192-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38782 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370Ab1INMWY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:22:24 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECMOGn023891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:24 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECMOUD010960
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:24 -0500 (CDT)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECMOh4029214
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:24 -0500 (CDT)
In-Reply-To: <1316003008-24192-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dispc_ovl_enable_replication() and dispc_ovl_set_fifo_threshold() are currently
called in configure_overlay(). These are the only functions which cause DISPC
register writes of overlay parameters outside of dispc_ovl_setup().

Move these to dispc_ovl_setup() and pass replication, fifo_low and fifo_high
thresholds as arguments to dispc_ovl_setup() in order to be aligned with other
overlay parameters. No functional changes are made.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   20 +++++++++++++-------
 drivers/video/omap2/dss/dss.h     |    5 ++---
 drivers/video/omap2/dss/manager.c |    7 ++-----
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f01a26d..fbcefce 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -971,7 +971,7 @@ static void dispc_ovl_set_vid_color_conv(enum omap_plane plane, bool enable)
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
-void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
+static void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
 {
 	static const unsigned shifts[] = { 5, 10, 10 };
 	int shift;
@@ -1019,7 +1019,8 @@ u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
 	return dispc.fifo_size[plane];
 }
 
-void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
+static void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low,
+		u32 high)
 {
 	u8 hi_start, hi_end, lo_start, lo_end;
 	u32 unit;
@@ -1675,7 +1676,8 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 }
 
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, enum omap_channel channel)
+		bool ilace, enum omap_channel channel, bool replication,
+		u32 fifo_low, u32 fifo_high)
 {
 	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
 	bool five_taps = 0;
@@ -1688,10 +1690,11 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	unsigned int field_offset = 0;
 
 	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
-		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d\n",
-		plane, oi->paddr, oi->p_uv_addr, oi->screen_width, oi->pos_x,
-		oi->pos_y, oi->width, oi->height, oi->out_width, oi->out_height,
-		oi->color_mode, oi->rotation, oi->mirror, ilace, channel);
+		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d repl %d "
+		"fifo_low %d fifo high %d\n", plane, oi->paddr, oi->p_uv_addr,
+		oi->screen_width, oi->pos_x, oi->pos_y, oi->width, oi->height,
+		oi->out_width, oi->out_height, oi->color_mode, oi->rotation,
+		oi->mirror, ilace, channel, replication, fifo_low, fifo_high);
 
 	if (oi->paddr == 0)
 		return -EINVAL;
@@ -1839,6 +1842,9 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 
 	dispc_ovl_set_channel_out(plane, channel);
 
+	dispc_ovl_enable_replication(plane, replication);
+	dispc_ovl_set_fifo_threshold(plane, fifo_low, fifo_high);
+
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index bcc9c4e..dff9b79 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -400,12 +400,11 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 
 
 u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
-void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 u32 dispc_ovl_get_burst_size(enum omap_plane plane);
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, enum omap_channel channel);
+		bool ilace, enum omap_channel channel, bool replication,
+		u32 fifo_low, u32 fifo_high);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
-void dispc_ovl_enable_replication(enum omap_plane plane, bool enable);
 
 
 void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index f1c334c..fdbbeeb 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -940,7 +940,8 @@ static int configure_overlay(enum omap_plane plane)
 	new_oi.out_height = outh;
 	new_oi.paddr = paddr;
 
-	r = dispc_ovl_setup(plane, &new_oi, c->ilace, c->channel);
+	r = dispc_ovl_setup(plane, &new_oi, c->ilace, c->channel,
+		c->replication, c->fifo_low, c->fifo_high);
 	if (r) {
 		/* this shouldn't happen */
 		DSSERR("dispc_ovl_setup failed for ovl %d\n", plane);
@@ -948,10 +949,6 @@ static int configure_overlay(enum omap_plane plane)
 		return r;
 	}
 
-	dispc_ovl_enable_replication(plane, c->replication);
-
-	dispc_ovl_set_fifo_threshold(plane, c->fifo_low, c->fifo_high);
-
 	dispc_ovl_enable(plane, 1);
 
 	return 0;
-- 
1.7.1

