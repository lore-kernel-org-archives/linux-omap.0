From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Mon, 16 Feb 2015 09:10:31 -0800
Message-ID: <20150216171030.GS2531@atomide.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Cc: khilman@deeprootsystems.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Robert ABEL <rabel@cit-ec.uni-bielefeld.de> [150216 07:52]:
> GPMC uses GPMCFCLKDIVIDER during synchronous as well as asynchronous accesses
> in conjunction with WAITMONITORINGTIME. Thus, it's wrong to only program it for
> synchronous accesses. Remove the conditional.

Do you have some test case that gets fixed by this? Or does this
fix some regression?

The reason why I'm asking is that AFAIK we've had async access
working all along?

Reagrds,

Tony


 
> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
> ---
>  arch/arm/mach-omap2/gpmc.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 5c3639c..bae4a20 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -382,19 +382,14 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
>  	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
>  		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
>  
> -	/* caller is expected to have initialized CONFIG1 to cover
> -	 * at least sync vs async
> -	 */
>  	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> -	if (l & (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {
>  #ifdef DEBUG
> -		printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
> -				cs, (div * gpmc_get_fclk_period()) / 1000, div);
> +	printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
> +	       cs, (div * gpmc_get_fclk_period()) / 1000, div);
>  #endif
> -		l &= ~0x03;
> -		l |= (div - 1);
> -		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
> -	}
> +	l &= ~0x03;
> +	l |= (div - 1);
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
>  
>  	gpmc_cs_bool_timings(cs, &t->bool_timings);
>  
> -- 
> 2.3.0
> 
