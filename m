From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 5/8] OMAP: dmtimer: platform driver
Date: Fri, 4 Mar 2011 14:37:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A360437@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-6-git-send-email-tarun.kanti@ti.com>
 <87mxlboh8o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43922 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031Ab1CDJHT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 04:07:19 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2497F1J001802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 03:07:17 -0600
In-Reply-To: <87mxlboh8o.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, March 04, 2011 6:05 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v11 5/8] OMAP: dmtimer: platform driver
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Thara Gopinath <thara@ti.com>
> >
> > Add dmtimer platform driver functions which include:
> > (1) platform driver initialization
> > (2) driver probe function
> > (3) driver remove function
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> 
> Some locking issues below...
> 
> > ---
> >  arch/arm/plat-omap/dmtimer.c              |  167
> ++++++++++++++++++++++++++++-
> >  arch/arm/plat-omap/include/plat/dmtimer.h |    2 +
> >  2 files changed, 168 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> > index 1bfaf09..bfe6fd3 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -43,6 +43,9 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> >  #include <mach/hardware.h>
> >  #include <plat/dmtimer.h>
> >  #include <mach/irqs.h>
> > @@ -257,7 +260,8 @@ static struct omap_dm_timer *dm_timers;
> >  static const char **dm_source_names;
> >  static struct clk **dm_source_clocks;
> >
> > -static spinlock_t dm_timer_lock;
> > +static LIST_HEAD(omap_timer_list);
> > +static DEFINE_SPINLOCK(dm_timer_lock);
> 
> This spinlock is being used as a mutex.  Please use a mutex instead.
Alright, I will use mutex instead.

> 
> >  /*
> >   * Reads timer registers in posted and non-posted mode. The posted mode
> bit
> > @@ -689,6 +693,167 @@ int omap_dm_timers_active(void)
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timers_active);
> >
> > +/**
> > + * omap_dm_timer_probe - probe function called for every registered
> device
> > + * @pdev:	pointer to current timer platform device
> > + *
> > + * Called by driver framework at the end of device registration for all
> > + * timer devices.
> > + */
> > +static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	unsigned long flags;
> > +	struct omap_dm_timer *timer;
> > +	struct resource *mem, *irq, *ioarea;
> > +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> > +
> > +	if (!pdata) {
> > +		dev_err(&pdev->dev, "%s: no platform data\n", __func__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	spin_lock_irqsave(&dm_timer_lock, flags);
> 
> Why do you need IRQ versions of the locks?   This lock is never used in
> interrupt context.
Yes.
> 
> Kevin
