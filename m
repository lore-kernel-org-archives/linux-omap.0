From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Fri, 07 Jan 2011 08:48:13 -0800
Message-ID: <87wrmgoe2a.fsf@ti.com>
References: <1294405659-25662-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:58739 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754492Ab1AGQsS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 11:48:18 -0500
Received: by mail-px0-f181.google.com with SMTP id 2so4946248pxi.40
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 08:48:18 -0800 (PST)
In-Reply-To: <1294405659-25662-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Fri, 7 Jan 2011 18:37:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> This patch adds support for new speed enhanced parts with ARM
> and IVA running at 720MHz and 520MHz respectively. These parts
> can be probed at run-time by reading PRODID.SKUID[3:0] at
> 0x4830A20C [1].

Please expand this a little to describe exactly which parts have this
feature.  All OMAP3?  34xx? 35xx? what about 36xx/37xx?  ISTR the
runtime probing for this feature is available on 35xx but not on 34xx,
but a summary of this should be here.

> This patch specifically does following:
>  * Detect devices capable of 720MHz.
>  * Add new OPP
>  * Ensure that OPP is conditionally enabled.
>
> The patch was tested on OMAP3EVM.

nit: Unrelated to this patch, but OMAP3EVM ethernet is still broken due to
missing GPIO configuration for the network reset.  This has been broken
since the GPIO hwmod merge and pointed out but nobody seems to be fixing
it.

> On 720MHz capable device:
> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> 720000
>
> On other devices:
> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> 600000
>
>   [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/control.h         |    7 +++++++
>  arch/arm/mach-omap2/id.c              |   10 ++++++++++
>  arch/arm/mach-omap2/opp3xxx_data.c    |   19 ++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/cpu.h |    2 ++
>  4 files changed, 37 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index f0629ae..eebc045 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -365,6 +365,13 @@
>  #define		FEAT_NEON		0
>  #define		FEAT_NEON_NONE		1
>  
> +/*
> + * Product ID register
> + */
> +#define OMAP3_PRODID			0x020C
> +
> +#define OMAP3_SKUID_MASK		0x0f
> +#define		OMAP3_SKUID_720MHZ	0x08
>  
>  #ifndef __ASSEMBLY__
>  #ifdef CONFIG_ARCH_OMAP2PLUS
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 5f9086c..53fbe01 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -195,6 +195,15 @@ static void __init omap3_check_features(void)
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
>  	 */
> +
> +	/*
> +	 * Does it support 720MHz?
> +	 */
> +	status = (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_PRODID));
> +
> +	if (status & OMAP3_SKUID_720MHZ) {
> +		omap3_features |= OMAP3_HAS_720MHZ;
> +	}
>  }
>  
>  static void __init omap3_check_revision(void)
> @@ -445,6 +454,7 @@ static void __init omap3_cpuinfo(void)
>  	OMAP3_SHOW_FEATURE(neon);
>  	OMAP3_SHOW_FEATURE(isp);
>  	OMAP3_SHOW_FEATURE(192mhz_clk);
> +	OMAP3_SHOW_FEATURE(720mhz);
>  
>  	printk(")\n");
>  }
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
> index 0486fce..01582b7 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -22,6 +22,9 @@
>  
>  #include "omap_opp_data.h"
>  
> +#define INDEX_MPU_720MHZ	5
> +#define INDEX_IVA_720MHZ	14
> +
>  static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	/* MPU OPP1 */
>  	OPP_INITIALIZER("mpu", true, 125000000, 975000),
> @@ -33,6 +36,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	OPP_INITIALIZER("mpu", true, 550000000, 1270000),
>  	/* MPU OPP5 */
>  	OPP_INITIALIZER("mpu", true, 600000000, 1350000),
> +	/* MPU OPP6 */
> +	OPP_INITIALIZER("mpu", false, 720000000, 1350000),
>  
>  	/*
>  	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
> @@ -58,6 +63,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	OPP_INITIALIZER("iva", true, 400000000, 1270000),
>  	/* DSP OPP5 */
>  	OPP_INITIALIZER("iva", true, 430000000, 1350000),
> +	/* DSP OPP6 */
> +	OPP_INITIALIZER("iva", false, 520000000, 1350000),
>  };
>  
>  static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
> @@ -98,9 +105,19 @@ static int __init omap3_opp_init(void)
>  	if (cpu_is_omap3630())
>  		r = omap_init_opp_table(omap36xx_opp_def_list,
>  			ARRAY_SIZE(omap36xx_opp_def_list));
> -	else
> +	else {
> +		if (omap3_has_720mhz()) {
> +			pr_info("Enabled OPP corresponding to 720MHz\n");
> +
> +			omap34xx_opp_def_list[INDEX_MPU_720MHZ]
> +				.default_available = true;
> +			omap34xx_opp_def_list[INDEX_IVA_720MHZ]
> +				.default_available = true;
> +		}
> +

I'm with Nishanth here.  Please stick to the OPP API for enabling OPPs.

First, it is future proof to internal table changes, but it also sets a
better precedent for others wanting to fiddle with OPPs.

Thanks,

Kevin

>  		r = omap_init_opp_table(omap34xx_opp_def_list,
>  			ARRAY_SIZE(omap34xx_opp_def_list));
> +	}
>  
>  	return r;
>  }
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 3fd8b40..5c77987 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -455,6 +455,7 @@ extern u32 omap3_features;
>  #define OMAP3_HAS_ISP			BIT(4)
>  #define OMAP3_HAS_192MHZ_CLK		BIT(5)
>  #define OMAP3_HAS_IO_WAKEUP		BIT(6)
> +#define OMAP3_HAS_720MHZ		BIT(7)
>  
>  #define OMAP3_HAS_FEATURE(feat,flag)			\
>  static inline unsigned int omap3_has_ ##feat(void)	\
> @@ -469,5 +470,6 @@ OMAP3_HAS_FEATURE(neon, NEON)
>  OMAP3_HAS_FEATURE(isp, ISP)
>  OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
>  OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
> +OMAP3_HAS_FEATURE(720mhz, 720MHZ)
>  
>  #endif
