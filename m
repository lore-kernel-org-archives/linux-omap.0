From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt
 handlers
Date: Fri, 1 Oct 2010 10:28:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010011012560.1813-100000@iolanthe.rowland.org>
References: <201010010041.26326.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60742 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932180Ab0JAO3A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 10:29:00 -0400
In-Reply-To: <201010010041.26326.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:

> > >  If RPM_IRQ is not set, but
> > > power.callbacks_in_irq is set, we should fall back to the normal behavior
> > > (ie. do not avoid sleeping).
> > 
> > By "do not avoid sleeping", do you mean that 
> > 
> > 	(1) the helper functions should be allowed to sleep, or
> > 
> > 	(2) the callbacks should be invoked with interrupts enabled?
> > 
> > The patch already does (1).  By contrast, (2) isn't safe.  It means
> > there is a risk of having one thread do a busy-wait with interrupts
> > disabled, waiting for another thread that can sleep.
> 
> In my opinion the _irq operations should really be one-shot, without
> any looping, waking up parents etc.  I mean, if the parent is not RPM_ACTIVE,
> the _irq resume should immediately fail and analogously for the _irq
> suspend.  And so on.  As simple as reasonably possible.

But what if the device's own status is currently SUSPENDING or
RESUMING?  Do you want to fail when that happens, instead of waiting
for the concurrent operation to finish?  There's no way to prevent this
on SMP systems, because a wakeup request can arrive while a
software-initiated resume is in progress.

> > Going further, I'm still a little dubious about the whole point of
> > having idle notifications at all.  I don't see why the PM core can't
> > notify a subsystem that a device is idle just by calling the
> > runtime_suspend routine.
> 
> Well, calling _idle is like saying "I think this device may be idle, please
> consider suspending it", while calling _suspend is like saying "suspend
> this device unless you can't".  I think that's enough of a difference to
> have separate _idle.

> A subsystem or a driver may want to schedule the suspend with a timeout
> if _idle is called instead of just suspending synchronously.  The r8169 driver
> actually does something similar (although a bit more complicated).

What you are describing is basically what autosuspend was intended to
accomplish (that is, formalizing the difference between "the device
just became idle, you should consider when to suspend it" and "the
device has been idle for a sufficiently long time, please suspend it
now").  Would the r8169 driver be simplified if it used autosuspend?

Alan Stern

