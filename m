From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 3/4 v2] omap: hwspinlock: Created driver for OMAP
 hardware spinlock.
Date: Wed, 22 Sep 2010 10:21:35 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E5F57C028@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48@dlee03.ent.ti.com>
 <20100920191351.GH4611@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58874 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab0IVPVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 11:21:39 -0400
In-Reply-To: <20100920191351.GH4611@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux Omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Premi, Sanjeev" <premi@ti.com>

Tony,

Thanks for your comments.

> * Que, Simon <sque@ti.com> [100811 17:22]:
> > Created driver for OMAP hardware spinlock.
> >
> >  - Reserved spinlocks for internal use
> >  - Dynamic allocation of unreserved locks
> >  - Lock, unlock, and trylock functions, with or without disabling
> irqs/preempt
> >  - Registered as a platform device driver
> 
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/hwspinlocks.c
> > @@ -0,0 +1,65 @@
> > +int __init hwspinlocks_init(void)
> > +{
> > +       int retval = 0;
> > +
> > +       struct omap_hwmod *oh;
> > +       const char *oh_name, *pdev_name;
> > +
> > +       oh_name = "spinlock";
> > +       oh = omap_hwmod_lookup(oh_name);
> > +       if (WARN_ON(oh == NULL))
> > +               return -EINVAL;
> > +
> > +       pdev_name = "hwspinlock";
> > +
> > +       /* Pass data to device initialization */
> > +       omap_device_build(pdev_name, 0, oh, NULL, 0,
> omap_spinlock_latency,
> > +                               ARRAY_SIZE(omap_spinlock_latency),
> false);
> > +
> > +       return retval;
> > +}
> > +postcore_initcall(hwspinlocks_init);
> 
> Is this initcall safe to run on all omaps or do you need some
> extra checks for it?

It is not since hwspinlock is not even present in pre-omap4. Do you suggest adding a check for " if (cpu_is_omap44xx())" in the init function ?


> 
> > --- /dev/null
> > +++ b/arch/arm/plat-omap/hwspinlock.c
> > @@ -0,0 +1,353 @@
> > +EXPORT_SYMBOL(hwspinlock_lock);
> > +EXPORT_SYMBOL(hwspinlock_trylock);
> > +EXPORT_SYMBOL(hwspinlock_unlock);
> > +EXPORT_SYMBOL(hwspinlock_request);
> > +EXPORT_SYMBOL(hwspinlock_request_specific);
> > +EXPORT_SYMBOL(hwspinlock_free);
> 
> Do we really want to export these functions? I think we're better
> off implementing low-level functions in the platform init code that
> are passed to the drivers in the platform_data.
> 
> This way the drivers stay generic, and we don't add yet another
> non-standard layer that will get misused all over the drivers.
> 
> If you really want to export these functions to the drivers,
> then all this code should live somewherew under drivers as well.

I agree. Will make this change in next revision.

> 
Thank you,
Best regards,
Hari
