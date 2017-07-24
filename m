From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 03/14] drm/omap: plane: update fifo size on ovl setup
Date: Mon, 24 Jul 2017 19:33:00 +0200
Message-ID: <20170724173311.27170-4-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This is a workaround for a hardware bug occuring on OMAP3
with manually updated panels. Details about the HW bug are
unknown to me, but without this fix the panel refresh does
not work at all on Nokia N950.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index fd7504b37e3b..b6dca5ee34d4 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -1398,6 +1398,18 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane_id plane,
 	}
 }
 
+void dispc_ovl_set_manual_fifo_threshold(enum omap_plane_id plane)
+{
+	u32 fifo_low, fifo_high;
+	bool use_fifo_merge = false;
+	bool use_manual_update = true;
+
+	dispc_ovl_compute_fifo_thresholds(plane, &fifo_low, &fifo_high,
+					  use_fifo_merge, use_manual_update);
+
+	dispc_ovl_set_fifo_threshold(plane, fifo_low, fifo_high);
+}
+
 static void dispc_ovl_set_mflag(enum omap_plane_id plane, bool enable)
 {
 	int bit;
@@ -2566,6 +2578,10 @@ static int dispc_ovl_setup(enum omap_plane_id plane,
 		oi->zorder, oi->pre_mult_alpha, oi->global_alpha,
 		oi->rotation_type, replication, vm, mem_to_mem);
 
+	/* manual mode needs other fifo thresholds */
+	if (mgr_fld_read(channel, DISPC_MGR_FLD_STALLMODE))
+		dispc_ovl_set_manual_fifo_threshold(plane);
+
 	return r;
 }
 
-- 
2.13.2
