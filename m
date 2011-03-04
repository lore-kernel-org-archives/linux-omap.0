From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 4/8] OMAP2+: dmtimer: convert to platform devices
Date: Sat, 5 Mar 2011 00:54:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A3605B7@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-5-git-send-email-tarun.kanti@ti.com>
	<87vczzn1fx.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037A3603A8@dbde02.ent.ti.com>
 <87zkpahk6u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51553 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab1CDTYP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 14:24:15 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p24JOBsQ006289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 13:24:14 -0600
In-Reply-To: <87zkpahk6u.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, March 04, 2011 10:55 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v11 4/8] OMAP2+: dmtimer: convert to platform devices
> 
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Hilman, Kevin
> >> Sent: Friday, March 04, 2011 6:32 AM
> >> To: DebBarma, Tarun Kanti
> >> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> >> Subject: Re: [PATCH v11 4/8] OMAP2+: dmtimer: convert to platform
> devices
> >>
> >> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> >>
> >> > Add routines to converts dmtimers to platform devices. The device
> data
> >> > is obtained from hwmod database of respective platform and is
> registered
> >> > to device model after successful binding to driver. It also provides
> >> > provision to access timers during early boot when pm_runtime
> framework
> >> > is not completely up and running.
> >> >
> >> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> >> > Signed-off-by: Thara Gopinath <thara@ti.com>
> >> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> >> > ---
> >> >  arch/arm/mach-omap2/Makefile  |    2 +-
> >> >  arch/arm/mach-omap2/dmtimer.c |  199
> >> +++++++++++++++++++++++++++++++++++++++++
> >> >  2 files changed, 200 insertions(+), 1 deletions(-)
> >> >  create mode 100644 arch/arm/mach-omap2/dmtimer.c
> >> >
> >> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-
> omap2/Makefile
> >> > index 1c3635d..7e5014b 100644
> >> > --- a/arch/arm/mach-omap2/Makefile
> >> > +++ b/arch/arm/mach-omap2/Makefile
> >> > @@ -4,7 +4,7 @@
> >> >
> >> >  # Common support
> >> >  obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-
> gp.o
> >> pm.o \
> >> > -	 common.o gpio.o dma.o wd_timer.o
> >> > +	 common.o gpio.o dma.o wd_timer.o dmtimer.o
> >> >
> >> >  omap-2-3-common				= irq.o sdrc.o
> >> >  hwmod-common				= omap_hwmod.o \
> >> > diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-
> >> omap2/dmtimer.c
> >> > new file mode 100644
> >> > index 0000000..00cebe9
> >> > --- /dev/null
> >> > +++ b/arch/arm/mach-omap2/dmtimer.c
> >> > @@ -0,0 +1,199 @@
> >> > +/**
> >> > + * OMAP2+ Dual-Mode Timers - platform device registration
> >> > + *
> >> > + * Contains first level initialization routines which extracts
> timers
> >> > + * information from hwmod database and registers with linux device
> >> model.
> >> > + * It also has low level function to change the timer input clock
> >> source.
> >> > + *
> >> > + * Copyright (C) 2010 Texas Instruments Incorporated -
> >> http://www.ti.com/
> >> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> >> > + * Thara Gopinath <thara@ti.com>
> >> > + *
> >> > + * This program is free software; you can redistribute it and/or
> modify
> >> > + * it under the terms of the GNU General Public License version 2 as
> >> > + * published by the Free Software Foundation.
> >> > + *
> >> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> >> > + * kind, whether express or implied; without even the implied
> warranty
> >> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> > + * GNU General Public License for more details.
> >> > + */
> >> > +
> >> > +#include <linux/clk.h>
> >> > +#include <linux/err.h>
> >> > +#include <linux/slab.h>
> >> > +
> >> > +#include <plat/dmtimer.h>
> >> > +#include <plat/omap_device.h>
> >> > +#include <plat/cpu.h>
> >> > +
> >> > +/*
> >> > + * OMAP4 IP revision has different register offsets
> >> > + * for interrupt registers and functional registers.
> >> > + */
> >> > +#define VERSION2_TIMER_WAKEUP_EN_REG_OFFSET	0x14
> >> > +#define VERSION2_TIMER_STAT_REG_OFFSET		0x10
> >>
> >> These should be in the driver along with all the other register
> offsets.
> >>
> >> This device code is already setting the IP rev type, the driver can
> >> handle the rest.
> > Ok, I will make the changes.
> >
> >>
> >> > +static int early_timer_count __initdata = 1;
> >>
> >> dumb question: why does this start at 1?
> >>
> > This is related to one of your early comments where this variable is
> used:
> > early_platform_driver_probe("earlytimer", early_timer_count, 0);
> > It was passed as early_timer_count + 1, as static variable starts at 0.
> > So it is just to avoid this addition of 1.
> 
> I see, but this change doesn't make it any more readable, IMO.
> 
> How about just create a local variable 'id = early_timer_count + 1',
> and pass id as the 2nd argument.  That way it's clear that it's being
> used for the ID.
OK.

