From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 11/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Thu, 24 Jun 2010 12:28:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D15E5B@dbde02.ent.ti.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
 <1277336563-24988-12-git-send-email-khilman@deeprootsystems.com>
 <alpine.DEB.2.00.1006232325470.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35825 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab0FXG7D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 02:59:03 -0400
In-Reply-To: <alpine.DEB.2.00.1006232325470.1550@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul
> Walmsley
> Sent: Thursday, June 24, 2010 11:57 AM
> To: Kevin Hilman
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 11/13] OMAP: create omap_devices for MPU, DSP, L3
> 
> Hi Kevin,
> 
> some comments below -
> 
> On Wed, 23 Jun 2010, Kevin Hilman wrote:
> 
> > Create simple omap_devices for the main processors and busses.
> >
> > This is required to support the forth-coming device-based OPP
> > approach, where OPPs are managed and tracked at the device level.
> >
> > So that these primary devices are available for early PM initialization,
> > they are created as early platform_devices.
> 
> The idea sounds good, but -
> 
> >
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  arch/arm/mach-omap2/devices.c            |    2 +
> >  arch/arm/mach-omap2/io.c                 |   55 +++++++++++++++++++++++++++++-
> >  arch/arm/plat-omap/include/plat/common.h |    4 ++
> >  3 files changed, 60 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > index 03e6c9e..62920ac 100644
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> >  #include <linux/clk.h>
> > +#include <linux/err.h>
> >
> >  #include <mach/hardware.h>
> >  #include <mach/irqs.h>
> > @@ -29,6 +30,7 @@
> >  #include <mach/gpio.h>
> >  #include <plat/mmc.h>
> >  #include <plat/dma.h>
> > +#include <plat/omap_device.h>
> >
> >  #include "mux.h"
> >
> > diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> > index 3cfb425..ecebbbf 100644
> > --- a/arch/arm/mach-omap2/io.c
> > +++ b/arch/arm/mach-omap2/io.c
> > @@ -45,7 +45,7 @@
> >
> >  #include <plat/clockdomain.h>
> >  #include "clockdomains.h"
> > -#include <plat/omap_hwmod.h>
> > +#include <plat/omap_device.h>
> >
> >  /*
> >   * The machine specific code may provide the extra mapping besides the
> > @@ -313,6 +313,58 @@ static int __init _omap2_init_reprogram_sdrc(void)
> >  	return v;
> >  }
> >
> > +static struct omap_device_pm_latency *pm_lats;
> > +
> > +static DEFINE_PER_CPU(struct device *, mpu_dev);
> > +static struct devicee *dsp_dev;
> > +static struct device *l3_dev;
> > +
> > +struct device *omap_get_mpu_device(void)
> > +{
> > +	mpu_dev = per_cpu(mpu_dev, smp_processor_id());
> 
> Looks like this will trash the per-CPU mpu_dev on SMP.  You'll need to
> rename one of these two mpu_devs.
> 
> Also, won't the use of smp_processor_id() mean that this will just return
> the struct device * for the MPU that is running this code?  So on a
> two-CPU system, it would be either CPU 0 or 1, randomly.  I guess one
> solution would be to pass in the processor ID to omap_get_mpu_device().
>
MPUSS and both CPU's are clocked from same clock source, so above assumption
still work on OMAP4.
 
> > +	WARN_ON_ONCE(!mpu_dev);
> > +	return mpu_dev;
> > +}
> > +
> > +struct device *omap_get_dsp_device(void)
> > +{
> > +	WARN_ON_ONCE(!dsp_dev);
> > +	return dsp_dev;
> > +}
> > +
> > +struct device *omap_get_l3_device(void)
> > +{
> > +	WARN_ON_ONCE(!l3_dev);
> > +	return l3_dev;
> > +}
> > +
> > +static int _init_omap_device(struct omap_hwmod *oh, void *user)
> > +{
> > +	struct omap_device *od;
> > +	const char *name = oh->name;
> > +	struct device **new_dev = (struct device **)user;
> > +
> > +	od = omap_device_build(name, 0, oh, NULL, 0, pm_lats, 0, true);
> > +	if (WARN(IS_ERR(od), "Could not build omap_device for %s\n", name))
> > +		return -ENODEV;
> > +
> > +	*new_dev = &od->pdev.dev;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Build omap_devices for processors and bus.
> > + */
> > +static void omap_init_processor_devices(void)
> > +{
> > +	mpu_dev = per_cpu(mpu_dev, smp_processor_id());
> 
> (same issues as above)
> 
> > +
> > +	omap_hwmod_for_each_by_class("mpu", _init_omap_device, &mpu_dev);
> 
> This won't work on SMP - it will use the same mpu_dev variable for each
> MPU, so mpu_dev will contain the struct device * for the last MPU hwmod
> iterated over.
> 
> Also, there is a hidden assumption that the hwmods of class "mpu" will be
> iterated over in the order that the per_cpu() variable expects...
> 
> > +	omap_hwmod_for_each_by_class("dsp", _init_omap_device, &dsp_dev);
> > +	omap_hwmod_for_each_by_class("l3", _init_omap_device, &l3_dev);
> 
> If there is more than one hwmod in these classes, these will lose the
> omap_device pointers for all but the final omap_hwmod iterated over.
> 
> It's probably easier to just call omap_hwmod_lookup()/_init_omap_device()
> directly and forget about omap_hwmod_for_each_by_class() for the above
> two cases - maybe all three...
> 
> > +}
> > +
> >  void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
> >  				 struct omap_sdrc_params *sdrc_cs1)
> >  {
> > @@ -342,6 +394,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
> >  	omap_serial_early_init();
> >  	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
> >  		omap_hwmod_late_init();
> > +	omap_init_processor_devices();
> >  	omap_pm_if_init();
> >  	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> >  		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> > diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
> > index d265018..0059dec 100644
> > --- a/arch/arm/plat-omap/include/plat/common.h
> > +++ b/arch/arm/plat-omap/include/plat/common.h
> > @@ -87,4 +87,8 @@ void omap2_set_globals_uart(struct omap_globals *);
> >  	}							\
> >  })
> >
> > +struct device *omap_get_mpu_device(void);
> > +struct device *omap_get_dsp_device(void);
> > +struct device *omap_get_l3_device(void);
> > +
> >  #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
> > --
> > 1.7.0.2
> >
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
