From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 09/10] drm: omapdrm: crtc: get manual mode displays
 working
Date: Sat, 4 Mar 2017 21:39:51 -0800
Message-ID: <20170305053951.GB20572@atomide.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-9-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170305004309.28259-9-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170304 16:45]:
> From: Tony Lindgren <tony@atomide.com>
> 
> With manual mode displays we need to flush the panel manually.
> 
> Let's add flushing so we get Tomi's fbtest, kmstest, kmstest --flip,
> and X and wayland working.
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -97,6 +97,11 @@ bool omap_crtc_is_manual_updated(struct drm_crtc *crtc)
>  	return omap_crtc->manually_updated;
>  }
>  
> +static void omap_crtc_manual_needs_flush(struct drm_crtc *crtc)
> +{
> +	omap_crtc_flush(crtc, 0, 0, 0, 0);
> +}
...

> @@ -554,6 +561,7 @@ static void omap_crtc_atomic_flush(struct drm_crtc *crtc,
>  		ret = drm_crtc_vblank_get(crtc);
>  		WARN_ON(ret != 0);
>  	}
> +	omap_crtc_flush(&omap_crtc->base, 0, 0, 0, 0);

Just noticed that this should also just use omap_crtc_manual_needs_flush()
here if you care to update it.

Regards,

Tony
