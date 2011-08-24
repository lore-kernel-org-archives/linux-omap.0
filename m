From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC: PATCH 1/4] AM335X: Update common omap platform files
Date: Wed, 24 Aug 2011 23:49:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC007CE3@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1313058630-32447-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33784 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab1HXSTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 14:19:13 -0400
In-Reply-To: <1313058630-32447-2-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Thursday, August 11, 2011 4:00 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Hilman, Kevin; paul@pwsan.com; linux-arm-
> kernel@lists.infradead.org; Mohammed, Afzal; Hiremath, Vaibhav
> Subject: [RFC: PATCH 1/4] AM335X: Update common omap platform files
> 
> From: Afzal Mohammed <afzal@ti.com>
> 
> This patch updates the common platform files with AM335X device
> support, which is closer to TI81XX family of devices and will be
> considered variant of TI81XX SoC.
> 
> Similar to TI81XX device, AM335X is treated as OMAP3 variant,
> where the cpu class is considered as OMAP34XX and the type is AM335X.
> This means, cpu_is_omap34xx(), cpu_is_ti81xx() and
> cpu_is_am335x() checks return success on AM335X.
> 
> The TI81XX kernel config option CONFIG_SOC_OMAPTI8XX is used
> to include support for AM335X build.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig                   |    2 +-
>  arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
>  arch/arm/plat-omap/include/plat/clock.h       |    1 +
>  arch/arm/plat-omap/include/plat/cpu.h         |   14 ++++++++++++++
>  4 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 4dacb8e..f9f5776 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -75,7 +75,7 @@ config SOC_OMAP3430
>  	select ARCH_OMAP_OTG
> 
>  config SOC_OMAPTI81XX
> -	bool "TI81XX support"
> +	bool "TI81XX/AM335x support"
>  	depends on ARCH_OMAP3
>  	default y
> 
> diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> index 3c50ec8..991e72c 100644
> --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> @@ -41,6 +41,7 @@ struct omap_clk {
>  #define CK_TI816X	(1 << 12)
>  #define CK_446X		(1 << 13)
>  #define CK_TI814X	(1 << 14)
> +#define CK_AM335X	(1 << 15)	/* AM335x specific clocks */
> 
> 
>  #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-
> omap/include/plat/clock.h
> index 1c41292..b5d7447 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -60,6 +60,7 @@ struct clkops {
>  #define RATE_IN_TI816X		(1 << 6)
>  #define RATE_IN_4460		(1 << 7)
>  #define RATE_IN_TI814X		(1 << 8)
> +#define RATE_IN_AM335X		(1 << 9)
> 
>  #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
>  #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-
> omap/include/plat/cpu.h
> index f4ebbae..5a831be 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -120,6 +120,12 @@ static inline int is_ti ##subclass (void)		\
>  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
>  }
> 
> +#define IS_AM_SUBCLASS(subclass, id)			\
> +static inline int is_am ##subclass (void)		\
> +{							\
> +	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
> +}
> +
>  IS_OMAP_CLASS(7xx, 0x07)
>  IS_OMAP_CLASS(15xx, 0x15)
>  IS_OMAP_CLASS(16xx, 0x16)
> @@ -138,6 +144,7 @@ IS_OMAP_SUBCLASS(446x, 0x446)
> 
>  IS_TI_SUBCLASS(816x, 0x816)
>  IS_TI_SUBCLASS(814x, 0x814)
> +IS_AM_SUBCLASS(335x, 0x335)
> 
[Hiremath, Vaibhav] During validation and testing on actual silicon/board,
I have realized that, it would not make much sense to follow cpu_is_ti81xx() for AM335x. We may end up polluting code like 

If (cpu_is_ti81xx() && !cpu_is_am335x()) 

And also, in the future we might see multiple devices coming under AM33xx family. There is some IP's being reused between TI814X and AM335x, so as between OMAPx.

So, we should create separate SoC family for AM33xx family of devices, like OMAP4 and TI81xx and stick to only cpu_is_omap34xx(), cpu_is_am33xx() and cpu_is_am335x().

I will be posting updated version of patch shortly (for review).

Thanks,
Vaibhav

>  #define cpu_is_omap7xx()		0
>  #define cpu_is_omap15xx()		0
> @@ -150,6 +157,7 @@ IS_TI_SUBCLASS(814x, 0x814)
>  #define cpu_is_ti81xx()			0
>  #define cpu_is_ti816x()			0
>  #define cpu_is_ti814x()			0
> +#define cpu_is_am335x()			0
>  #define cpu_is_omap44xx()		0
>  #define cpu_is_omap443x()		0
>  #define cpu_is_omap446x()		0
> @@ -358,6 +366,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>  # undef cpu_is_ti81xx
>  # undef cpu_is_ti816x
>  # undef cpu_is_ti814x
> +# undef cpu_is_am335x
>  # define cpu_is_omap3430()		is_omap3430()
>  # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
>  						(!omap3_has_iva()) &&	\
> @@ -376,6 +385,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>  # define cpu_is_ti81xx()		is_ti81xx()
>  # define cpu_is_ti816x()		is_ti816x()
>  # define cpu_is_ti814x()		is_ti814x()
> +# define cpu_is_am335x()		is_am335x()
>  #endif
> 
>  # if defined(CONFIG_ARCH_OMAP4)
> @@ -431,6 +441,9 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define TI8148_REV_ES2_0	(TI814X_CLASS | (OMAP_REVBITS_01 << 8))
>  #define TI8148_REV_ES2_1	(TI814X_CLASS | (OMAP_REVBITS_02 << 8))
> 
> +#define AM335X_CLASS		0x33500034
> +#define AM335X_REV_ES1_0	AM335X_CLASS
> +
>  #define OMAP443X_CLASS		0x44300044
>  #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
>  #define OMAP4430_REV_ES2_0	(OMAP443X_CLASS | (0x20 << 8))
> @@ -471,6 +484,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define CHIP_IS_TI816X			(1 << 14)
>  #define CHIP_IS_OMAP4460ES1_0		(1 << 15)
>  #define CHIP_IS_TI814X			(1 << 16)
> +#define CHIP_IS_AM335X			(1 << 17)
> 
>  #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
> 
> --
> 1.6.2.4

