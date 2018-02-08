From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Thu, 8 Feb 2018 10:41:05 +0100
Message-ID: <20180208094105.GB4595@amd>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <5c747b23-c586-4997-cf92-2725483343c5@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c747b23-c586-4997-cf92-2725483343c5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I've also picked patches 7-12.

It seems that part of the support made it to v4.16. Is it supposed to
be complete?

I still have these in my tree, and result works on Nokia N9. Is there
any way I can help with the merge?

Best regards,

								Pavel

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/=
drm/omapdrm/displays/panel-dsi-cm.c
index 15399a1..39b26cf 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -33,8 +33,6 @@
 #define TCH 0
=20
 #define DCS_READ_NUM_ERRORS	0x05
-#define DCS_BRIGHTNESS		0x51
-#define DCS_CTRL_DISPLAY	0x53
 #define DCS_GET_ID1		0xda
 #define DCS_GET_ID2		0xdb
 #define DCS_GET_ID3		0xdc
@@ -385,7 +383,8 @@ static int dsicm_bl_update_status(struct backlight_devi=
ce *dev)
=20
 		r =3D dsicm_wake_up(ddata);
 		if (!r)
-			r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, level);
+			r =3D dsicm_dcs_write_1(ddata, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
+					      level);
=20
 		in->ops.dsi->bus_unlock(in);
 	}
@@ -667,11 +666,11 @@ static int dsicm_power_on(struct panel_drv_data *ddat=
a)
 	if (r)
 		goto err;
