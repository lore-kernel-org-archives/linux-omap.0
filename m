From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 10/23] drm: omapdrm: crtc: detect manually updated displays
Date: Sat, 26 Mar 2016 18:51:44 +0200
Message-ID: <14468818.yB5yOlC6bO@avalon>
References: <1457455195-1938-1-git-send-email-sre@kernel.org> <1457455195-1938-11-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-11-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

Thank you for the patch.

On Tuesday 08 Mar 2016 17:39:42 Sebastian Reichel wrote:
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/gpu/drm/omapdrm/omap_crtc.c | 31 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/omapdrm/omap_drv.h  |  1 +
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c
> b/drivers/gpu/drm/omapdrm/omap_crtc.c index 78ef9773cca1..8967013c1fb5
> 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -48,6 +48,7 @@ struct omap_crtc {
>  	struct omap_overlay_manager *mgr;
> 
>  	struct omap_video_timings timings;
> +	bool manually_updated;
> 
>  	struct omap_drm_irq vblank_irq;
>  	struct omap_drm_irq error_irq;
> @@ -90,6 +91,12 @@ int omap_crtc_wait_pending(struct drm_crtc *crtc)
>  				  msecs_to_jiffies(50));
>  }
> 
> +bool omap_crtc_is_manual_updated(struct drm_crtc *crtc)
> +{
> +	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +	return omap_crtc->manually_updated;
> +}
> +
>  /*
> ---------------------------------------------------------------------------
> -- * DSS Manager Functions
>   */
> @@ -154,6 +161,11 @@ static void omap_crtc_set_enabled(struct drm_crtc
> *crtc, bool enable) omap_crtc->ignore_digit_sync_lost = true;
>  	}
> 
> +	if (omap_crtc->manually_updated) {
> +		dev_dbg(dev->dev, "stallmode detected, not waiting for irq");
> +		return;
> +	}
> +
>  	framedone_irq = dispc_mgr_get_framedone_irq(channel);
>  	vsync_irq = dispc_mgr_get_vsync_irq(channel);
> 
> @@ -233,7 +245,13 @@ static void omap_crtc_dss_set_lcd_config(struct
> omap_overlay_manager *mgr, const struct dss_lcd_mgr_config *config)
>  {
>  	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
> -	DBG("%s", omap_crtc->name);
> +	struct drm_device *dev = omap_crtc->base.dev;
> +	struct drm_plane *plane;
> +
> +	dev_dbg(dev->dev, "set lcd config for %s", omap_crtc->name);
> +
> +	omap_crtc->manually_updated = dss_lcd_mgr_config_get_stallmode(config);
> +
>  	dispc_mgr_set_lcd_config(omap_crtc->channel, config);
>  }
> 
> @@ -358,10 +376,18 @@ static bool omap_crtc_mode_fixup(struct drm_crtc
> *crtc, static void omap_crtc_enable(struct drm_crtc *crtc)
>  {
>  	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> +	struct omap_dss_device *display = omap_crtc->mgr->output->dst;
>  	struct drm_device *dev = crtc->dev;
> 
>  	DBG("%s", omap_crtc->name);
> 
> +	/* manual updated display will not trigger vsync irq */
> +	/* omap_crtc->manually_updated is not yet set */

Can't you figure out whether the display requires manual update earlier, 
preferably during atomic_check, and store the value in the CRTC state ?

> +	if (display->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
> +		dev_dbg(dev->dev, "manual update display detected!");
> +		return;
> +	}
> +
>  	if (test_and_set_bit(crtc_pending, &omap_crtc->state))
>  		dev_warn(dev->dev, "crtc enable while pending bit set!");
> 
> @@ -407,6 +433,9 @@ static void omap_crtc_atomic_flush(struct drm_crtc
> *crtc,
> 
>  	WARN_ON(omap_crtc->vblank_irq.registered);
> 
> +	if (omap_crtc->manually_updated)
> +		return;
> +
>  	if (dispc_mgr_is_enabled(omap_crtc->channel)) {
> 
>  		DBG("%s: GO", omap_crtc->name);
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h
> b/drivers/gpu/drm/omapdrm/omap_drv.h index 5dfa93a3b505..71e2c2284b86
> 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.h
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.h
> @@ -155,6 +155,7 @@ void omap_crtc_pre_uninit(void);
>  struct drm_crtc *omap_crtc_init(struct drm_device *dev,
>  		struct drm_plane *plane, enum omap_channel channel, int id);
>  int omap_crtc_wait_pending(struct drm_crtc *crtc);
> +bool omap_crtc_is_manual_updated(struct drm_crtc *crtc);
> 
>  struct drm_plane *omap_plane_init(struct drm_device *dev,
>  		int id, enum drm_plane_type type);

-- 
Regards,

Laurent Pinchart
