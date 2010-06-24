From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS: Fix for dsi_pll to dpll4 clk switch
Date: Thu, 24 Jun 2010 13:51:12 +0300
Message-ID: <1277376672.2464.188.camel@tubuntu.research.nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BDA5E730@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65513 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0FXKwR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 06:52:17 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDA5E730@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-06-17 at 07:12 +0200, ext Nagarajan, Rajkumar wrote:
> When switching between clocks, The new functional clock is
> effective when the next vertical blanking interval occurs.
> GOLCD bit has to be set for the new clock to take effect.

Where did you encounter this problem?

> Signed-off-by: Kishore Y <kishore.y@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
> ---
>  drivers/video/omap2/dss/dpi.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index 960e977..5d778d6 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -214,10 +214,15 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
>  
>  #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
>  	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
> +	dispc_go(OMAP_DSS_CHANNEL_LCD);

I don't think GO does anything here, as the channel has already been
disabled.

> +	while	(dispc_go_busy(OMAP_DSS_CHANNEL_LCD))
> +		;

Busy looping is not good.

>  	dsi_pll_uninit();
>  	dss_clk_disable(DSS_CLK_FCK2);
>  #endif
>  
> +	dispc_enable_channel(OMAP_DSS_CHANNEL_LCD, 0);
> +

The channel has already been disabled above, in
dssdev->manager->disable(dssdev->manager);

 Tomi


