From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
Date: Wed, 23 Jan 2013 00:41:53 +0100
Message-ID: <20130122234153.GO31870@phenom.ffwll.local>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-2-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:44923 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab3AVXjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 18:39:51 -0500
Received: by mail-we0-f177.google.com with SMTP id d7so886644wer.8
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 15:39:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358894185-21617-2-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, Jan 22, 2013 at 04:36:22PM -0600, Rob Clark wrote:
> A simple DRM/KMS driver for the TI LCD Controller found in various
> smaller TI parts (AM33xx, OMAPL138, etc).  This driver uses the
> CMA helpers.  Currently only the TFP410 DVI encoder is supported
> (tested with beaglebone + DVI cape).  There are also various LCD
> displays, for which support can be added (as I get hw to test on),
> and an external i2c HDMI encoder found on some boards.
> 
> The display controller supports a single CRTC.  And the encoder+
> connector are split out into sub-devices.  Depending on which LCD
> or external encoder is actually present, the appropriate output
> module(s) will be loaded.
> 
> v1: original
> v2: fix fb refcnting and few other cleanups
> v3: get +/- vsync/hsync from timings rather than panel-info, add
>     option DT max-bandwidth field so driver doesn't attempt to
>     pick a display mode with too high memory bandwidth, and other
>     small cleanups
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>

Ok, read through it, looks nice. No idea whether this should use the panel
stuff, but since no-one else does who cares. A few nits and questions
below. Was a nice reading to learn about kfifo and the runtime power
stuff.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/Kconfig                |   2 +
>  drivers/gpu/drm/Makefile               |   1 +
>  drivers/gpu/drm/tilcdc/Kconfig         |  10 +
>  drivers/gpu/drm/tilcdc/Makefile        |   8 +
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c   | 597 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 605 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h    | 159 +++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h   | 154 +++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 423 +++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.h |  26 ++
>  10 files changed, 1985 insertions(+)
>  create mode 100644 drivers/gpu/drm/tilcdc/Kconfig
>  create mode 100644 drivers/gpu/drm/tilcdc/Makefile
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_regs.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h
> 

[cut]

> +struct tilcdc_crtc {
> +	struct drm_crtc base;
> +
> +	const struct tilcdc_panel_info *info;
> +	uint32_t dirty;
> +	dma_addr_t start, end;
> +	struct drm_pending_vblank_event *event;
> +	int dpms;
> +	wait_queue_head_t frame_done_wq;
> +	bool frame_done;
> +
> +	/* fb currently set to scanout 0/1: */
> +	struct drm_framebuffer *scanout[2];
> +
> +	/* for deferred fb unref's: */
> +	DECLARE_KFIFO_PTR(unref_fifo, struct drm_framebuffer *);
> +	struct work_struct work;
> +};
> +#define to_tilcdc_crtc(x) container_of(x, struct tilcdc_crtc, base)
> +
> +static void unref_worker(struct work_struct *work)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = container_of(work, struct tilcdc_crtc, work);
> +	struct drm_device *dev = tilcdc_crtc->base.dev;
> +	struct drm_framebuffer *fb;
> +
> +	mutex_lock(&dev->mode_config.mutex);
> +	while (kfifo_get(&tilcdc_crtc->unref_fifo, &fb))
> +		drm_framebuffer_unreference(fb);
> +	mutex_unlock(&dev->mode_config.mutex);

Hm, just learned about the kfifo api. It looks like the locking here still
works even with the new modeset locking, since kfifo explicitly allows
concurrent readers and writers without locking, as long as there's only on
of each kind. But maybe switch over to crtc->mutex to make things less
tricky.

Also, kfifo seems to have a new api which allows embedding of the kfifo
thing and needs to be used with kfifo_in/out.

[cut]

