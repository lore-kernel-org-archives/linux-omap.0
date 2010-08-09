From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Issues with calling pm_runtime functions in
 platform_pm_suspend_noirq/IRQ disabled context.
Date: Mon, 9 Aug 2010 21:55:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C65531A3@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED0FDF@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1008061305360.5732@utopia.booyaka.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E800BD63@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1008082350130.8958@utopia.booyaka.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E800C34D@dbde02.ent.ti.com>
	<871va7n6pe.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C6553186@dbde02.ent.ti.com>
 <87tyn3lr1j.fsf@deeprootsystems.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C6553199@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36493 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983Ab0HIQZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 12:25:49 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C6553199@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Monday, August 09, 2010 9:43 PM
> To: Kevin Hilman
> Cc: Basak, Partha; Paul Walmsley; linux-omap@vger.kernel.org; Kalliguddi,
> Hema; Raja, Govindraj; Varadarajan, Charulatha
> Subject: RE: Issues with calling pm_runtime functions in
> platform_pm_suspend_noirq/IRQ disabled context.
> 

[Snip]

> > >> pm_runtime_put_sync()
> > >>     __pm_runtime_put()
> > >>         pm_runtime_idle()
> > >>             spin_lock_irq()
> > >>             __pm_runtime_idle()
> > >>                 spin_unlock_irq()   <--- interrupts unconditionally
> > >> enabled
> > >>                 dev->bus->pm->runtime_idle()
> > >>                 spin_lock_irq()
> > >>              spin_unlock_irq()
> > >>
> > >> To fix, use the save/restore versions of the spinlock API.
> > >>
> > > Similar thing was thought when this problem was encountered but
> > > there was a concern that it may lead to interrupts are being disable
> > > for longer times
> >
> > why?
> >
> > if interrupts are enabled when this API is used, this patch doesn't
> > change the amount of time interrupts are disabled.
> >
> > if interrupts are already disabled, then you *want* interrupts to be
> > disabled for the entire time.
> >
> Correct me if I am off the track here.
> 
> If these API's are _always_ called with interrupt disabled then probably
> we don't even need the new spinlock version locking.
> 
> Considering the API is called with interrupt enabled.
> 
> int pm_runtime_suspend(struct device *dev)
>  {
>  	int retval;
> 
> 	spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	retval = __pm_runtime_suspend(dev, false);
> 	spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);c
> 
> The interrupt on local cpu remain disabled till "__pm_runtime_suspend"
> does its job and re-enables the interrupts. No?
> 
> 
Sorry Kevin for oversight. The existing used lock is already a irq version.
You are right. This change should be fine. Some how I was under impression
the existing code was using plain spin lock version.

Really sorry about the noise.

Regards,
Santosh

