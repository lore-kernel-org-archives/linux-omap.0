From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH][RFC] OMAP3630: Create architecture macros and config
 entries.
Date: Sun, 20 Sep 2009 17:07:58 +0200
Message-ID: <74583B8642AB8841B30447520659FCA9DD85B939@dnce01.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402534261B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32922 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435AbZITPH4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Sep 2009 11:07:56 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8KF7x5X014041
	for <linux-omap@vger.kernel.org>; Sun, 20 Sep 2009 10:07:59 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n8KF7xk8001554
	for <linux-omap@vger.kernel.org>; Sun, 20 Sep 2009 10:07:59 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n8KF7wdL016319
	for <linux-omap@vger.kernel.org>; Sun, 20 Sep 2009 10:07:59 -0500 (CDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402534261B3@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Raju, Veeramanikandan" <veera@ti.com>, "Bongale, Hariprasad" <hariprasad.bongale@ti.com>

Hi Allen,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pais, Allen
> Sent: Sunday, September 20, 2009 9:47 AM
> To: linux-omap@vger.kernel.org; Raju, Veeramanikandan; Bongale, Hariprasad
> Subject: [PATCH][RFC] OMAP3630: Create architecture macros and config
> entries.
> 
> 
> This patch creates the architectural macros for OMAP3630.
> 
> Signed-off-by: Allen Pais <allen.pais@ti.com>
> 
> arch/arm/mach-omap2/Kconfig                 |   13 ++
> arch/arm/plat-omap/include/mach/cpu.h       |   30 +++++-
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 75b1c7e..618b7d5 100755
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -19,11 +19,20 @@ config ARCH_OMAP34XX
>  	bool "OMAP34xx Based System"
>  	depends on ARCH_OMAP3
> 
> +config ARCH_OMAP36XX
> +	bool "OMAP36xx Based System"
> +	depends on ARCH_OMAP3
> +
>  config ARCH_OMAP3430
>  	bool "OMAP3430 support"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select ARCH_OMAP_OTG
> 
> +config ARCH_OMAP3630
> +	bool "OMAP3630 support"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX && ARCH_OMAP36XX
> +	select ARCH_OMAP_OTG
> +
>  comment "OMAP Board Type"
>  	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
> 
> @@ -73,6 +82,10 @@ config MACH_OMAP_3430SDP
>  	bool "OMAP 3430 SDP board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> 
> +config MACH_OMAP_3630SDP
> +	bool "OMAP 3630 SDP board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX & ARCH_OMAP36XX
> +
>  config MACH_NOKIA_N8X0
>  	bool "Nokia N800/N810"
>  	depends on ARCH_OMAP2420
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-
> omap/include/mach/cpu.h
> index 7a5f9e8..73c656c 100755
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -157,10 +157,12 @@ IS_OMAP_CLASS(15xx, 0x15)
>  IS_OMAP_CLASS(16xx, 0x16)
>  IS_OMAP_CLASS(24xx, 0x24)
>  IS_OMAP_CLASS(34xx, 0x34)
> +IS_OMAP_CLASS(36xx, 0x36)

OMAP3630 is "just" an OMAP3430 in disguise. 
I don't think it deserves a new class. It should probably be handled like it was done for 1610 and 1710.

Theoretically, it should be considered as a 3430 ES4.0, because it is an OMAP3430 ES3 + couple of bug fixes + couple of improvements. 

I think, that the proposal from Sanjeev to support 35xx (http://marc.info/?l=linux-omap&m=125050987112798&w=2 ) might be leveraged to handle 36xx as well.   

Regards,
Benoit
 
>  IS_OMAP_SUBCLASS(242x, 0x242)
>  IS_OMAP_SUBCLASS(243x, 0x243)
>  IS_OMAP_SUBCLASS(343x, 0x343)
> +IS_OMAP_SUBCLASS(363x, 0x363)
> 
>  #define cpu_is_omap7xx()		0
>  #define cpu_is_omap15xx()		0
> @@ -170,6 +172,8 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>  #define cpu_is_omap243x()		0
>  #define cpu_is_omap34xx()		0
>  #define cpu_is_omap343x()		0
> +#define cpu_is_omap36xx()		0
> +#define cpu_is_omap363x()		0
>  #define cpu_is_omap44xx()		0
>  #define cpu_is_omap443x()		0
> 
> @@ -245,6 +249,14 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>  #  undef  cpu_is_omap343x
>  #  define cpu_is_omap343x()		1
>  # endif
> +# if defined(CONFIG_ARCH_OMAP36XX)
> +#  undef  cpu_is_omap36xx
> +#  define cpu_is_omap36xx()		1
> +# endif
> +# if defined(CONFIG_ARCH_OMAP3630)
> +#  undef  cpu_is_omap363x
> +#  define cpu_is_omap363x()		1
> +# endif
>  #endif
> 
>  /*
> @@ -287,6 +299,7 @@ IS_OMAP_TYPE(2422, 0x2422)
>  IS_OMAP_TYPE(2423, 0x2423)
>  IS_OMAP_TYPE(2430, 0x2430)
>  IS_OMAP_TYPE(3430, 0x3430)
> +IS_OMAP_TYPE(3630, 0x3630)
> 
>  #define cpu_is_omap310()		0
>  #define cpu_is_omap730()		0
> @@ -302,6 +315,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define cpu_is_omap2423()		0
>  #define cpu_is_omap2430()		0
>  #define cpu_is_omap3430()		0
> +#define cpu_is_omap3630()		0
> 
>  /*
>   * Whether we have MULTI_OMAP1 or not, we still need to distinguish
> @@ -354,6 +368,11 @@ IS_OMAP_TYPE(3430, 0x3430)
>  # define cpu_is_omap3430()		is_omap3430()
>  #endif
> 
> +#if defined(CONFIG_ARCH_OMAP36XX)
> +# undef cpu_is_omap3630
> +# define cpu_is_omap3630()		1
> +#endif
> +
>  # if defined(CONFIG_ARCH_OMAP4)
>  # undef cpu_is_omap44xx
>  # undef cpu_is_omap443x
> @@ -365,7 +384,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
>  				cpu_is_omap16xx())
>  #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
> -				cpu_is_omap44xx())
> +				cpu_is_omap36xx || cpu_is_omap44xx())
> 
>  /* Various silicon revisions for omap2 */
>  #define OMAP242X_CLASS		0x24200024
> @@ -382,6 +401,9 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define OMAP3430_REV_ES3_0	0x34303034
>  #define OMAP3430_REV_ES3_1	0x34304034
> 
> +#define OMAP363X_CLASS		0x36300036
> +#define OMAP3630_REV_ES1_0	0x36300036
> +
>  #define OMAP443X_CLASS		0x44300034
> 
>  /*
> @@ -406,6 +428,12 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
>  #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
> 
> +/* OMAP 3630 CHIP is backword compatible to 3430
> + * 3630 ES1 IS compatible with 3430 ES2 */
> +
> +#define CHIP_IS_OMAP3630		(1 << 2)
> +#define CHIP_IS_OMAP3630ES1		(1 << 4)
> +
>  #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
> 
>  /*
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

