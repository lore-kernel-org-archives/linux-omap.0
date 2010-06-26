From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Sat, 26 Jun 2010 21:38:08 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366B504@dbde02.ent.ti.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
 <1277423084-25528-11-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47790 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab0FZQIL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Jun 2010 12:08:11 -0400
In-Reply-To: <1277423084-25528-11-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, June 25, 2010 5:15 AM
> To: linux-omap@vger.kernel.org
> Cc: paul@pwsan.com
> Subject: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
> 
> Create simple omap_devices for the main processors and busses.
> 
> This is required to support the forth-coming device-based OPP
> approach, where OPPs are managed and tracked at the device level.
> 
> So that these primary devices are available for early PM initialization,
> they are created as early platform_devices.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/devices.c            |    2 +
>  arch/arm/mach-omap2/io.c                 |   58
> +++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/common.h |    4 ++
>  3 files changed, 63 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 03e6c9e..62920ac 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
> +#include <linux/err.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> @@ -29,6 +30,7 @@
>  #include <mach/gpio.h>
>  #include <plat/mmc.h>
>  #include <plat/dma.h>
> +#include <plat/omap_device.h>
> 
>  #include "mux.h"
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 3cfb425..407498d 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -45,7 +45,7 @@
> 
>  #include <plat/clockdomain.h>
>  #include "clockdomains.h"
> -#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> 
>  /*
>   * The machine specific code may provide the extra mapping besides the
> @@ -313,6 +313,61 @@ static int __init _omap2_init_reprogram_sdrc(void)
>  	return v;
>  }
> 
> +static struct omap_device_pm_latency *pm_lats;
> +
> +static struct device *mpu_dev;
> +static struct device *dsp_dev;
> +static struct device *l3_dev;
> +
> +struct device *omap_get_mpuss_device(void)
> +{
> +	WARN_ON_ONCE(!mpu_dev);
> +	return mpu_dev;
> +}
> +
> +struct device *omap_get_dsp_device(void)
> +{
> +	WARN_ON_ONCE(!dsp_dev);
> +	return dsp_dev;
> +}
> +
> +struct device *omap_get_l3_device(void)
> +{
> +	WARN_ON_ONCE(!l3_dev);
> +	return l3_dev;
> +}
> +
> +/* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
> +static int _init_omap_device(char *name, struct device **new_dev)
> +{
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +
> +	oh = omap_hwmod_lookup(name);
> +	if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
> +		 __func__, name))
> +		return -ENODEV;
> +
> +	od = omap_device_build(oh->name, 0, oh, NULL, 0, pm_lats, 0, true);

[Tarun Kanti DebBarma] 
I am new to hwmod and just trying to catch up. In omap_device_build(...) we anyway pass (oh) and so why also pass (oh->name)? If so we can reduce a parameter.


> +	if (WARN(IS_ERR(od), "%s: could not build omap_device for %s\n",
> +		 __func__, name))
> +		return -ENODEV;
> +
> +	*new_dev = &od->pdev.dev;
> +
> +	return 0;
> +}
> +
> +/*
> + * Build omap_devices for processors and bus.
> + */
> +static void omap_init_processor_devices(void)
> +{
> +	_init_omap_device("mpu", &mpu_dev);
> +	_init_omap_device("iva", &dsp_dev);
> +	_init_omap_device("l3_main", &l3_dev);
> +}
> +
>  void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  				 struct omap_sdrc_params *sdrc_cs1)
>  {
> @@ -342,6 +397,7 @@ void __init omap2_init_common_hw(struct
> omap_sdrc_params *sdrc_cs0,
>  	omap_serial_early_init();
>  	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
>  		omap_hwmod_late_init();
> +	omap_init_processor_devices();
>  	omap_pm_if_init();
>  	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>  		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-
> omap/include/plat/common.h
> index d265018..9cdd9cd 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -87,4 +87,8 @@ void omap2_set_globals_uart(struct omap_globals *);
>  	}							\
>  })
> 
> +struct device *omap_get_mpuss_device(void);
> +struct device *omap_get_dsp_device(void);
> +struct device *omap_get_l3_device(void);
> +
>  #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
> --
> 1.7.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
