From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 13/23] drm: omapdrm: crtc: update plane fifos on lcd config change
Date: Tue,  8 Mar 2016 17:39:45 +0100
Message-ID: <1457455195-1938-14-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Due to a hardware bug, FIFOs thresholds must be
configured very carefully for manually updated
displays.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 8967013c1fb5..094e89a2fa94 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -253,6 +253,10 @@ static void omap_crtc_dss_set_lcd_config(struct omap_overlay_manager *mgr,
 	omap_crtc->manually_updated = dss_lcd_mgr_config_get_stallmode(config);
 
 	dispc_mgr_set_lcd_config(omap_crtc->channel, config);
+
+	drm_for_each_plane(plane, dev) {
+		omap_plane_update_fifo(plane);
+	}
 }
 
 static int omap_crtc_dss_register_framedone(
-- 
2.7.0
