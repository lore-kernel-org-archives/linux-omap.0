From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 1/6] drm/tilcdc: Fix module unloading
Date: Fri, 8 May 2015 14:27:14 +0300
Message-ID: <67d7bc9aa6dc55a7bf851e6493463077166a25c4.1431083641.git.jsarha@ti.com>
References: <cover.1431083641.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59317 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbbEHL1o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2015 07:27:44 -0400
In-Reply-To: <cover.1431083641.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

Force crtc dpms off before destroying the crtc instead of just
checking the dpms state. This fixes warning message and frozen picture
after tilcdc module unloading.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index c735884..c2d5980 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -135,11 +135,12 @@ static void stop(struct drm_crtc *crtc)
 	tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
 }
 
+static void tilcdc_crtc_dpms(struct drm_crtc *crtc, int mode);
 static void tilcdc_crtc_destroy(struct drm_crtc *crtc)
 {
 	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
 
-	WARN_ON(tilcdc_crtc->dpms == DRM_MODE_DPMS_ON);
+	tilcdc_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
 
 	drm_crtc_cleanup(crtc);
 	drm_flip_work_cleanup(&tilcdc_crtc->unref_work);
-- 
1.9.1

