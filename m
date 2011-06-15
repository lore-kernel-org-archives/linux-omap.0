From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Wed, 15 Jun 2011 14:54:00 -0700
Message-ID: <87fwna3gnb.fsf@ti.com>
References: <Pine.LNX.4.44L0.1106111227580.3439-100000@netrider.rowland.org>
	<201106120046.36618.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53429 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752251Ab1FOVyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 17:54:07 -0400
Received: by pzk30 with SMTP id 30so760456pzk.32
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 14:54:05 -0700 (PDT)
In-Reply-To: <201106120046.36618.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun, 12 Jun 2011 00:46:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Saturday, June 11, 2011, Alan Stern wrote:
>> On Fri, 10 Jun 2011, Kevin Hilman wrote:
>> 
>> > Alan Stern <stern@rowland.harvard.edu> writes:
>> > 
>> > [...]
>> 
>> > > If the wakeup setting is not correct, it has to be changed.  That 
>> > > often implies going back to full power in order to change the 
>> > > wakeup setting, then going to low power again.
>> > 
>> > OK, but how should this be implemented?  
>> > 
>> > If the device is runtime suspended at system suspend time, it implies
>> > that somwhere in the system suspend path, the device has to be powered
>> > on and enabled (a.k.a. runtime resumed.)
>> > 
>> > From a driver writer's perspective, doing a pm_runtime_get_sync() would
>> > be the obvious choice, but that causes nesting of ->runtime_resume
>> > callbacks within ->suspend callbacks which is apparently forbidden (or
>> > rather strongly recommended against :)
>> > 
>> > Now, assuming the driver's suspend can't do a pm_runtime_get()...
>> > 
>> > In order to power on & enable the device, the driver has to essentially
>> > duplicate everything that would be done by a runtime resume.
>> 
>> Again, this depends on the subsystem and the driver.  For example, the
>> USB subsystem does call pm_runtime_resume() in order to bring a device
>> back to full power if the wakeup setting needs to be changed.  This is
>> done in the subsystem code, and the subsystem is designed to allow it.
>> 
>> (Actually, it could be improved.  In theory the driver doesn't need to
>> be involved at all; a USB device's wakeup setting can be changed purely
>> by the subsystem.  Nevertheless, the pm_runtime_resume call does wake
>> up the driver, which then needs to be quiesced again shortly thereafter
>> -- overall a waste of time.  This was the easiest approach.)
>> 
>> > The problem comes because this work is shared between the driver and the
>> > subsystem.  IOW, it's the driver's ->suspend() callback that decides
>> > whether or not the device needs to be powered-on/enabled (e.g. to
>> > enable/disable wakeups), but it might be the subsystem that actually has
>> > does the magic_device_set_full_power(), magic_device_enable().
>> > 
>> > So once the driver's ->suspend() realizes it needs to power on & enable
>> > the device, it has no way to tell the subsystem to do so, wait for it to
>> > happen, and then enable/disable its wakeups.
>> 
>> Then the subsystem should _provide_ a way, if that's how you decide to
>> handle things.
>> 
>> > Maybe I'm being really dense, really blind, or really stubborn (or all
>> > three), but it seems to be that using runtime PM calls to implement
>> > these things would be the most obvious and the most readable.
>> 
>> Have you tried actually doing it in a situation where you control both
>> the driver and the subsystem?
>> 
>> Basically, I think what Rafael was saying before referred to the 
>> general case, where you don't know anything about the subsystem and 
>> can't afford to make assumptions.  But in the real world you'll be 
>> writing a driver for a particular subsystem and you'll know how that 
>> subsystem works.  If the subsystem permits runtime PM calls to be 
>> nested within the system PM routines, feel free to go ahead and use 
>> them.
>
> But then we get the problem that user space may echo "on" to the
> device's "control" file in sysfs and the whole clever plan basically goes
> south.
>
> Moreover, on some systems devices will belong to PM domains and their
> drivers may potentially be used with different PM domains on different
> platforms.  This means that drivers really should not make any assumptions
> about whether or not they can use runtime PM in their system suspend/resume
> routines.  They can't.

Sure, but it's easy enough for subsystems that need protection to add
it.  Why not just better document that driver & subsytem runtime PM
callbacks *could* be called during a system suspend (and same for
resume.)  Any subsystems that want/need protection can prevent nesting
simply with pm_runtime_get_noresume() and _put_noidle().

As I mentioned earlier in the thread, this can already happen today
without .suspend() callbacks directly calling pm_runtime_suspend()
(e.g. driver xfer finishes and does pm_runtime_put_sync() anytime after
system suspend has started.)

> Now, Kevin, I think that the problem you really want to address is this:
> Suppose a driver needs to do one thing in its .runtime_suspend() callback
> (e.g. "save state") and it wants to do two things in its .suspend()
> callback (e.g. "quiesce device" and "save state").  Then, it seems, the
> simplest approach would be to call its .runtie_suspend() routine from
> its .suspend() routine (after doing the "quiesce device" thing).

Partially, yes.  But I'm not primarily concerned about the callbacks.
Many of our simple drivers don't even need runtime PM callbacks
(e.g. state is saved using shadow regs, or device is re-init'd for for
every xfer etc.)

