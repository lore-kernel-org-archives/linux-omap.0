From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: Fix build breaks for rfbi.c and dsi.c
Date: Wed, 15 Dec 2010 17:06:38 +0200
Message-ID: <1292425598.11825.10.camel@tubuntu>
References: <1292383012-22772-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:58354 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823Ab0LOPGo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 10:06:44 -0500
In-Reply-To: <1292383012-22772-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 2010-12-15 at 08:46 +0530, ext Archit Taneja wrote:
> The following patches caused compilation errors in rfbi.c and dsi.c:
> OMAP: DSS2: Introduce omap_channel argument to DISPC functions used by interface drivers
> OMAP: DSS2: Change remaining DISPC functions for new omap_channel argument
> 
> Signed-off-by: Archit Taneja <archit@ti.com>

Thanks, looks fine.

 Tomi

> ---
>  drivers/video/omap2/dss/dsi.c  |    2 +-
>  drivers/video/omap2/dss/dss.h  |    2 +-
>  drivers/video/omap2/dss/rfbi.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index f00ebb3..ddf3a05 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -2990,7 +2990,7 @@ static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
>  	cinfo.regm  = dssdev->phy.dsi.div.regm;
>  	cinfo.regm3 = dssdev->phy.dsi.div.regm3;
>  	cinfo.regm4 = dssdev->phy.dsi.div.regm4;
> -	r = dsi_calc_clock_rates(&cinfo);
> +	r = dsi_calc_clock_rates(dssdev, &cinfo);
>  	if (r) {
>  		DSSERR("Failed to calc dsi clocks\n");
>  		return r;
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index dd51d3f..b394951 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -431,7 +431,7 @@ void rfbi_dump_regs(struct seq_file *s);
>  
>  int rfbi_configure(int rfbi_module, int bpp, int lines);
>  void rfbi_enable_rfbi(bool enable);
> -void rfbi_transfer_area(omap_dss_device *dssdev, u16 width,
> +void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
>  		u16 height, void (callback)(void *data), void *data);
>  void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
>  unsigned long rfbi_get_max_tx_rate(void);
> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
> index c20a185..10a2ffe 100644
> --- a/drivers/video/omap2/dss/rfbi.c
> +++ b/drivers/video/omap2/dss/rfbi.c
> @@ -301,7 +301,7 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
>  }
>  EXPORT_SYMBOL(omap_rfbi_write_pixels);
>  
> -void rfbi_transfer_area(omap_dss_device *dssdev, u16 width,
> +void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
>  		u16 height, void (*callback)(void *data), void *data)
>  {
>  	u32 l;


