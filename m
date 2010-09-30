From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Fri, 1 Oct 2010 00:41:26 +0200
Message-ID: <201010010041.26326.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009301703270.1314-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33765 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756775Ab0I3Wmj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 18:42:39 -0400
In-Reply-To: <Pine.LNX.4.44L0.1009301703270.1314-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Thursday, September 30, 2010, Alan Stern wrote:
> On Thu, 30 Sep 2010, Rafael J. Wysocki wrote:
> 
> > > --- usb-2.6.orig/include/linux/pm.h
> > > +++ usb-2.6/include/linux/pm.h
> > > @@ -485,6 +485,7 @@ struct dev_pm_info {
> > >  	unsigned int		run_wake:1;
> > >  	unsigned int		runtime_auto:1;
> > >  	unsigned int		no_callbacks:1;
> > > +	unsigned int		callbacks_in_irq:1;
> > 
> > I kind of don't like this name.  What about irq_safe ?
> 
> Sure, that's a better name.
> 
> > > --- usb-2.6.orig/include/linux/pm_runtime.h
> > > +++ usb-2.6/include/linux/pm_runtime.h
> > > @@ -21,6 +21,7 @@
> > >  #define RPM_GET_PUT		0x04	/* Increment/decrement the
> > >  					    usage_count */
> > >  #define RPM_AUTO		0x08	/* Use autosuspend_delay */
> > > +#define RPM_IRQ			0x10	/* Don't enable interrupts */
> > >  
> > >  #ifdef CONFIG_PM_RUNTIME
> > >  
> > > @@ -40,6 +41,7 @@ extern int pm_generic_runtime_idle(struc
> > >  extern int pm_generic_runtime_suspend(struct device *dev);
> > >  extern int pm_generic_runtime_resume(struct device *dev);
> > >  extern void pm_runtime_no_callbacks(struct device *dev);
> > > +extern void pm_runtime_callbacks_in_irq(struct device *dev);
> > 
> > Perhaps this one can be called pm_runtime_irq_safe() in analogy to the struct
> > member?
> 
> Yes.
> 
> > Hmm.  This looks rather complicated.  I don't really feel good about this
> > change.  It seems to me that it might be better to actually implement
> > the _irq() helpers from scratch.  I think I'll try to do that.
> 
> That might work out better, but there will be a substantial amount of
> code duplication.  Try it and see how it turns out.

I think you're right, but I'm not sure yet.

> > Overall, it looks like there's some overlap between RPM_IRQ and
> > power.callbacks_in_irq, where the latter may influence the behavior of the
> > helpers even if RPM_IRQ is unset.
> 
> Exactly.  That was intentional.
> 
> > I think we should return error code if RPM_IRQ is used, but 
> > power.callbacks_in_irq is not set.
> 
> The patch does that.
> 
> >  If RPM_IRQ is not set, but
> > power.callbacks_in_irq is set, we should fall back to the normal behavior
> > (ie. do not avoid sleeping).
> 
> By "do not avoid sleeping", do you mean that 
> 
> 	(1) the helper functions should be allowed to sleep, or
> 
> 	(2) the callbacks should be invoked with interrupts enabled?
> 
> The patch already does (1).  By contrast, (2) isn't safe.  It means
> there is a risk of having one thread do a busy-wait with interrupts
> disabled, waiting for another thread that can sleep.

In my opinion the _irq operations should really be one-shot, without
any looping, waking up parents etc.  I mean, if the parent is not RPM_ACTIVE,
the _irq resume should immediately fail and analogously for the _irq
suspend.  And so on.  As simple as reasonably possible.

> > That's why I think it's better to change the name of power.callbacks_in_irq
> > to power.irq_safe.
> > 
> > Also I think we should refuse to set power.callbacks_in_irq for a device
> > whose partent (1) doesn't have power.callbacks_in_irq and (2) doesn't
> > have power.ignore_children set , and (3) doesn't have power.disable_depth > 0.
> > Then, once we've set power.callbacks_in_irq for a device, we should take
> > this into consideration when trying to change the parent's settings.
> 
> That's not a bad idea, but I don't know if it's necessary in practice.  
> With the current patch, if you violate this condition you will simply
> encounter an error when the PM core refuses to resume a sleeping
> parent.  Maybe we should allow violations and the resulting refusals
> but print a warning message in the system log.

Yes, see above.  I think printing a message in case a suspended parent
prevented an _irq resume from happening, for example, is a good idea.

> > There probably is more subtelties like this, but I can't see them at the moment.
> 
> There are some subtle aspects related to the interplay between idle and
> the other callbacks.  In principle, the idle and suspend callbacks
> doesn't need to have interrupts disabled -- we don't care if interrupt
> handlers can't do synchronous suspends; they only need synchronous
> resumes.  But I wanted to keep things simple, so I treated all the
> callbacks the same.

OK

> Going further, I'm still a little dubious about the whole point of
> having idle notifications at all.  I don't see why the PM core can't
> notify a subsystem that a device is idle just by calling the
> runtime_suspend routine.

Well, calling _idle is like saying "I think this device may be idle, please
consider suspending it", while calling _suspend is like saying "suspend
this device unless you can't".  I think that's enough of a difference to
have separate _idle.

> The routine doesn't have to suspend if it
> doesn't want to, and it can always schedule a delayed suspend or an
> autosuspend.  Maybe you know of a use case where having explicit idle
> notifications really does help, but I can't think of any.

A subsystem or a driver may want to schedule the suspend with a timeout
if _idle is called instead of just suspending synchronously.  The r8169 driver
actually does something similar (although a bit more complicated).

> One more thing: I'm not sure we really need the "notify" variable in
> rpm_suspend.  When a suspend callback fails, it means the device is in
> use.  Whatever is using the device should then be responsible for
> sending its own idle notification when it is finished; we shouldn't
> need to send a notification as soon as the suspend callback fails.

OK, I'm fine with removing it or calling rpm_idle(dev, RPM_ASYNC)
instead of rpm_idle(dev, 0) in there.

Thanks,
Rafael
