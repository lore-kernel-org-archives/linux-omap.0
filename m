From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 11 Mar 2011 10:06:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD95E@dbde02.ent.ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
	<1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
 <8739muh9lr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41917 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab1CKEgV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 23:36:21 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2B4aIn6008084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 22:36:20 -0600
In-Reply-To: <8739muh9lr.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, March 11, 2011 4:22 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > Add routines to converts dmtimers to platform devices. The device data
> > is obtained from hwmod database of respective platform and is registered
> > to device model after successful binding to driver. It also provides
> > provision to access timers during early boot when pm_runtime framework
> > is not completely up and running.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> > ---
> >  arch/arm/mach-omap2/Makefile               |    2 +-
> >  arch/arm/mach-omap2/dmtimer.c              |  190
> ++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/dmtimer.h              |   32 +++++
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +
> >  arch/arm/plat-omap/include/plat/dmtimer.h  |    4 +
> >  5 files changed, 232 insertions(+), 1 deletions(-)
> >  create mode 100755 arch/arm/mach-omap2/dmtimer.c
> >  create mode 100755 arch/arm/mach-omap2/dmtimer.h
> >
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index 1c3635d..7e5014b 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -4,7 +4,7 @@
> >
> >  # Common support
> >  obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> pm.o \
> > -	 common.o gpio.o dma.o wd_timer.o
> > +	 common.o gpio.o dma.o wd_timer.o dmtimer.o
> >
> >  omap-2-3-common				= irq.o sdrc.o
> >  hwmod-common				= omap_hwmod.o \
> > diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-
> omap2/dmtimer.c
> > new file mode 100755
> > index 0000000..60c410b
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/dmtimer.c
> > @@ -0,0 +1,190 @@
> > +/**
> > + * OMAP2+ Dual-Mode Timers - platform device registration
> > + *
> > + * Contains first level initialization routines which extracts timers
> > + * information from hwmod database and registers with linux device
> model.
> > + * It also has low level function to change the timer input clock
> source.
> > + *
> > + * Copyright (C) 2010 Texas Instruments Incorporated -
> http://www.ti.com/
> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > + * Thara Gopinath <thara@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +
> > +#include <plat/dmtimer.h>
> > +#include <plat/omap_device.h>
> > +#include <plat/cpu.h>
> > +#include <plat/omap_hwmod.h>
> > +
> > +static u8 __initdata system_timer_id;
> 
> This will initialize to zero, but is never assigned in this patch.
> Fortunately it works since there is no "timer0".
Right, thanks.

> 
> Rather than add this here, It should be added in the patch where it is
> used (and assigned) (PATCH 6/9).
Yes.

> 
> [...]
> 
> > +/**
> > + * omap_timer_init - build and register timer device with an
> > + * associated timer hwmod
> > + * @oh:	timer hwmod pointer to be used to build timer device
> > + * @user:	parameter that can be passed from calling hwmod API
> > + *
> > + * Called by omap_hwmod_for_each_by_class to register each of the timer
> > + * devices present in the system. The number of timer devices is known
> > + * by parsing through the hwmod database for a given class name. At the
> > + * end of function call memory is allocated for timer device and it is
> > + * registered to the framework ready to be proved by the driver.
> > + */
> > +static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
> > +{
> > +	int id;
> > +	int ret = 0;
> > +	char *name = "omap_timer";
> > +	struct dmtimer_platform_data *pdata;
> > +	struct omap_device *od;
> > +	struct omap_secure_timer_dev_attr *secure_timer_dev_attr;
> > +
> > +	/*
> > +	 * Extract the IDs from name field in hwmod database
> > +	 * and use the same for constructing ids' for the
> > +	 * timer devices. In a way, we are avoiding usage of
> > +	 * static variable witin the function to do the same.
> > +	 * CAUTION: We have to be careful and make sure the
> > +	 * name in hwmod database does not change in which case
> > +	 * we might either make corresponding change here or
> > +	 * switch back static variable mechanism.
> > +	 */
> > +	sscanf(oh->name, "timer%2d", &id);
> > +	if (unlikely(id == system_timer_id))
> > +		return ret;
> > +
> > +	pr_debug("%s: %s\n", __func__, oh->name);
> > +
> > +	/* do not register secure timer */
> 
> Why not?
> 
> On GP devices, the secure time should be registered, otherwise boards
> using timer12 (Beagle and clones) will stop working.  They work now
> because OMAP3 timer12 has not been flagged as secure yet.  That should
> be done in this series too.
OK, I got it. Thanks.
> 
> > +	secure_timer_dev_attr = oh->dev_attr;
> > +	if (secure_timer_dev_attr)
> > +		if (secure_timer_dev_attr->is_secure_timer)
> > +			return ret;
> > +
> 
> [...]
> 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_44xx_data.c
> > index 9a34e20..93dd209 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -3976,6 +3976,11 @@ static struct omap_hwmod_class
> omap44xx_timer_hwmod_class = {
> >  	.rev	= OMAP_TIMER_IP_VERSION_2,
> >  };
> >
> > +/* secure timer can assign this to .dev_attr field */
> > +static struct omap_secure_timer_dev_attr secure_timer_dev_attr = {
> > +	.is_secure_timer        = true,
> > +};
> > +
> 
> OK, going in the right direction now, but this is attr is never
> associated with any timer since timer12 is still missing from the db.
> Please work with Benoit to add GPT12 to the OMAP4 hwmod db.
Yes, I will work with him and get this done.

> 
> Also, OMAP3 timer12 needs to be flagged as secure.
Sure.
--
Tarun
> 
> Kevin
