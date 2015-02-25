From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 6/8 v2] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Wed, 25 Feb 2015 15:31:54 +0200
Message-ID: <54EDCECA.2030801@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On 24/02/15 22:05, Robert ABEL wrote:
> The WAITMONITORINGTIME is expressed as a number of GPMC_CLK clock cycles,
> even though the access is defined as asynchronous, and no GPMC_CLK clock
> is provided to the external device. Still, GPMCFCLKDIVIDER is used as a divider
> for the GPMC clock, so it must be programmed to define the
> correct WAITMONITORINGTIME delay.
> 
> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  drivers/memory/omap-gpmc.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index ff1a1e7..a6abaf0 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -566,19 +566,14 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
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
> +			cs, (div * gpmc_get_fclk_period()) / 1000, div);
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
>  	gpmc_cs_show_timings(cs, "after gpmc_cs_set_timings");
> 
