From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 11/23] include: video: omapdss: provide fifo threshold methods
Date: Sat, 26 Mar 2016 18:44:15 +0200
Message-ID: <3716861.y7tsY0dg3h@avalon>
References: <1457455195-1938-1-git-send-email-sre@kernel.org> <1457455195-1938-12-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-12-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

Thank you for the patch.

On Tuesday 08 Mar 2016 17:39:43 Sebastian Reichel wrote:
> The FIFO thresholds must be configured by omapdrm for
> manually updated DSI panels due to a hardware bug.

I find the subject a bit misleading, it made me think that the patch added new 
methods, while it only declares them as part of the DSS public API.

> Signed-off-By: Sebastian Reichel <sre@kernel.org>
> ---
>  include/video/omapdss.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index 9bde65b79220..f6cdd809ae5c 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -935,6 +935,12 @@ int dispc_ovl_setup(enum omap_plane plane, const struct
> omap_overlay_info *oi, bool replication, const struct omap_video_timings
> *mgr_timings, bool mem_to_mem);
> 
> +void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
> +		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
> +		bool manual_update);
> +void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32
> high);

Should you then remove the function declarations from 
drivers/gpu/drm/omapdrm/dss/dss.h ?

> +
> +

One blank line is enough.

>  int omapdss_compat_init(void);
>  void omapdss_compat_uninit(void);

-- 
Regards,

Laurent Pinchart
