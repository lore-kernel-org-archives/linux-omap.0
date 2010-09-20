From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4 v2] omap: hwspinlock: Created driver for OMAP
 hardware spinlock.
Date: Mon, 20 Sep 2010 12:13:52 -0700
Message-ID: <20100920191351.GH4611@atomide.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50642 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab0ITTNw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 15:13:52 -0400
Content-Disposition: inline
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>
Cc: Linux Omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

* Que, Simon <sque@ti.com> [100811 17:22]:
> Created driver for OMAP hardware spinlock.
> 
>  - Reserved spinlocks for internal use
>  - Dynamic allocation of unreserved locks
>  - Lock, unlock, and trylock functions, with or without disabling irqs/preempt
>  - Registered as a platform device driver
 
> --- /dev/null
> +++ b/arch/arm/mach-omap2/hwspinlocks.c
> @@ -0,0 +1,65 @@
> +int __init hwspinlocks_init(void)
> +{
> +       int retval = 0;
> +
> +       struct omap_hwmod *oh;
> +       const char *oh_name, *pdev_name;
> +
> +       oh_name = "spinlock";
> +       oh = omap_hwmod_lookup(oh_name);
> +       if (WARN_ON(oh == NULL))
> +               return -EINVAL;
> +
> +       pdev_name = "hwspinlock";
> +
> +       /* Pass data to device initialization */
> +       omap_device_build(pdev_name, 0, oh, NULL, 0, omap_spinlock_latency,
> +                               ARRAY_SIZE(omap_spinlock_latency), false);
> +
> +       return retval;
> +}
> +postcore_initcall(hwspinlocks_init);

Is this initcall safe to run on all omaps or do you need some
extra checks for it?

> --- /dev/null
> +++ b/arch/arm/plat-omap/hwspinlock.c
> @@ -0,0 +1,353 @@
> +EXPORT_SYMBOL(hwspinlock_lock);
> +EXPORT_SYMBOL(hwspinlock_trylock);
> +EXPORT_SYMBOL(hwspinlock_unlock);
> +EXPORT_SYMBOL(hwspinlock_request);
> +EXPORT_SYMBOL(hwspinlock_request_specific);
> +EXPORT_SYMBOL(hwspinlock_free);

Do we really want to export these functions? I think we're better
off implementing low-level functions in the platform init code that
are passed to the drivers in the platform_data.

This way the drivers stay generic, and we don't add yet another
non-standard layer that will get misused all over the drivers.

If you really want to export these functions to the drivers,
then all this code should live somewherew under drivers as well.

> +static int __init hwspinlock_init(void)
> +{
> +       int retval = 0;
> +
> +       /* Register spinlock driver */
> +       retval = platform_driver_register(&hwspinlock_driver);
> +
> +       return retval;
> +}
> +postcore_initcall(hwspinlock_init);

Is this initcall safe to run on all omaps?

Tony
