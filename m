From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Sun, 12 Jun 2011 00:46:36 +0200
Message-ID: <201106120046.36618.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106111227580.3439-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48826 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab1FKWqP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jun 2011 18:46:15 -0400
In-Reply-To: <Pine.LNX.4.44L0.1106111227580.3439-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@ti.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Saturday, June 11, 2011, Alan Stern wrote:
> On Fri, 10 Jun 2011, Kevin Hilman wrote:
> 
> > Alan Stern <stern@rowland.harvard.edu> writes:
> > 
> > [...]
> 
> > > If the wakeup setting is not correct, it has to be changed.  That 
> > > often implies going back to full power in order to change the 
> > > wakeup setting, then going to low power again.
> > 
> > OK, but how should this be implemented?  
> > 
> > If the device is runtime suspended at system suspend time, it implies
> > that somwhere in the system suspend path, the device has to be powered
> > on and enabled (a.k.a. runtime resumed.)
> > 
> > From a driver writer's perspective, doing a pm_runtime_get_sync() would
> > be the obvious choice, but that causes nesting of ->runtime_resume
> > callbacks within ->suspend callbacks which is apparently forbidden (or
> > rather strongly recommended against :)
> > 
> > Now, assuming the driver's suspend can't do a pm_runtime_get()...
> > 
> > In order to power on & enable the device, the driver has to essentially
> > duplicate everything that would be done by a runtime resume.
> 
> Again, this depends on the subsystem and the driver.  For example, the
> USB subsystem does call pm_runtime_resume() in order to bring a device
> back to full power if the wakeup setting needs to be changed.  This is
> done in the subsystem code, and the subsystem is designed to allow it.
> 
> (Actually, it could be improved.  In theory the driver doesn't need to
> be involved at all; a USB device's wakeup setting can be changed purely
> by the subsystem.  Nevertheless, the pm_runtime_resume call does wake
> up the driver, which then needs to be quiesced again shortly thereafter
> -- overall a waste of time.  This was the easiest approach.)
> 
> > The problem comes because this work is shared between the driver and the
> > subsystem.  IOW, it's the driver's ->suspend() callback that decides
> > whether or not the device needs to be powered-on/enabled (e.g. to
> > enable/disable wakeups), but it might be the subsystem that actually has
> > does the magic_device_set_full_power(), magic_device_enable().
> > 
> > So once the driver's ->suspend() realizes it needs to power on & enable
> > the device, it has no way to tell the subsystem to do so, wait for it to
> > happen, and then enable/disable its wakeups.
> 
> Then the subsystem should _provide_ a way, if that's how you decide to
> handle things.
> 
> > Maybe I'm being really dense, really blind, or really stubborn (or all
> > three), but it seems to be that using runtime PM calls to implement
> > these things would be the most obvious and the most readable.
> 
> Have you tried actually doing it in a situation where you control both
> the driver and the subsystem?
> 
> Basically, I think what Rafael was saying before referred to the 
> general case, where you don't know anything about the subsystem and 
> can't afford to make assumptions.  But in the real world you'll be 
> writing a driver for a particular subsystem and you'll know how that 
> subsystem works.  If the subsystem permits runtime PM calls to be 
> nested within the system PM routines, feel free to go ahead and use 
> them.

But then we get the problem that user space may echo "on" to the
device's "control" file in sysfs and the whole clever plan basically goes
south.

Moreover, on some systems devices will belong to PM domains and their
drivers may potentially be used with different PM domains on different
platforms.  This means that drivers really should not make any assumptions
about whether or not they can use runtime PM in their system suspend/resume
routines.  They can't.

Now, Kevin, I think that the problem you really want to address is this:
Suppose a driver needs to do one thing in its .runtime_suspend() callback
(e.g. "save state") and it wants to do two things in its .suspend()
callback (e.g. "quiesce device" and "save state").  Then, it seems, the
simplest approach would be to call its .runtie_suspend() routine from
its .suspend() routine (after doing the "quiesce device" thing).

So far, so good, but suppose there's a subsystem, different from the platform
bus type, or a PM domain such that it's not sufficient to call the driver's
.runtime_suspend() alone, because the subsystem-level .runtime_suspend() does
something that's necessary for "really suspending" the device.  Then,
apparently, one can simply call pm_runtime_suspend() from the driver's
.suspend() callback and that will take care of runniung the subsystem-level
.runtime_suspend() too.

Unfortunately, the problem with subsystem-level PM callbacks is that, in
general, the subsystem-level .runtime_suspend() needs to do something slightly
different that the subsystem-level system suspend callbacks.  The reason why is,
more or less, wakeup (plus the fact that hibernate callbacks need not power
down things, which is a detail and I'll ignore it from now on).  More precisely,
the set of wakeup devices for system suspend is determined by user space, while
for runtime PM all devices that can do remote wakeup should be set up to do it.
That's why, in general, the subsystem-level .runtime_suspend() may do wrong
things when it's invoked via the driver's .suspend() routine, during system
suspend.  Apart from this, of course, the subsystem-level .suspend() that
has invoked the driver's .suspend() might already do something that won't
play well with the subsystem-level .runtime_suspend(), if it's called at this
point, or even more likely the subsystem-level .suspend_noirq() that will be
run later may not play well with whatever the subsystem-level .runtime_suspend()
does.

So, we seem to be in a "Catch 22" situation, in which the driver needs to run
its .runtime_suspend() code during system suspend, but it has to do it through
the subsystem-level .runtime_suspend() that cannot be run at that time.
Fortunately, however, there is a way out of it, because the driver has an
option to point its .suspend_noirq() callback to the same routine pointed to
by its .runtime_suspend() and get the subsystem-level .suspend_noirq() to
execute it.  The subsystem-level (e.g. PM domain) callbacks, in turn, may be
designed so that this always works.

Thanks,
Rafael
