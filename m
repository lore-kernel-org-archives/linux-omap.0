From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/10] OMAP: DSS2: DSI Video mode support
Date: Thu, 01 Sep 2011 16:14:29 +0300
Message-ID: <1314882869.2169.22.camel@lappyti>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
	 <1314701495-11247-11-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:59935 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757191Ab1IANOg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 09:14:36 -0400
Received: by mail-bw0-f43.google.com with SMTP id zv15so2145084bkb.30
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 06:14:35 -0700 (PDT)
In-Reply-To: <1314701495-11247-11-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2011-08-30 at 16:21 +0530, Archit Taneja wrote:
> Add initial support for DSI video mode panels:
> - Add a new structure omap_dss_dsi_videomode_data in the member "panel" in
>   omap_dss_device struct. This allows panel driver to configure dsi video_mode
>   specific parameters.
> - Configure basic DSI video mode timing parameters: HBP, HFP, HSA, VBP, VFP, VSA,
>   TL and VACT.
> - Configure DSI protocol engine registers for video_mode support.
> - Introduce functions dsi_video_mode_enable() and dsi_video_mode_disable() which
>   enable/disable video mode for a given virtual channel and a given pixel format
>   type.
> 
> Things left for later
> - Add functions to check for errors in video mode timings provided by panel.
> - Configure timing registers required  for command mode interleaving.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dsi.c |  256 ++++++++++++++++++++++++++++++++++++-----
>  include/video/omapdss.h       |   32 +++++
>  2 files changed, 259 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 582ae7b..e3d5c38 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -132,7 +132,7 @@ struct dsi_reg { u16 idx; };
>  #define DSI_IRQ_TA_TIMEOUT	(1 << 20)
>  #define DSI_IRQ_ERROR_MASK \
>  	(DSI_IRQ_HS_TX_TIMEOUT | DSI_IRQ_LP_RX_TIMEOUT | DSI_IRQ_SYNC_LOST | \
> -	DSI_IRQ_TA_TIMEOUT)
> +	DSI_IRQ_TA_TIMEOUT | DSI_IRQ_SYNC_LOST)
>  #define DSI_IRQ_CHANNEL_MASK	0xf
>  
>  /* Virtual channel interrupts */
> @@ -2472,6 +2472,12 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
>  
>  	dsi_cio_timings(dsidev);
>  
> +	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
> +		/* DDR_CLK_ALWAYS_ON */
> +		REG_FLD_MOD(dsidev, DSI_CLK_CTRL,
> +			dssdev->panel.dsi_vm_data.ddr_clk_always_on, 13, 13);
> +	}
> +

For the DDR clock to start, you need to send a null packet, don't you?

 Tomi


