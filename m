From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 11/23] include: video: omapdss: provide fifo threshold methods
Date: Tue,  8 Mar 2016 17:39:43 +0100
Message-ID: <1457455195-1938-12-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The FIFO thresholds must be configured by omapdrm for
manually updated DSI panels due to a hardware bug.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 include/video/omapdss.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9bde65b79220..f6cdd809ae5c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -935,6 +935,12 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool replication, const struct omap_video_timings *mgr_timings,
 		bool mem_to_mem);
 
+void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
+		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
+		bool manual_update);
+void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
+
+
 int omapdss_compat_init(void);
 void omapdss_compat_uninit(void);
 
-- 
2.7.0
