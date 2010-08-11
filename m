From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC v.4] omap: hwspinlock: Added hwspinlock driver
Date: Wed, 11 Aug 2010 17:44:20 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4D79679E@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0F@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E80AC50C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54611 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab0HKWoX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 18:44:23 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80AC50C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>, "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Partha and Benoit,

> > +/* Attempt to acquire a spinlock once */
> > +int hwspinlock_trylock(struct hwspinlock *handle)
> > +{
> > +       int retval = 0;
> > +
> > +       if (WARN_ON(handle == NULL))
> > +               return -EINVAL;
> > +
> > +       if (WARN_ON(in_irq()))
> > +               return -EPERM;
> > +
> > +       if (pm_runtime_get(&handle->pdev->dev) < 0)
> > +               return -ENODEV;
> > +
> > +       /* Attempt to acquire the lock by reading from it */
> > +       retval = readl(handle->lock_reg);
> > +
> > +       if (retval == HWSPINLOCK_BUSY)
> > +               pm_runtime_put(&handle->pdev->dev);
> Any reason for using pm_runtime_put instead of pm_runtime_put_sync?
> 
> Using pm_runtime_gett_sync & pm_runtime_put_sync have been recommended by
> Kevin Hilman.

Actually is there a need to call pm_runtime_put_sync for hwspinlock ? Spinlocks are used by the co-processors and we have to ensure that the device doesn't enter some low power mode without the knowledge of Co-processor. I don't think run time PM is needed for hwspinlock.

Just doing pm_runtime_get_sync at probe time for all the spinlock instances should be good.

> 

Thank you,
Best regards,
Hari
