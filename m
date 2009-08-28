From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: PM: Refine API's for Power domain
 Framework Support.
Date: Fri, 28 Aug 2009 05:01:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908280456350.15963@utopia.booyaka.com>
References: <1250663090-10409-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48633 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbZH1LBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 07:01:30 -0400
In-Reply-To: <1250663090-10409-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Abhijit,

some comments.

On Wed, 19 Aug 2009, abhijitpagare@ti.com wrote:

> From: Abhijit Pagare <abhijitpagare@ti.com>
> 
> This Patch Adds Silicon Specific initialisations for the API support.
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   96 +++++++++++++++++++++++++++++++------
>  1 files changed, 81 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 8f19c38..5ea7afa 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -38,6 +38,63 @@
>  #include <mach/powerdomain.h>
>  #include <mach/clockdomain.h>
>  
> +/* OMAP3 Or OMAP4 specific register bit initialisations
> + * Notice that the names here are not according to each power
> + * domain but the bit mapping used applies to all of them
> + */
> +#ifdef CONFIG_ARCH_OMAP34XX

This will break multi-OMAP builds.  And should not be necessary, given 
that the OMAP3 defines appear to be identical to the OMAP4 defines 
(with the exception of the additional bank).

> +/* OMAP4 Logic Retention control and status bits*/
> +#define OMAP_LOGICRET_STATE OMAP4430_LOGICRETSTATE_MASK
> +#define OMAP_LOGICSTATEST OMAP4430_LOGICSTATEST

Please drop the above and 
> +
> +/* OMAP4 Memory Onstate Masks (common across all power domains) */
> +#define OMAP_MEM0_ONSTATE_MASK OMAP4430_CORE_OTHER_BANK_ONSTATE_MASK
> +#define OMAP_MEM1_ONSTATE_MASK OMAP4430_CORE_OCMRAM_ONSTATE_MASK
> +#define OMAP_MEM2_ONSTATE_MASK OMAP4430_DUCATI_L2RAM_ONSTATE_MASK
> +#define OMAP_MEM3_ONSTATE_MASK OMAP4430_DUCATI_UNICACHE_ONSTATE_MASK
> +#define OMAP_MEM4_ONSTATE_MASK OMAP4430_OCP_NRET_BANK_ONSTATE_MASK
> +
> +/* OMAP4 Memory Retstate Masks (common across all power domains) */
> +#define OMAP_MEM0_RETSTATE_MASK OMAP4430_CORE_OTHER_BANK_RETSTATE_MASK
> +#define OMAP_MEM1_RETSTATE_MASK OMAP4430_CORE_OCMRAM_RETSTATE_MASK
> +#define OMAP_MEM2_RETSTATE_MASK OMAP4430_DUCATI_L2RAM_RETSTATE_MASK
> +#define OMAP_MEM3_RETSTATE_MASK OMAP4430_DUCATI_UNICACHE_RETSTATE_MASK
> +#define OMAP_MEM4_RETSTATE_MASK OMAP4430_OCP_NRET_BANK_RETSTATE_MASK
> +
> +/* OMAP4 Memory Status bits */
> +#define OMAP_MEM0_STATEST_MASK OMAP4430_CORE_OTHER_BANK_STATEST_MASK
> +#define OMAP_MEM1_STATEST_MASK OMAP4430_CORE_OCMRAM_STATEST_MASK
> +#define OMAP_MEM2_STATEST_MASK OMAP4430_DUCATI_L2RAM_STATEST_MASK
> +#define OMAP_MEM3_STATEST_MASK OMAP4430_DUCATI_UNICACHE_STATEST_MASK
> +#define OMAP_MEM4_STATEST_MASK OMAP4430_OCP_NRET_BANK_STATEST_MASK

I like the idea that you propose above - to use macro aliases for the bank 
masks.  But let's make some changes.  Banks 0 - 3 should use the OMAP3430 
macros, since that's where they were first introduced.  Bank 4 should keep 
the OMAP4430 macro.

> @@ -714,8 +771,8 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
>  	 * but the type of value returned is the same for each
>  	 * powerdomain.
>  	 */
> -	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE,
> -			     (pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE)),
> +	prm_rmw_mod_reg_bits(OMAP_LOGICRET_STATE,
> +			     (pwrst << __ffs(OMAP_LOGICRET_STATE)),
>  			     pwrdm->prcm_offs, PM_PWSTCTRL);
>  
>  	return 0;
> @@ -759,16 +816,19 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
>  	 */
>  	switch (bank) {
>  	case 0:
> -		m = OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK;
> +		m = OMAP_MEM0_ONSTATE_MASK;
>  		break;
>  	case 1:
> -		m = OMAP3430_L1FLATMEMONSTATE_MASK;
> +		m = OMAP_MEM1_ONSTATE_MASK;
>  		break;
>  	case 2:
> -		m = OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK;
> +		m = OMAP_MEM2_ONSTATE_MASK;
>  		break;
>  	case 3:
> -		m = OMAP3430_L2FLATMEMONSTATE_MASK;
> +		m = OMAP_MEM3_ONSTATE_MASK;
> +		break;
> +	case 4:
> +		m = OMAP_MEM4_ONSTATE_MASK;
>  		break;
>  	default:
>  		WARN_ON(1); /* should never happen */
> @@ -820,16 +880,19 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
>  	 */
>  	switch (bank) {
>  	case 0:
> -		m = OMAP3430_SHAREDL1CACHEFLATRETSTATE;
> +		m = OMAP_MEM0_RETSTATE_MASK;
>  		break;
>  	case 1:
> -		m = OMAP3430_L1FLATMEMRETSTATE;
> +		m = OMAP_MEM1_RETSTATE_MASK;
>  		break;
>  	case 2:
> -		m = OMAP3430_SHAREDL2CACHEFLATRETSTATE;
> +		m = OMAP_MEM2_RETSTATE_MASK;
>  		break;
>  	case 3:
> -		m = OMAP3430_L2FLATMEMRETSTATE;
> +		m = OMAP_MEM3_RETSTATE_MASK;
> +		break;
> +	case 4:
> +		m = OMAP_MEM4_RETSTATE_MASK;
>  		break;
>  	default:
>  		WARN_ON(1); /* should never happen */
> @@ -857,7 +920,7 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
>  		return -EINVAL;
>  
>  	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTST,
> -					OMAP3430_LOGICSTATEST);
> +					OMAP_LOGICSTATEST);
>  }
>  
>  /**
> @@ -911,16 +974,19 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>  	 */
>  	switch (bank) {
>  	case 0:
> -		m = OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK;
> +		m = OMAP_MEM0_STATEST_MASK;
>  		break;
>  	case 1:
> -		m = OMAP3430_L1FLATMEMSTATEST_MASK;
> +		m = OMAP_MEM1_STATEST_MASK;
>  		break;
>  	case 2:
> -		m = OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK;
> +		m = OMAP_MEM2_STATEST_MASK;
>  		break;
>  	case 3:
> -		m = OMAP3430_L2FLATMEMSTATEST_MASK;
> +		m = OMAP_MEM3_STATEST_MASK;
> +		break;
> +	case 4:
> +		m = OMAP_MEM4_STATEST_MASK;
>  		break;
>  	default:
>  		WARN_ON(1); /* should never happen */
> -- 
> 1.5.4.7


- Paul
