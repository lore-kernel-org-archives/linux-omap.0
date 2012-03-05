From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] GPMC: add ECC control definitions
Date: Mon, 5 Mar 2012 15:03:34 -0800
Message-ID: <20120305230334.GM12083@atomide.com>
References: <4F1D4CB3.5080803@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11673 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab2CEXDi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 18:03:38 -0500
Content-Disposition: inline
In-Reply-To: <4F1D4CB3.5080803@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, arm-linux <linux-arm-kernel@lists.infradead.org>

* Yegor Yefremov <yegor_sub1@visionsystems.de> [120123 03:33]:
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> Index: b/arch/arm/mach-omap2/gpmc.c
> ===================================================================
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -50,6 +50,19 @@
>  #define GPMC_ECC_SIZE_CONFIG	0x1fc
>  #define GPMC_ECC1_RESULT        0x200
>  
> +/* GPMC ECC control settings */
> +#define GPMC_ECC_CTRL_ECCCLEAR		0x100
> +#define GPMC_ECC_CTRL_ECCDISABLE	0x000
> +#define GPMC_ECC_CTRL_ECCREG1		0x001
> +#define GPMC_ECC_CTRL_ECCREG2		0x002
> +#define GPMC_ECC_CTRL_ECCREG3		0x003
> +#define GPMC_ECC_CTRL_ECCREG4		0x004
> +#define GPMC_ECC_CTRL_ECCREG5		0x005
> +#define GPMC_ECC_CTRL_ECCREG6		0x006
> +#define GPMC_ECC_CTRL_ECCREG7		0x007
> +#define GPMC_ECC_CTRL_ECCREG8		0x008
> +#define GPMC_ECC_CTRL_ECCREG9		0x009
> +
>  #define GPMC_CS0_OFFSET		0x60
>  #define GPMC_CS_SIZE		0x30
>  
> @@ -855,8 +868,9 @@
>  	gpmc_ecc_used = cs;
>  
>  	/* clear ecc and enable bits */
> -	val = ((0x00000001<<8) | 0x00000001);
> -	gpmc_write_reg(GPMC_ECC_CONTROL, val);
> +	gpmc_write_reg(GPMC_ECC_CONTROL,
> +			GPMC_ECC_CTRL_ECCCLEAR |
> +			GPMC_ECC_CTRL_ECCREG1);
>  
>  	/* program ecc and result sizes */
>  	val = ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
> @@ -864,13 +878,19 @@
>  
>  	switch (mode) {
>  	case GPMC_ECC_READ:
> -		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
> +		gpmc_write_reg(GPMC_ECC_CONTROL,
> +				GPMC_ECC_CTRL_ECCCLEAR |
> +				GPMC_ECC_CTRL_ECCREG1);
>  		break;
>  	case GPMC_ECC_READSYN:
> -		 gpmc_write_reg(GPMC_ECC_CONTROL, 0x100);
> +		gpmc_write_reg(GPMC_ECC_CONTROL,
> +				GPMC_ECC_CTRL_ECCCLEAR |
> +				GPMC_ECC_CTRL_ECCDISABLE);
>  		break;
>  	case GPMC_ECC_WRITE:
> -		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
> +		gpmc_write_reg(GPMC_ECC_CONTROL,
> +				GPMC_ECC_CTRL_ECCCLEAR |
> +				GPMC_ECC_CTRL_ECCREG1);
>  		break;
>  	default:
>  		printk(KERN_INFO "Error: Unrecognized Mode[%d]!\n", mode);
> 

No functional changes here, right?

Can GPMC_ECC_READ and GPMC_ECC_WRITE case be combined:

	switch (mode) {
	case GPMC_ECC_READ:
	case GPMC_ECC_WRITE:
		gpmc_write_reg(GPMC_ECC_CONTROL,
			GPMC_ECC_CTRL_ECCCLEAR |
			GPMC_ECC_CTRL_ECCREG1);
	break;
	...

Regards,

Tony
