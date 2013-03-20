From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 01/14] OMAPDSS: DISPC: store core clk rate
Date: Wed, 20 Mar 2013 16:38:33 +0530
Message-ID: <514998B1.8040907@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com> <1362743569-10289-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37600 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617Ab3CTLJU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 07:09:20 -0400
In-Reply-To: <1362743569-10289-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Friday 08 March 2013 05:22 PM, Tomi Valkeinen wrote:
> Store dispc core clock rate so that it's available for calculations even
> if the HW is disabled.

I think the core_clk_rate variable should change when we change the lcd 
clock source through dss_select_lcd_clk_source() for omap3.

If we have the following sequence:

...
dispc_mgr_set_lcd_divisor();
dss_select_lcd_clk_source();
...

The value of core_clock variable would be based on the previous clock 
source, and not the current one.

This situation doesn't occur currently as the 'apply' framework delays 
all dispc writes to the point when we enable the manager. So the 
sequence above cannot occur. But maybe we should keep this in mind when 
we move more things to omapdrm, where 'apply' isn't in use.

Archit

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dispc.c |   18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 05ff2b9..f564955 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -97,6 +97,8 @@ static struct {
>
>   	int irq;
>
> +	unsigned long core_clk_rate;
> +
>   	u32 fifo_size[DISPC_MAX_NR_FIFOS];
>   	/* maps which plane is using a fifo. fifo-id -> plane-id */
>   	int fifo_assignment[DISPC_MAX_NR_FIFOS];
> @@ -2951,6 +2953,10 @@ static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
>
>   	dispc_write_reg(DISPC_DIVISORo(channel),
>   			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
> +
> +	if (dss_has_feature(FEAT_CORE_CLK_DIV) == false &&
> +			channel == OMAP_DSS_CHANNEL_LCD)
> +		dispc.core_clk_rate = dispc_fclk_rate() / lck_div;
>   }
>
>   static void dispc_mgr_get_lcd_divisor(enum omap_channel channel, int *lck_div,
> @@ -3056,15 +3062,7 @@ unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
>
>   unsigned long dispc_core_clk_rate(void)
>   {
> -	int lcd;
> -	unsigned long fclk = dispc_fclk_rate();
> -
> -	if (dss_has_feature(FEAT_CORE_CLK_DIV))
> -		lcd = REG_GET(DISPC_DIVISOR, 23, 16);
> -	else
> -		lcd = REG_GET(DISPC_DIVISORo(OMAP_DSS_CHANNEL_LCD), 23, 16);
> -
> -	return fclk / lcd;
> +	return dispc.core_clk_rate;
>   }
>
>   static unsigned long dispc_plane_pclk_rate(enum omap_plane plane)
> @@ -3451,6 +3449,8 @@ static void _omap_dispc_initial_config(void)
>   		l = FLD_MOD(l, 1, 0, 0);
>   		l = FLD_MOD(l, 1, 23, 16);
>   		dispc_write_reg(DISPC_DIVISOR, l);
> +
> +		dispc.core_clk_rate = dispc_fclk_rate();
>   	}
>
>   	/* FUNCGATED */
>

