From: Tony Lindgren <tony@atomide.com>
Subject: Re: GPMC: fix device size setup
Date: Fri, 20 Jan 2012 08:25:47 -0800
Message-ID: <20120120162546.GO22818@atomide.com>
References: <4F199017.80506@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36528 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab2ATQZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 11:25:48 -0500
Content-Disposition: inline
In-Reply-To: <4F199017.80506@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Yegor Yefremov <yegor_sub1@visionsystems.de> [120120 07:29]:
> following statement can only change device size from 8-bit(0) to 16-bit(1),
> but not vice versa:
> 
> regval |= GPMC_CONFIG1_DEVICESIZE(wval);
> 
> so as this field has 1 reserved bit, that could be used in future,
> just clear both bits and then OR with the desired value

Looks like a valid fix to me. Care to repost it with linux-arm-kernel
mailing list also Cc'd so I can apply it into my fixes branch?

Thanks,

Tony
 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: b/arch/arm/mach-omap2/gpmc.c
> ===================================================================
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -528,7 +528,13 @@
>  
>  	case GPMC_CONFIG_DEV_SIZE:
>  		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +		/* clear 2 target bits */
> +		regval &= ~GPMC_CONFIG1_DEVICESIZE(3);
> +
> +		/* set the proper value */
>  		regval |= GPMC_CONFIG1_DEVICESIZE(wval);
> +
>  		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
>  		break;
>  
> 
