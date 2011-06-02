From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Thu, 02 Jun 2011 11:29:45 -0700
Message-ID: <87sjrsw0h2.fsf@ti.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<1304687833-4578-5-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:51065 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754290Ab1FBS3t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 14:29:49 -0400
Received: by mail-pv0-f172.google.com with SMTP id 18so764009pvh.17
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 11:29:48 -0700 (PDT)
In-Reply-To: <1304687833-4578-5-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Fri, 6 May 2011 18:47:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_reset.
>
> TWL4030 power scripts which can be used by different OMAP3 boards
> with the power companion chip (TWL4030 series).
>
> The twl4030 generic script can be used by any board file to update
> the power data in twl4030_platform_data.

What about existing board files that are using their own scripts?

On n900 for example, board-rx51-peripherals.c has its own custom
scripts which are registered at board init time.  These are then
over written by your new driver which loads later.

So first, can you verify if the n900 scripts can/should be replaced by
these generic ones.  And second, please find a way for board files to
override these scripts at runtime instead of using a Kconfig.

> Since the TWL4030 power script has dependency with APIs in twl4030-power.c
> removing the __init for these APIs.

I think separating this part out into a separate patch, with a better
description would make the rest of this patch much more readable.  As it
is, it doesn't make much sense since all the script functions and data
are __init or __initdata.

These changes also introduce a new complier warning:

  CC      drivers/mfd/twl4030-power.o
/work/kernel/omap/pm/drivers/mfd/twl4030-power.c: In function 'twl4030_power_init':
/work/kernel/omap/pm/drivers/mfd/twl4030-power.c:457:5: warning: 'err' may be used uninitialized in this function
/work/kernel/omap/pm/drivers/mfd/twl4030-power.c:171:6: note: 'err' was declared here
 

> For more information please see:
> 	http://omapedia.org/wiki/TWL4030_power_scripts

This is an excellent wiki, thank for the detailed description!

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

Shouldn't this depend on CONFIG_TWL4030_SCRIPT ?

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

I guess this gets to the debate about whether these scripts should be in
drivers/mfd or in arch/arm/mach-omap2,  but wherever the script data
lives, this platform_device definition and register should be also.

IOW, there's not a clean separation between driver and device currently.
IMO, The platform_driver part should just be part of twl4030-power.c,
and all the scripts and platform_device creation/registration should be
part of the script file.

As far as where the script device data should go, I'd vote for
drivers/mfd, where it can be compiled as a module along with the rest of
the twl4030 code.

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
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3ed3ff0..bed88ce 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -204,6 +204,17 @@ config TWL4030_POWER
>  	  and load scripts controlling which resources are switched off/on
>  	  or reset when a sleep, wakeup or warm reset event occurs.
>  
> +config TWL4030_SCRIPT
> +	tristate "Support TWL4030 script for OMAP3 boards"
> +	depends on TWL4030_CORE && TWL4030_POWER
> +	help
> +	  Say yes here if you want to use the twl4030 power scripts
> +	  for OMAP3 boards. Power bus message sequence for
> +	  TWL4030 to enter sleep/wakeup/warm_reset.
> +
> +	  TWL4030 power scripts which can be used by different
> +	  OMAP3 boards with the power companion chip (TWL4030 series).
> +

Why do we need another Kconfig for this?  It should be enabled and
overridden at runtime via board files.

Kevin
