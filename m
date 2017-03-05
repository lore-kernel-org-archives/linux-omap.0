From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 05/10] drm: omapdrm: crtc: detect manually updated displays
Date: Sun,  5 Mar 2017 01:43:04 +0100
Message-ID: <20170305004309.28259-5-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
[tony@atomide.com: rebased on event_lock changes]
---
 drivers/gpu/drm/omapdrm/dss/omapdss.h    |  1 +
 drivers/gpu/drm/omapdrm/dss/output.c     |  6 ++++++
 drivers/gpu/drm/omapdrm/omap_connector.c |  7 +++++++
 drivers/gpu/drm/omapdrm/omap_crtc.c      | 29 +++++++++++++++++++++++++++--
 drivers/gpu/drm/omapdrm/omap_drv.h       |  2 ++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 5b3b961127bd..5666ecbe4b80 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -918,5 +918,6 @@ int dss_mgr_register_framedone_handler(enum omap_channel channel,
 		void (*handler)(void *), void *data);
 void dss_mgr_unregister_framedone_handler(enum omap_channel channel,
 		void (*handler)(void *), void *data);
+bool dss_lcd_mgr_config_get_stallmode(const struct dss_lcd_mgr_config *config);
 
 #endif /* __OMAP_DRM_DSS_H */
diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index a901af5a9bc3..08c730d1dada 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -214,6 +214,12 @@ void dss_mgr_set_lcd_config(enum omap_channel channel,
 }
 EXPORT_SYMBOL(dss_mgr_set_lcd_config);
 
+bool dss_lcd_mgr_config_get_stallmode(const struct dss_lcd_mgr_config *config)
+{
+	return config->stallmode;
+}
+EXPORT_SYMBOL(dss_lcd_mgr_config_get_stallmode);
+
 int dss_mgr_enable(enum omap_channel channel)
 {
 	return dss_mgr_ops->enable(channel);
diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index 7b2a9f680dce..b09d8989b789 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -35,6 +35,13 @@ struct omap_connector {
 	bool hdmi_mode;
 };
 
+bool omap_connector_get_manually_updated(struct drm_connector *connector)
+{
+	struct omap_connector *omap_connector = to_omap_connector(connector);
+
+	return !!(omap_connector->dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE);
+}
+
 bool omap_connector_get_hdmi_mode(struct drm_connector *connector)
 {
 	struct omap_connector *omap_connector = to_omap_connector(connector);
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 76a411fe957a..03351ca2ee41 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -35,6 +35,7 @@ struct omap_crtc {
 	enum omap_channel channel;
 
 	struct videomode vm;
+	bool manually_updated;
 
 	bool ignore_digit_sync_lost;
 
@@ -89,6 +90,12 @@ int omap_crtc_wait_pending(struct drm_crtc *crtc)
 				  msecs_to_jiffies(250));
 }
 
+bool omap_crtc_is_manual_updated(struct drm_crtc *crtc)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	return omap_crtc->manually_updated;
+}
+
 /* -----------------------------------------------------------------------------
  * DSS Manager Functions
  */
@@ -237,6 +244,9 @@ static void omap_crtc_dss_set_lcd_config(enum omap_channel channel,
 {
 	struct omap_crtc *omap_crtc = omap_crtcs[channel];
 	DBG("%s", omap_crtc->name);
+
+	omap_crtc->manually_updated = dss_lcd_mgr_config_get_stallmode(config);
+
 	dispc_mgr_set_lcd_config(omap_crtc->channel, config);
 }
 
@@ -355,10 +365,23 @@ static void omap_crtc_destroy(struct drm_crtc *crtc)
 static void omap_crtc_enable(struct drm_crtc *crtc)
 {
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
+	struct drm_connector *connector;
 	int ret;
 
 	DBG("%s", omap_crtc->name);
 
+	/* manual updated display will not trigger vsync irq */
+	/* omap_crtc->manually_updated is not yet set */
+	drm_for_each_connector(connector, crtc->dev) {
+		if (connector->state->crtc != crtc)
+			continue;
+		if (!omap_connector_get_manually_updated(connector))
+			continue;
+		dev_dbg(dev->dev, "manually updated display detected!");
+		return;
+	}
+
 	spin_lock_irq(&crtc->dev->event_lock);
 	drm_crtc_vblank_on(crtc);
 	ret = drm_crtc_vblank_get(crtc);
@@ -440,8 +463,10 @@ static void omap_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	DBG("%s: GO", omap_crtc->name);
 
-	ret = drm_crtc_vblank_get(crtc);
-	WARN_ON(ret != 0);
+	if (!omap_crtc->manually_updated) {
+		ret = drm_crtc_vblank_get(crtc);
+		WARN_ON(ret != 0);
+	}
 
 	spin_lock_irq(&crtc->dev->event_lock);
 	dispc_mgr_go(omap_crtc->channel);
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 5b1061586401..5a0106239be2 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -139,6 +139,7 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 int omap_crtc_wait_pending(struct drm_crtc *crtc);
 void omap_crtc_error_irq(struct drm_crtc *crtc, uint32_t irqstatus);
 void omap_crtc_vblank_irq(struct drm_crtc *crtc);
+bool omap_crtc_is_manual_updated(struct drm_crtc *crtc);
 
 struct drm_plane *omap_plane_init(struct drm_device *dev,
 		int id, enum drm_plane_type type,
@@ -155,6 +156,7 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 struct drm_encoder *omap_connector_attached_encoder(
 		struct drm_connector *connector);
 bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
+bool omap_connector_get_manually_updated(struct drm_connector *connector);
 void omap_connector_flush(struct drm_connector *connector,
 		int x, int y, int w, int h);
 
-- 
2.11.0
