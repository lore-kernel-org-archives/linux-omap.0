From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Thu, 16 Jun 2011 02:01:46 +0200
Message-ID: <201106160201.47123.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106111227580.3439-100000@netrider.rowland.org> <201106120046.36618.rjw@sisk.pl> <87fwna3gnb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59647 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab1FPABT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 20:01:19 -0400
In-Reply-To: <87fwna3gnb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Wednesday, June 15, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
...
> > Moreover, on some systems devices will belong to PM domains and their
> > drivers may potentially be used with different PM domains on different
> > platforms.  This means that drivers really should not make any assumptions
> > about whether or not they can use runtime PM in their system suspend/resume
> > routines.  They can't.
> 
> Sure, but it's easy enough for subsystems that need protection to add
> it.  Why not just better document that driver & subsytem runtime PM
> callbacks *could* be called during a system suspend (and same for
> resume.)

Because allowing that to happen was a mistake in the first place.

> Any subsystems that want/need protection can prevent nesting
> simply with pm_runtime_get_noresume() and _put_noidle().
> 
> As I mentioned earlier in the thread, this can already happen today
> without .suspend() callbacks directly calling pm_runtime_suspend()
> (e.g. driver xfer finishes and does pm_runtime_put_sync() anytime after
> system suspend has started.)

Which is wrong.  At least, as I said in a different thread, no runtime PM
stuff should be run after .suspend() has returned for the given device.
Otherwise it will violate some assumptions regarding the conditions in which
the _noirq() callbacks are run.

> > Now, Kevin, I think that the problem you really want to address is this:
> > Suppose a driver needs to do one thing in its .runtime_suspend() callback
> > (e.g. "save state") and it wants to do two things in its .suspend()
> > callback (e.g. "quiesce device" and "save state").  Then, it seems, the
> > simplest approach would be to call its .runtie_suspend() routine from
> > its .suspend() routine (after doing the "quiesce device" thing).
> 
> Partially, yes.  But I'm not primarily concerned about the callbacks.
> Many of our simple drivers don't even need runtime PM callbacks
> (e.g. state is saved using shadow regs, or device is re-init'd for for
> every xfer etc.)
> 
> More important to me is how driver writers for embedded devices think
> about PM for embedded systems.  IMO, driver writers should think
> primarily in terms of runtime PM, and use that as the primary API for
> all driver PM. From my POV, system PM for embedded devices is just a
> special case of runtime PM.
>
> From a device driver perspective, system PM is just runtime
> PM where the "idleness" was forced and only a subset of possible wakeup
> sources are enabled.

Oh well, I wonder how much of a difference would make you think those things
are really different. ;-)

> I think this runtime-PM-centric view of the world
> is maybe where our differences of opinion are coming from.

Very much so.

> So with that perspecive, I'd like the code to reflect a
> runtime-PM-centric view as well.

And I wouldn't.

> The development effort is primarily
> focused on implementing efficient runtime PM for an _active_ system.
> When this is working, implementing system PM is easy: all that is needed
> is to enable/disable relevant wakeups and force the device to idle.
> This allows runtime PM to trigger, and the device is suspended.

No, it doesn't.  What you're trying to do is to "maunally" trigger runtime PM
when _you_ think is suitable.

...
> 
> Maybe it helps to show the flow of how I think this would work for a
> typical device during system suspend:
> 
> subsys->suspend()
>     driver->suspend()
>         /* check device_may_wakeup(), enable/disable wakeups */
>         /* quiesce HW, triggers runtime PM _put() or _suspend() */
>         subsys->runtime_suspend()
>             driver->runtime_suspend()
>                 driver_save_context()
>             /* subsys idles HW, sets low-power state */
>         /* nothing left for driver to do */
>     /* nothing left for subsys to do */

Please.  Why do you want to use subsys->runtime_suspend() _directly_ instead of
implementing .suspend_noirq() in the subsystem and allowing the core to run it
for you?  Quite frankly, I don't get it.

> > So, we seem to be in a "Catch 22" situation, in which the driver needs to run
> > its .runtime_suspend() code during system suspend, but it has to do it through
> > the subsystem-level .runtime_suspend() that cannot be run at that time.
> > Fortunately, however, there is a way out of it, because the driver has an
> > option to point its .suspend_noirq() callback to the same routine pointed to
> > by its .runtime_suspend() and get the subsystem-level .suspend_noirq() to
> > execute it.  The subsystem-level (e.g. PM domain) callbacks, in turn, may be
> > designed so that this always works.
> 
> I don't follow this part.
> 
> So you're not OK with running the subsystem or driver .runtime_suspend()
> during .suspend(), but it is OK during .suspend_noirq()? 

No.  Please see above.

> Also, where/when would the subsystem .runtime_suspend() be called?

It won't be called during system suspend at all.  It doesn't have to be
called and it really shouldn't be called at that time.

Let me put it this way.  We have runtime PM callbacks and we have system suspend
callbacks _precisely_ because we want people to use the former for runtime PM
and the latter for system suspend.  We introduced different callback pointers
for the two things _on_ _purpose_ and I totally disagree with your trying to
play games to avoid using some of them.

I hope that's clear enough.

Thanks,
Rafael
