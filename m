From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv2 6/13] dmtimer: hwmod: OMAP2PLUS: device registration
Date: Wed, 1 Sep 2010 15:41:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03291AD382@dbde02.ent.ti.com>
References: <1281800238-15135-1-git-send-email-tarun.kanti@ti.com>
 <87zkwcq3g5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55042 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789Ab0IAKMJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 06:12:09 -0400
In-Reply-To: <87zkwcq3g5.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 24, 2010 5:37 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara; Basak, Partha; Nayak,
> Rajendra; Paul Walmsley; Tony Lindgren
> Subject: Re: [PATCHv2 6/13] dmtimer: hwmod: OMAP2PLUS: device registration
>
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
> > From: Thara Gopinath <thara@ti.com>
> >
> > This patch converts dmtimers into platform devices using omap hwmod,
> > omap device and runtime pm frameworks. It also allows GPTIMER1 and
> > GPTIMER2 and GPTIMER10 to be registered as early devices. This allows
> > any one of the these three to be registered as system timer very early
> > during system boot sequence. Later during normal plaform_device_register
> > these are converted to normal platform device.
>
> What about GPT12 which is used as system timer on Beagle due to a board
> bug on early revs of board?
>
Will modify design to incorporate any of the timers as an early timer.

> > comments incorporated:
> > (1) registration of devices through automatic learning from hwmod
> database
> > (2) enabling functionality both with and without pm_runtime
> > (3) extract device id from hwmod structure's name field.
> > (4) free platform data at the end of successful platform device
> registration
>
> I still don't like the way early devices are implemented.   My comments
> from the first time I reviewed this series appear to have been ignored.
>
> It is not at all clear why the separate pdata functions are needed for
> early and "normal" devices.  Many more questions/comments on this below...
>
Will merge the two and embed them within pdata.

> > Signed-off-by: Partha Basak <p-basak2@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/Makefile   |    2 +-
> >  arch/arm/mach-omap2/dmtimer.c  |  403
> ++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/dmtimer.h  |   19 ++
> >  arch/arm/mach-omap2/io.c       |    2 +
> >  arch/arm/mach-omap2/timer-gp.c |    1 -
> >  5 files changed, 425 insertions(+), 2 deletions(-)
> >  create mode 100755 arch/arm/mach-omap2/dmtimer.c
> >  create mode 100755 arch/arm/mach-omap2/dmtimer.h
> >  mode change 100644 => 100755 arch/arm/mach-omap2/io.c
> >
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index 9b44773..c54f6e8 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -3,7 +3,7 @@
> >  #
> >
> >  # Common support
> > -obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> pm.o
> > +obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> pm.o dmtimer.o
> >
> >  omap-2-3-common                            = irq.o sdrc.o
> >  hwmod-common                               = omap_hwmod.o \
> > diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-
> omap2/dmtimer.c
> > new file mode 100755
> > index 0000000..2c40a9b
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/dmtimer.c
> > @@ -0,0 +1,403 @@
> > +/**
> > + * linux/arch/arm/mach-omap2/dmtimer.c
> > + *
> > + * Copyright (C) 2010 Texas Instruments, Inc.
> > + * Thara Gopinath <thara@ti.com>
> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > + * - Highlander ip support on omap4
> > + * - hwmod support
> > + *
> > + * OMAP2 Dual-Mode Timers
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +
> > +#include <mach/irqs.h>
> > +#include <plat/dmtimer.h>
> > +#include <plat/omap_hwmod.h>
> > +#include <plat/omap_device.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +static int early_timer_count __initdata;
> > +static int is_early_init __initdata = 1;
> > +
> > +static char *omap2_dm_source_names[] __initdata = {
> > +   "sys_ck",
> > +   "func_32k_ck",
> > +   "alt_ck",
> > +   NULL
> > +};
> > +static struct clk *omap2_dm_source_clocks[3];
> >
> > +static char *omap3_dm_source_names[] __initdata = {
> > +   "sys_ck",
> > +   "omap_32k_fck",
> > +   NULL
> > +};
> > +static struct clk *omap3_dm_source_clocks[2];
> > +
> > +static char *omap4_dm_source_names[] __initdata = {
> > +   "sys_clkin_ck",
> > +   "sys_32k_ck",
> > +   "syc_clk_div_ck",
> > +   NULL
> > +};
> > +static struct clk *omap4_dm_source_clocks[3];
> > +
> > +static struct clk **omap_dm_source_clocks;
>
> The clock names should all be part of pdata too.   There is no reason
> to keep these SoC specifics in the driver.
>
OK, I will change.

> > +static void omap2_dm_timer_enable(struct platform_device *pdev)
> > +{
> > +   if (!pdev) {
> > +           dev_err(&pdev->dev, "%s: invalid pdev\n", __func__);
> > +           return;
> > +   }
> > +   pm_runtime_get_sync(&pdev->dev);
> > +}
> > +
> > +static void omap2_dm_timer_disable(struct platform_device *pdev)
> > +{
> > +   if (!pdev) {
> > +           dev_err(&pdev->dev, "%s: invalid pdev\n", __func__);
> > +           return;
> > +   }
> > +   pm_runtime_put_sync(&pdev->dev);
> > +}
>
> There is no need for these functions.  Driver should be calling runtime
> PM API directly.
In that case, driver will have to make call by directly accessing acquired timer's internal variables as shown below.
pm_runtime_put_sync(&timer->pdev->dev);
However, I believe we would like other drivers' perform all operations on acquired timers through exported APIs and keep the pm_runtime_put_sync() call internal to exported APIs as is the case current implementation.

Let me know if I am missing anything here!!

>
> > +static void omap2_dm_early_timer_enable(struct platform_device *pdev)
> > +{
> > +#ifdef CONFIG_PM_RUNTIME
> > +   /* when pm_runtime is enabled, it is still inactive at this point
>
> wrong multi-line comment style
>
> > +    * that is why this call is needed as it is not enabled by default
> > +    */
>
> so the driver should do what it does for every other case where it needs
> the device to be active, and do a pm_runtime_get()
We will let the drivers take care of this.

