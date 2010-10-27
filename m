From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PERF(kernel): Cleanup power events V2
Date: Wed, 27 Oct 2010 12:22:08 +0200
Message-ID: <201010271222.08921.rjw@sisk.pl>
References: <20101026181421.GA30090@Krystal> <201010270020.35941.rjw@sisk.pl> <20101027004625.GB8219@Krystal>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57397 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760727Ab0J0KXJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 06:23:09 -0400
In-Reply-To: <20101027004625.GB8219@Krystal>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Wednesday, October 27, 2010, Mathieu Desnoyers wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > On Tuesday, October 26, 2010, Mathieu Desnoyers wrote:
> > > * Alan Stern (stern@rowland.harvard.edu) wrote:
> > > > On Tue, 26 Oct 2010, Mathieu Desnoyers wrote:
> > > > 
> > > > > * Peter Zijlstra (peterz@infradead.org) wrote:
> > > > > > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > > > > > 
> > > > > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > > > > >         atomic_inc(&dev->power.usage_count); 
> > > > > > 
> > > > > > That's terribly racy..
> > > > > 
> > > > > Looking at the original code, it looks racy even without considering the
> > > > > tracepoint:
> > > > > 
> > > > > int __pm_runtime_get(struct device *dev, bool sync)
> > > > >  {
> > > > >         int retval;
> > > > > 
> > > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > > >         atomic_inc(&dev->power.usage_count);
> > > > >         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> > > > > 
> > > > > There is no implied memory barrier after "atomic_inc". So either all these
> > > > > inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> > > > > why atomic operations are used at all, or it's a racy mess. (I vote for the
> > > > > second option)
> > > > 
> > > > I don't understand.  What's the problem?  The inc/dec are atomic 
> > > > because they are not protected by spinlocks, but everything else is 
> > > > (aside from the tracepoint, which is new).
> > > > 
> > > > > kref should certainly be used there.
> > > > 
> > > > What for?
> > > 
> > > kref has the following "get":
> > > 
> > >         atomic_inc(&kref->refcount);
> > >         smp_mb__after_atomic_inc();
> > > 
> > > What seems to be missing in __pm_runtime_get() and pm_runtime_get_noresume() is
> > > the memory barrier after the atomic increment. The atomic increment is free to
> > > be reordered into the following spinlock (within pm_request_resume or pm_request
> > > resume execution) because taking a spinlock only acts as a memory barrier with
> > > acquire semantic, not a full memory barrier.
> > >
> > > So AFAIU, the failure scenario would be as follows (sorry for the 80+ columns):
> > > 
> > > initial conditions: usage_count = 1
> > > 
> > > CPU A                                                       CPU B
> > > 1) __pm_runtime_get() (sync = true)
> > > 2)   atomic_inc(&usage_count) (not committed to memory yet)
> > > 3)   pm_runtime_resume()
> > > 4)     spin_lock_irqsave(&dev->power.lock, flags);
> > > 5)     retval = __pm_request_resume(dev);
> > 
> > If sync = true this is
> >            retval = __pm_runtime_resume(dev);
> > which drops and reacquires the spinlock.
> 
> Let's see. Upon entry in __pm_runtime_resume, the following condition holds
> (remember, the initial condition is that usage_count == 1):
> 
>   dev->power.runtime_status == RPM_ACTIVE
> 
> so retval is set to 1, which goto directly to "out", without setting "parent".
> So there does not seem to be any spinlock reacquire on this path, or am I
> misunderstanding how the "runtime_status" works ?

No, you're not I think, the above is correct.  I was referring to the scenario
in which the device was RPM_SUSPENDED initially.

