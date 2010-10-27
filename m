From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [linux-pm] [PATCH] PERF(kernel): Cleanup power events V2
Date: Wed, 27 Oct 2010 08:21:15 -0400
Message-ID: <20101027122115.GA10722@Krystal>
References: <20101026181421.GA30090@Krystal> <201010270020.35941.rjw@sisk.pl> <20101027004625.GB8219@Krystal> <201010271222.08921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:43939 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755232Ab0J0MVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 08:21:20 -0400
Content-Disposition: inline
In-Reply-To: <201010271222.08921.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Wednesday, October 27, 2010, Mathieu Desnoyers wrote:
> > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > On Tuesday, October 26, 2010, Mathieu Desnoyers wrote:
> > > > * Alan Stern (stern@rowland.harvard.edu) wrote:
> > > > > On Tue, 26 Oct 2010, Mathieu Desnoyers wrote:
> > > > > 
> > > > > > * Peter Zijlstra (peterz@infradead.org) wrote:
> > > > > > > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > > > > > > 
> > > > > > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > > > > > >         atomic_inc(&dev->power.usage_count); 
> > > > > > > 
> > > > > > > That's terribly racy..
> > > > > > 
> > > > > > Looking at the original code, it looks racy even without considering the
> > > > > > tracepoint:
> > > > > > 
> > > > > > int __pm_runtime_get(struct device *dev, bool sync)
> > > > > >  {
> > > > > >         int retval;
> > > > > > 
> > > > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > > > >         atomic_inc(&dev->power.usage_count);
> > > > > >         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> > > > > > 
> > > > > > There is no implied memory barrier after "atomic_inc". So either all these
> > > > > > inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> > > > > > why atomic operations are used at all, or it's a racy mess. (I vote for the
> > > > > > second option)
> > > > > 
> > > > > I don't understand.  What's the problem?  The inc/dec are atomic 
> > > > > because they are not protected by spinlocks, but everything else is 
> > > > > (aside from the tracepoint, which is new).
> > > > > 
> > > > > > kref should certainly be used there.
> > > > > 
> > > > > What for?
> > > > 
> > > > kref has the following "get":
> > > > 
> > > >         atomic_inc(&kref->refcount);
> > > >         smp_mb__after_atomic_inc();
> > > > 
> > > > What seems to be missing in __pm_runtime_get() and pm_runtime_get_noresume() is
> > > > the memory barrier after the atomic increment. The atomic increment is free to
> > > > be reordered into the following spinlock (within pm_request_resume or pm_request
> > > > resume execution) because taking a spinlock only acts as a memory barrier with
> > > > acquire semantic, not a full memory barrier.
> > > >
> > > > So AFAIU, the failure scenario would be as follows (sorry for the 80+ columns):
> > > > 
> > > > initial conditions: usage_count = 1
> > > > 
> > > > CPU A                                                       CPU B
> > > > 1) __pm_runtime_get() (sync = true)
> > > > 2)   atomic_inc(&usage_count) (not committed to memory yet)
> > > > 3)   pm_runtime_resume()
> > > > 4)     spin_lock_irqsave(&dev->power.lock, flags);
> > > > 5)     retval = __pm_request_resume(dev);
> > > 
> > > If sync = true this is
> > >            retval = __pm_runtime_resume(dev);
> > > which drops and reacquires the spinlock.
> > 
> > Let's see. Upon entry in __pm_runtime_resume, the following condition holds
> > (remember, the initial condition is that usage_count == 1):
> > 
> >   dev->power.runtime_status == RPM_ACTIVE
> > 
> > so retval is set to 1, which goto directly to "out", without setting "parent".
> > So there does not seem to be any spinlock reacquire on this path, or am I
> > misunderstanding how the "runtime_status" works ?
> 
> No, you're not I think, the above is correct.  I was referring to the scenario
> in which the device was RPM_SUSPENDED initially.

Good to know I'm not losing it. ;-)

> 
> > > In the meantime it sets
> > > ->power.runtime_status so that __pm_runtime_idle() will fail if run at this
> > > point.
> > 
> > runtime_status will be left at "RPM_ACTIVE", which is the appropriate value
> > expected by __pm_runtime_idle.
> > 
> > > 
> > > > 6)     (execute the body of __pm_request_resume and return)
> > > > 7)                                                          __pm_runtime_put() (sync = true) 
> > > > 8)                                                          if (atomic_dec_and_test(&dev->power.usage_count))
> > > >                                                               (still see usage_count == 1 before decrement,
> > > >                                                                thus decrement to 0)
> > > > 9)                                                             pm_runtime_idle()
> > > > 10)  spin_unlock_irqrestore(&dev->power.lock, flags)
> > > > 11)                                                            spin_lock_irq(&dev->power.lock);
> > > > 12)                                                            retval = __pm_runtime_idle(dev);
> > > 
> > > Moreover, __pm_runtime_idle() checks ->power.usage_count under the spinlock,
> > > so it will see it's been incremented in the meantime and it will back off.
> > 
> > This is a subtle but important point. Yes, my scenario seems to be dealt with by
> > the extra usage_count check while the spinlock is held.
> > 
> > How about adding a comment under this atomic_inc() stating that the memory
> > barriers are implicitely dealt with by the following spinlock release and the
> > extra check while spinlock is held ?
> > 
> > Commenting memory barriers is important, but commenting why memory barriers are
> > not needed due to a subtle corner-case looks even more important.
> 
> Well, given that this discussion is taking place at all, I admit that it would
> be good to document this somehow. :-)

