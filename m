From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK
 position
Date: Wed, 14 Oct 2009 17:21:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910141536210.23283@utopia.booyaka.com>
References: <A24693684029E5489D1D202277BE89444BE28394@dlee02.ent.ti.com> <1251444297-13577-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55440 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbZJNXVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 19:21:41 -0400
In-Reply-To: <1251444297-13577-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Thara,

I regret the delay.  A comment:

On Fri, 28 Aug 2009, Thara Gopinath wrote:

> MPU power domain bank 0 bits are displayed in position of bank 1
> in PWRSTS and PREPWRSTS registers. So read them from correct
> position

Indeed.  What do you think about a slightly different approach: changing 
powerdomains34xx.h to be correct?  In other words, instead of

	.pwrsts_mem_ret	  = {
		[0] = PWRSTS_OFF_RET,
	},
	.pwrsts_mem_on	  = {
		[0] = PWRSTS_OFF_ON,
	},

we would use:

	.pwrsts_mem_ret	  = {
		[1] = PWRSTS_OFF_RET,
	},
	.pwrsts_mem_on	  = {
		[1] = PWRSTS_OFF_ON,
	},

We have to deal with the bank count field in struct powerdomain - we could 
just convert it into a bitmap representing available banks.  So instead 
of:

        .banks = 1,

use maybe:

	.banks = PWRDM_BANK_1,  /* | PWRDM_BANK_0, etc */


Can you foresee any problems with the above approach?

- Paul

> Patch refresh issue.
> 
>  arch/arm/mach-omap2/powerdomain.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 2594cbf..6c5fee9 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -971,6 +971,16 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>  		return -EEXIST;
>  
>  	/*
> +	 * In 3430, for MPU domain bank 0 status bits
> +	 * are displayed in the position of bank1 status bits
> +	 * in PWST  . So the hack. Think of a cleaner
> +	 * way of doing this
> +	 */
> +	if (cpu_is_omap34xx())
> +		if (!strcmp("mpu_pwrdm", pwrdm->name))
> +			bank = 1;
> +
> +	/*
>  	 * The register bit names below may not correspond to the
>  	 * actual names of the bits in each powerdomain's register,
>  	 * but the type of value returned is the same for each
> @@ -1018,6 +1028,15 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>  		return -EEXIST;
>  
>  	/*
> +	 * In 3430, for MPU domain bank 0 status bits
> +	 * are displayed in the position of bank1 status bits
> +	 * in PREPWST  . So the hack. Think of a cleaner
> +	 * way of doing this
> +	 */
> +	if (cpu_is_omap34xx())
> +		if (!strcmp("mpu_pwrdm", pwrdm->name))
> +			bank = 1;
> +	/*
>  	 * The register bit names below may not correspond to the
>  	 * actual names of the bits in each powerdomain's register,
>  	 * but the type of value returned is the same for each
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