=20
-	r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff);
+	r =3D dsicm_dcs_write_1(ddata, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
 	if (r)
 		goto err;
=20
-	r =3D dsicm_dcs_write_1(ddata, DCS_CTRL_DISPLAY,
+	r =3D dsicm_dcs_write_1(ddata, MIPI_DCS_WRITE_CONTROL_DISPLAY,
 			(1<<2) | (1<<5));	/* BL | BCTRL */
 	if (r)
 		goto err;
@@ -685,6 +684,8 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 	if (r)
 		goto err;
=20
+	mdelay(1000);
+
 	r =3D _dsicm_enable_te(ddata, ddata->te_enabled);
 	if (r)
 		goto err;
@@ -1100,7 +1101,8 @@ static int dsicm_memory_read(struct omap_dss_device *=
dssdev,
 		goto err2;
=20
 	while (buf_used < size) {
-		u8 dcs_cmd =3D first ? 0x2e : 0x3e;
+		u8 dcs_cmd =3D first ? MIPI_DCS_READ_MEMORY_START :
+								MIPI_DCS_READ_MEMORY_CONTINUE;
 		first =3D 0;
=20
 		r =3D in->ops.dsi->dcs_read(in, ddata->channel, dcs_cmd,
@@ -1378,6 +1380,7 @@ static int dsicm_probe(struct platform_device *pdev)
 	if (ddata->use_dsi_backlight) {
 		struct backlight_properties props =3D { 0 };
 		props.max_brightness =3D 255;
+		props.brightness =3D 128;
 		props.type =3D BACKLIGHT_RAW;
=20
 		bldev =3D devm_backlight_device_register(dev, dev_name(dev),
@@ -1396,6 +1399,18 @@ static int dsicm_probe(struct platform_device *pdev)
 		goto err_bl;
 	}
=20
+#if 0
+	mutex_lock(&ddata->lock);
+	ddata->in->ops.dsi->bus_lock(ddata->in);
+	r =3D dsicm_wake_up(ddata);
+	if (!r)
+		r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff);
+	r =3D dsicm_dcs_write_1(ddata, DCS_CTRL_DISPLAY,
+			(1<<2) | (1<<5));	/* BL | BCTRL */
+	r =3D dsicm_dcs_write_0(ddata, MIPI_DCS_SET_DISPLAY_ON);
+	ddata->in->ops.dsi->bus_unlock(ddata->in);
+	mutex_unlock(&ddata->lock);
+#endif
 	return 0;
=20
 err_bl:
diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/=
dss/dispc.c
index 4e8f68e..e63a783 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -1489,6 +1489,18 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_pla=
ne_id plane,
 	}
 }
=20
+void dispc_ovl_set_manual_fifo_threshold(enum omap_plane_id plane)
+{
+	u32 fifo_low, fifo_high;
+	bool use_fifo_merge =3D false;
+	bool use_manual_update =3D true;
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
@@ -2652,6 +2664,10 @@ static int dispc_ovl_setup(enum omap_plane_id plane,
 		oi->zorder, oi->pre_mult_alpha, oi->global_alpha,
 		oi->rotation_type, replication, vm, mem_to_mem);
=20
+	/* manual mode needs other fifo thresholds */
+	if (mgr_fld_read(channel, DISPC_MGR_FLD_STALLMODE))
+		dispc_ovl_set_manual_fifo_threshold(plane);
+
 	return r;
 }
=20
diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/oma=
pdrm/omap_connector.c
index a0d7b1d..a33b514 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -57,6 +57,14 @@ bool omap_connector_get_hdmi_mode(struct drm_connector *=
connector)
 	return omap_connector->hdmi_mode;
 }
=20
+bool omap_connector_get_manually_updated(struct drm_connector *connector)
+{
+	struct omap_connector *omap_connector =3D to_omap_connector(connector);
+
+	return !!(omap_connector->dssdev->caps &
+		  OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE);
+}
+
 static enum drm_connector_status omap_connector_detect(
 		struct drm_connector *connector, bool force)
 {
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/=
omap_crtc.c
index 1b8154e..c2defb51 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -51,6 +51,10 @@ struct omap_crtc {
 	bool pending;
 	wait_queue_head_t pending_wait;
 	struct drm_pending_vblank_event *event;
+	struct delayed_work update_work;
+
+	void (*framedone_handler)(void *);
+	void *framedone_handler_data;
 };
=20
 /* -----------------------------------------------------------------------=
------
@@ -139,6 +143,28 @@ static void omap_crtc_dss_disconnect(enum omap_channel=
 channel,
=20
 static void omap_crtc_dss_start_update(enum omap_channel channel)
 {
+	struct omap_crtc *omap_crtc =3D omap_crtcs[channel];
+	struct omap_drm_private *priv =3D omap_crtc->base.dev->dev_private;
+
+	priv->dispc_ops->mgr_enable(channel, true);
+}
+
+static bool omap_crtc_is_manually_updated(struct drm_crtc *crtc)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	bool result =3D false;
+
+	drm_connector_list_iter_begin(crtc->dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (connector->state->crtc !=3D crtc)
+			continue;
+		result =3D omap_connector_get_manually_updated(connector);
+		break;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return result;
 }
=20
 /* Called only from the encoder enable/disable and suspend/resume handlers=
=2E */
@@ -150,12 +176,17 @@ static void omap_crtc_set_enabled(struct drm_crtc *cr=
tc, bool enable)
 	enum omap_channel channel =3D omap_crtc->channel;
 	struct omap_irq_wait *wait;
 	u32 framedone_irq, vsync_irq;
+	bool is_manual =3D omap_crtc_is_manually_updated(crtc);
+	enum omap_display_type type =3D omap_crtc_output[channel]->output_type;
 	int ret;
=20
 	if (WARN_ON(omap_crtc->enabled =3D=3D enable))
 		return;
=20
-	if (omap_crtc_output[channel]->output_type =3D=3D OMAP_DISPLAY_TYPE_HDMI)=
 {
+	if (is_manual)
+		omap_irq_enable_framedone(crtc, enable);
+
+	if (is_manual || type =3D=3D OMAP_DISPLAY_TYPE_HDMI) {
 		priv->dispc_ops->mgr_enable(channel, enable);
 		omap_crtc->enabled =3D enable;
 		return;
@@ -206,7 +237,6 @@ static void omap_crtc_set_enabled(struct drm_crtc *crtc=
, bool enable)
 	}
 }
=20
-
 static int omap_crtc_dss_enable(enum omap_channel channel)
 {
 	struct omap_crtc *omap_crtc =3D omap_crtcs[channel];
@@ -247,6 +277,17 @@ static int omap_crtc_dss_register_framedone(
 		enum omap_channel channel,
 		void (*handler)(void *), void *data)
 {
+	struct omap_crtc *omap_crtc =3D omap_crtcs[channel];
+	struct drm_device *dev =3D omap_crtc->base.dev;
+
+	if (omap_crtc->framedone_handler)
+		return -EBUSY;
+
+	dev_dbg(dev->dev, "register framedone %s", omap_crtc->name);
+
+	omap_crtc->framedone_handler =3D handler;
+	omap_crtc->framedone_handler_data =3D data;
+
 	return 0;
 }
=20
@@ -254,6 +295,16 @@ static void omap_crtc_dss_unregister_framedone(
 		enum omap_channel channel,
 		void (*handler)(void *), void *data)
 {
+	struct omap_crtc *omap_crtc =3D omap_crtcs[channel];
+	struct drm_device *dev =3D omap_crtc->base.dev;
+
+	dev_dbg(dev->dev, "unregister framedone %s", omap_crtc->name);
+
+	WARN_ON(omap_crtc->framedone_handler !=3D handler);
+	WARN_ON(omap_crtc->framedone_handler_data !=3D data);
+
+	omap_crtc->framedone_handler =3D NULL;
+	omap_crtc->framedone_handler_data =3D NULL;
 }
=20
 static const struct dss_mgr_ops mgr_ops =3D {
@@ -321,6 +372,77 @@ void omap_crtc_vblank_irq(struct drm_crtc *crtc)
 	DBG("%s: apply done", omap_crtc->name);
 }
=20
+void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus)
+{
+	struct omap_crtc *omap_crtc =3D to_omap_crtc(crtc);
+
+	if (!omap_crtc->framedone_handler) {
+		dev_warn(omap_crtc->base.dev->dev, "no framedone handler?");
+		return;
+	}
+
+	omap_crtc->framedone_handler(omap_crtc->framedone_handler_data);
+
+	spin_lock(&crtc->dev->event_lock);
+	/* Send the vblank event if one has been requested. */
+	if (omap_crtc->event) {
+		drm_crtc_send_vblank_event(crtc, omap_crtc->event);
+		omap_crtc->event =3D NULL;
+	}
+	omap_crtc->pending =3D false;
+	spin_unlock(&crtc->dev->event_lock);
+
+	/* Wake up omap_atomic_complete. */
+	wake_up(&omap_crtc->pending_wait);
+}
+
+void omap_crtc_flush(struct drm_crtc *crtc)
+{
+	struct omap_crtc *omap_crtc =3D to_omap_crtc(crtc);
+
+	if (!omap_crtc_is_manually_updated(crtc))
+		return;
+
+	if (!delayed_work_pending(&omap_crtc->update_work))
+		schedule_delayed_work(&omap_crtc->update_work, 0);
+}
+
+static void omap_crtc_manual_display_update(struct work_struct *data)
+{
+	struct omap_crtc *omap_crtc =3D
+			container_of(data, struct omap_crtc, update_work.work);
+	struct omap_dss_device *dssdev =3D omap_crtc_output[omap_crtc->channel];
+	struct drm_device *dev =3D omap_crtc->base.dev;
+	struct omap_dss_driver *dssdrv;
+	int ret, width, height;
+
+	if (!dssdev || !dssdev->dst) {
+		dev_err_once(dev->dev, "missing dssdev!");
+		return;
+	}
+
+	dssdev =3D dssdev->dst;
+	dssdrv =3D dssdev->driver;
+
+	if (!dssdrv || !dssdrv->update) {
+		dev_err_once(dev->dev, "incorrect dssdrv!");
+		return;
+	}
+
+	if (dssdrv->sync)
+		dssdrv->sync(dssdev);
+
+	width =3D dssdev->panel.vm.hactive;
+	height =3D dssdev->panel.vm.vactive;
+	ret =3D dssdrv->update(dssdev, 0, 0, width, height);
+	if (ret < 0) {
+		spin_lock_irq(&dev->event_lock);
+		omap_crtc->pending =3D false;
+		spin_unlock_irq(&dev->event_lock);
+		wake_up(&omap_crtc->pending_wait);
+	}
+}
+
 static void omap_crtc_write_crtc_properties(struct drm_crtc *crtc)
 {
 	struct omap_drm_private *priv =3D crtc->dev->dev_private;
@@ -373,6 +495,10 @@ static void omap_crtc_atomic_enable(struct drm_crtc *c=
rtc,
=20
 	DBG("%s", omap_crtc->name);
=20
+	/* manual updated display will not trigger vsync irq */
+	if (omap_crtc_is_manually_updated(crtc))
+		return;
+
 	spin_lock_irq(&crtc->dev->event_lock);
 	drm_crtc_vblank_on(crtc);
 	ret =3D drm_crtc_vblank_get(crtc);
@@ -386,6 +512,7 @@ static void omap_crtc_atomic_disable(struct drm_crtc *c=
rtc,
 				     struct drm_crtc_state *old_state)
 {
 	struct omap_crtc *omap_crtc =3D to_omap_crtc(crtc);
+	struct drm_device *dev =3D crtc->dev;
=20
 	DBG("%s", omap_crtc->name);
=20
@@ -396,6 +523,11 @@ static void omap_crtc_atomic_disable(struct drm_crtc *=
crtc,
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
=20
+	cancel_delayed_work(&omap_crtc->update_work);
+
+	if (!omap_crtc_wait_pending(crtc))
+		dev_warn(dev->dev, "manual display update did not finish!");
+
 	drm_crtc_vblank_off(crtc);
 }
=20
@@ -545,13 +677,20 @@ static void omap_crtc_atomic_flush(struct drm_crtc *c=
rtc,
=20
 	DBG("%s: GO", omap_crtc->name);
=20
-	ret =3D drm_crtc_vblank_get(crtc);
-	WARN_ON(ret !=3D 0);
+	if (!omap_crtc_is_manually_updated(crtc)) {
+		ret =3D drm_crtc_vblank_get(crtc);
+		WARN_ON(ret !=3D 0);
=20
-	spin_lock_irq(&crtc->dev->event_lock);
-	priv->dispc_ops->mgr_go(omap_crtc->channel);
-	omap_crtc_arm_event(crtc);
-	spin_unlock_irq(&crtc->dev->event_lock);
+		spin_lock_irq(&crtc->dev->event_lock);
+		priv->dispc_ops->mgr_go(omap_crtc->channel);
+		omap_crtc_arm_event(crtc);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	} else {
+		spin_lock_irq(&crtc->dev->event_lock);
+		omap_crtc_flush(crtc);
+		omap_crtc_arm_event(crtc);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
 }
=20
 static int omap_crtc_atomic_set_property(struct drm_crtc *crtc,
@@ -713,6 +852,9 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 	omap_crtc->channel =3D channel;
 	omap_crtc->name =3D channel_names[channel];
=20
+	INIT_DELAYED_WORK(&omap_crtc->update_work,
+			  omap_crtc_manual_display_update);
+
 	ret =3D drm_crtc_init_with_planes(dev, crtc, plane, NULL,
 					&omap_crtc_funcs, NULL);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/o=
map_drv.c
index dd68b25..bc5b68e 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -74,36 +74,23 @@ static void omap_atomic_commit_tail(struct drm_atomic_s=
tate *old_state)
 	/* Apply the atomic update. */
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
=20
-	if (priv->omaprev !=3D 0x3430) {
-		/* With the current dss dispc implementation we have to enable
-		 * the new modeset before we can commit planes. The dispc ovl
-		 * configuration relies on the video mode configuration been
-		 * written into the HW when the ovl configuration is
-		 * calculated.
-		 *
-		 * This approach is not ideal because after a mode change the
-		 * plane update is executed only after the first vblank
-		 * interrupt. The dispc implementation should be fixed so that
-		 * it is able use uncommitted drm state information.
-		 */
-		drm_atomic_helper_commit_modeset_enables(dev, old_state);
-		omap_atomic_wait_for_completion(dev, old_state);
-
-		drm_atomic_helper_commit_planes(dev, old_state, 0);
-
-		drm_atomic_helper_commit_hw_done(old_state);
-	} else {
-		/*
-		 * OMAP3 DSS seems to have issues with the work-around above,
-		 * resulting in endless sync losts if a crtc is enabled without
-		 * a plane. For now, skip the WA for OMAP3.
-		 */
-		drm_atomic_helper_commit_planes(dev, old_state, 0);
-
-		drm_atomic_helper_commit_modeset_enables(dev, old_state);
-
-		drm_atomic_helper_commit_hw_done(old_state);
-	}
+	/* With the current dss dispc implementation we have to enable
+	 * the new modeset before we can commit planes. The dispc ovl
+	 * configuration relies on the video mode configuration been
+	 * written into the HW when the ovl configuration is
+	 * calculated.
+	 *
+	 * This approach is not ideal because after a mode change the
+	 * plane update is executed only after the first vblank
+	 * interrupt. The dispc implementation should be fixed so that
+	 * it is able use uncommitted drm state information.
+	 */
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+	omap_atomic_wait_for_completion(dev, old_state);
+
+	drm_atomic_helper_commit_planes(dev, old_state, 0);
+
+	drm_atomic_helper_commit_hw_done(old_state);
=20
 	/*
 	 * Wait for completion of the page flips to ensure that old buffers
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/om=
ap_fb.c
index b2539a9..57b1767 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -95,8 +95,28 @@ static void omap_framebuffer_destroy(struct drm_framebuf=
fer *fb)
 	kfree(omap_fb);
 }
=20
+static int omap_framebuffer_dirty(struct drm_framebuffer *fb,
+				  struct drm_file *file_priv,
+				  unsigned flags, unsigned color,
+				  struct drm_clip_rect *clips,
+				  unsigned num_clips)
+{
+	struct drm_connector *connector =3D NULL;
+
+	drm_modeset_lock_all(fb->dev);
+
+	while ((connector =3D omap_framebuffer_get_next_connector(fb, connector)))
+		if (connector->encoder && connector->encoder->crtc)
+			omap_crtc_flush(connector->encoder->crtc);
+
+	drm_modeset_unlock_all(fb->dev);
+
+	return 0;
+}
+
 static const struct drm_framebuffer_funcs omap_framebuffer_funcs =3D {
 	.create_handle =3D omap_framebuffer_create_handle,
+	.dirty =3D omap_framebuffer_dirty,
 	.destroy =3D omap_framebuffer_destroy,
 };
=20
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/o=
map_irq.c
index 53ba424..354df35 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -85,6 +85,27 @@ int omap_irq_wait(struct drm_device *dev, struct omap_ir=
q_wait *wait,
 	return ret =3D=3D 0 ? -1 : 0;
 }
=20
+int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable)
+{
+	struct drm_device *dev =3D crtc->dev;
+	struct omap_drm_private *priv =3D dev->dev_private;
+	unsigned long flags;
+	enum omap_channel channel =3D omap_crtc_channel(crtc);
+	int framedone_irq =3D priv->dispc_ops->mgr_get_framedone_irq(channel);
+
+	DBG("dev=3D%p, crtc=3D%u, enable=3D%d", dev, channel, enable);
+
+	spin_lock_irqsave(&priv->wait_lock, flags);
+	if (enable)
+		priv->irq_mask |=3D framedone_irq;
+	else
+		priv->irq_mask &=3D ~framedone_irq;
+	omap_irq_update(dev);
+	spin_unlock_irqrestore(&priv->wait_lock, flags);
+
+	return 0;
+}
+
 /**
  * enable_vblank - enable vblank interrupt events
  * @dev: DRM device
@@ -215,6 +236,9 @@ static irqreturn_t omap_irq_handler(int irq, void *arg)
=20
 		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(channel))
 			omap_crtc_error_irq(crtc, irqstatus);
+
+		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(channel))
+			omap_crtc_framedone_irq(crtc, irqstatus);
 	}
=20
 	omap_irq_ocp_error_handler(dev, irqstatus);
diff --git a/include/video/mipi_display.h b/include/video/mipi_display.h
index 19aa65a..1d9fdd6 100644
--- a/include/video/mipi_display.h
+++ b/include/video/mipi_display.h
@@ -102,7 +102,8 @@ enum {
 	MIPI_DCS_WRITE_MEMORY_START	=3D 0x2C,
 	MIPI_DCS_WRITE_LUT		=3D 0x2D,
 	MIPI_DCS_READ_MEMORY_START	=3D 0x2E,
-	MIPI_DCS_SET_PARTIAL_AREA	=3D 0x30,
+	MIPI_DCS_SET_PARTIAL_ROWS	=3D 0x30,
+	MIPI_DCS_SET_PARTIAL_COLUMNS	=3D 0x31,
 	MIPI_DCS_SET_SCROLL_AREA	=3D 0x33,
 	MIPI_DCS_SET_TEAR_OFF		=3D 0x34,
 	MIPI_DCS_SET_TEAR_ON		=3D 0x35,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp8GzEACgkQMOfwapXb+vLknwCeImFKUAONG6k2BzZEqAKL9J1d
8ZYAoKhsiSfzYm6KIQWo678AC1BSJEk2
=Vbu6
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
