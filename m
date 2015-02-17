From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Tue, 17 Feb 2015 10:12:51 +0200
Message-ID: <54E2F803.3070901@ti.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41387 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756188AbbBQINL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Feb 2015 03:13:11 -0500
In-Reply-To: <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Robert,

On 16/02/15 17:48, Robert ABEL wrote:
> GPMC uses GPMCFCLKDIVIDER during synchronous as well as asynchronous accesses
> in conjunction with WAITMONITORINGTIME. Thus, it's wrong to only program it for
> synchronous accesses. Remove the conditional.

Can you use the following wording from TRM instead?

as per am335x TRM (spruh73i.pdf), section 7.1.3.3.8.3.2

The WAITMONITORINGTIME is expressed as a number of GPMC_CLK clock cycles,
even though the access is defined as asynchronous, and no GPMC_CLK clock
is provided to the external device. Still, GPMCFCLKDIVIDER is used as a divider
for the GPMC clock, so it must be programmed to define the
correct WAITMONITORINGTIME delay.

> 
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

Instead of this can we explicitly set the GPMC_CLK divider to 1 and hence
corresponding divider bits to 0 in the asynchronous case?
This is because the previously calculated "div" depends on synchronous clock which
might not be properly initialized for asynchronous devices.

AFAIK t->sync_clk is always 0 for asynchronous devices and gpmc_calc_divider(0)
will return 1 and your patch will work but still we shouldn't depend on sync_clk for
asynchronous devices so let's set this explicitly.

You can add a note like this
"For asynchronous devices we explicitly set GPMC_CLK to be equal to GPMC_FCLK.
Even though GPMC_CLK pin is not used by the asynchronous device we need it
for WAITMONITORINGTIME configuration in case wait-pin monitoring is used."

>  
>  	gpmc_cs_bool_timings(cs, &t->bool_timings);
>  
> 

cheers,
-roger
