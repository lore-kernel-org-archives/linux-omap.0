From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
	interrupt handlers
Date: Fri, 1 Oct 2010 23:23:47 +0200
Message-ID: <201010012323.47697.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010011012560.1813-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1010011012560.1813-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, October 01, 2010, Alan Stern wrote:
> On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:
> 
> > > >  If RPM_IRQ is not set, but
> > > > power.callbacks_in_irq is set, we should fall back to the normal behavior
> > > > (ie. do not avoid sleeping).
> > > 
> > > By "do not avoid sleeping", do you mean that 
> > > 
> > > 	(1) the helper functions should be allowed to sleep, or
> > > 
> > > 	(2) the callbacks should be invoked with interrupts enabled?
> > > 
> > > The patch already does (1).  By contrast, (2) isn't safe.  It means
> > > there is a risk of having one thread do a busy-wait with interrupts
> > > disabled, waiting for another thread that can sleep.
> > 
> > In my opinion the _irq operations should really be one-shot, without
> > any looping, waking up parents etc.  I mean, if the parent is not RPM_ACTIVE,
> > the _irq resume should immediately fail and analogously for the _irq
> > suspend.  And so on.  As simple as reasonably possible.
> 
> But what if the device's own status is currently SUSPENDING or
> RESUMING?  Do you want to fail when that happens, instead of waiting
> for the concurrent operation to finish?

Yes.  IMO an _irq() suspend should only be allowed if the status is RPM_ACTIVE
and an _irq() resume should fail if the status is not RPM_SUSPENDED.  The
error code returned should depend on the situation, though.

> There's no way to prevent this
> on SMP systems, because a wakeup request can arrive while a
> software-initiated resume is in progress.

I know that. :-)

> > > Going further, I'm still a little dubious about the whole point of
> > > having idle notifications at all.  I don't see why the PM core can't
> > > notify a subsystem that a device is idle just by calling the
> > > runtime_suspend routine.
> > 
> > Well, calling _idle is like saying "I think this device may be idle, please
> > consider suspending it", while calling _suspend is like saying "suspend
> > this device unless you can't".  I think that's enough of a difference to
> > have separate _idle.
> 
> > A subsystem or a driver may want to schedule the suspend with a timeout
> > if _idle is called instead of just suspending synchronously.  The r8169 driver
> > actually does something similar (although a bit more complicated).
> 
> What you are describing is basically what autosuspend was intended to
> accomplish (that is, formalizing the difference between "the device
> just became idle, you should consider when to suspend it" and "the
> device has been idle for a sufficiently long time, please suspend it
> now").  Would the r8169 driver be simplified if it used autosuspend?

At the moment it suspends when the network cable is removed from the device
and the hack I mentioned is used during the resume after the cable has been
reinserted (it checks if the cable is still there and schedules suspend if not).

If we removed the immediate idle notification after a successful resume, it
might need to be reworked slightly.

Thanks,
Rafael
