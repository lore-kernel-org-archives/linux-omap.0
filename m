From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt handlers
Date: Mon, 22 Nov 2010 00:41:06 +0100
Message-ID: <201011220041.06440.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1011201152210.5871-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41605 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754768Ab0KUXlr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Nov 2010 18:41:47 -0500
In-Reply-To: <Pine.LNX.4.44L0.1011201152210.5871-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Saturday, November 20, 2010, Alan Stern wrote:
> On Sat, 20 Nov 2010, Rafael J. Wysocki wrote:
> 
> > On Friday, November 19, 2010, Alan Stern wrote:
> > > This patch (as1431b) makes the synchronous runtime-PM interface
> > > suitable for use in interrupt handlers.  Subsystems can call the new
> > > pm_runtime_irq_safe() function to tell the PM core that a device's
> > > runtime-PM callbacks should be invoked with interrupts disabled
> > > (runtime_suspend and runtime_resume callbacks will be invoked with the
> > > spinlock held as well).  This permits the pm_runtime_get_sync() and
> > > pm_runtime_put_sync() routines to be called from within interrupt
> > > handlers.
> > > 
> > > When a device is declared irq-safe in this way, the PM core increments
> > > the parent's usage count, so the parent will never be runtime
> > > suspended.  This prevents difficult situations in which an irq-safe
> > > device can't resume because it is forced to wait for its non-irq-safe
> > > parent.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> > > --- usb-2.6.orig/drivers/base/power/runtime.c
> > > +++ usb-2.6/drivers/base/power/runtime.c
> > > @@ -223,11 +223,19 @@ static int rpm_idle(struct device *dev, 
> > >  		callback = NULL;
> > >  
> > >  	if (callback) {
> > > -		spin_unlock_irq(&dev->power.lock);
> > > +		if (dev->power.irq_safe) {
> > > +			spin_unlock(&dev->power.lock);
> > >  
> > > -		callback(dev);
> > > +			callback(dev);
> > >  
> > > -		spin_lock_irq(&dev->power.lock);
> > > +			spin_lock(&dev->power.lock);
> > > +		} else {
> > > +			spin_unlock_irq(&dev->power.lock);
> > > +
> > > +			callback(dev);
> > > +
> > > +			spin_lock_irq(&dev->power.lock);
> > > +		}
> > >  	}
> > 
> > I didn't like this change before and I still don't like it.  Quite frankly, I'm
> > not sure I can convince Linus to pull it. :-)
> > 
> > Why don't we simply execute the callback under the spinlock in the
> > IRQ safe case?
> 
> Because it wouldn't work.  The job of the runtime_idle callback is to
> call pm_runtime_suspend when needed.  But if the callback runs under
> the spinlock then pm_runtime_suspend would hang when it tries to grab
> the lock.

Yes, in the _idle case.  I actually should have put my comment under
the change in rpm_callback(), which is what I really meant.

Moreover, I'm not sure if we need an "IRQ safe" version of _idle.  Why do
we need it, exactly?

> I don't think Linus will object to this.

Well, I guess we'll see. :-)

Thanks,
Rafael
