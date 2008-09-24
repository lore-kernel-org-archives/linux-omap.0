From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [PATCH 1/3] ARM: OMAP: Allocate McBSP devices dynamically, add
	34xx support
Date: Wed, 24 Sep 2008 13:58:38 +0200
Message-ID: <20080924115838.GB18700@strlen.de>
References: <1222249943-19435-1-git-send-email-tony@atomide.com> <1222249943-19435-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:51917 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234AbYIXL6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Sep 2008 07:58:41 -0400
Content-Disposition: inline
In-Reply-To: <1222249943-19435-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Chandra Shekhar <x0044955@ti.com>

Hello,

I wonder if this patch should be further split.

To my taste this should be at least:

 - Allocate McBSP devices dynamically,
 - add 34xx support

maybe more, see below.

> diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
> index afb5789..7de7c69 100644
> --- a/arch/arm/mach-omap1/mcbsp.c
> +++ b/arch/arm/mach-omap1/mcbsp.c
> @@ -103,30 +103,6 @@ static inline void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
>  { }
>  #endif
>  
> -static int omap1_mcbsp_check(unsigned int id)
> -{
> -	/* REVISIT: Check correctly for number of registered McBSPs */
> -	if (cpu_is_omap730()) {
> -		if (id > OMAP_MAX_MCBSP_COUNT - 2) {
> -		       printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
> -				id + 1);
> -		       return -ENODEV;
> -		}
> -		return 0;
> -	}
> -
> -	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
> -		if (id > OMAP_MAX_MCBSP_COUNT - 1) {
> -			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
> -				id + 1);
> -			return -ENODEV;
> -		}
> -		return 0;
> -	}
> -
> -	return -ENODEV;
> -}
> -
>  static void omap1_mcbsp_request(unsigned int id)
>  {
>  	/*
> @@ -151,7 +127,6 @@ static void omap1_mcbsp_free(unsigned int id)
>  }
>  
>  static struct omap_mcbsp_ops omap1_mcbsp_ops = {
> -	.check		= omap1_mcbsp_check,
Why can this function go away?  IMHO it should either go away in a
separate commit or be extended to be more general to apply for the 34xx
case, too.  (Same for omap2_mcbsp_check.)

> @@ -185,7 +226,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>  #define OMAP34XX_MCBSP_PDATA_SZ		0
>  #endif
>  
> -int __init omap2_mcbsp_init(void)
> +static int __init omap2_mcbsp_init(void)
>  {
>  	int i;
>  
OK, this is trivial, but if you ask me, at least note it in the commit
message.

> @@ -196,9 +237,18 @@ int __init omap2_mcbsp_init(void)
>  	}
>  
>  	if (cpu_is_omap24xx())
> +		omap_mcbsp_count = OMAP24XX_MCBSP_PDATA_SZ;
> +	if (cpu_is_omap34xx())
> +		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
> +
> +	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
> +								GFP_KERNEL);
> +	if (!mcbsp_ptr)
> +		return -ENOMEM;
> +
> +	if (cpu_is_omap24xx())
>  		omap_mcbsp_register_board_cfg(omap24xx_mcbsp_pdata,
>  						OMAP24XX_MCBSP_PDATA_SZ);
> -
>  	if (cpu_is_omap34xx())
>  		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
>  						OMAP34XX_MCBSP_PDATA_SZ);
Hhm, it looks there is already some 34xx support in the file.  Should
the commit log be more detailed?

(Note, I didn't check the rest of the patch.)

Best regards
Uwe
