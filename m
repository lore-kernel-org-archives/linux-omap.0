From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 15/23] drm: omapdrm: crtc: add support for manual updated displays
Date: Tue,  8 Mar 2016 17:39:47 +0100
Message-ID: <1457455195-1938-16-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 91 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/omapdrm/omap_drv.h  |  2 +
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 3ce7143e5a5f..10d2647965c2 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -51,12 +51,14 @@ struct omap_crtc {
 	bool manually_updated;
 
 	struct omap_drm_irq vblank_irq;
+	struct omap_drm_irq framedone_irq;
 	struct omap_drm_irq error_irq;
 
 	bool ignore_digit_sync_lost;
 
 	unsigned long state;
 	wait_queue_head_t pending_wait;
+	struct delayed_work update_work;
 
 	void (*framedone_handler)(void *);
 	void *framedone_handler_data;
@@ -91,7 +93,7 @@ int omap_crtc_wait_pending(struct drm_crtc *crtc)
 
 	return wait_event_timeout(omap_crtc->pending_wait,
 				  !test_bit(crtc_pending, &omap_crtc->state),
-				  msecs_to_jiffies(50));
+				  msecs_to_jiffies(250));
 }
 
 bool omap_crtc_is_manual_updated(struct drm_crtc *crtc)
@@ -141,6 +143,15 @@ static void omap_crtc_dss_disconnect(struct omap_overlay_manager *mgr,
 
 static void omap_crtc_dss_start_update(struct omap_overlay_manager *mgr)
 {
+	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
+	struct drm_device *dev = omap_crtc->base.dev;
+	enum omap_channel channel = omap_crtc->channel;
+
+	WARN_ON(dispc_mgr_is_enabled(channel));
+
+	omap_irq_register(dev, &omap_crtc->framedone_irq);
+
+	dispc_mgr_enable(channel, true);
 }
 
 /* Called only from the encoder enable/disable and suspend/resume handlers. */
@@ -209,8 +220,11 @@ static void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
 static int omap_crtc_dss_enable(struct omap_overlay_manager *mgr)
 {
 	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
+	struct drm_device *dev = omap_crtc->base.dev;
 	struct omap_overlay_manager_info info;
 
+	dev_dbg(dev->dev, "crtc dss enable %s", omap_crtc->name);
+
 	memset(&info, 0, sizeof(info));
 	info.default_color = 0x00000000;
 	info.trans_key = 0x00000000;
@@ -230,6 +244,9 @@ static int omap_crtc_dss_enable(struct omap_overlay_manager *mgr)
 static void omap_crtc_dss_disable(struct omap_overlay_manager *mgr)
 {
 	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
+	struct drm_device *dev = omap_crtc->base.dev;
+
+	dev_dbg(dev->dev, "crtc dss disable %s", omap_crtc->name);
 
 	clear_bit(crtc_enabled, &omap_crtc->state);
 
@@ -376,6 +393,63 @@ static void omap_crtc_vblank_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
 	wake_up(&omap_crtc->pending_wait);
 }
 
+static void omap_crtc_framedone_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
+{
+	struct omap_crtc *omap_crtc =
+			container_of(irq, struct omap_crtc, framedone_irq);
+	struct drm_device *dev = omap_crtc->base.dev;
+
+	if (omap_crtc->framedone_handler)
+		omap_crtc->framedone_handler(omap_crtc->framedone_handler_data);
+
+	__omap_irq_unregister(dev, &omap_crtc->framedone_irq);
+
+	clear_bit(crtc_pending, &omap_crtc->state);
+	wake_up(&omap_crtc->pending_wait);
+}
+
+void omap_crtc_flush(struct drm_crtc *crtc,
+		int x, int y, int w, int h)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+
+	if (!omap_crtc->manually_updated)
+		return;
+
+	if (!test_bit(crtc_enabled, &omap_crtc->state))
+		return;
+
+	if (!delayed_work_pending(&omap_crtc->update_work))
+		schedule_delayed_work(&omap_crtc->update_work, 0);
+}
+
+static void omap_crtc_manual_display_update(struct work_struct *data)
+{
+	struct omap_crtc *omap_crtc = container_of(data, struct omap_crtc,
+					update_work.work);
+	struct omap_dss_device *dssdev = omap_crtc->mgr->output->dst;
+	struct omap_dss_driver *dssdrv = dssdev->driver;
+	int ret;
+
+	if (!dssdrv || !dssdrv->update)
+		return;
+
+	if (!test_bit(crtc_enabled, &omap_crtc->state))
+		return;
+
+	if (test_and_set_bit(crtc_pending, &omap_crtc->state))
+		return;
+
+	if (dssdrv->sync)
+		dssdrv->sync(dssdev);
+
+	ret = dssdrv->update(dssdev, 0, 0, omap_crtc->timings.x_res, omap_crtc->timings.y_res);
+	if (ret < 0) {
+		clear_bit(crtc_pending, &omap_crtc->state);
+		wake_up(&omap_crtc->pending_wait);
+	}
+}
+
 /* -----------------------------------------------------------------------------
  * CRTC Functions
  */
@@ -407,7 +481,7 @@ static void omap_crtc_enable(struct drm_crtc *crtc)
 	struct omap_dss_device *display = omap_crtc->mgr->output->dst;
 	struct drm_device *dev = crtc->dev;
 
-	DBG("%s", omap_crtc->name);
+	dev_dbg(dev->dev, "enable crtc %s", omap_crtc->name);
 
 	/* manual updated display will not trigger vsync irq */
 	/* omap_crtc->manually_updated is not yet set */
@@ -427,8 +501,14 @@ static void omap_crtc_enable(struct drm_crtc *crtc)
 static void omap_crtc_disable(struct drm_crtc *crtc)
 {
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 
-	DBG("%s", omap_crtc->name);
+	dev_dbg(dev->dev, "disable crtc %s", omap_crtc->name);
+
+	cancel_delayed_work(&omap_crtc->update_work);
+
+	if (!omap_crtc_wait_pending(crtc))
+		dev_warn(dev->dev, "manual display update did not finish!");
 
 	drm_crtc_vblank_off(crtc);
 }
@@ -571,6 +651,8 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 
 	init_waitqueue_head(&omap_crtc->pending_wait);
 
+	INIT_DELAYED_WORK(&omap_crtc->update_work, omap_crtc_manual_display_update);
+
 	omap_crtc->state = 0;
 
 	omap_crtc->channel = channel;
@@ -579,6 +661,9 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 	omap_crtc->vblank_irq.irqmask = pipe2vbl(crtc);
 	omap_crtc->vblank_irq.irq = omap_crtc_vblank_irq;
 
+	omap_crtc->framedone_irq.irqmask = dispc_mgr_get_framedone_irq(omap_crtc->channel);
+	omap_crtc->framedone_irq.irq = omap_crtc_framedone_irq;
+
 	omap_crtc->error_irq.irqmask =
 			dispc_mgr_get_sync_lost_irq(channel);
 	omap_crtc->error_irq.irq = omap_crtc_error_irq;
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 3ab4919aff4b..e08f4ef1bf3c 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -174,6 +174,8 @@ struct drm_encoder *omap_connector_attached_encoder(
 bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
 void omap_connector_flush(struct drm_connector *connector,
 		int x, int y, int w, int h);
+void omap_crtc_flush(struct drm_crtc *crtc,
+		int x, int y, int w, int h);
 
 void copy_timings_omap_to_drm(struct drm_display_mode *mode,
 		struct omap_video_timings *timings);
-- 
2.7.0
