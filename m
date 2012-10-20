From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/7] ARM: OMAP3xxx: hwmod: Convert SHAM crypto device
 data to hwmod
Date: Sat, 20 Oct 2012 19:41:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210201940550.27264@utopia.booyaka.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com> <1350683640-15044-4-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53835 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab2JTTlh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 15:41:37 -0400
In-Reply-To: <1350683640-15044-4-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 19 Oct 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Convert the device data for the OMAP3 SHAM2 (SHA1/MD5) crypto IP
> from explicit platform_data to hwmod. When bit 27 (OMAP3430_ST_SHA12_MASK)
> of the CM_IDLEST1_CORE register is 0, the SHA2 IP is present.
> 
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

...

> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 5b613fa..40211de 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -36,6 +36,7 @@
>  #include "devices.h"
>  #include "cm2xxx_3xxx.h"
>  #include "cm-regbits-24xx.h"
> +#include "cm-regbits-34xx.h"
>  
>  #define L3_MODULES_MAX_LEN 12
>  #define L3_MODULES 3
> @@ -453,40 +454,14 @@ static void omap_init_rng(void)
>  	WARN(IS_ERR(pdev), "Can't build omap_device for omap_rng\n");
>  }
>  
> -#if defined(CONFIG_CRYPTO_DEV_OMAP_SHAM) || defined(CONFIG_CRYPTO_DEV_OMAP_SHAM_MODULE)
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct resource omap3_sham_resources[] = {
> -	{
> -		.start	= OMAP34XX_SEC_SHA1MD5_BASE,
> -		.end	= OMAP34XX_SEC_SHA1MD5_BASE + 0x64,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	{
> -		.start	= 49 + OMAP_INTC_START,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -	{
> -		.start	= OMAP34XX_DMA_SHA1MD5_RX,
> -		.flags	= IORESOURCE_DMA,
> -	}
> -};
> -static int omap3_sham_resources_sz = ARRAY_SIZE(omap3_sham_resources);
> -#else
> -#define omap3_sham_resources		NULL
> -#define omap3_sham_resources_sz		0
> -#endif
> -
> -static struct platform_device sham_device = {
> -	.name		= "omap-sham",
> -	.id		= -1,
> -};
> -
> -static void omap_init_sham(void)
> +static void __init omap_init_sham(void)
>  {
> -	if (cpu_is_omap24xx() &&
> -	    (omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_IDLEST4) &
> -						 OMAP24XX_ST_SHA_MASK)) {
> +	if ((cpu_is_omap24xx() &&
> +	     (omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_IDLEST4) &
> +						 OMAP24XX_ST_SHA_MASK)) ||
> +	    (cpu_is_omap34xx() &&
> +	     (!(omap2_cm_read_mod_reg(CORE_MOD, CM_IDLEST1) &
> +						 OMAP3430_ST_SHA12_MASK)))) {

Same comment here as on the CM read on the 2xxx patch.


- Paul