> > In the meantime it sets
> > ->power.runtime_status so that __pm_runtime_idle() will fail if run at this
> > point.
> 
> runtime_status will be left at "RPM_ACTIVE", which is the appropriate value
> expected by __pm_runtime_idle.
> 
> > 
> > > 6)     (execute the body of __pm_request_resume and return)
> > > 7)                                                          __pm_runtime_put() (sync = true) 
> > > 8)                                                          if (atomic_dec_and_test(&dev->power.usage_count))
> > >                                                               (still see usage_count == 1 before decrement,
> > >                                                                thus decrement to 0)
> > > 9)                                                             pm_runtime_idle()
> > > 10)  spin_unlock_irqrestore(&dev->power.lock, flags)
> > > 11)                                                            spin_lock_irq(&dev->power.lock);
> > > 12)                                                            retval = __pm_runtime_idle(dev);
> > 
> > Moreover, __pm_runtime_idle() checks ->power.usage_count under the spinlock,
> > so it will see it's been incremented in the meantime and it will back off.
> 
> This is a subtle but important point. Yes, my scenario seems to be dealt with by
> the extra usage_count check while the spinlock is held.
> 
> How about adding a comment under this atomic_inc() stating that the memory
> barriers are implicitely dealt with by the following spinlock release and the
> extra check while spinlock is held ?
> 
> Commenting memory barriers is important, but commenting why memory barriers are
> not needed due to a subtle corner-case looks even more important.

Well, given that this discussion is taking place at all, I admit that it would
be good to document this somehow. :-)

I'll take care of that.

> (hrm, but more below considering pm_runtime_get_noresume())
> 
> > 
> > > 13)                                                            spin_unlock_irq(&dev->power.lock);
> > > 
> > > So we end up in a situation where CPU A expects the device to be resumed, but
> > > the last action performed has been to bring it to idle.
> > >
> > > A smp_mb__after_atomic_inc() between lines 2 and 3 would fix this.
> > 
> > I don't think this particular race is possible.  However, there is another one
> > that seems to be possible (in a different function) that an explicit barrier
> > will prevent from happening.
> > 
> > It's related to pm_runtime_get_noresume(), but I think it's better to put the
> > barrier where it's necessary rather than into pm_runtime_get_noresume() itself.
> 
> Quoting your following mail:
> 
> > Actually, no.  Since rpm_idle() and rpm_suspend() both check usage_count under
> > the spinlock, the race I was thinking about doesn't appear to be possible
> > after all.
> 
> Hrm, for the extra-usage_count-under-spinlock check to work, all
> pm_runtime_get_noresume() callers should grab and release the dev->power.lock
> after incrementing the usage_count. This does not seem to be the case though. So
> you might really have a race there.
> 
> So every code path that does:
> 
> 1) pm_runtime_get_noresume(dev);
> 
> 2) ...
> 
> 3) pm_runtime_put_noidle(dev);
> 
> expecting that the device state cannot be changed between 1 and 3 might be
> surprised by a concurrent call to __pm_runtime_idle() that would put a device to
> idle (or similarly with suspend) due to lack of memory barrier after the atomic
> increment.
> 
> Or am I missing something else ?

First of all, the device can always be resumed regardless of the usage_count
value.  usage_count is only used to block attempts to suspend the device and
execute its driver's ->runtime_idle() callback after it has been resumed.
That's why the "normal" pm_runtime_get() queues up a resume request.

IOW, the _get() only becomes meaningful after attempting to resume the device
(which is what I tried to tell Arjan in one of the previous messages).

Second, there's no synchronization between pm_runtime_get_noresume() and
pm_runtime_suspend/idle() etc., so calling pm_runtime_get_noresume() is
certainly insufficient to block pm_runtime_suspend/idle() regardless of memory
barriers (there may be one already in progress when _get_noresume() is called).
To limit possible status changes from happening one should (at least) run
pm_runtime_barrier() (surprise, no? ;-)) after pm_runtime_get_noresume().

So if you don't want to resume the device immediately after increasing its
usage_count (in which case it's better to use pm_runtime_get_sync()), you
should do something like this:

1) pm_runtime_get_noresume(dev);
1a) pm_runtime_barrier(dev);  // That takes care of all pending requests etc.

2) ...
 
3) pm_runtime_put_noidle(dev);

[The meaning of pm_runtime_barrier() is that all of the runtime PM activity
started before the barrier has been completed when it returns.]

There's one place in the PM core where that really is necessary, but I wouldn't
recommend anyone doing anything like it in a driver.

Thanks,
Rafael
