From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] drm/omap: use omapdss low level API
Date: Fri, 16 Nov 2012 12:14:15 +0530
Message-ID: <50A5E0BF.1010403@ti.com>
References: <1353024058-11504-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57736 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2KPGop (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 01:44:45 -0500
In-Reply-To: <1353024058-11504-1-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, patches@linaro.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg KH <greg@kroah.com>

On Friday 16 November 2012 05:30 AM, Rob Clark wrote:
> This patch changes the omapdrm KMS to bypass the omapdss "compat"
> layer and use the core omapdss API directly.  This solves some layering
> issues that would cause unpin confusion vs GO bit status, because we
> would not know whether a particular pageflip or overlay update has hit
> the screen or not.  Now instead we explicitly manage the GO bits in
> dispc and handle the vblank/framedone interrupts ourself so that we
> always know which buffers are being scanned out at any given time, and
> so on.
>
> As an added bonus, we no longer leave the last overlay buffer pinned
> when the display is disabled, and have been able to add the previously
> missing vblank event handling.
>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> Note: this patch applies on top of staging-next plus the "OMAPDSS:
> create compat layer" patch series:
>
> http://comments.gmane.org/gmane.linux.ports.arm.omap/89435
>
>   drivers/staging/omapdrm/Makefile         |   1 +
>   drivers/staging/omapdrm/TODO             |   3 -
>   drivers/staging/omapdrm/omap_connector.c | 111 +-------
>   drivers/staging/omapdrm/omap_crtc.c      | 472 +++++++++++++++++++++++++++++--
>   drivers/staging/omapdrm/omap_drv.c       | 439 +++++-----------------------
>   drivers/staging/omapdrm/omap_drv.h       | 140 +++++++--
>   drivers/staging/omapdrm/omap_encoder.c   | 132 ++++-----
>   drivers/staging/omapdrm/omap_irq.c       | 322 +++++++++++++++++++++
>   drivers/staging/omapdrm/omap_plane.c     | 452 +++++++++++------------------
>   9 files changed, 1207 insertions(+), 865 deletions(-)
>   create mode 100644 drivers/staging/omapdrm/omap_irq.c
>
> diff --git a/drivers/staging/omapdrm/Makefile b/drivers/staging/omapdrm/Makefile
> index 1ca0e00..d85e058 100644
> --- a/drivers/staging/omapdrm/Makefile
> +++ b/drivers/staging/omapdrm/Makefile
> @@ -5,6 +5,7 @@
>
>   ccflags-y := -Iinclude/drm -Werror
>   omapdrm-y := omap_drv.o \
> +	omap_irq.o \
>   	omap_debugfs.o \
>   	omap_crtc.o \
>   	omap_plane.o \
> diff --git a/drivers/staging/omapdrm/TODO b/drivers/staging/omapdrm/TODO
> index 938c788..abeeb00 100644
> --- a/drivers/staging/omapdrm/TODO
> +++ b/drivers/staging/omapdrm/TODO
> @@ -17,9 +17,6 @@ TODO
>   . Revisit GEM sync object infrastructure.. TTM has some framework for this
>     already.  Possibly this could be refactored out and made more common?
>     There should be some way to do this with less wheel-reinvention.
> -. Review DSS vs KMS mismatches.  The omap_dss_device is sort of part encoder,
> -  part connector.  Which results in a bit of duct tape to fwd calls from
> -  encoder to connector.  Possibly this could be done a bit better.
>   . Solve PM sequencing on resume.  DMM/TILER must be reloaded before any
>     access is made from any component in the system.  Which means on suspend
>     CRTC's should be disabled, and on resume the LUT should be reprogrammed
> diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
> index 91edb3f..4cc9ee7 100644
> --- a/drivers/staging/omapdrm/omap_connector.c
> +++ b/drivers/staging/omapdrm/omap_connector.c
> @@ -31,9 +31,10 @@
>   struct omap_connector {
>   	struct drm_connector base;
>   	struct omap_dss_device *dssdev;
> +	struct drm_encoder *encoder;
>   };
>
> -static inline void copy_timings_omap_to_drm(struct drm_display_mode *mode,
> +void copy_timings_omap_to_drm(struct drm_display_mode *mode,
>   		struct omap_video_timings *timings)
>   {
>   	mode->clock = timings->pixel_clock;
> @@ -64,7 +65,7 @@ static inline void copy_timings_omap_to_drm(struct drm_display_mode *mode,
>   		mode->flags |= DRM_MODE_FLAG_NVSYNC;
>   }
>
> -static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
> +void copy_timings_drm_to_omap(struct omap_video_timings *timings,
>   		struct drm_display_mode *mode)
>   {
>   	timings->pixel_clock = mode->clock;
> @@ -96,48 +97,7 @@ static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
>   	timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
>   }
>
> -static void omap_connector_dpms(struct drm_connector *connector, int mode)
> -{
> -	struct omap_connector *omap_connector = to_omap_connector(connector);
> -	struct omap_dss_device *dssdev = omap_connector->dssdev;
> -	int old_dpms;
> -
> -	DBG("%s: %d", dssdev->name, mode);
> -
> -	old_dpms = connector->dpms;
> -
> -	/* from off to on, do from crtc to connector */
> -	if (mode < old_dpms)
> -		drm_helper_connector_dpms(connector, mode);
> -
> -	if (mode == DRM_MODE_DPMS_ON) {
> -		/* store resume info for suspended displays */
> -		switch (dssdev->state) {
> -		case OMAP_DSS_DISPLAY_SUSPENDED:
> -			dssdev->activate_after_resume = true;
> -			break;
> -		case OMAP_DSS_DISPLAY_DISABLED: {
> -			int ret = dssdev->driver->enable(dssdev);
> -			if (ret) {
> -				DBG("%s: failed to enable: %d",
> -						dssdev->name, ret);
> -				dssdev->driver->disable(dssdev);
> -			}
> -			break;
> -		}
> -		default:
> -			break;
> -		}
> -	} else {
> -		/* TODO */
> -	}
> -
> -	/* from on to off, do from connector to crtc */
> -	if (mode > old_dpms)
> -		drm_helper_connector_dpms(connector, mode);
> -}
> -
> -enum drm_connector_status omap_connector_detect(
> +static enum drm_connector_status omap_connector_detect(
>   		struct drm_connector *connector, bool force)
>   {
>   	struct omap_connector *omap_connector = to_omap_connector(connector);
> @@ -164,8 +124,6 @@ static void omap_connector_destroy(struct drm_connector *connector)
>   	struct omap_connector *omap_connector = to_omap_connector(connector);
>   	struct omap_dss_device *dssdev = omap_connector->dssdev;
>
> -	dssdev->driver->disable(dssdev);
> -
>   	DBG("%s", omap_connector->dssdev->name);
>   	drm_sysfs_connector_remove(connector);
>   	drm_connector_cleanup(connector);
> @@ -261,36 +219,12 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
>   struct drm_encoder *omap_connector_attached_encoder(
>   		struct drm_connector *connector)
>   {
> -	int i;
>   	struct omap_connector *omap_connector = to_omap_connector(connector);
> -
> -	for (i = 0; i < DRM_CONNECTOR_MAX_ENCODER; i++) {
> -		struct drm_mode_object *obj;
> -
> -		if (connector->encoder_ids[i] == 0)
> -			break;
> -
> -		obj = drm_mode_object_find(connector->dev,
> -				connector->encoder_ids[i],
> -				DRM_MODE_OBJECT_ENCODER);
> -
> -		if (obj) {
> -			struct drm_encoder *encoder = obj_to_encoder(obj);
> -			struct omap_overlay_manager *mgr =
> -					omap_encoder_get_manager(encoder);
> -			DBG("%s: found %s", omap_connector->dssdev->name,
> -					mgr->name);
> -			return encoder;
> -		}
> -	}
> -
> -	DBG("%s: no encoder", omap_connector->dssdev->name);
> -
> -	return NULL;
> +	return omap_connector->encoder;
>   }
>
>   static const struct drm_connector_funcs omap_connector_funcs = {
> -	.dpms = omap_connector_dpms,
> +	.dpms = drm_helper_connector_dpms,
>   	.detect = omap_connector_detect,
>   	.fill_modes = drm_helper_probe_single_connector_modes,
>   	.destroy = omap_connector_destroy,
> @@ -302,34 +236,6 @@ static const struct drm_connector_helper_funcs omap_connector_helper_funcs = {
>   	.best_encoder = omap_connector_attached_encoder,
>   };
>
> -/* called from encoder when mode is set, to propagate settings to the dssdev */
> -void omap_connector_mode_set(struct drm_connector *connector,
> -		struct drm_display_mode *mode)
> -{
> -	struct drm_device *dev = connector->dev;
> -	struct omap_connector *omap_connector = to_omap_connector(connector);
> -	struct omap_dss_device *dssdev = omap_connector->dssdev;
> -	struct omap_dss_driver *dssdrv = dssdev->driver;
> -	struct omap_video_timings timings = {0};
> -
> -	copy_timings_drm_to_omap(&timings, mode);
> -
> -	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			omap_connector->dssdev->name,
> -			mode->base.id, mode->name, mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal, mode->type, mode->flags);
> -
> -	if (dssdrv->check_timings(dssdev, &timings)) {
> -		dev_err(dev->dev, "could not set timings\n");
> -		return;
> -	}
> -
> -	dssdrv->set_timings(dssdev, &timings);
> -}
> -
>   /* flush an area of the framebuffer (in case of manual update display that
>    * is not automatically flushed)
>    */
> @@ -344,7 +250,8 @@ void omap_connector_flush(struct drm_connector *connector,
>
>   /* initialize connector */
>   struct drm_connector *omap_connector_init(struct drm_device *dev,
> -		int connector_type, struct omap_dss_device *dssdev)
> +		int connector_type, struct omap_dss_device *dssdev,
> +		struct drm_encoder *encoder)
>   {
>   	struct drm_connector *connector = NULL;
>   	struct omap_connector *omap_connector;
> @@ -360,6 +267,8 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
>   	}
>
>   	omap_connector->dssdev = dssdev;
> +	omap_connector->encoder = encoder;
> +
>   	connector = &omap_connector->base;
>
>   	drm_connector_init(dev, connector, &omap_connector_funcs,
> diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/omapdrm/omap_crtc.c
> index 3e2c736..e3496e5 100644
> --- a/drivers/staging/omapdrm/omap_crtc.c
> +++ b/drivers/staging/omapdrm/omap_crtc.c
> @@ -28,19 +28,131 @@
>   struct omap_crtc {
>   	struct drm_crtc base;
>   	struct drm_plane *plane;
> +
>   	const char *name;
> -	int id;
> +	int pipe;
> +	enum omap_channel channel;
> +	struct omap_overlay_manager_info info;
> +
> +	/*
> +	 * Temporary: eventually this will go away, but it is needed
> +	 * for now to keep the output's happy.  (They only need
> +	 * mgr->id.)  Eventually this will be replaced w/ something
> +	 * more common-panel-framework-y
> +	 */
> +	struct omap_overlay_manager mgr;
> +
> +	struct omap_video_timings timings;
> +	bool enabled;
> +	bool full_update;
> +
> +	struct omap_drm_apply apply;
> +
> +	struct omap_drm_irq apply_irq;
> +	struct omap_drm_irq error_irq;
> +
> +	/* list of in-progress apply's: */
> +	struct list_head pending_applies;
> +
> +	/* list of queued apply's: */
> +	struct list_head queued_applies;
> +
> +	/* for handling queued and in-progress applies: */
> +	struct work_struct apply_work;
>
>   	/* if there is a pending flip, these will be non-null: */
>   	struct drm_pending_vblank_event *event;
>   	struct drm_framebuffer *old_fb;
> +
> +	/* for handling page flips without caring about what
> +	 * the callback is called from.  Possibly we should just
> +	 * make omap_gem always call the cb from the worker so
> +	 * we don't have to care about this..
> +	 *
> +	 * XXX maybe fold into apply_work??
> +	 */
> +	struct work_struct page_flip_work;
>   };
>
> +/*
> + * Manager-ops, callbacks from output when they need to configure
> + * the upstream part of the video pipe.
> + *
> + * Most of these we can ignore until we add support for command-mode
> + * panels.. for video-mode the crtc-helpers already do an adequate
> + * job of sequencing the setup of the video pipe in the proper order
> + */
> +
> +/* we can probably ignore these until we support command-mode panels: */
> +static void omap_crtc_start_update(struct omap_overlay_manager *mgr)
> +{
> +}
> +
> +static int omap_crtc_enable(struct omap_overlay_manager *mgr)
> +{
> +	return 0;
> +}
> +
> +static void omap_crtc_disable(struct omap_overlay_manager *mgr)
> +{
> +}
> +
> +static void omap_crtc_set_timings(struct omap_overlay_manager *mgr,
> +		const struct omap_video_timings *timings)
> +{
> +	struct omap_crtc *omap_crtc = container_of(mgr, struct omap_crtc, mgr);
> +	DBG("%s", omap_crtc->name);
> +	omap_crtc->timings = *timings;
> +	omap_crtc->full_update = true;
> +}
> +
> +static void omap_crtc_set_lcd_config(struct omap_overlay_manager *mgr,
> +		const struct dss_lcd_mgr_config *config)
> +{
> +	struct omap_crtc *omap_crtc = container_of(mgr, struct omap_crtc, mgr);
> +	DBG("%s", omap_crtc->name);
> +	dispc_mgr_set_lcd_config(omap_crtc->channel, config);

Maybe you should move this dispc write also to omap_crtc_pre_apply, the 
same way it's done for timings. We'll also be confident about having the 
clocks required if this is called in pre_apply.

> +}
> +
> +static int omap_crtc_register_framedone_handler(
> +		struct omap_overlay_manager *mgr,
> +		void (*handler)(void *), void *data)
> +{
> +	return 0;
> +}
> +
> +static void omap_crtc_unregister_framedone_handler(
> +		struct omap_overlay_manager *mgr,
> +		void (*handler)(void *), void *data)
> +{
> +}
> +
> +static const struct dss_mgr_ops mgr_ops = {
> +		.start_update = omap_crtc_start_update,
> +		.enable = omap_crtc_enable,
> +		.disable = omap_crtc_disable,
> +		.set_timings = omap_crtc_set_timings,
> +		.set_lcd_config = omap_crtc_set_lcd_config,
> +		.register_framedone_handler = omap_crtc_register_framedone_handler,
> +		.unregister_framedone_handler = omap_crtc_unregister_framedone_handler,
> +};
> +
> +/*
> + * CRTC funcs:
> + */
> +
>   static void omap_crtc_destroy(struct drm_crtc *crtc)
>   {
>   	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +
> +	DBG("%s", omap_crtc->name);
> +
> +	WARN_ON(omap_crtc->apply_irq.registered);
> +	omap_irq_unregister(crtc->dev, &omap_crtc->error_irq);
> +
>   	omap_crtc->plane->funcs->destroy(omap_crtc->plane);
>   	drm_crtc_cleanup(crtc);
> +
>   	kfree(omap_crtc);
>   }
>
> @@ -48,14 +160,25 @@ static void omap_crtc_dpms(struct drm_crtc *crtc, int mode)
>   {
>   	struct omap_drm_private *priv = crtc->dev->dev_private;
>   	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +	bool enabled = (mode == DRM_MODE_DPMS_ON);
>   	int i;
>
> -	WARN_ON(omap_plane_dpms(omap_crtc->plane, mode));
> +	DBG("%s: %d", omap_crtc->name, mode);
> +
> +	if (enabled != omap_crtc->enabled) {
> +		omap_crtc->enabled = enabled;
> +		omap_crtc->full_update = true;
> +		omap_crtc_apply(crtc, &omap_crtc->apply);
>
> -	for (i = 0; i < priv->num_planes; i++) {
> -		struct drm_plane *plane = priv->planes[i];
> -		if (plane->crtc == crtc)
> -			WARN_ON(omap_plane_dpms(plane, mode));
> +		/* also enable our private plane: */
> +		WARN_ON(omap_plane_dpms(omap_crtc->plane, mode));
> +
> +		/* and any attached overlay planes: */
> +		for (i = 0; i < priv->num_planes; i++) {
> +			struct drm_plane *plane = priv->planes[i];
> +			if (plane->crtc == crtc)
> +				WARN_ON(omap_plane_dpms(plane, mode));
> +		}
>   	}
>   }
>
> @@ -73,12 +196,26 @@ static int omap_crtc_mode_set(struct drm_crtc *crtc,
>   		struct drm_framebuffer *old_fb)
>   {
>   	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> -	struct drm_plane *plane = omap_crtc->plane;
>
> -	return omap_plane_mode_set(plane, crtc, crtc->fb,
> +	mode = adjusted_mode;
> +
> +	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			omap_crtc->name, mode->base.id, mode->name,
> +			mode->vrefresh, mode->clock,
> +			mode->hdisplay, mode->hsync_start,
> +			mode->hsync_end, mode->htotal,
> +			mode->vdisplay, mode->vsync_start,
> +			mode->vsync_end, mode->vtotal,
> +			mode->type, mode->flags);
> +
> +	copy_timings_drm_to_omap(&omap_crtc->timings, mode);
> +	omap_crtc->full_update = true;
> +
> +	return omap_plane_mode_set(omap_crtc->plane, crtc, crtc->fb,
>   			0, 0, mode->hdisplay, mode->vdisplay,
>   			x << 16, y << 16,
> -			mode->hdisplay << 16, mode->vdisplay << 16);
> +			mode->hdisplay << 16, mode->vdisplay << 16,
> +			NULL, NULL);
>   }
>
>   static void omap_crtc_prepare(struct drm_crtc *crtc)
> @@ -102,10 +239,11 @@ static int omap_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
>   	struct drm_plane *plane = omap_crtc->plane;
>   	struct drm_display_mode *mode = &crtc->mode;
>
> -	return plane->funcs->update_plane(plane, crtc, crtc->fb,
> +	return omap_plane_mode_set(plane, crtc, crtc->fb,
>   			0, 0, mode->hdisplay, mode->vdisplay,
>   			x << 16, y << 16,
> -			mode->hdisplay << 16, mode->vdisplay << 16);
> +			mode->hdisplay << 16, mode->vdisplay << 16,
> +			NULL, NULL);
>   }
>
>   static void omap_crtc_load_lut(struct drm_crtc *crtc)
> @@ -123,7 +261,7 @@ static void vblank_cb(void *arg)
>
>   	/* wakeup userspace */
>   	if (omap_crtc->event)
> -		drm_send_vblank_event(dev, -1, omap_crtc->event);
> +		drm_send_vblank_event(dev, omap_crtc->pipe, omap_crtc->event);
>
>   	omap_crtc->event = NULL;
>   	omap_crtc->old_fb = NULL;
> @@ -131,25 +269,37 @@ static void vblank_cb(void *arg)
>   	spin_unlock_irqrestore(&dev->event_lock, flags);
>   }
>
> -static void page_flip_cb(void *arg)
> +static void page_flip_worker(struct work_struct *work)
>   {
> -	struct drm_crtc *crtc = arg;
> -	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> -	struct drm_framebuffer *old_fb = omap_crtc->old_fb;
> +	struct omap_crtc *omap_crtc =
> +			container_of(work, struct omap_crtc, page_flip_work);
> +	struct drm_crtc *crtc = &omap_crtc->base;
> +	struct drm_device *dev = crtc->dev;
> +	struct drm_display_mode *mode = &crtc->mode;
>   	struct drm_gem_object *bo;
>
> -	omap_crtc_mode_set_base(crtc, crtc->x, crtc->y, old_fb);
> -
> -	/* really we'd like to setup the callback atomically w/ setting the
> -	 * new scanout buffer to avoid getting stuck waiting an extra vblank
> -	 * cycle.. for now go for correctness and later figure out speed..
> -	 */
> -	omap_plane_on_endwin(omap_crtc->plane, vblank_cb, crtc);
> +	mutex_lock(&dev->mode_config.mutex);
> +	omap_plane_mode_set(omap_crtc->plane, crtc, crtc->fb,
> +			0, 0, mode->hdisplay, mode->vdisplay,
> +			crtc->x << 16, crtc->y << 16,
> +			mode->hdisplay << 16, mode->vdisplay << 16,
> +			vblank_cb, crtc);
> +	mutex_unlock(&dev->mode_config.mutex);
>
>   	bo = omap_framebuffer_bo(crtc->fb, 0);
>   	drm_gem_object_unreference_unlocked(bo);
>   }
>
> +static void page_flip_cb(void *arg)
> +{
> +	struct drm_crtc *crtc = arg;
> +	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +	struct omap_drm_private *priv = crtc->dev->dev_private;
> +
> +	/* avoid assumptions about what ctxt we are called from: */
> +	queue_work(priv->wq, &omap_crtc->page_flip_work);
> +}
> +
>   static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
>   		 struct drm_framebuffer *fb,
>   		 struct drm_pending_vblank_event *event)
> @@ -158,14 +308,14 @@ static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
>   	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
>   	struct drm_gem_object *bo;
>
> -	DBG("%d -> %d", crtc->fb ? crtc->fb->base.id : -1, fb->base.id);
> +	DBG("%d -> %d (event=%p)", crtc->fb ? crtc->fb->base.id : -1,
> +			fb->base.id, event);
>
>   	if (omap_crtc->old_fb) {
>   		dev_err(dev->dev, "already a pending flip\n");
>   		return -EINVAL;
>   	}
>
> -	omap_crtc->old_fb = crtc->fb;
>   	omap_crtc->event = event;
>   	crtc->fb = fb;
>
> @@ -213,14 +363,244 @@ static const struct drm_crtc_helper_funcs omap_crtc_helper_funcs = {
>   	.load_lut = omap_crtc_load_lut,
>   };
>
> +const struct omap_video_timings *omap_crtc_timings(struct drm_crtc *crtc)
> +{
> +	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +	return &omap_crtc->timings;
> +}
> +
> +enum omap_channel omap_crtc_channel(struct drm_crtc *crtc)
> +{
> +	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +	return omap_crtc->channel;
> +}
> +
> +static void omap_crtc_error_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
> +{
> +	struct omap_crtc *omap_crtc =
> +			container_of(irq, struct omap_crtc, error_irq);
> +	struct drm_crtc *crtc = &omap_crtc->base;
> +	DRM_ERROR("%s: errors: %08x\n", omap_crtc->name, irqstatus);
> +	/* avoid getting in a flood, unregister the irq until next vblank */
> +	omap_irq_unregister(crtc->dev, &omap_crtc->error_irq);
> +}
> +
> +static void omap_crtc_apply_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
> +{
> +	struct omap_crtc *omap_crtc =
> +			container_of(irq, struct omap_crtc, apply_irq);
> +	struct drm_crtc *crtc = &omap_crtc->base;
> +
> +	if (!omap_crtc->error_irq.registered)
> +		omap_irq_register(crtc->dev, &omap_crtc->error_irq);
> +
> +	if (!dispc_mgr_go_busy(omap_crtc->channel)) {
> +		struct omap_drm_private *priv =
> +				crtc->dev->dev_private;
> +		DBG("%s: apply done", omap_crtc->name);
> +		omap_irq_unregister(crtc->dev, &omap_crtc->apply_irq);
> +		queue_work(priv->wq, &omap_crtc->apply_work);
> +	}
> +}
> +
> +static void apply_worker(struct work_struct *work)
> +{
> +	struct omap_crtc *omap_crtc =
> +			container_of(work, struct omap_crtc, apply_work);
> +	struct drm_crtc *crtc = &omap_crtc->base;
> +	struct drm_device *dev = crtc->dev;
> +	struct omap_drm_apply *apply, *n;
> +	bool need_apply;
> +
> +	/*
> +	 * Synchronize everything on mode_config.mutex, to keep
> +	 * the callbacks and list modification all serialized
> +	 * with respect to modesetting ioctls from userspace.
> +	 */
> +	mutex_lock(&dev->mode_config.mutex);
> +	dispc_runtime_get();
> +
> +	/*
> +	 * If we are still pending a previous update, wait.. when the
> +	 * pending update completes, we get kicked again.
> +	 */
> +	if (omap_crtc->apply_irq.registered)
> +		goto out;
> +
> +	/* finish up previous apply's: */
> +	list_for_each_entry_safe(apply, n,
> +			&omap_crtc->pending_applies, pending_node) {
> +		apply->post_apply(apply);
> +		list_del(&apply->pending_node);
> +	}
> +
> +	need_apply = !list_empty(&omap_crtc->queued_applies);
> +
> +	/* then handle the next round of of queued apply's: */
> +	list_for_each_entry_safe(apply, n,
> +			&omap_crtc->queued_applies, queued_node) {
> +		apply->pre_apply(apply);
> +		list_del(&apply->queued_node);
> +		apply->queued = false;
> +		list_add_tail(&apply->pending_node,
> +				&omap_crtc->pending_applies);
> +	}
> +
> +	if (need_apply) {
> +		enum omap_channel channel = omap_crtc->channel;
> +
> +		DBG("%s: GO", omap_crtc->name);
> +
> +		if (dispc_mgr_is_enabled(channel)) {
> +			omap_irq_register(dev, &omap_crtc->apply_irq);
> +			dispc_mgr_go(channel);
> +		} else if (!dispc_mgr_go_busy(channel)) {

I'm not clear about this. Why would GO be set in the first place if the 
manager isn't enabled? This could be replaced with a simple 'else'

> +			struct omap_drm_private *priv = dev->dev_private;
> +			queue_work(priv->wq, &omap_crtc->apply_work);
> +		}
> +	}
> +
> +out:
> +	dispc_runtime_put();
> +	mutex_unlock(&dev->mode_config.mutex);
> +}
> +
> +int omap_crtc_apply(struct drm_crtc *crtc,
> +		struct omap_drm_apply *apply)
> +{
> +	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +	struct drm_device *dev = crtc->dev;
> +
> +	WARN_ON(!mutex_is_locked(&dev->mode_config.mutex));
> +
> +	/* no need to queue it again if it is already queued: */
> +	if (apply->queued)
> +		return 0;
> +
> +	apply->queued = true;
> +	list_add_tail(&apply->queued_node, &omap_crtc->queued_applies);
> +
> +	/*
> +	 * If there are no currently pending updates, then go ahead and
> +	 * kick the worker immediately, otherwise it will run again when
> +	 * the current update finishes.
> +	 */
> +	if (list_empty(&omap_crtc->pending_applies)) {
> +		struct omap_drm_private *priv = crtc->dev->dev_private;
> +		queue_work(priv->wq, &omap_crtc->apply_work);
> +	}
> +
> +	return 0;
> +}
> +
> +/* called only from apply */
> +static void set_enabled(struct drm_crtc *crtc, bool enable)
> +{
> +	struct drm_device *dev = crtc->dev;
> +	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +	enum omap_channel channel = omap_crtc->channel;
> +	struct omap_irq_wait *wait = NULL;
> +
> +	if (dispc_mgr_is_enabled(channel) == enable)
> +		return;
> +
> +	/* ignore sync-lost irqs during enable/disable */
> +	omap_irq_unregister(crtc->dev, &omap_crtc->error_irq);
> +
> +	if (dispc_mgr_get_framedone_irq(channel)) {
> +		if (!enable) {
> +			wait = omap_irq_wait_init(dev,
> +					dispc_mgr_get_framedone_irq(channel), 1);
> +		}
> +	} else {
> +		/*
> +		 * When we disable digit output, we need to wait until fields
> +		 * are done.  Otherwise the DSS is still working, and turning
> +		 * off the clocks prevents DSS from going to OFF mode. And when
> +		 * enabling, we need to wait for the extra sync losts
> +		 */
> +		wait = omap_irq_wait_init(dev,
> +				dispc_mgr_get_vsync_irq(channel), 2);
> +	}
> +
> +	dispc_mgr_enable(channel, enable);
> +
> +	if (wait) {
> +		int ret = omap_irq_wait(dev, wait, msecs_to_jiffies(100));
> +		if (ret) {
> +			dev_err(dev->dev, "%s: timeout waiting for %s\n",
> +					omap_crtc->name, enable ? "enable" : "disable");
> +		}
> +	}
> +
> +	omap_irq_register(crtc->dev, &omap_crtc->error_irq);
> +}
> +
> +static void omap_crtc_pre_apply(struct omap_drm_apply *apply)
> +{
> +	struct omap_crtc *omap_crtc =
> +			container_of(apply, struct omap_crtc, apply);
> +	struct drm_crtc *crtc = &omap_crtc->base;
> +	struct drm_encoder *encoder = NULL;
> +
> +	DBG("%s: enabled=%d, full=%d", omap_crtc->name,
> +			omap_crtc->enabled, omap_crtc->full_update);
> +
> +	if (omap_crtc->full_update) {

If I get it right, full_update refers to manager properties that 
previously used to propogate downstream from the output driver to dispc, 
i.e, things like timings and so on. and the ones which aren't 
full_update are upstream properties like transparency keys, 
default_color and so on?

> +		struct omap_drm_private *priv = crtc->dev->dev_private;
> +		int i;
> +		for (i = 0; i < priv->num_encoders; i++) {
> +			if (priv->encoders[i]->crtc == crtc) {
> +				encoder = priv->encoders[i];
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (!omap_crtc->enabled) {
> +		set_enabled(&omap_crtc->base, false);
> +		if (encoder)
> +			omap_encoder_set_enabled(encoder, false);
> +	} else {
> +		if (encoder) {
> +			omap_encoder_set_enabled(encoder, false);
> +			omap_encoder_update(encoder, &omap_crtc->mgr,
> +					&omap_crtc->timings);
> +			omap_encoder_set_enabled(encoder, true);
> +			omap_crtc->full_update = false;
> +		}
> +
> +		dispc_mgr_setup(omap_crtc->channel, &omap_crtc->info);
> +		dispc_mgr_set_timings(omap_crtc->channel,
> +				&omap_crtc->timings);
> +		set_enabled(&omap_crtc->base, true);
> +	}
> +
> +	omap_crtc->full_update = false;
> +}
> +
><

snip
>
> -static int omap_modeset_init(struct drm_device *dev)
> -{
> -	const struct omap_drm_platform_data *pdata = dev->dev->platform_data;
> -	struct omap_kms_platform_data *kms_pdata = NULL;
> -	struct omap_drm_private *priv = dev->dev_private;
> -	struct omap_dss_device *dssdev = NULL;
> -	int i, j;
> -	unsigned int connected_connectors = 0;
> +		encoder = omap_encoder_init(dev, dssdev);
>
> -	drm_mode_config_init(dev);
> -
> -	if (pdata && pdata->kms_pdata) {
> -		kms_pdata = pdata->kms_pdata;
> -
> -		/* if platform data is provided by the board file, use it to
> -		 * control which overlays, managers, and devices we own.
> -		 */
> -		for (i = 0; i < kms_pdata->mgr_cnt; i++) {
> -			struct omap_overlay_manager *mgr =
> -				omap_dss_get_overlay_manager(
> -						kms_pdata->mgr_ids[i]);
> -			create_encoder(dev, mgr);
> -		}
> -
> -		for (i = 0; i < kms_pdata->dev_cnt; i++) {
> -			struct omap_dss_device *dssdev =
> -				omap_dss_find_device(
> -					(void *)kms_pdata->dev_names[i],
> -					match_dev_name);
> -			if (!dssdev) {
> -				dev_warn(dev->dev, "no such dssdev: %s\n",
> -						kms_pdata->dev_names[i]);
> -				continue;
> -			}
> -			create_connector(dev, dssdev);
> +		if (!encoder) {
> +			dev_err(dev->dev, "could not create encoder: %s\n",
> +					dssdev->name);
> +			return -ENOMEM;
>   		}
>
> -		connected_connectors = detect_connectors(dev);
> +		connector = omap_connector_init(dev,
> +				get_connector_type(dssdev), dssdev, encoder);
>
> -		j = 0;
> -		for (i = 0; i < kms_pdata->ovl_cnt; i++) {
> -			struct omap_overlay *ovl =
> -				omap_dss_get_overlay(kms_pdata->ovl_ids[i]);
> -			create_crtc(dev, ovl, &j, connected_connectors);
> +		if (!connector) {
> +			dev_err(dev->dev, "could not create connector: %s\n",
> +					dssdev->name);
> +			return -ENOMEM;
>   		}
>
> -		for (i = 0; i < kms_pdata->pln_cnt; i++) {
> -			struct omap_overlay *ovl =
> -				omap_dss_get_overlay(kms_pdata->pln_ids[i]);
> -			create_plane(dev, ovl, (1 << priv->num_crtcs) - 1);
> -		}
> -	} else {
> -		/* otherwise just grab up to CONFIG_DRM_OMAP_NUM_CRTCS and try
> -		 * to make educated guesses about everything else
> -		 */
> -		int max_overlays = min(omap_dss_get_num_overlays(), num_crtc);
> +		BUG_ON(priv->num_encoders >= ARRAY_SIZE(priv->encoders));
> +		BUG_ON(priv->num_connectors >= ARRAY_SIZE(priv->connectors));
>
> -		for (i = 0; i < omap_dss_get_num_overlay_managers(); i++)
> -			create_encoder(dev, omap_dss_get_overlay_manager(i));
> -
> -		for_each_dss_dev(dssdev) {
> -			create_connector(dev, dssdev);
> -		}
> +		priv->encoders[priv->num_encoders++] = encoder;
> +		priv->connectors[priv->num_connectors++] = connector;
>
> -		connected_connectors = detect_connectors(dev);
> +		drm_mode_connector_attach_encoder(connector, encoder);
>
> -		j = 0;
> -		for (i = 0; i < max_overlays; i++) {
> -			create_crtc(dev, omap_dss_get_overlay(i),
> -					&j, connected_connectors);
> -		}
> -
> -		/* use any remaining overlays as drm planes */
> -		for (; i < omap_dss_get_num_overlays(); i++) {
> -			struct omap_overlay *ovl = omap_dss_get_overlay(i);
> -			create_plane(dev, ovl, (1 << priv->num_crtcs) - 1);
> +		/* figure out which crtc's we can connect the encoder to: */
> +		encoder->possible_crtcs = 0;
> +		for (id = 0; id < priv->num_crtcs; id++) {
> +			enum omap_display_type supported_displays =
> +					dss_feat_get_supported_displays(pipe2chan(id));

We could use the newer version here: dss_feat_get_supported_outputs(), 
this will tell what all outputs a manager can connect to.

> +			if (supported_displays & dssdev->type)
> +				encoder->possible_crtcs |= (1 << id);
>   		}
>   	}
>
> -	/* for now keep the mapping of CRTCs and encoders static.. */
> -	for (i = 0; i < priv->num_encoders; i++) {
> -		struct drm_encoder *encoder = priv->encoders[i];
> -		struct omap_overlay_manager *mgr =
> -				omap_encoder_get_manager(encoder);
> -
> -		encoder->possible_crtcs = (1 << priv->num_crtcs) - 1;
> -
> -		DBG("%s: possible_crtcs=%08x", mgr->name,
> -					encoder->possible_crtcs);
> -	}
> -
> -	dump_video_chains();
> -
>   	dev->mode_config.min_width = 32;
>   	dev->mode_config.min_height = 32;
>
> @@ -450,7 +229,7 @@ static int ioctl_gem_new(struct drm_device *dev, void *data,
>   		struct drm_file *file_priv)
>   {
>   	struct drm_omap_gem_new *args = data;
> -	DBG("%p:%p: size=0x%08x, flags=%08x", dev, file_priv,
> +	VERB("%p:%p: size=0x%08x, flags=%08x", dev, file_priv,
>   			args->size.bytes, args->flags);
>   	return omap_gem_new_handle(dev, file_priv, args->size,
>   			args->flags, &args->handle);
> @@ -510,7 +289,7 @@ static int ioctl_gem_info(struct drm_device *dev, void *data,
>   	struct drm_gem_object *obj;
>   	int ret = 0;
>
> -	DBG("%p:%p: handle=%d", dev, file_priv, args->handle);
> +	VERB("%p:%p: handle=%d", dev, file_priv, args->handle);
>
>   	obj = drm_gem_object_lookup(dev, file_priv, args->handle);
>   	if (!obj)
> @@ -565,14 +344,6 @@ static int dev_load(struct drm_device *dev, unsigned long flags)
>
>   	dev->dev_private = priv;
>
> -	ret = omapdss_compat_init();
> -	if (ret) {
> -		dev_err(dev->dev, "coult not init omapdss\n");
> -		dev->dev_private = NULL;
> -		kfree(priv);
> -		return ret;
> -	}
> -

How can omapdss_compat_init/ininit already exist in the driver, and 
removed in this patch?

<snip>
Archit

