From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 08/23] drm: omapdrm: crtc: add enabled bit to state
Date: Sat, 26 Mar 2016 18:35:56 +0200
Message-ID: <7825357.9S665VRxLh@avalon>
References: <1457455195-1938-1-git-send-email-sre@kernel.org> <1457455195-1938-9-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-9-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

Thank you for the patch.

Given that you only add four lines of code here, and given that the enabled 
bit is unused here, I'd just squash this patch with the one that makes use of 
the enabled bit.

On Tuesday 08 Mar 2016 17:39:40 Sebastian Reichel wrote:
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/gpu/drm/omapdrm/omap_crtc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c
> b/drivers/gpu/drm/omapdrm/omap_crtc.c index 5ef27664bcfa..78ef9773cca1
> 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -207,6 +207,8 @@ static int omap_crtc_dss_enable(struct
> omap_overlay_manager *mgr) &omap_crtc->timings);
>  	omap_crtc_set_enabled(&omap_crtc->base, true);
> 
> +	set_bit(crtc_enabled, &omap_crtc->state);
> +

Atomic KMS drivers should store state in the state structure, not the KMS 
objects themselves. Beside, how does this differ from the CRTC state enable 
and active fields ?

>  	return 0;
>  }
> 
> @@ -214,6 +216,8 @@ static void omap_crtc_dss_disable(struct
> omap_overlay_manager *mgr) {
>  	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
> 
> +	clear_bit(crtc_enabled, &omap_crtc->state);
> +
>  	omap_crtc_set_enabled(&omap_crtc->base, false);
>  }

-- 
Regards,

Laurent Pinchart
