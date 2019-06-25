From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 2/5] drm/panel: simple: Add Ortustech COM37H3M panel
 support
Date: Tue, 25 Jun 2019 22:40:00 +0200
Message-ID: <20190625204000.GC18595@ravnborg.org>
References: <cover.1559905870.git.hns@goldelico.com>
 <43b47034b618cff26cea0484591c6deafb7f0685.1559905870.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43b47034b618cff26cea0484591c6deafb7f0685.1559905870.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com, imirkin@alum.mit.edu, marek.belisko@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 07, 2019 at 01:11:08PM +0200, H. Nikolaus Schaller wrote:
> The change adds support for the Ortustech COM37H3M05DTC/99DTC 3.7" TFT LCD panel.
> 
> Tested on Letux3704.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 33 ++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 5b27829c5a78..1fb74908a269 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2007,6 +2007,33 @@ static const struct panel_desc ontat_yx700wv03 = {
>  	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
>  };
>  
> +static const struct drm_display_mode ortustech_com37h3m_mode  = {
> +	.clock = 22153,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 8,
> +	.hsync_end = 480 + 8 + 10,
> +	.htotal = 480 + 8 + 10 + 10,
> +	.vdisplay = 640,
> +	.vsync_start = 640 + 4,
> +	.vsync_end = 640 + 4 + 3,
> +	.vtotal = 640 + 4 + 3 + 4,
> +	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +};
> +
> +static const struct panel_desc ortustech_com37h3m = {
> +	.modes = &ortustech_com37h3m_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 56,	/* 56.16mm */
> +		.height = 75,	/* 74.88mm */
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE |
> +		     DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE,
> +};
> +
>  static const struct drm_display_mode ortustech_com43h4m85ulc_mode  = {
>  	.clock = 25000,
>  	.hdisplay = 480,
> @@ -2786,6 +2813,12 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "ontat,yx700wv03",
>  		.data = &ontat_yx700wv03,
> +	}, {
> +		.compatible = "ortustech,com37h3m05dtc",
> +		.data = &ortustech_com37h3m,
> +	}, {
> +		.compatible = "ortustech,com37h3m99dtc",
> +		.data = &ortustech_com37h3m,
>  	}, {
>  		.compatible = "ortustech,com43h4m85ulc",
>  		.data = &ortustech_com43h4m85ulc,
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