More important to me is how driver writers for embedded devices think
about PM for embedded systems.  IMO, driver writers should think
primarily in terms of runtime PM, and use that as the primary API for
all driver PM.

>From my POV, system PM for embedded devices is just a special case of
runtime PM.  From a device driver perspective, system PM is just runtime
PM where the "idleness" was forced and only a subset of possible wakeup
sources are enabled.   I think this runtime-PM-centric view of the world
is maybe where our differences of opinion are coming from.

So with that perspecive, I'd like the code to reflect a
runtime-PM-centric view as well.  The development effort is primarily
focused on implementing efficient runtime PM for an _active_ system.
When this is working, implementing system PM is easy: all that is needed
is to enable/disable relevant wakeups and force the device to idle.
This allows runtime PM to trigger, and the device is suspended.

> So far, so good, but suppose there's a subsystem, different from the platform
> bus type, or a PM domain such that it's not sufficient to call the driver's
> .runtime_suspend() alone, because the subsystem-level .runtime_suspend() does
> something that's necessary for "really suspending" the device.  

Yes, for OMAP, the "really suspending" work is done by the subsystem.

> Then, apparently, one can simply call pm_runtime_suspend() from the
> driver's .suspend() callback and that will take care of runniung the
> subsystem-level .runtime_suspend() too.

Exactly.

> Unfortunately, the problem with subsystem-level PM callbacks is that, in
> general, the subsystem-level .runtime_suspend() needs to do something slightly
> different that the subsystem-level system suspend callbacks.  The reason why is,
> more or less, wakeup (plus the fact that hibernate callbacks need not power
> down things, which is a detail and I'll ignore it from now on).  More precisely,
> the set of wakeup devices for system suspend is determined by user space, while
> for runtime PM all devices that can do remote wakeup should be set up to do it.
> That's why, in general, the subsystem-level .runtime_suspend() may do wrong
> things when it's invoked via the driver's .suspend() routine, during system
> suspend.  

I still don't quite see what runtime_suspend() would do wrong in terms
of wakeups.  Do you mean that subsys->runtime_suspend() might enable
wakeups even though subsys->suspend() has just disabled them?  If so, it
should be the responsibility of the subsystem to manage this correctly.  

It would be pretty straightforward for the subsystem to know if its
.runtime_suspend() is being called during system suspend (e.g. flag set
during ->prepare, etc.) and not mess with wakeup settings.

At least on OMAP, this isn't an issue since the runtime PM path doesn't
touch wakeups at all.  Wakeup-capable devices have wakeups enabled
during device init, and remain wakeup capable during runtime PM.
Neither the driver or subsystem runtime PM callbacks do anything for
wakeups.  Only the driver (or possibly subsystem) .suspend() and
.resume() do any changing of wakeup settings.

> Apart from this, of course, the subsystem-level .suspend() that
> has invoked the driver's .suspend() might already do something that won't
> play well with the subsystem-level .runtime_suspend(), if it's called at this
> point, or even more likely the subsystem-level .suspend_noirq() that will be
> run later may not play well with whatever the subsystem-level .runtime_suspend()
> does.

Do you have something in mind about how they wouldn't play well
together?  

I'm starting from the assumption that subsystems need to be aware or
potential nesting of callbacks (which can happen today), and either take
care of it or prevent it.

If the HW really needs different handling for system suspend and runtime
PM, then I see your point, and the subsystem is free to treat them more
independently, and even to prevent them from nesting.  My point is that
for embedded systems, there is no difference at the HW other than wakeup
programming, and wakeups are easy enough to handle.

Yes, all of this means that the subsystem has to be written with this
runtime-PM-centric view in mind, but I am pursuaded that doing so is the
best model for the PM domains on embedded devices.

Put differently, with a runtime-PM-centric view of the world, the
subsystem .suspend really has nothing to do, so it is rather easy for it
to play well with .runtime_suspend().  The driver .suspend will
enable/disable wakeups, quiesce the HW, and as a result a runtime PM
transition will occur.   Then there's nothing left for the subsystem
.suspend to do.

Maybe it helps to show the flow of how I think this would work for a
typical device during system suspend:

subsys->suspend()
    driver->suspend()
        /* check device_may_wakeup(), enable/disable wakeups */
        /* quiesce HW, triggers runtime PM _put() or _suspend() */
        subsys->runtime_suspend()
            driver->runtime_suspend()
                driver_save_context()
            /* subsys idles HW, sets low-power state */
        /* nothing left for driver to do */
    /* nothing left for subsys to do */

> So, we seem to be in a "Catch 22" situation, in which the driver needs to run
> its .runtime_suspend() code during system suspend, but it has to do it through
> the subsystem-level .runtime_suspend() that cannot be run at that time.
> Fortunately, however, there is a way out of it, because the driver has an
> option to point its .suspend_noirq() callback to the same routine pointed to
> by its .runtime_suspend() and get the subsystem-level .suspend_noirq() to
> execute it.  The subsystem-level (e.g. PM domain) callbacks, in turn, may be
> designed so that this always works.

I don't follow this part.

So you're not OK with running the subsystem or driver .runtime_suspend()
during .suspend(), but it is OK during .suspend_noirq()? 

Also, where/when would the subsystem .runtime_suspend() be called?

Kevin