>
> > +   if (omap_device_enable(pdev))
> > +           dev_warn(&pdev->dev, "%s: Unable to enable the timer%d\n",
> > +                   __func__, pdev->id);
> > +#endif
> > +}
> > +
> > +static void omap2_dm_early_timer_disable(struct platform_device *pdev)
> > +{
> > +#ifdef CONFIG_PM_RUNTIME
> > +   /* when pm_runtime is enabled, it is still inactive at this point
> > +    * that is why this call is needed as it is not enabled by default
> > +    */
> > +   if (omap_device_idle(pdev))
> > +           dev_warn(&pdev->dev, "%s: Unable to disable the timer%d\n",
> > +                   __func__, pdev->id);
> > +#endif
> > +}
>
> Alternatively, (as I mentioned the first time I reviewed this series),
> why do clock management on early timers in the first place.  Just enable
> them and then runtime PM manage them only after the "real" devices are
> registered.
>
OK.

> > +/**
> > +* omap2_dm_timer_set_src - change the timer input clock source
>
> wrong multi-line comment style.
>
> There are *lots* of these in this code.
>
Will take care.

> > +* @pdev: timer platform device pointer
> > +* @timer_clk: current clock source
> > +* @source: array index of parent clock source
> > +**/
> > +static int omap2_dm_timer_set_src(struct platform_device *pdev,
> > +                   struct clk *timer_clk, int source)
> > +{
> > +   int ret;
> > +
> > +   if (IS_ERR(timer_clk)) {
> > +           dev_warn(&pdev->dev, "%s: Not able get the clock pointer\n",
> > +                   __func__);
> > +           return -EINVAL;
> > +   }
> > +
> > +#ifndef CONFIG_PM_RUNTIME
> > +   clk_disable(timer_clk); /* enabled in hwmod */
> > +#else
> > +   if (unlikely(is_early_init))
> > +           omap_device_idle(pdev);
> > +   else
> > +           pm_runtime_put_sync(&pdev->dev);
> > +#endif
>
> yowza.  /me no like.    see above
>
Will modify the design!

> > +
> > +   ret = clk_set_parent(timer_clk, omap_dm_source_clocks[source]);
> > +   if (ret)
> > +           dev_warn(&pdev->dev, "%s: Not able to change "
> > +                   "fclk source\n", __func__);
> > +
> > +#ifndef CONFIG_PM_RUNTIME
> > +   clk_enable(timer_clk);
> > +#else
> > +   if (unlikely(is_early_init))
> > +           omap_device_enable(pdev);
> > +   else
> > +           pm_runtime_get_sync(&pdev->dev);
> > +#endif
> > +
> > +   return ret;
> > +}
> > +
> > +static int omap2_dm_timer_set_clk(struct platform_device *pdev, int
> source)
> > +{
> > +   struct clk *timer_clk = clk_get(&pdev->dev, "fck");
> > +
> > +   return omap2_dm_timer_set_src(pdev, timer_clk, source);
> > +}
> > +
> > +struct clk *omap2_dm_timer_get_fclk(struct platform_device *pdev)
> > +{
> > +   return clk_get(&pdev->dev, "fck");
> > +}
> > +
> > +static int omap2_dm_early_timer_set_clk
> > +                   (struct platform_device *pdev, int source)
> > +{
> > +   struct omap_device *odev = to_omap_device(pdev);
> > +
> > +   dev_dbg(&pdev->dev, "%s:+\n", __func__);
> > +   return omap2_dm_timer_set_src(pdev,
> > +                   omap_hwmod_get_clk(odev->hwmods[0]),
> > +                   source);
> > +}
> > +
> > +static struct clk *omap2_dm_early_timer_get_fclk
> > +                           (struct platform_device *pdev)
> > +{
> > +   struct omap_device *odev = to_omap_device(pdev);
> > +
> > +   dev_dbg(&pdev->dev, "%s:+\n", __func__);
> > +   return omap_hwmod_get_clk(odev->hwmods[0]);
> > +}
>
> OK, a thorough explanation as to why these hooks have to be different
> between early and normal devices would have helped here.  Without that,
> I have to assume....
>
> So, I assume that the problem here is that clk_get() doesn't work
> because there is no platform_device initialized so struct device has
> no name, and therefore clk_get() fails.
>
Right!!

