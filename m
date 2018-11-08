From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/2] arm: omap_hwmod disable ick autoidling when a hwmod
 requires that
Date: Thu, 8 Nov 2018 12:26:08 +0200
Message-ID: <bac125b7-68c5-4c90-ad98-22872db9ccff@ti.com>
References: <20181004203817.22101-1-andreas@kemnade.info>
 <20181004203817.22101-3-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004203817.22101-3-andreas@kemnade.info>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On 04/10/2018 23:38, Andreas Kemnade wrote:
> Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> that makes hwmods working properly which cannot handle
> autoidle properly in lower power states.
> Affected is e. g. the omap_hdq.
> Since an ick might have mulitple users, autoidle is disabled
> when an individual user requires that rather than in
> _setup_iclk_autoidle. dss_ick is an example for that.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index bb641e6c93d0..0078b0e1d242 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -986,8 +986,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
>   		clk_enable(oh->_clk);
>   
>   	list_for_each_entry(os, &oh->slave_ports, node) {
> -		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
> +		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
> +			omap2_clk_deny_idle(os->_clk);

I think calling this unconditionally across all platforms / clock types 
might cause problems. Checking kernel, am33xx seems to have one clock 
with this flag that is not of omap2 type. Do we have any testing data 
that this doesn't break things?

-Tero

>   			clk_enable(os->_clk);
> +		}
>   	}
>   
>   	/* The opt clocks are controlled by the device driver. */
> @@ -1039,8 +1041,10 @@ static int _disable_clocks(struct omap_hwmod *oh)
>   		clk_disable(oh->_clk);
>   
>   	list_for_each_entry(os, &oh->slave_ports, node) {
> -		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
> +		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
>   			clk_disable(os->_clk);
> +			omap2_clk_allow_idle(os->_clk);
> +		}
>   	}
>   
>   	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
> @@ -2410,9 +2414,13 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
>   			continue;
>   
>   		if (os->flags & OCPIF_SWSUP_IDLE) {
> -			/* XXX omap_iclk_deny_idle(c); */
> +			/*
> +			 * we might have multiple users of one iclk with
> +			 * different requirements, disable autoidle when
> +			 * the module is enabled, e.g. dss iclk
> +			 */
>   		} else {
> -			/* XXX omap_iclk_allow_idle(c); */
> +			/* we are enabling autoidle afterwards anyways */
>   			clk_enable(os->_clk);
>   		 >   	}
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
