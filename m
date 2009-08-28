From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4: PM: Add power domain framework.
Date: Fri, 28 Aug 2009 05:15:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908280508100.15963@utopia.booyaka.com>
References: <1250663046-10234-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50406 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZH1LPU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 07:15:20 -0400
In-Reply-To: <1250663046-10234-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Abhijit,

a few more comments.

On Wed, 19 Aug 2009, abhijitpagare@ti.com wrote:

> From: Abhijit Pagare <abhijitpagare@ti.com>
> 
> This Patch Adds the new power domain framework for OMAP4 and introduces \
> some MACROS for OMAP4 Support. It also takes care of the initialisations \
> of the power domains based on the silicon.
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> index bacfc97..5bab417 100644
> --- a/arch/arm/mach-omap2/prm.h
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -473,11 +473,17 @@
>   *
>   */
>  
> -/* Registers appearing on both 24xx and 34xx */
> -
> -#define RM_RSTCTRL					0x0050
> -#define RM_RSTTIME					0x0054
> -#define RM_RSTST					0x0058
> +/* Registers appearing on 24xx and 34xx and 44xx */
> +
> +#ifdef CONFIG_ARCH_OMAP4

This will break multi-OMAP kernels.  If those offsets differ, please define
two sets, e.g.,

#define OMAP2_RM_RSTCTRL				0x0050
...

#define OMAP4_RM_RSTCTRL				0x0000
...

You'll need to patch some of other code with the appropriate offsets.

> +#define RM_RSTCTRL					0x0000 /* OMAP4 */
> +#define RM_RSTTIME					0x0004 /* OMAP4 */
> +#define RM_RSTST					0x0008 /* OMAP4 */
> +#else
> +#define RM_RSTCTRL					0x0050 /* OMAP2 & 3 */
> +#define RM_RSTTIME					0x0054 /* OMAP2 & 3 */
> +#define RM_RSTST					0x0058 /* OMAP2 & 3 */
> +#endif
>  
>  #define PM_WKEN						0x00a0
>  #define PM_WKEN1					PM_WKEN
> @@ -487,8 +493,14 @@
>  #define PM_EVGENCTRL					0x00d4
>  #define PM_EVGENONTIM					0x00d8
>  #define PM_EVGENOFFTIM					0x00dc
> -#define PM_PWSTCTRL					0x00e0
> -#define PM_PWSTST					0x00e4
> +
> +#ifdef CONFIG_ARCH_OMAP4

Same here.

> +#define PM_PWSTCTRL					0x0000 /* OMAP4 */
> +#define PM_PWSTST					0x0004 /* OMAP4 */
> +#else
> +#define PM_PWSTCTRL					0x00e0 /* OMAP2 & 3 */
> +#define PM_PWSTST					0x00e4 /* OMAP2 & 3 */
> +#endif
>  
>  /* Omap2 specific registers */
>  #define OMAP24XX_PM_WKEN2				0x00a4
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> index fc60c4e..4647f9a 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -253,6 +253,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>   * cpu_is_omap2423():	True for OMAP2423
>   * cpu_is_omap2430():	True for OMAP2430
>   * cpu_is_omap3430():	True for OMAP3430
> + * cpu_is_omap4430():	True for OMAP4430
>   */
>  #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
>  
> @@ -385,7 +386,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define OMAP3430_REV_ES3_0	0x34303034
>  #define OMAP3430_REV_ES3_1	0x34304034
>  
> -#define OMAP443X_CLASS		0x44300034
> +#define OMAP443X_CLASS		0x44300044
>  
>  /*
>   * omap_chip bits
> @@ -408,6 +409,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define CHIP_IS_OMAP3430ES2		(1 << 4)
>  #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
>  #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
> +#define CHIP_IS_OMAP4430		(1 << 7)
>  
>  #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
>  

The above changes to cpu.h don't belong as part of a
powerdomains-related patch and should be placed in a separate OMAP4
base patch.

> diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
> index 69c9e67..2742106 100644
> --- a/arch/arm/plat-omap/include/mach/powerdomain.h
> +++ b/arch/arm/plat-omap/include/mach/powerdomain.h
> @@ -46,13 +46,13 @@
>   * Number of memory banks that are power-controllable.	On OMAP3430, the
>   * maximum is 4.
>   */
> -#define PWRDM_MAX_MEM_BANKS	4
> +#define PWRDM_MAX_MEM_BANKS	5
>  
>  /*
>   * Maximum number of clockdomains that can be associated with a powerdomain.
>   * CORE powerdomain on OMAP3 is the worst case

Please update this comment.

>   */
> -#define PWRDM_MAX_CLKDMS	4
> +#define PWRDM_MAX_CLKDMS	9
>  
>  /* XXX A completely arbitrary number. What is reasonable here? */
>  #define PWRDM_TRANSITION_BAILOUT 100000

I also have another comment, which, by request of others at TI India, I 
will send you via private E-mail for now.


- Paul
