From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/6] OMAP4: Clock: Associate clocks for OMAP temperature
 sensor
Date: Thu, 22 Sep 2011 23:18:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109222316350.10719@utopia.booyaka.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com> <1316705361-12175-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51401 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab1IWFSh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 01:18:37 -0400
In-Reply-To: <1316705361-12175-3-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 22 Sep 2011, Keerthy wrote:

> div_ts_ck feeds only the temperature sensor functional clock
> and also has a clksel associated (for divider selection). Mapping this
> as well as the bandgap_ts_fclk the fclk of temperature sensor in clkdev table,
> so a clk_set_rate() on the div_ts_ck in the driver would have the effect of
> changing the temperature sensor clock rate indirectly.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> Cc: tony@atomide.com
> Cc: paul@pwsan.com 

Your cc's didn't take effect...

> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 946bf04..c51e513 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3185,9 +3185,9 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
>  	CLK(NULL,	"aess_fck",			&aess_fck,	CK_443X),
>  	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
> -	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
> +	CLK("omap4460plus_scm.0",	"fck",		&bandgap_ts_fclk,	CK_446X),
>  	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
> -	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
> +	CLK("omap4460plus_scm.0",	"div_ck",			&div_ts_ck,	CK_446X),

Clearly this device is incorrectly named.  You're setting up a clkdev 
entry that's marked as being valid for OMAP4430, but your device is called 
"omap4460plus_scm".  They can't both be right...


>  	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
>  	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
>  	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
