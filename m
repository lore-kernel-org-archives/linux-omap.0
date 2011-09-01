From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/6 V4] OMAP4: Clock: Associate clocks for OMAP temperature
 sensor
Date: Wed, 31 Aug 2011 18:00:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108311757260.26173@utopia.booyaka.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com> <1314811510-15595-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44971 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871Ab1IAAAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 20:00:21 -0400
In-Reply-To: <1314811510-15595-2-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rnayak@ti.com

Hi,

a comment:

On Wed, 31 Aug 2011, Keerthy wrote:

> div_ts_ck feeds only the temperature sensor functional clock
> and also has a clksel associated (for divider selection). Mapping this
> as the functional clock for the temperature sensor in clkdev table,
> so a clk_set_rate() in the driver would have the effect of changing the
> temperature sensor clock rate indirectly.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> Cc: tony@atomide.com
> Cc: rnayak@ti.com
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 2af0e3f..4a788f4 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3187,7 +3187,7 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
>  	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
>  	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
> -	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
> +	CLK("omap_temp_sensor.0",	"fck",			&div_ts_ck,	CK_446X),

It shouldn't be necessary to add the device name/ID here.  We're trying 
to get rid of these.  The omap_device code should take care of adding the 
appropriate alias.


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
