From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH] drm/omap: update for interlaced
Date: Thu, 6 Sep 2012 11:12:01 +0530
Message-ID: <CAB2ybb-FDpFiaz6tAFajeohyUX54jOybZHFxZbMzFpFnhKMM+w@mail.gmail.com>
References: <1346881733-31970-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:45448 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126Ab2IFFmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 01:42:23 -0400
Received: by pbbrr13 with SMTP id rr13so2019801pbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 22:42:22 -0700 (PDT)
In-Reply-To: <1346881733-31970-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

Hi Rob,
On Thu, Sep 6, 2012 at 3:18 AM, Rob Clark <rob.clark@linaro.org> wrote:
> From: Rob Clark <rob@ti.com>
>
> 'struct omap_video_timings' was updated w/ a 'bool interlaced'.  Without
> a matching update in omap_connector, this field could have undefined
> values from the stack, which isn't quite ideal.
>
> Update the fxns to convert omapdss<->drm timings structs, and zero-init
> 'struct omap_video_timings' when it is declared on stack to avoid issues
> like this in the future.
>
> Signed-off-by: Rob Clark <rob@ti.com>
Feel free to use
Reviewed-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  drivers/staging/omapdrm/omap_connector.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
> index 5e2856c..5f4a89b 100644
> --- a/drivers/staging/omapdrm/omap_connector.c
> +++ b/drivers/staging/omapdrm/omap_connector.c
> @@ -48,13 +48,10 @@ static inline void copy_timings_omap_to_drm(struct drm_display_mode *mode,
>         mode->vsync_end = mode->vsync_start + timings->vsw;
>         mode->vtotal = mode->vsync_end + timings->vbp;
>
> -       /* note: whether or not it is interlaced, +/- h/vsync, etc,
> -        * which should be set in the mode flags, is not exposed in
> -        * the omap_video_timings struct.. but hdmi driver tracks
> -        * those separately so all we have to have to set the mode
> -        * is the way to recover these timings values, and the
> -        * omap_dss_driver would do the rest.
> -        */
> +       mode->flags = 0;
> +
> +       if (timings->interlace)
> +               mode->flags |= DRM_MODE_FLAG_INTERLACE;
>  }
>
>  static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
> @@ -71,6 +68,8 @@ static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
>         timings->vfp = mode->vsync_start - mode->vdisplay;
>         timings->vsw = mode->vsync_end - mode->vsync_start;
>         timings->vbp = mode->vtotal - mode->vsync_end;
> +
> +       timings->interlace = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
>  }
>
>  static void omap_connector_dpms(struct drm_connector *connector, int mode)
> @@ -187,7 +186,7 @@ static int omap_connector_get_modes(struct drm_connector *connector)
>                 }
>         } else {
>                 struct drm_display_mode *mode = drm_mode_create(dev);
> -               struct omap_video_timings timings;
> +               struct omap_video_timings timings = {0};
>
>                 dssdrv->get_timings(dssdev, &timings);
>
> @@ -291,7 +290,7 @@ void omap_connector_mode_set(struct drm_connector *connector,
>         struct omap_connector *omap_connector = to_omap_connector(connector);
>         struct omap_dss_device *dssdev = omap_connector->dssdev;
>         struct omap_dss_driver *dssdrv = dssdev->driver;
> -       struct omap_video_timings timings;
> +       struct omap_video_timings timings = {0};
>
>         copy_timings_drm_to_omap(&timings, mode);
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
