From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/7] ARM: OMAP2xxx: hwmod: Convert SHAM crypto device
 data to hwmod
Date: Sat, 20 Oct 2012 19:40:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210201934550.27264@utopia.booyaka.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com> <1350683640-15044-2-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53824 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab2JTTkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 15:40:20 -0400
In-Reply-To: <1350683640-15044-2-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

a few comments:

On Fri, 19 Oct 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Convert the device data for the OMAP2 SHAM crypto IP from
> explicit platform_data to hwmod.  When bit 1 (OMAP24XX_ST_SHA_MASK)
> of the CM_IDLEST4_CORE register is set, the SHA IP is present.
> 
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

...

> 
> diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
> index c3cde1a..a09603c 100644
> --- a/arch/arm/mach-omap2/clock2420_data.c
> +++ b/arch/arm/mach-omap2/clock2420_data.c
> @@ -1905,6 +1905,7 @@ static struct omap_clk omap2420_clks[] = {
>  	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
>  	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
>  	CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
> +	CLK(NULL,	"sha_ick",	&sha_ick,	CK_242X),

This isn't needed; this alias already exists two lines below.

>  	CLK("omap-sham",	"ick",	&sha_ick,	CK_242X),
>  	CLK(NULL,	"sha_ick",	&sha_ick,	CK_242X),
>  	CLK("omap_rng",	"ick",		&rng_ick,	CK_242X),
> diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
> index 22404fe..654e314 100644
> --- a/arch/arm/mach-omap2/clock2430_data.c
> +++ b/arch/arm/mach-omap2/clock2430_data.c
> @@ -1992,6 +1992,7 @@ static struct omap_clk omap2430_clks[] = {
>  	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X),
>  	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_243X),
>  	CLK(NULL,	"des_ick",	&des_ick,	CK_243X),
> +	CLK(NULL,	"sha_ick",	&sha_ick,	CK_242X),
>  	CLK("omap-sham",	"ick",	&sha_ick,	CK_243X),
>  	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X),
>  	CLK(NULL,	"rng_ick",	&rng_ick,	CK_243X),
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c8c2117..5b613fa 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -34,6 +34,8 @@
>  #include "mux.h"
>  #include "control.h"
>  #include "devices.h"
> +#include "cm2xxx_3xxx.h"
> +#include "cm-regbits-24xx.h"
>  
>  #define L3_MODULES_MAX_LEN 12
>  #define L3_MODULES 3
> @@ -453,24 +455,6 @@ static void omap_init_rng(void)
>  
>  #if defined(CONFIG_CRYPTO_DEV_OMAP_SHAM) || defined(CONFIG_CRYPTO_DEV_OMAP_SHAM_MODULE)
>  
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct resource omap2_sham_resources[] = {
> -	{
> -		.start	= OMAP24XX_SEC_SHA1MD5_BASE,
> -		.end	= OMAP24XX_SEC_SHA1MD5_BASE + 0x64,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	{
> -		.start	= 51 + OMAP_INTC_START,
> -		.flags	= IORESOURCE_IRQ,
> -	}
> -};
> -static int omap2_sham_resources_sz = ARRAY_SIZE(omap2_sham_resources);
> -#else
> -#define omap2_sham_resources		NULL
> -#define omap2_sham_resources_sz		0
> -#endif
> -
>  #ifdef CONFIG_ARCH_OMAP3
>  static struct resource omap3_sham_resources[] = {
>  	{
> @@ -500,17 +484,27 @@ static struct platform_device sham_device = {
>  
>  static void omap_init_sham(void)
>  {
> -	if (cpu_is_omap24xx()) {
> -		sham_device.resource = omap2_sham_resources;
> -		sham_device.num_resources = omap2_sham_resources_sz;
> +	if (cpu_is_omap24xx() &&
> +	    (omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_IDLEST4) &
> +						 OMAP24XX_ST_SHA_MASK)) {

Hmm.  Not sure I understand the purpose of this CM read.  Don't we want to 
initialize this device unconditionally?

Also we're trying to get rid of all of the direct CM/PRM accesses outside 
of the prm*.c/cm*.c code.  If we need something like this, we should add 
some support for it in hwmod & CM code, since that's where the data lives.


- Paul
