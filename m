From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Fri, 8 Oct 2010 21:57:07 +0200
Message-ID: <201010082157.07823.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010071318570.1753-100000@iolanthe.rowland.org> <201010080137.38422.rjw@sisk.pl> <87y6a9zhf7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57591 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959Ab0JHT5u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 15:57:50 -0400
In-Reply-To: <87y6a9zhf7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Friday, October 08, 2010, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Friday, October 08, 2010, Kevin Hilman wrote:
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >> > On Thursday, October 07, 2010, Alan Stern wrote:
> >> >> On Thu, 7 Oct 2010, Kevin Hilman wrote:
> >> >> 
> >> >> > My confusion is not about the use of spinlocks, it's a question of what
> >> >> > is being busy-waited for, and the thread that is being waited for is
> >> >> > going to complete when interrupts are disabled.
> >> >> > 
> >> >> > Sorry to be dense, but can you (re)summarize what you're proposing as I
> >> >> > think I'm getting mixed up with all the various options we've been
> >> >> > tossing around.
> >> >> > 
> >> >> > If it can work, I'm certainly in favor of a busy-wait approach as it 
> >> >> > really ensures that sync requests are handled quickly.
> >> >> 
> >> >> Okay, here's the story in a nutshell.  Allowing a subsystem's or
> >> >> driver's runtime-PM callbacks to run with interrupts disabled faces two
> >> >> obstacles:
> >> >> 
> >> >>    (1): We don't want two different CPUs to run callbacks for the
> >> >> 	same device at the same time.  So if a callback is already
> >> >> 	running on one CPU (i.e., if the device's runtime status is
> >> >> 	either SUSPENDING or RESUMING) then another CPU can't be
> >> >> 	allowed to invoke a callback.
> >> >> 
> >> >> 	Thus, you can't do a synchronous pm_runtime_resume_irq()
> >> >> 	if the device is in the middle of a suspend or resume
> >> >> 	operation.  We're left with two choices: Fail the synchronous
> >> >> 	call and force the driver to defer matters to a workqueue
> >> >> 	(possibly masking an IRQ line in the meantime), or busy-wait
> >> >> 	until the concurrent operation finishes.
> >> >> 
> >> >> 	If the PM core simply avoids releasing dev->power.lock before
> >> >> 	invoking the runtime_suspend or runtime_resume callback, the
> >> >> 	end result is almost the same as with busy-waiting.
> >> >
> >> > This is slightly more complicated, because suspend is a bit different from
> >> > resume.  I think it's generally acceptable to refuse to do a "fast path" suspend
> >> > if the device state is not RPM_ACTIVE at the moment, but refusing to do
> >> > a "fast path" resume may be more problematic (more on that later).
> >> >
> >> >>    (2): In general we can't resume a device if its parent is suspended.
> >> >> 	If the parent's runtime_resume routine needs to run with
> >> >> 	interrupts enabled then there's no way to resume the device
> >> >> 	while keeping interrupts disabled.
> >> >> 
> >> >> 	Possible solutions involve, again, deferring matters to a
> >> >> 	workqueue, or else simply not allowing the situation to arise
> >> >> 	in the first place (forbid a device to have interrupt-disabled 
> >> >> 	callbacks unless its parent does too or the parent doesn't use 
> >> >> 	runtime PM at all).
> >> >> 
> >> >> In general I'm against the solutions that require a workqueue.
> >> >
> >> > OK
> >> >
> >> >> Raphael appears to favor workqueues for (1) and be against them for (2).
> >> >
> >> > The particular case we need to handle (I think) is that some devices need to be
> >> > resumed "atomically" as a part of bringing a CPU package out of a C-like-state
> >> > (Kevin, is that correct?).  
> >> 
> >> Correct, but there is more than one problematic case.
> >> 
> >> Another problem is in devices that are not atomic with C-states, but
> >> receive wakeup IRQs while they're suspended and thus need to
> >> pm_runtime_get() from their ISRs, without having an essentially
> >> unbounded interrupt latency before the ISR can be handled.
> >> 
> >> Consider the following sequence for a given device
> >> 
> >> - device: ->runtime_suspend() /* registers not accessible */
> >> - pm_idle
> >> - IRQs disabled
> >> - idle
> >> - wakeup event
> >> - idle loop finishes
> >> - IRQs enabled
> >> - device: ->runtime_resume()
> >> 
> >> Now, consider the 'wakeup event' is an IRQ for that device.  That means
> >> as soon as IRQs are (re)enabled (and before some other activity has
> >> triggered a ->runtime_resume), the device's ISR is called.  Since it is
> >> RPM_SUSPENDED, it's registers are not accessible so it needs to do a
> >> pm_runtime_get().
> >> 
> >> The case that raised this initially was a GPIO IRQ demux, where the
> >> initial ISR is just a chained handler whichfigures out which GPIO
> >> fired and then call genirq for that IRQ.
> >> 
> >> All that being said, while I've currently described these as two
> >> different problems, the second one could be solved by converting it to
> >> the first one.  IOW, make GPIO be one of those devices that are
> >> suspended/resumed atomically with the CPU so that it is guaranteed to be
> >> awake when IRQs are re-enabled.
> >> 
> >> While that would work, I've been trying to move in the opposite
> >> direction by trying to dis-connect them from CPU idle.
> >> 
> >> > In that case not only we can't defer the resume (by
> >> > using a workqueue), but also we have to finish the resume within strict time
> >> > constraints (the time to leave the given C-like-state is one of the parameters
> >> > used by cpuidle governors to decide which state to choose).
> >> >
> >> > On the other hand, busy waiting (by looping) in the case the state is
> >> > RPM_RESUMING is as though the callbacks were executed under a spinlock and we
> >> > happened to wait on it.  I'd prefer to avoid that.  Moreover, if the state is
> >> > RPM_SUSPENDING at the time a "fast path" resume is started, we are almost
> >> > guaranteed to violate the time constraints (by busy waiting for the suspend to
> >> > complete and carrying out the resume).
> >> >
> >> > So, here's an idea:
> >> >
> >> > First, let's introduce two flags in struct dev_pm_info, irq_safe and
> >> > fast_resume.  The former has to be set so that the things above work.
> >> >
> >> > Second, let's add a new flag to pass to __pm_runtime_{suspend|resume}(),
> >> > RPM_FAST_RESUME such that if it is passed to __pm_runtime_suspend(), it
> >> > causes fast_resume to be set for the given device (if the status is already
> >> > RPM_SUSPENDED, it just sets the flag, otherwise it suspends the device
> >> > normally and then sets the flag).  Now, if fast_resume is set,
> >> > __pm_runtime_resume() has to be passed RPM_FAST_RESUME, or it will
> >> > fail (it also will fail if passed RPM_FAST_RESUME and fast_resume isn't
> >> > set).  In that case the status has to be RPM_SUSPENDED or RPM_RESUMING
> >> > (otherwise fast_resume won't be set) and if it is RPM_RESUMING, this means
> >> > that the other resume has been called with RPM_FAST_RESUME too (it would
> >> > fail otherwise), so it's fine to busy loop until the status is RPM_SUSPENDED
> >> > (it's the caller's problem to avoid that).  RPM_FAST_RESUME causes
> >> > __pm_runtime_resume() to avod turning interrupts on.
> >> >
> >> > If necessary, there may be a flag for __pm_runtime_suspend() that will
> >> > carry out "atomic" suspend, but I'm not sure if that's necessary.  Kevin?
> >> 
> >> I think we'll need both "atomic" suspend & resume.  
> >> 
> >> One of the devices I'm currently managing in this atomic fashion (inside
> >> pm_idle) is the UARTs (of course, I'm not currently using runtime PM for
> >> this, I'm calling platform-specific hooks directly since IRQs are
> >> disabled.)  For the UARTs I'm using both atomic suspend and resume,
> >> primarily for debug so I am sure UARTs are awake to see any panics
> >> during the last parts of the suspend/idle process and the early parts of
> >> the resume path.   This UART case is a bit of a hack until the driver is
> >> converted to runtime PM, but illustrates some debug related reasons we
> >> might also need atomic suspend and resume.
> >> 
> >> We also have some workarounds for hardware errata that require
> >> putting certain devices in a specific state just before (and after)
> >> idle.  The drivers for these devices will need both suspend and resume.
> >
> > OK, thanks for the info.
> >
> > Do you need "normal" resume to work after "atomic" suspend, or is it
> > sufficient that "atomic" suspend will require "atomic" resume?
> 
> hmm... while I'm definitely needing an "atomic" resume after a "normal"
> suspend, for now I can't think of a case where a "normal" resume would
> be needed after an "atomic" suspend.  All the cases where I'm currently
> using an atomic suspend also have a corresponding atomic resume.
> 
> As I write this, it wouldn't surprise me down the road to find some HW
> errata that requires the device in a specific state only before idle,
> but not caring about the state after idle.  That would be a case where
> an atomic suspend would be needed, but the resume would be "normal"
> sometime later when the device is next needed.

Still, I think it wouldn't hurt if "fast resume" is used in that case.

I'm trying to figure out if atomic suspend should always imply atomic resume.

Thanks,
Rafael