> 
> >> > +struct dm_timer_data {
> >> > +	struct omap_device *od;
> >> > +	struct dmtimer_platform_data *pdata;
> >> > +	struct list_head node;
> >> > +};
> >> > +
> >> > +static __initdata LIST_HEAD(dm_timer_data_list);
> >> > +
> >> > +/**
> >> > + * omap2_dm_timer_set_src - change the timer input clock source
> >> > + * @pdev:	timer platform device pointer
> >> > + * @timer_clk:	current clock source
> >> > + * @source:	array index of parent clock source
> >> > + */
> >> > +static int omap2_dm_timer_set_src(struct platform_device *pdev, int
> >> source)
> >> > +{
> >> > +	int ret;
> >> > +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> >> > +	struct clk *fclk = clk_get(&pdev->dev, "fck");
> >> > +	struct clk *new_fclk;
> >> > +	char *fclk_name = "32k_ck"; /* default name */
> >> > +
> >> > +	switch (source) {
> >> > +	case OMAP_TIMER_SRC_SYS_CLK:
> >> > +		fclk_name = "sys_ck";
> >> > +		break;
> >> > +
> >> > +	case OMAP_TIMER_SRC_32_KHZ:
> >> > +		fclk_name = "32k_ck";
> >> > +		break;
> >> > +
> >> > +	case OMAP_TIMER_SRC_EXT_CLK:
> >> > +		if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_1) {
> >> > +			fclk_name = "alt_ck";
> >> > +			break;
> >> > +		}
> >> > +		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
> >> > +			__func__, __LINE__);
> >> > +		return -EINVAL;
> >> > +	}
> >> > +
> >> > +	if (IS_ERR_OR_NULL(fclk)) {
> >> > +		dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
> >> > +			__func__, __LINE__);
> >> > +		return -EINVAL;
> >> > +	}
> >> > +
> >> > +	new_fclk = clk_get(&pdev->dev, fclk_name);
> >> > +	if (IS_ERR_OR_NULL(new_fclk)) {
> >> > +		dev_err(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
> >> > +			__func__, __LINE__, fclk_name);
> >> > +		clk_put(fclk);
> >> > +		return -EINVAL;
> >> > +	}
> >> > +
> >> > +	ret = clk_set_parent(fclk, new_fclk);
> >> > +	if (IS_ERR_VALUE(ret)) {
> >> > +		dev_err(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
> >> > +			__func__, fclk_name);
> >> > +		ret = -EINVAL;
> >> > +	}
> >> > +
> >> > +	clk_put(new_fclk);
> >> > +	clk_put(fclk);
> >> > +
> >> > +	return ret;
> >> > +}
> >> > +
> >> > +struct omap_device_pm_latency omap2_dmtimer_latency[] = {
> >> > +	{
> >> > +		.deactivate_func = omap_device_idle_hwmods,
> >> > +		.activate_func   = omap_device_enable_hwmods,
> >> > +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> >> > +	},
> >> > +};
> >> > +
> >> > +/**
> >> > + * omap_timer_init - build and register timer device with an
> >> > + * associated timer hwmod
> >> > + * @oh:	timer hwmod pointer to be used to build timer device
> >> > + * @user:	parameter that can be passed from calling hwmod API
> >> > + *
> >> > + * Called by omap_hwmod_for_each_by_class to register each of the
> timer
> >> > + * devices present in the system. The number of timer devices is
> known
> >> > + * by parsing through the hwmod database for a given class name. At
> the
> >> > + * end of function call memory is allocated for timer device and it
> is
> >> > + * registered to the framework ready to be proved by the driver.
> >> > + */
> >> > +static int __init omap_timer_init(struct omap_hwmod *oh, void
> *unused)
> >> > +{
> >> > +	int id;
> >> > +	int ret = 0;
> >> > +	char *name = "omap_timer";
> >> > +	struct dmtimer_platform_data *pdata;
> >> > +	struct omap_device *od;
> >> > +	struct dm_timer_data *timer_data = NULL;
> >> > +
> >> > +	pr_debug("%s: %s\n", __func__, oh->name);
> >> > +
> >> > +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> >>
> >> Memory leak.
> >>
> >> This needs to be free'd after omap_device_build().  The platform_device
> >> core makes a copy of the pdata (via kmemdup.)
> > Yes, it was there and I missed it while implementing the double
> registration
> > Issue :( Thanks!
BTW, I realized that pdata is freed later at the end of normal registration.

> >
> >>
> >> > +	if (!pdata) {
> >> > +		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
> >> > +		return -ENOMEM;
> >> > +	}
> >> > +
> >> > +	pdata->is_early_init = 1;
> >> > +	pdata->is_omap16xx = 0;
> >> > +	pdata->dm_timer_reset = NULL;
> >> > +	pdata->set_timer_src = omap2_dm_timer_set_src;
> >> > +
> >> > +	pdata->timer_ip_type = oh->class->rev;
> >> > +	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
> >> > +		pdata->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
> >> > +		pdata->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
> >> > +	} else {
> >> > +		pdata->func_offset = 0;
> >> > +		pdata->intr_offset = 0;
> >> > +	}
> >> > +
> >> > +	/*
> >> > +	 * Extract the IDs from name field in hwmod database
> >> > +	 * and use the same for constructing ids' for the
> >> > +	 * timer devices. In a way, we are avoiding usage of
> >> > +	 * static variable witin the function to do the same.
> >> > +	 * CAUTION: We have to be careful and make sure the
> >> > +	 * name in hwmod database does not change in which case
> >> > +	 * we might either make corresponding change here or
> >> > +	 * switch back static variable mechanism.
> >> > +	 */
> >> > +	sscanf(oh->name, "timer%2d", &id);
> >> > +
> >> > +	/* do registration of timer12 on GP device only */
> >> > +	if (id == 12 && omap_type() != OMAP2_DEVICE_TYPE_GP)
> >> > +		return ret;
> >>
> >> hmm, grumble
> >>
> >> Is this true on OMAP4?  I thought GPT12 was not accessible on OMAP4
> even
> >> on GP devices.
> >
> > On OMAP4 hwmod database there is no entry for GPT12.
> > So, this condition would NOT be applicable to OMAP4 at all as I
> understand.
> 
> Not really true.
> 
> Just like OMAP3, OMAP4 has a secure-mode GPT12.  (c.f. OMAP4430 ES2.x
> NDA TRM HS Security Addendum vI, Chapter 6.1 Secure Timers.)  What's not
> clear (and needs to be tested) is whether this timer is available on GP
> devices.
As far as I remember GP does not have GPT12, unlike OMAP3.
Anyways, I can confirm once again.

> 
> Benoit gave me a GPT12 hwmod for OMAP4 and I boot tested it on top of
> your series and it seems to work fine on my ES2.0 GP Panda, so we should
> just add the GPT12 hwmod and make it behave just like OMAP3.
Ok, I was not aware of this.

> 
> > Of course, as I see it the comment is not very clear and I can change
> that.
> >
> >>
> >> As I've said a few times before, what we need here is some sort of
> >> "capabilities" flag for each timer in the hwmod.  In addition to this
> >> "secure-mode only" feature, there are other capabilities such as 1ms
> >> timers, PWM capable, etc.
> > I can consider this. However I feel this would take sometime to align on
> the
> > Final choice/option of implementation.
> 
> Yes, it would take some time, which is why I've been suggesing this
> feature since this series was first proposed a few months ago.
Looks like I have definitely missed this point somehow.
Sorry about that.

> 
> > So, is the above implementation acceptable for now?
> 
> If it can be done without feeling like a hack.
> 
> Personally, I think a better short-term hack would be to have a dev_attr
> flag for "secure" rather than a hard-coded check for timer 12.
Yes, I will try out this change.
--
Tarun

> 
> >>
> >> > +	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
> >> > +			omap2_dmtimer_latency,
> >> > +			ARRAY_SIZE(omap2_dmtimer_latency),
> >> > +			pdata->is_early_init);
> >> > +
> >> > +	if (IS_ERR(od)) {
> >> > +		pr_err("%s: Can't build omap_device for %s: %s.\n",
> >> > +			__func__, name, oh->name);
> >> > +		ret = -EINVAL;
> >> > +	} else if (pdata->is_early_init)
> >> > +		early_timer_count++;
> >> > +
> >> > +	timer_data = kzalloc(sizeof(*timer_data), GFP_KERNEL);
> >> > +	if (!timer_data) {
> >> > +		pr_debug("%s: no memory for dm_timer_data\n",
> >> > +				__func__);
> >> > +		return -ENOMEM;
> >> > +	}
> >> > +
> >> > +	/* store od and pdata to be used later during normal
> initialization
> >> */
> >> > +	timer_data->od = od;
> >> > +	timer_data->pdata = pdata;
> >> > +	list_add_tail(&timer_data->node, &dm_timer_data_list);
> >> > +
> >> > +	return ret;
> >> > +}
> >>
> >> Kevin
