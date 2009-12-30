From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: PM: Add the missing Clock Domain
 Structure
Date: Wed, 30 Dec 2009 01:34:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912300133050.24862@utopia.booyaka.com>
References: <1261583193-22140-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51713 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbZL3IeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 03:34:15 -0500
In-Reply-To: <1261583193-22140-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Abhijit,

On Wed, 23 Dec 2009, Abhijit Pagare wrote:

> One of the clock domains was missing from the auto-generated file.
> It has been added here.

Please repost this with the subject line change that Tony mentioned.  The 
rest of the patch is fine.

- Paul

> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> Compiled and Boot Tested on OMAP4430 simulator, ES1 Chip & OMAP3430 SDP.
> And also Compiled for OMAP2430 and OMAP2420
> 
> This patch has a dependency on the earlier set of OMAP4 clock-domain patches.
> 
>  arch/arm/mach-omap2/clockdomains.h     |    1 +
>  arch/arm/mach-omap2/clockdomains44xx.h |    8 ++++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
> index f985e0a..6dc5ddc 100644
> --- a/arch/arm/mach-omap2/clockdomains.h
> +++ b/arch/arm/mach-omap2/clockdomains.h
> @@ -461,6 +461,7 @@ static struct clockdomain *clockdomains_omap[] = {
>  	&l4_secure_44xx_clkdm,
>  	&l4_per_44xx_clkdm,
>  	&abe_44xx_clkdm,
> +	&l3_instr_44xx_clkdm,
>  	&l3_init_44xx_clkdm,
>  	&mpuss_44xx_clkdm,
>  	&mpu0_44xx_clkdm,
> diff --git a/arch/arm/mach-omap2/clockdomains44xx.h b/arch/arm/mach-omap2/clockdomains44xx.h
> index 6fc55e4..438aaee 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx.h
> +++ b/arch/arm/mach-omap2/clockdomains44xx.h
> @@ -102,6 +102,14 @@ static struct clockdomain abe_44xx_clkdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  };
>  
> +static struct clockdomain l3_instr_44xx_clkdm = {
> +	.name		  = "l3_instr_clkdm",
> +	.pwrdm		  = { .name = "core_pwrdm" },
> +	.clkstctrl_reg	  = OMAP4430_CM_L3INSTR_CLKSTCTRL,
> +	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
> +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
>  static struct clockdomain l3_init_44xx_clkdm = {
>  	.name		  = "l3_init_clkdm",
>  	.pwrdm		  = { .name = "l3init_pwrdm" },
> -- 
> 1.5.4.7
> 


- Paul
