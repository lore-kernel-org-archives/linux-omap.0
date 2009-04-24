From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] enabled alpha blender for OMAP2/3 DSS2 driver.
Date: Fri, 24 Apr 2009 06:46:36 -0700
Message-ID: <87skjyxiyr.fsf@deeprootsystems.com>
References: <90b950fc0904240213x70f66891j7dc587f09445e2f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:22245 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847AbZDXNqk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 09:46:40 -0400
Received: by wa-out-1112.google.com with SMTP id j5so563646wah.21
        for <linux-omap@vger.kernel.org>; Fri, 24 Apr 2009 06:46:40 -0700 (PDT)
In-Reply-To: <90b950fc0904240213x70f66891j7dc587f09445e2f3@mail.gmail.com> (InKi Dae's message of "Fri\, 24 Apr 2009 18\:13\:22 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: InKi Dae <daeinki@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

InKi Dae <daeinki@gmail.com> writes:

> - Added global alpha value for GFX and VIDEO2 layer.
> - Modified dispc_alpha_blending_enabled function.
>   -> for OMAP_DSS_CHANNEL_DIGIT, it has to get DISPC_CONFIG[19], not 18.
>
> For alpha channel, dispc_enable_alpha_blending() is called by
> omapfb_fb_init() in case of only XXX_ARGB16, RGBA32 or ARGB32
>
> Signed-off-by: InKi Dae <inki.dae@samsung.com>
> --
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 9bab6cf..c5335e5 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1846,8 +1846,10 @@ void dispc_enable_trans_key(enum omap_channel
> ch, bool enable)
>           enable_clocks(1);
>           if (ch == OMAP_DSS_CHANNEL_LCD)
>                      REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
> -          else /* OMAP_DSS_CHANNEL_DIGIT */
> +         else if (ch == OMAP_DSS_CHANNEL_DIGIT)
>                      REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
> +         else
> +                   BUG();

BUG() will halt the whole kernel.  I don't think you want to do that
for this issue.  I think WARN() is more appropriate here and the other
cases in this patch as well.

Kevin

>           enable_clocks(0);
>  }
>  void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
> @@ -1855,8 +1857,10 @@ void dispc_enable_alpha_blending(enum
> omap_channel ch, bool enable)
>           enable_clocks(1);
>           if (ch == OMAP_DSS_CHANNEL_LCD)
>                      REG_FLD_MOD(DISPC_CONFIG, enable, 18, 18);
> -          else /* OMAP_DSS_CHANNEL_DIGIT */
> +         else if (ch == OMAP_DSS_CHANNEL_DIGIT)
>                      REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
> +         else
> +                   BUG();
>           enable_clocks(0);
>  }
>  bool dispc_alpha_blending_enabled(enum omap_channel ch)
> @@ -1867,7 +1871,7 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
>           if (ch == OMAP_DSS_CHANNEL_LCD)
>                      enabled = REG_GET(DISPC_CONFIG, 18, 18);
>           else if (ch == OMAP_DSS_CHANNEL_DIGIT)
> -                    enabled = REG_GET(DISPC_CONFIG, 18, 18);
> +                   enabled = REG_GET(DISPC_CONFIG, 19, 19);
>           else
>                      BUG();
>           enable_clocks(0);
> @@ -1876,6 +1880,18 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
>
>  }
>
> +void dispc_set_global_alpha(int layer, int alpha)
> +{
> +         enable_clocks(1);
> +         if (layer == 0)
> +                   REG_FLD_MOD(DISPC_GLOBAL_ALPHA, alpha, 7, 0);
> +         else if (layer == 2)
> +                   REG_FLD_MOD(DISPC_GLOBAL_ALPHA, alpha, 23, 16);
> +         else
> +                   BUG();
> +
> +         enable_clocks(0);
> +}
>
>  bool dispc_trans_key_enabled(enum omap_channel ch)
>  {
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> b/drivers/video/omap2/omapfb/omapfb-main.c
> index 76e7c6c..98cad35 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -1583,6 +1583,17 @@ int omapfb_fb_init(struct omapfb2_device
> *fbdev, struct fb_info *fbi)
>                                           r = mode;
>                                           goto err;
>                                 }
> +
> +                              if (mode == OMAP_DSS_COLOR_ARGB16 ||
> +                                                   mode ==
> OMAP_DSS_COLOR_RGBA32 ||
> +                                                   mode ==
> OMAP_DSS_COLOR_ARGB32) {
> +
> +
> dispc_enable_alpha_blending(OMAP_DSS_CHANNEL_LCD, 1);
> +
> +                                         /* Set global alpha value to
> fully apaque */
> +                                         dispc_set_global_alpha(id, 255);
> +                              }
> +
>                                 r = dss_mode_to_fb_mode(mode, var);
>                                 if (r < 0)
>                                           goto err;
> diff --git a/drivers/video/omap2/omapfb/omapfb.h
> b/drivers/video/omap2/omapfb/omapfb.h
> index 43f6922..56c303e 100644
> --- a/drivers/video/omap2/omapfb/omapfb.h
> +++ b/drivers/video/omap2/omapfb/omapfb.h
> @@ -147,4 +147,8 @@ static inline int omapfb_overlay_enable(struct
> omap_overlay *ovl,
>           return ovl->set_overlay_info(ovl, &info);
>  }
>
> +extern void dispc_enable_alpha_blending(enum omap_channel ch,
> +                   int enable);
> +extern void dispc_set_global_alpha(int layer, int alpha);
> +
>  #endif
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