> +static void update_scanout(struct drm_crtc *crtc)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	struct drm_device *dev = crtc->dev;
> +	struct drm_framebuffer *fb = crtc->fb;
> +	struct drm_gem_cma_object *gem;
> +	unsigned int depth, bpp;
> +
> +	drm_fb_get_bpp_depth(fb->pixel_format, &depth, &bpp);
> +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> +
> +	tilcdc_crtc->start = gem->paddr + fb->offsets[0] +
> +			(crtc->y * fb->pitches[0]) + (crtc->x * bpp/8);
> +
> +	tilcdc_crtc->end = tilcdc_crtc->start +
> +			(crtc->mode.vdisplay * fb->pitches[0]);
> +
> +	if (tilcdc_crtc->dpms == DRM_MODE_DPMS_ON) {
> +		/* already enabled, so just mark the frames that need
> +		 * updating and they will be updated on vblank:
> +		 */
> +		tilcdc_crtc->dirty |= LCDC_END_OF_FRAME0 | LCDC_END_OF_FRAME1;
> +		drm_vblank_get(dev, 0);
> +	} else {
> +		/* not enabled yet, so update registers immediately: */
> +		set_scanout(crtc, 0);
> +		set_scanout(crtc, 1);

At least on intel we disallow pageflips on disabled crtcs since
drm_vblank_get will fail. So dunno whether this is allowed on other
places, but in any case I don't see a drm_vblank_handle call, which means
we'll miss out on the pageflip completion event ...

> +	}
> +}
> +
> +static void start(struct drm_crtc *crtc)
> +{
> +	struct drm_device *dev = crtc->dev;
> +	struct tilcdc_drm_private *priv = dev->dev_private;
> +
> +	if (priv->rev == 2) {
> +		tilcdc_set(dev, LCDC_CLK_RESET_REG, LCDC_CLK_MAIN_RESET);
> +		msleep(1);
> +		tilcdc_clear(dev, LCDC_CLK_RESET_REG, LCDC_CLK_MAIN_RESET);
> +		msleep(1);
> +	}
> +
> +	tilcdc_set(dev, LCDC_DMA_CTRL_REG, LCDC_DUAL_FRAME_BUFFER_ENABLE);
> +	tilcdc_set(dev, LCDC_RASTER_CTRL_REG, LCDC_PALETTE_LOAD_MODE(DATA_ONLY));
> +	tilcdc_set(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
> +}
> +
> +static void stop(struct drm_crtc *crtc)
> +{
> +	struct drm_device *dev = crtc->dev;
> +
> +	tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
> +}
> +
> +static void tilcdc_crtc_destroy(struct drm_crtc *crtc)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +
> +	WARN_ON(tilcdc_crtc->dpms == DRM_MODE_DPMS_ON);
> +
> +	drm_crtc_cleanup(crtc);
> +	WARN_ON(!kfifo_is_empty(&tilcdc_crtc->unref_fifo));
> +	kfifo_free(&tilcdc_crtc->unref_fifo);
> +	kfree(tilcdc_crtc);
> +}
> +
> +static int tilcdc_crtc_page_flip(struct drm_crtc *crtc,
> +		struct drm_framebuffer *fb,
> +		struct drm_pending_vblank_event *event)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	struct drm_device *dev = crtc->dev;
> +
> +	if (tilcdc_crtc->event) {
> +		dev_err(dev->dev, "already pending page flip!\n");
> +		return -EBUSY;
> +	}
> +
> +	crtc->fb = fb;
> +	tilcdc_crtc->event = event;
> +	update_scanout(crtc);
> +
> +	return 0;
> +}
> +
> +static void tilcdc_crtc_dpms(struct drm_crtc *crtc, int mode)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	struct drm_device *dev = crtc->dev;
> +	struct tilcdc_drm_private *priv = dev->dev_private;
> +
> +	/* we really only care about on or off: */
> +	if (mode != DRM_MODE_DPMS_ON)
> +		mode = DRM_MODE_DPMS_OFF;
> +
> +	if (tilcdc_crtc->dpms == mode)
> +		return;
> +
> +	tilcdc_crtc->dpms = mode;
> +
> +	pm_runtime_get_sync(dev->dev);
> +
> +	if (mode == DRM_MODE_DPMS_ON) {
> +		pm_runtime_forbid(dev->dev);
> +		start(crtc);
> +	} else {
> +		tilcdc_crtc->frame_done = false;
> +		stop(crtc);
> +
> +		/* if necessary wait for framedone irq which will still come
> +		 * before putting things to sleep..
> +		 */
> +		if (priv->rev == 2) {
> +			int ret = wait_event_timeout(
> +					tilcdc_crtc->frame_done_wq,
> +					tilcdc_crtc->frame_done,
> +					msecs_to_jiffies(50));
> +			if (ret == 0)
> +				dev_err(dev->dev, "timeout waiting for framedone\n");
> +		}
> +		pm_runtime_allow(dev->dev);
> +	}
> +
> +	pm_runtime_put_sync(dev->dev);
> +}
> +
> +static bool tilcdc_crtc_mode_fixup(struct drm_crtc *crtc,
> +		const struct drm_display_mode *mode,
> +		struct drm_display_mode *adjusted_mode)
> +{
> +	return true;
> +}
> +
> +static void tilcdc_crtc_prepare(struct drm_crtc *crtc)
> +{
> +	tilcdc_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
> +}
> +
> +static void tilcdc_crtc_commit(struct drm_crtc *crtc)
> +{
> +	tilcdc_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
> +}
> +
> +static int tilcdc_crtc_mode_set(struct drm_crtc *crtc,
> +		struct drm_display_mode *mode,
> +		struct drm_display_mode *adjusted_mode,
> +		int x, int y,
> +		struct drm_framebuffer *old_fb)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	struct drm_device *dev = crtc->dev;
> +	struct tilcdc_drm_private *priv = dev->dev_private;
> +	const struct tilcdc_panel_info *info = tilcdc_crtc->info;
> +	uint32_t reg, hbp, hfp, hsw, vbp, vfp, vsw;
> +	int ret;
> +
> +	ret = tilcdc_crtc_mode_valid(crtc, mode);
> +	if (WARN_ON(ret))
> +		return ret;
> +
> +	if (WARN_ON(!info))
> +		return -EINVAL;
> +
> +	pm_runtime_get_sync(dev->dev);
> +
> +	/* Configure the Burst Size and fifo threshold of DMA: */
> +	reg = tilcdc_read(dev, LCDC_DMA_CTRL_REG) & ~0x00000770;
> +	switch (info->dma_burst_sz) {
> +	case 1:
> +		reg |= LCDC_DMA_BURST_SIZE(LCDC_DMA_BURST_1);
> +		break;
> +	case 2:
> +		reg |= LCDC_DMA_BURST_SIZE(LCDC_DMA_BURST_2);
> +		break;
> +	case 4:
> +		reg |= LCDC_DMA_BURST_SIZE(LCDC_DMA_BURST_4);
> +		break;
> +	case 8:
> +		reg |= LCDC_DMA_BURST_SIZE(LCDC_DMA_BURST_8);
> +		break;
> +	case 16:
> +		reg |= LCDC_DMA_BURST_SIZE(LCDC_DMA_BURST_16);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	reg |= (info->fifo_th << 8);
> +	tilcdc_write(dev, LCDC_DMA_CTRL_REG, reg);
> +
> +	/* Configure the AC Bias Period and Number of Transitions per Interrupt: */
> +	reg = tilcdc_read(dev, LCDC_RASTER_TIMING_2_REG) & ~0x000fff00;
> +	reg |= LCDC_AC_BIAS_FREQUENCY(info->ac_bias) |
> +		LCDC_AC_BIAS_TRANSITIONS_PER_INT(info->ac_bias_intrpt);
> +	tilcdc_write(dev, LCDC_RASTER_TIMING_2_REG, reg);
> +
> +	/* Configure timings: */
> +	hbp = mode->htotal - mode->hsync_end;
> +	hfp = mode->hsync_start - mode->hdisplay;
> +	hsw = mode->hsync_end - mode->hsync_start;
> +	vbp = mode->vtotal - mode->vsync_end;
> +	vfp = mode->vsync_start - mode->vdisplay;
> +	vsw = mode->vsync_end - mode->vsync_start;
> +
> +	DBG("%dx%d, hbp=%u, hfp=%u, hsw=%u, vbp=%u, vfp=%u, vsw=%u",
> +			mode->hdisplay, mode->vdisplay, hbp, hfp, hsw, vbp, vfp, vsw);
> +
> +	reg = (((mode->hdisplay >> 4) - 1) << 4) |
> +		((hbp & 0xff) << 24) |
> +		((hfp & 0xff) << 16) |
> +		((hsw & 0x3f) << 10);
> +	if (priv->rev == 2)
> +		reg |= (((mode->hdisplay >> 4) - 1) & 0x40) >> 3;
> +	tilcdc_write(dev, LCDC_RASTER_TIMING_0_REG, reg);
> +
> +	reg = ((mode->vdisplay - 1) & 0x3ff) |
> +		((vbp & 0xff) << 24) |
> +		((vfp & 0xff) << 16) |
> +		((vsw & 0x3f) << 10);
> +	tilcdc_write(dev, LCDC_RASTER_TIMING_1_REG, reg);
> +
> +	/* Configure display type: */
> +	reg = tilcdc_read(dev, LCDC_RASTER_CTRL_REG) &
> +		~(LCDC_TFT_MODE | LCDC_MONO_8BIT_MODE | LCDC_MONOCHROME_MODE |
> +			LCDC_V2_TFT_24BPP_MODE | LCDC_V2_TFT_24BPP_UNPACK | 0x000ff000);
> +	reg |= LCDC_TFT_MODE; /* no monochrome/passive support */
> +	if (info->tft_alt_mode)
> +		reg |= LCDC_TFT_ALT_ENABLE;
> +	if (priv->rev == 2) {
> +		unsigned int depth, bpp;
> +
> +		drm_fb_get_bpp_depth(crtc->fb->pixel_format, &depth, &bpp);
> +		switch (bpp) {
> +		case 16:
> +			break;
> +		case 32:
> +			reg |= LCDC_V2_TFT_24BPP_UNPACK;
> +			/* fallthrough */
> +		case 24:
> +			reg |= LCDC_V2_TFT_24BPP_MODE;
> +			break;
> +		default:
> +			dev_err(dev->dev, "invalid pixel format\n");
> +			return -EINVAL;
> +		}
> +	}
> +	reg |= info->fdd < 12;
> +	tilcdc_write(dev, LCDC_RASTER_CTRL_REG, reg);
> +
> +	if (info->invert_pxl_clk)
> +		tilcdc_set(dev, LCDC_RASTER_TIMING_2_REG, LCDC_INVERT_PIXEL_CLOCK);
> +	else
> +		tilcdc_clear(dev, LCDC_RASTER_TIMING_2_REG, LCDC_INVERT_PIXEL_CLOCK);
> +
> +	if (info->sync_ctrl)
> +		tilcdc_set(dev, LCDC_RASTER_TIMING_2_REG, LCDC_SYNC_CTRL);
> +	else
> +		tilcdc_clear(dev, LCDC_RASTER_TIMING_2_REG, LCDC_SYNC_CTRL);
> +
> +	if (info->sync_edge)
> +		tilcdc_set(dev, LCDC_RASTER_TIMING_2_REG, LCDC_SYNC_EDGE);
> +	else
> +		tilcdc_clear(dev, LCDC_RASTER_TIMING_2_REG, LCDC_SYNC_EDGE);
> +
> +	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +		tilcdc_set(dev, LCDC_RASTER_TIMING_2_REG, LCDC_INVERT_HSYNC);
> +	else
> +		tilcdc_clear(dev, LCDC_RASTER_TIMING_2_REG, LCDC_INVERT_HSYNC);
> +
> +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +		tilcdc_set(dev, LCDC_RASTER_TIMING_2_REG, LCDC_INVERT_VSYNC);
> +	else
> +		tilcdc_clear(dev, LCDC_RASTER_TIMING_2_REG, LCDC_INVERT_VSYNC);
> +
> +	if (info->raster_order)
> +		tilcdc_set(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ORDER);
> +	else
> +		tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ORDER);
> +
> +
> +	update_scanout(crtc);
> +	tilcdc_crtc_update_clk(crtc);
> +
> +	pm_runtime_put_sync(dev->dev);
> +
> +	return 0;
> +}
> +
> +static int tilcdc_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
> +		struct drm_framebuffer *old_fb)
> +{
> +	update_scanout(crtc);
> +	return 0;
> +}
> +
> +static void tilcdc_crtc_load_lut(struct drm_crtc *crtc)
> +{
> +}
> +
> +static const struct drm_crtc_funcs tilcdc_crtc_funcs = {
> +		.destroy        = tilcdc_crtc_destroy,
> +		.set_config     = drm_crtc_helper_set_config,
> +		.page_flip      = tilcdc_crtc_page_flip,
> +};
> +
> +static const struct drm_crtc_helper_funcs tilcdc_crtc_helper_funcs = {
> +		.dpms           = tilcdc_crtc_dpms,
> +		.mode_fixup     = tilcdc_crtc_mode_fixup,
> +		.prepare        = tilcdc_crtc_prepare,
> +		.commit         = tilcdc_crtc_commit,
> +		.mode_set       = tilcdc_crtc_mode_set,
> +		.mode_set_base  = tilcdc_crtc_mode_set_base,
> +		.load_lut       = tilcdc_crtc_load_lut,
> +};
> +
> +int tilcdc_crtc_max_width(struct drm_crtc *crtc)
> +{
> +	struct drm_device *dev = crtc->dev;
> +	struct tilcdc_drm_private *priv = dev->dev_private;
> +	int max_width = 0;
> +
> +	if (priv->rev == 1)
> +		max_width = 1024;
> +	else if (priv->rev == 2)
> +		max_width = 2048;
> +
> +	return max_width;
> +}
> +
> +int tilcdc_crtc_mode_valid(struct drm_crtc *crtc, struct drm_display_mode *mode)
> +{
> +	struct tilcdc_drm_private *priv = crtc->dev->dev_private;
> +	unsigned int bandwidth;
> +
> +	if (mode->hdisplay > tilcdc_crtc_max_width(crtc))
> +		return MODE_VIRTUAL_X;
> +
> +	/* width must be multiple of 16 */
> +	if (mode->hdisplay & 0xf)
> +		return MODE_VIRTUAL_X;
> +
> +	if (mode->vdisplay > 2048)
> +		return MODE_VIRTUAL_Y;
> +
> +	/* filter out modes that would require too much memory bandwidth: */
> +	bandwidth = mode->hdisplay * mode->vdisplay * drm_mode_vrefresh(mode);
> +	if (bandwidth > priv->max_bandwidth)
> +		return MODE_BAD;
> +
> +	return MODE_OK;
> +}
> +
> +void tilcdc_crtc_set_panel_info(struct drm_crtc *crtc,
> +		const struct tilcdc_panel_info *info)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	tilcdc_crtc->info = info;
> +}
> +
> +void tilcdc_crtc_update_clk(struct drm_crtc *crtc)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	struct drm_device *dev = crtc->dev;
> +	struct tilcdc_drm_private *priv = dev->dev_private;
> +	int dpms = tilcdc_crtc->dpms;
> +	unsigned int lcd_clk, div;
> +	int ret;
> +
> +	pm_runtime_get_sync(dev->dev);
> +
> +	if (dpms == DRM_MODE_DPMS_ON)
> +		tilcdc_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
> +
> +	/* in raster mode, minimum divisor is 2: */
> +	ret = clk_set_rate(priv->disp_clk, crtc->mode.clock * 1000 * 2);
> +	if (ret) {
> +		dev_err(dev->dev, "failed to set display clock rate to: %d\n",
> +				crtc->mode.clock);
> +		goto out;
> +	}
> +
> +	lcd_clk = clk_get_rate(priv->clk);
> +	div = lcd_clk / (crtc->mode.clock * 1000);
> +
> +	DBG("lcd_clk=%u, mode clock=%d, div=%u", lcd_clk, crtc->mode.clock, div);
> +	DBG("fck=%lu, dpll_disp_ck=%lu", clk_get_rate(priv->clk), clk_get_rate(priv->disp_clk));
> +
> +	/* Configure the LCD clock divisor. */
> +	tilcdc_write(dev, LCDC_CTRL_REG, LCDC_CLK_DIVISOR(div) |
> +			LCDC_RASTER_MODE);
> +
> +	if (priv->rev == 2)
> +		tilcdc_set(dev, LCDC_CLK_ENABLE_REG,
> +				LCDC_V2_DMA_CLK_EN | LCDC_V2_LIDD_CLK_EN |
> +				LCDC_V2_CORE_CLK_EN);
> +
> +	if (dpms == DRM_MODE_DPMS_ON)
> +		tilcdc_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
> +
> +out:
> +	pm_runtime_put_sync(dev->dev);
> +}
> +
> +irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	struct drm_device *dev = crtc->dev;
> +	struct tilcdc_drm_private *priv = dev->dev_private;
> +	uint32_t stat = tilcdc_read_irqstatus(dev);
> +
> +	if ((stat & LCDC_SYNC_LOST) && (stat & LCDC_FIFO_UNDERFLOW)) {
> +		stop(crtc);
> +		dev_err(dev->dev, "error: %08x\n", stat);
> +		tilcdc_clear_irqstatus(dev, stat);
> +		start(crtc);
> +	} else if (stat & LCDC_PL_LOAD_DONE) {
> +		tilcdc_clear_irqstatus(dev, stat);
> +	} else {
> +		struct drm_pending_vblank_event *event;
> +		unsigned long flags;
> +		uint32_t dirty = tilcdc_crtc->dirty & stat;
> +
> +		tilcdc_clear_irqstatus(dev, stat);
> +
> +		if (dirty & LCDC_END_OF_FRAME0)
> +			set_scanout(crtc, 0);
> +
> +		if (dirty & LCDC_END_OF_FRAME1)
> +			set_scanout(crtc, 1);
> +
> +		drm_handle_vblank(dev, 0);
> +
> +		spin_lock_irqsave(&dev->event_lock, flags);
> +		event = tilcdc_crtc->event;
> +		tilcdc_crtc->event = NULL;
> +		if (event)
> +			drm_send_vblank_event(dev, 0, event);
> +		spin_unlock_irqrestore(&dev->event_lock, flags);
> +
> +		if (dirty && !tilcdc_crtc->dirty)
> +			drm_vblank_put(dev, 0);
> +	}
> +
> +	if (priv->rev == 2) {
> +		if (stat & LCDC_FRAME_DONE) {
> +			tilcdc_crtc->frame_done = true;
> +			wake_up(&tilcdc_crtc->frame_done_wq);
> +		}
> +		tilcdc_write(dev, LCDC_END_OF_INT_IND_REG, 0);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void tilcdc_crtc_cancel_page_flip(struct drm_crtc *crtc, struct drm_file *file)
> +{
> +	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	struct drm_pending_vblank_event *event;
> +	struct drm_device *dev = crtc->dev;
> +	unsigned long flags;
> +
> +	/* Destroy the pending vertical blanking event associated with the
> +	 * pending page flip, if any, and disable vertical blanking interrupts.
> +	 */
> +	spin_lock_irqsave(&dev->event_lock, flags);
> +	event = tilcdc_crtc->event;
> +	if (event && event->base.file_priv == file) {
> +		tilcdc_crtc->event = NULL;
> +		event->base.destroy(&event->base);
> +		drm_vblank_put(dev, 0);
> +	}
> +	spin_unlock_irqrestore(&dev->event_lock, flags);
> +}

We need some common (helper function) solution for this kind of cleanup -
have the drivers have a copy&pasta version of it, the others miss it
completely. Maybe we need to keep them on a per-crtc list or something
like that ... Volunteered to look a bit into this?

[cut]

> +/*
> + * Power management:
> + */
> +
> +#if CONFIG_PM_SLEEP
> +static int tilcdc_pm_suspend(struct device *dev)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct tilcdc_drm_private *priv = ddev->dev_private;
> +	unsigned i, n = 0;
> +
> +	drm_kms_helper_poll_disable(ddev);
> +
> +	/* Save register state: */
> +	for (i = 0; i < ARRAY_SIZE(registers); i++)
> +		if (registers[i].save && (priv->rev >= registers[i].rev))
> +			priv->saved_register[n++] = tilcdc_read(ddev, registers[i].reg);
> +
> +	return 0;
> +}
> +
> +static int tilcdc_pm_resume(struct device *dev)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct tilcdc_drm_private *priv = ddev->dev_private;
> +	unsigned i, n = 0;
> +
> +	/* Restore register state: */
> +	for (i = 0; i < ARRAY_SIZE(registers); i++)
> +		if (registers[i].save && (priv->rev >= registers[i].rev))
> +			tilcdc_write(ddev, registers[i].reg, priv->saved_register[n++]);
> +
> +	drm_kms_helper_poll_enable(ddev);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops tilcdc_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(tilcdc_pm_suspend, tilcdc_pm_resume)
> +};

Mind the clueless but curious about platform pm stuff: Why are those
suspend/resume functions not associated with the platform device?

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
