From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 08/23] drm: omapdrm: crtc: add enabled bit to state
Date: Tue,  8 Mar 2016 17:39:40 +0100
Message-ID: <1457455195-1938-9-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 5ef27664bcfa..78ef9773cca1 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -207,6 +207,8 @@ static int omap_crtc_dss_enable(struct omap_overlay_manager *mgr)
 			&omap_crtc->timings);
 	omap_crtc_set_enabled(&omap_crtc->base, true);
 
+	set_bit(crtc_enabled, &omap_crtc->state);
+
 	return 0;
 }
 
@@ -214,6 +216,8 @@ static void omap_crtc_dss_disable(struct omap_overlay_manager *mgr)
 {
 	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
 
+	clear_bit(crtc_enabled, &omap_crtc->state);
+
 	omap_crtc_set_enabled(&omap_crtc->base, false);
 }
 
-- 
2.7.0
