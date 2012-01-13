From: Archit <a0393947@ti.com>
Subject: Re: [PATCH 5/6] OMAPDSS: DISPC: move fifo threhold calc to dispc.c
Date: Sat, 14 Jan 2012 01:30:58 +0530
Message-ID: <4F108D7A.4010802@ti.com>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com> <1326455193-19716-6-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54551 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574Ab2AMUBJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 15:01:09 -0500
In-Reply-To: <1326455193-19716-6-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com, rob@ti.com

Hi,

On Friday 13 January 2012 05:16 PM, Tomi Valkeinen wrote:
> Move fifo threshold calculation into dispc.c, as the thresholds are
> really dispc internal thing.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>

<snip>

> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 511ae2a..1cbb7a5 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -4524,14 +4524,6 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
>   }
>   EXPORT_SYMBOL(omapdss_dsi_enable_te);
>
> -void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
> -		u32 fifo_size, u32 burst_size,
> -		u32 *fifo_low, u32 *fifo_high)
> -{
> -	*fifo_high = fifo_size - burst_size;
> -	*fifo_low = fifo_size - burst_size * 2;
> -}

We are removing the special treatment for overlays connected to DSI done 
before. Won't this cause the issues you saw with DSI in OMAP3?

Archit

> -
>   int dsi_init_display(struct omap_dss_device *dssdev)
>   {
>   	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 3cf99a9..f2378a8 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -202,9 +202,6 @@ void dss_uninit_device(struct platform_device *pdev,
>   		struct omap_dss_device *dssdev);
>   bool dss_use_replication(struct omap_dss_device *dssdev,
>   		enum omap_color_mode mode);
> -void default_get_overlay_fifo_thresholds(enum omap_plane plane,
> -		u32 fifo_size, u32 burst_size,
> -		u32 *fifo_low, u32 *fifo_high);
>
>   /* manager */
>   int dss_init_overlay_managers(struct platform_device *pdev);
> @@ -313,9 +310,6 @@ int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
>   int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
>   		bool enable_hsdiv);
>   void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
> -void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
> -		u32 fifo_size, u32 burst_size,
> -		u32 *fifo_low, u32 *fifo_high);
>   void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev);
>   void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev);
>   struct platform_device *dsi_get_dsidev_from_id(int module);
> @@ -429,8 +423,8 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
>
>
>   void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
> -u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
> -u32 dispc_ovl_get_burst_size(enum omap_plane plane);
> +void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
> +		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge);
>   int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
>   		bool ilace, bool replication);
>   int dispc_ovl_enable(enum omap_plane plane, bool enable);