Yep, it's astonishing how a few comments can end up saving lots of emails from
confused reviewers. ;-)

> 
> I'll take care of that.
> 
> > (hrm, but more below considering pm_runtime_get_noresume())
> > 
> > > 
> > > > 13)                                                            spin_unlock_irq(&dev->power.lock);
> > > > 
> > > > So we end up in a situation where CPU A expects the device to be resumed, but
> > > > the last action performed has been to bring it to idle.
> > > >
> > > > A smp_mb__after_atomic_inc() between lines 2 and 3 would fix this.
> > > 
> > > I don't think this particular race is possible.  However, there is another one
> > > that seems to be possible (in a different function) that an explicit barrier
> > > will prevent from happening.
> > > 
> > > It's related to pm_runtime_get_noresume(), but I think it's better to put the
> > > barrier where it's necessary rather than into pm_runtime_get_noresume() itself.
> > 
> > Quoting your following mail:
> > 
> > > Actually, no.  Since rpm_idle() and rpm_suspend() both check usage_count under
> > > the spinlock, the race I was thinking about doesn't appear to be possible
> > > after all.
> > 
> > Hrm, for the extra-usage_count-under-spinlock check to work, all
> > pm_runtime_get_noresume() callers should grab and release the dev->power.lock
> > after incrementing the usage_count. This does not seem to be the case though. So
> > you might really have a race there.
> > 
> > So every code path that does:
> > 
> > 1) pm_runtime_get_noresume(dev);
> > 
> > 2) ...
> > 
> > 3) pm_runtime_put_noidle(dev);
> > 
> > expecting that the device state cannot be changed between 1 and 3 might be
> > surprised by a concurrent call to __pm_runtime_idle() that would put a device to
> > idle (or similarly with suspend) due to lack of memory barrier after the atomic
> > increment.
> > 
> > Or am I missing something else ?
> 
> First of all, the device can always be resumed regardless of the usage_count
> value.  usage_count is only used to block attempts to suspend the device and
> execute its driver's ->runtime_idle() callback after it has been resumed.
> That's why the "normal" pm_runtime_get() queues up a resume request.
> 
> IOW, the _get() only becomes meaningful after attempting to resume the device
> (which is what I tried to tell Arjan in one of the previous messages).

OK

> 
> Second, there's no synchronization between pm_runtime_get_noresume() and
> pm_runtime_suspend/idle() etc., so calling pm_runtime_get_noresume() is
> certainly insufficient to block pm_runtime_suspend/idle() regardless of memory
> barriers (there may be one already in progress when _get_noresume() is called).

Agreed, I was wondering how this was expected to work.

> To limit possible status changes from happening one should (at least) run
> pm_runtime_barrier() (surprise, no? ;-)) after pm_runtime_get_noresume().

Hrm, then why export pm_runtime_get_noresume() at all ? I don't feel comfortable
with some of the pm_runtime_get_noresume() callers.

> 
> So if you don't want to resume the device immediately after increasing its
> usage_count (in which case it's better to use pm_runtime_get_sync()), you
> should do something like this:
> 
> 1) pm_runtime_get_noresume(dev);
> 1a) pm_runtime_barrier(dev);  // That takes care of all pending requests etc.
> 
> 2) ...
>  
> 3) pm_runtime_put_noidle(dev);
> 
> [The meaning of pm_runtime_barrier() is that all of the runtime PM activity
> started before the barrier has been completed when it returns.]
> 
> There's one place in the PM core where that really is necessary, but I wouldn't
> recommend anyone doing anything like it in a driver.

grep -r pm_runtime_get_noresume drivers/    hands out very interesting info.

e.g.:

drivers/usb/core/drivers.c: usb_autopm_get_interface_async()

        pm_runtime_get_noresume(&intf->dev);
        s = ACCESS_ONCE(intf->dev.power.runtime_status);
        if (s == RPM_SUSPENDING || s == RPM_SUSPENDED)
                status = pm_request_resume(&intf->dev);

How is this supposed to work ?

If the ACCESS_ONCE can be reordered before the atomic_inc(), then I fear the
device can be suspended even after the check.

My point is that a get/put semantic should imply memory barriers, especially if
these are exported APIs.

Thanks,

Mathieu


> 
> Thanks,
> Rafael

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