> Another solution would be to ensure the early devices are created with
> the 'dev->init_name' field populated correctly.  That should ensure that
> the same clk_get() can work in both cases, and you should not need the
> new omap_hwmod_get_clk() API.
OK, I will consider!
>
> > +/**
> > +* omap2_dm_timer_setup - acquire clock structure associated with
> > +* current omap platform
> > +*
> > +* timers in different omap platform support different types of clocks
> > +* as input source. there is a static array of struct clk * as its
> > +* elements which are initialized to point to respective clk structure.
> > +* the clk structures are obtained using clk_get() which fetches the
> > +* clock pointer from a omap platform specific static clock array.
> > +* these clk* elements are finally used while changing the input clock
> > +* source of the timers.
> > +**/
> > +static void __init omap2_dm_timer_setup(void)
> > +{
> > +   int i;
> > +   char **clock_source_names;
> > +
> > +   if (cpu_is_omap24xx()) {
> > +           clock_source_names = omap2_dm_source_names;
> > +           omap_dm_source_clocks = omap2_dm_source_clocks;
> > +   } else if (cpu_is_omap34xx()) {
> > +           clock_source_names = omap3_dm_source_names;
> > +           omap_dm_source_clocks = omap3_dm_source_clocks;
> > +   } else if (cpu_is_omap44xx()) {
> > +           clock_source_names = omap4_dm_source_names;
> > +           omap_dm_source_clocks = omap4_dm_source_clocks;
> > +   } else {
> > +           pr_err("%s: Chip support not yet added\n", __func__);
> > +           return;
> > +   }
>
> see above.
>
> Any usage of cpu_is_* in a converted driver should be an indicator that
> something needs to be moved to platform_data.
I will do further analysis and make the needful change.

>
> > +   /* Initialize the dmtimer src clocks */
> > +   for (i = 0; clock_source_names[i] != NULL; i++)
> > +                   omap_dm_source_clocks[i] =
> > +                           clk_get(NULL, clock_source_names[i]);
> > +}
> > +
> > +struct omap_device_pm_latency omap2_dmtimer_latency[] = {
> > +   {
> > +           .deactivate_func = omap_device_idle_hwmods,
> > +           .activate_func   = omap_device_enable_hwmods,
> > +           .flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> > +   },
> > +};
> > +
> > +/**
>
> mis-aligned comment style
>
Will take care!

> > +* omap_dm_timer_early_init - build and register early timer device
> > +* with an associated timer hwmod
> > +* @oh: timer hwmod pointer to be used to build timer device
> > +* @user: parameter that can be passed from calling hwmod API
> > +*
> > +* early init is called in the last part of omap2_init_common_hw
> > +* for each early timer class using omap_hwmod_for_each_by_class.
> > +* it registers each of the timer devices present in the system.
> > +* at the end of function call memory is allocated for omap_device
> > +* and hwmod for early timer and the device is registered to the
> > +* framework ready to be probed by the driver.
> > +**/
> > +static int __init omap_dm_timer_early_init(struct omap_hwmod *oh, void
> *user)
> > +{
> > +   int id;
> > +   int ret = 0;
> > +   char *name = "dmtimer";
> > +   struct omap_dmtimer_platform_data *pdata;
> > +   struct omap_device *od;
> > +
> > +   if (!oh) {
> > +           pr_err("%s:Could not find [%s]\n", __func__, oh->name);
> > +           return -EINVAL;
> > +   }
> > +
> > +   pr_debug("%s:%s\n", __func__, oh->name);
> > +
> > +   pdata = kzalloc(sizeof(struct omap_dmtimer_platform_data),
> > +                   GFP_KERNEL);
> > +   if (!pdata) {
> > +           pr_err("%s: No memory for [%s]\n", __func__, oh->name);
> > +           return -ENOMEM;
> > +   }
>
> insert blank line
>
OK.

> > +   /* hook timer enable/disable functions */
> > +   pdata->omap_dm_clk_enable = omap2_dm_early_timer_enable;
> > +   pdata->omap_dm_clk_disable = omap2_dm_early_timer_disable;
>
> as above, I don't like these.  I'd rather just delay clock management of
> these until "real" devices are ready.
>
Yes. Will let the driver take care, as explained above.

> > +   /* hook clock set/get functions */
> > +   pdata->omap_dm_set_source_clk = omap2_dm_early_timer_set_clk;
> > +   pdata->omap_dm_get_timer_clk = omap2_dm_early_timer_get_fclk;
> > +
> > +   /* read timer ip version */
> > +   pdata->timer_ip_type = oh->class->rev;
> > +
> > +   /*
> > +   * extract the id from name
> > +   * this is not the best implementation, but the cleanest with
> > +   * the existing constraints: (1) early timers are not sequential,
> > +   * 1/2/10 (2) export APIs use id's to identify corresponding
> > +   * timers (3) non-early timers initialization have to track the
> > +   * id's already used by early timers.
> > +   *
> > +   * well, the ideal solution would have been to have an 'id' field
> > +   * in struct omap_hwmod {}. otherwise, we have to have devattr
> > +   * for all timers.
> > +   */
> > +   sscanf(oh->name, "timer%2d", &id);
> > +
> > +   od = omap_device_build(name, id - 1, oh, pdata, sizeof(*pdata),
> > +                   omap2_dmtimer_latency,
> > +                   ARRAY_SIZE(omap2_dmtimer_latency), 1);
> > +
> > +   if (IS_ERR(od)) {
> > +           pr_err("%s: Cant build omap_device for %s:%s.\n",
> > +                   __func__, name, oh->name);
> > +           ret = -EINVAL;
> > +   } else
> > +           early_timer_count++;
> > +   /*
> > +   * pdata can be freed because omap_device_build
> > +   * creates its own memory pool
> > +   */
> > +   kfree(pdata);
> > +
> > +   return ret;
> > +}
> > +
> > +/**
> > +* omap2_dm_timer_init - build and register timer device with an
> > +* associated timer hwmod
> > +* @oh: timer hwmod pointer to be used to build timer device
> > +* @user: parameter that can be passed from calling hwmod API
> > +*
> > +* called by omap_hwmod_for_each_by_class to register each of the timer
> > +* devices present in the system. the number of timer devices is known
> > +* by parsing through the hwmod database for a given class name. at the
> > +* end of function call memory is allocated for omap_device and hwmod
> > +* for timer and the device is registered to the framework ready to be
> > +* proved by the driver.
> > +**/
> > +static int __init omap2_dm_timer_init(struct omap_hwmod *oh, void
> *user)
> > +{
> > +   int id;
> > +   int ret = 0;
> > +   char *name = "dmtimer";
> > +   struct omap_device *od;
> > +   struct omap_dmtimer_platform_data *pdata;
> > +
> > +   if (!oh) {
> > +           pr_err("%s:NULL hwmod pointer (oh)\n", __func__);
> > +           return -EINVAL;
> > +   }
> > +   pr_debug("%s:%s\n", __func__, oh->name);
> > +
> > +   pdata = kzalloc(sizeof(struct omap_dmtimer_platform_data),
> GFP_KERNEL);
> > +   if (!pdata) {
> > +           pr_err("%s:No memory for [%s]\n",  __func__, oh->name);
> > +           return -ENOMEM;
> > +   }
> > +   /* hook timer enable/disable functions */
> > +   pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
> > +   pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
> > +
> > +   /* hook clock set/get functions */
> > +   pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;
> > +   pdata->omap_dm_get_timer_clk = omap2_dm_timer_get_fclk;
> > +
> > +   /* read timer ip version */
> > +   pdata->timer_ip_type = oh->class->rev;
> > +
> > +   /*
> > +   * extract the id from name
> > +   * this may not the best implementation, but the cleanest with
> > +   * the existing constraints: (1) early timers are not sequential,
> > +   * 1/2/10 (2) export APIs use id's to identify corresponding
> > +   * timers (3) non-early timers initialization have to track the
> > +   * id's already used by early timers.
> > +   *
> > +   * well, the ideal solution would have been to have an 'id' field
> > +   * in struct omap_hwmod {}. otherwise we have to have devattr for
> > +   * all timers.
> > +   */
> > +   sscanf(oh->name, "timer%2d", &id);
> > +
> > +   od = omap_device_build(name, id - 1, oh,
> > +                   pdata, sizeof(*pdata),
> > +                   omap2_dmtimer_latency,
> > +                   ARRAY_SIZE(omap2_dmtimer_latency), 0);
> > +
> > +   if (IS_ERR(od)) {
> > +           pr_err("%s: Cant build omap_device for %s:%s.\n",
> > +                   __func__, name, oh->name);
> > +           ret =  -EINVAL;
> > +   }
> > +   /*
> > +   * pdata can be freed because omap_device_build
> > +   * creates its own memory pool
> > +   */
> > +   kfree(pdata);
> > +   return ret;
> > +}
> > +
> > +/**
> > +* omap2_dm_timer_early_init - top level early timer initialization
> > +* called in the last part of omap2_init_common_hw
> > +*
> > +* uses dedicated hwmod api to parse through hwmod database for
> > +* given class name and then build and register the timer device.
> > +* at the end driver is registered and early probe initiated.
> > +**/
> > +void __init omap2_dm_timer_early_init(void)
> > +{
> > +   omap_hwmod_for_each_by_class("timer_1ms",
> > +                           omap_dm_timer_early_init, NULL);
> > +   omap2_dm_timer_setup();
> > +   early_platform_driver_register_all("earlytimer");
> > +   early_platform_driver_probe("earlytimer", early_timer_count + 1, 0);
>
> why the  '+ 1' ?
>
The variable counted from zero and is less by 1.
Anyways, this would go away as the design would now enable any of the timers to be early timers.

> > +}
> > +
> > +/**
> > +* omap_timer_init - top level timer device initialization
> > +*
> > +* uses dedicated hwmod api to parse through hwmod database for
> > +* given class names and then build and register the timer device.
> > +**/
> > +static int __init omap_timer_init(void)
> > +{
> > +   /* disable early init flag */
> > +   is_early_init = 0;
>
> see above, should not need this flag
>
OK, will remove after necessary modification.

-tarun

> [...]
>
> Kevin
