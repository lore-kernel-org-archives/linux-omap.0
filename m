From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: move dss device clock configuration
Date: Fri, 1 Apr 2011 12:35:07 +0530
Message-ID: <4D957923.2030902@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com> <1301566266-11187-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55563 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512Ab1DAHAy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Apr 2011 03:00:54 -0400
In-Reply-To: <1301566266-11187-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Thursday 31 March 2011 03:40 PM, Valkeinen, Tomi wrote:
> Clock configuration was defined inside dssdev.phy.dsi struct. The clock
> config doesn't really belong there, and so it's moved to dssdev.clock
> struct.
>
> Now the explicit clock configuration could also be used for other
> interfaces than DSI, although there's no support for it currently.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/board-4430sdp.c       |   14 +++++++++-----
>   arch/arm/plat-omap/include/plat/display.h |   28 ++++++++++++++++------------
>   drivers/video/omap2/dss/dsi.c             |   14 +++++++-------
>   3 files changed, 32 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 05288c9..626b16b 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -766,17 +766,21 @@ static struct omap_dss_device sdp4430_lcd_device = {
>   		.data1_pol	= 0,
>   		.data2_lane	= 3,
>   		.data2_pol	= 0,
> -		.div		= {
> +	},
> +
> +	.clocks = {
> +		.dispc = {
> +			.lck_div	= 1,	/* Logic Clock = 172.8 MHz */
> +			.pck_div	= 5,	/* Pixel Clock = 34.56 MHz */
> +		},
> +
> +		.dsi = {
>   			.regn		= 16,	/* Fint = 2.4 MHz */
>   			.regm		= 180,	/* DDR Clock = 216 MHz */
>   			.regm_dispc	= 5,	/* PLL1_CLK1 = 172.8 MHz */
>   			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
>
>   			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
> -
> -			.lck_div	= 1,	/* Logic Clock = 172.8 MHz */
> -			.pck_div	= 5,	/* Pixel Clock = 34.56 MHz */
> -
>   		},
>   	},
>   	.channel		= OMAP_DSS_CHANNEL_LCD,
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index 5e04ddc..e10cfe2 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -401,18 +401,6 @@ struct omap_dss_device {
>   			u8 data2_lane;
>   			u8 data2_pol;
>
> -			struct {
> -				u16 regn;
> -				u16 regm;
> -				u16 regm_dispc;
> -				u16 regm_dsi;
> -
> -				u16 lp_clk_div;
> -
> -				u16 lck_div;
> -				u16 pck_div;
> -			} div;
> -
>   			bool ext_te;
>   			u8 ext_te_gpio;
>   		} dsi;
> @@ -424,6 +412,22 @@ struct omap_dss_device {
>   	} phy;
>
>   	struct {
> +		struct {
> +			u16 lck_div;
> +			u16 pck_div;

Is it possible to wrap these members around a channel member? The board 
file can then fill up the lck_div and ppck_div based on what channel it 
is using.

Archit

> +		} dispc;
> +
> +		struct {
> +			u16 regn;
> +			u16 regm;
> +			u16 regm_dispc;
> +			u16 regm_dsi;
> +
> +			u16 lp_clk_div;
> +		} dsi;
> +	} clocks;
> +
> +	struct {
>   		struct omap_video_timings timings;
>
>   		int acbi;	/* ac-bias pin transitions per interrupt */
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 23d9bbe..7304c87 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -1026,7 +1026,7 @@ static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
>   	unsigned lp_clk_div;
>   	unsigned long lp_clk;
>
> -	lp_clk_div = dssdev->phy.dsi.div.lp_clk_div;
> +	lp_clk_div = dssdev->clocks.dsi.lp_clk_div;
>
>   	if (lp_clk_div == 0 || lp_clk_div>  dsi.lpdiv_max)
>   		return -EINVAL;
> @@ -3388,10 +3388,10 @@ static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
>
>   	/* we always use DSS_CLK_SYSCK as input clock */
>   	cinfo.use_sys_clk = true;
> -	cinfo.regn  = dssdev->phy.dsi.div.regn;
> -	cinfo.regm  = dssdev->phy.dsi.div.regm;
> -	cinfo.regm_dispc = dssdev->phy.dsi.div.regm_dispc;
> -	cinfo.regm_dsi = dssdev->phy.dsi.div.regm_dsi;
> +	cinfo.regn  = dssdev->clocks.dsi.regn;
> +	cinfo.regm  = dssdev->clocks.dsi.regm;
> +	cinfo.regm_dispc = dssdev->clocks.dsi.regm_dispc;
> +	cinfo.regm_dsi = dssdev->clocks.dsi.regm_dsi;
>   	r = dsi_calc_clock_rates(dssdev,&cinfo);
>   	if (r) {
>   		DSSERR("Failed to calc dsi clocks\n");
> @@ -3415,8 +3415,8 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
>
>   	fck = dsi_get_pll_hsdiv_dispc_rate();
>
> -	dispc_cinfo.lck_div = dssdev->phy.dsi.div.lck_div;
> -	dispc_cinfo.pck_div = dssdev->phy.dsi.div.pck_div;
> +	dispc_cinfo.lck_div = dssdev->clocks.dispc.lck_div;
> +	dispc_cinfo.pck_div = dssdev->clocks.dispc.pck_div;
>
>   	r = dispc_calc_clock_rates(fck,&dispc_cinfo);
>   	if (r) {

