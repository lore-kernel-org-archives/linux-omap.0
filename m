From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Thu, 12 May 2011 03:56:07 -0700
Message-ID: <20110512105607.GM31483@atomide.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
 <1304687833-4578-5-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42551 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754026Ab1ELK4K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 06:56:10 -0400
Content-Disposition: inline
In-Reply-To: <1304687833-4578-5-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

* Lesly A M <leslyam@ti.com> [110506 06:14]:
> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_reset.
> 
> TWL4030 power scripts which can be used by different OMAP3 boards
> with the power companion chip (TWL4030 series).
> 
> The twl4030 generic script can be used by any board file to update
> the power data in twl4030_platform_data.
> 
> Since the TWL4030 power script has dependency with APIs in twl4030-power.c
> removing the __init for these APIs.
> 
> For more information please see:
> 	http://omapedia.org/wiki/TWL4030_power_scripts
> 
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  arch/arm/mach-omap2/devices.c        |   15 ++
>  drivers/mfd/Kconfig                  |   11 +
>  drivers/mfd/Makefile                 |    1 +
>  drivers/mfd/twl4030-power.c          |   31 ++--
>  drivers/mfd/twl4030-script-omap.c    |  373 ++++++++++++++++++++++++++++++++++
>  include/linux/i2c/twl.h              |   41 ++++-
>  7 files changed, 454 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/mfd/twl4030-script-omap.c
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 076db52..d9b9858 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -184,6 +184,7 @@ CONFIG_TWL4030_WATCHDOG=y
>  CONFIG_MENELAUS=y
>  CONFIG_TWL4030_CORE=y
>  CONFIG_TWL4030_POWER=y
> +CONFIG_TWL4030_SCRIPT=m
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_TWL4030=y
>  CONFIG_REGULATOR_TPS65023=y
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 7b85585..7653329 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -329,6 +329,20 @@ static void omap_init_audio(void)
>  static inline void omap_init_audio(void) {}
>  #endif
>  
> +#ifdef CONFIG_ARCH_OMAP3
> +static struct platform_device omap_twl4030_script = {
> +	.name	= "twl4030_script",
> +	.id	= -1,
> +};
> +
> +static void omap_init_twl4030_script(void)
> +{
> +	platform_device_register(&omap_twl4030_script);
> +}
> +#else
> +static inline void omap_init_twl4030_script(void) {}
> +#endif

This should be if defined(CONFIG_TWL4030_SCRIPT) ||
defined(CONFIG_TWL4030_SCRIPT_MODULE) instead. And you should
probably only enable it based on some board specific flag.

>  #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
>  
>  #include <plat/mcspi.h>
> @@ -691,6 +705,7 @@ static int __init omap2_init_devices(void)
>  	omap_init_sham();
>  	omap_init_aes();
>  	omap_init_vout();
> +	omap_init_twl4030_script();
>  
>  	return 0;
>  }

The changes above probably also conflict with what I have
in devel-cleanup branch. So maybe split it so I can take this
part?

Also, please note that patches touching arch/arm/*omap*/
files should also be sent with linux-arm-kernel list Cc'd.

Regards,

Tony

Tony
