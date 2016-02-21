From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: Fix onenand initialization to avoid
 filesystem corruption
Date: Sun, 21 Feb 2016 20:44:12 +0200
Message-ID: <20160221184412.GR1640@darkstar.musicnaut.iki.fi>
References: <linux-kernel@vger.kernel.org>
 <1454683028-4193-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454683028-4193-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, rogerq@ti.com, khilman@deeprootsystems.com, linux@arm.linux.org.uk, pali.rohar@gmail.com, sre@kernel.org, pavel@ucw.cz, nm@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Feb 05, 2016 at 04:37:08PM +0200, Ivaylo Dimitrov wrote:
> Commit <e7b11dc7b77bfce0a351230a5feeadc1d0bba997> ("ARM: OMAP2+: Fix
> onenand rate detection to avoid filesystem corruption") partially fixed
> onenand configuration when GPMC module is reset. Finish the job by also
> providing the correct values in ONENAND_REG_SYS_CFG1 register.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

I tested this on N950 by creating ubifs file system with stock kernel,
then reading & writing to it with mainline kernel, and then again
verifying the fs is good with the stock kernel. Note that onenand does
not work properly on N950 at the moment unless ONENAND_HAS_CACHE_PROGRAM
is disabled by patching, but that's an issue unrelated to this patch.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/arm/mach-omap2/gpmc-onenand.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> index 7b76ce0..8633c70 100644
> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -101,10 +101,8 @@ static void omap2_onenand_set_async_mode(void __iomem *onenand_base)
>  
>  static void set_onenand_cfg(void __iomem *onenand_base)
>  {
> -	u32 reg;
> +	u32 reg = ONENAND_SYS_CFG1_RDY | ONENAND_SYS_CFG1_INT;
>  
> -	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
> -	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
>  	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
>  		ONENAND_SYS_CFG1_BL_16;
>  	if (onenand_flags & ONENAND_FLAG_SYNCREAD)
> @@ -123,6 +121,7 @@ static void set_onenand_cfg(void __iomem *onenand_base)
>  		reg |= ONENAND_SYS_CFG1_VHF;
>  	else
>  		reg &= ~ONENAND_SYS_CFG1_VHF;
> +
>  	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
>  }
>  
> @@ -289,6 +288,7 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
>  		}
>  	}
>  
> +	onenand_async.sync_write = true;
>  	omap2_onenand_calc_async_timings(&t);
>  
>  	ret = gpmc_cs_program_settings(gpmc_onenand_data->cs, &onenand_async);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
