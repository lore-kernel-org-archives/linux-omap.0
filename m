From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] ARM: OMAP4: PM: OMAP4 essential basic
 initialisations.
Date: Mon, 28 Dec 2009 15:33:31 -0800
Message-ID: <20091228233331.GR3512@atomide.com>
References: <1260528356-11621-1-git-send-email-a0393848@linfarm476.(none)>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63647 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbZL1Xdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 18:33:36 -0500
Content-Disposition: inline
In-Reply-To: <1260528356-11621-1-git-send-email-a0393848@linfarm476.(none)>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit.Pagare@india.ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>, Benoit Cousson <b-cousson@ti.com>

* Abhijit.Pagare@india.ti.com <Abhijit.Pagare@india.ti.com> [091211 02:50]:
> From: Abhijit Pagare <abhijitpagare@ti.com>
> 
> Some of the OMAP4 specific chip level initialisations are taken care of.

Here's yet another series of patches with "PM" in the subject
for no obvious reason.

Please repost all with with sensible subjects.

Tony

 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |    8 +++++++-
>  arch/arm/plat-omap/include/plat/cpu.h |    6 +++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 4fad192..52aca5f 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -336,8 +336,12 @@ void __init omap2_check_revision(void)
>  		omap3_check_features();
>  		omap3_cpuinfo();
>  	} else if (cpu_is_omap44xx()) {
> +		/*
> +		 * omap44xx_check_revision() should
> +		 * be defined above and then called
> +		 * from here.
> +		 */
>  		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
> -		return;
>  	} else {
>  		pr_err("OMAP revision unknown, please fix!\n");
>  	}
> @@ -367,6 +371,8 @@ void __init omap2_check_revision(void)
>  			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
>  		else if (omap_rev() == OMAP3630_REV_ES1_0)
>  			omap_chip.oc |= CHIP_IS_OMAP3630ES1;
> +	} else if (cpu_is_omap44xx()) {
> +		omap_chip.oc |= CHIP_IS_OMAP4430;
>  	} else {
>  		pr_err("Uninitialized omap_chip, please fix!\n");
>  	}
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 2e17890..6a296b8 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -154,6 +154,7 @@ unsigned int omap_rev(void);
>   * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
>   * cpu_is_omap243x():	True for OMAP2430
>   * cpu_is_omap343x():	True for OMAP3430
> + * cpu_is_omap443x():	True for OMAP4430
>   */
>  #define GET_OMAP_CLASS	(omap_rev() & 0xff)
>  
> @@ -284,6 +285,7 @@ IS_OMAP_SUBCLASS(363x, 0x363)
>   * cpu_is_omap2423():	True for OMAP2423
>   * cpu_is_omap2430():	True for OMAP2430
>   * cpu_is_omap3430():	True for OMAP3430
> + * cpu_is_omap4430():	True for OMAP4430
>   * cpu_is_omap3505():	True for OMAP3505
>   * cpu_is_omap3517():	True for OMAP3517
>   */
> @@ -332,6 +334,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define cpu_is_omap3505()		0
>  #define cpu_is_omap3517()		0
>  #define cpu_is_omap3430()		0
> +#define cpu_is_omap4430()		0
>  #define cpu_is_omap3630()		0
>  
>  /*
> @@ -443,7 +446,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 12))
>  #define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 12))
>  
> -#define OMAP443X_CLASS		0x44300034
> +#define OMAP443X_CLASS		0x44300044
>  
>  /*
>   * omap_chip bits
> @@ -467,6 +470,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
>  #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
>  #define CHIP_IS_OMAP3630ES1		(1 << 7)
> +#define CHIP_IS_OMAP4430		(1 << 8)
>  
>  #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
>  
> -- 
> 1.5.4.7
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
