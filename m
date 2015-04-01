From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4 1/7] drm/tilcdc: Fix module unloading
Date: Wed, 1 Apr 2015 11:49:25 +0300
Message-ID: <7bf4ec2424642563f561785a9188ed7eb97d8b72.1427877412.git.jsarha@ti.com>
References: <cover.1427877412.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39310 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbDAIzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2015 04:55:31 -0400
In-Reply-To: <cover.1427877412.git.jsarha@ti.com>
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

