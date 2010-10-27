From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [linux-pm] [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 20:46:25 -0400
Message-ID: <20101027004625.GB8219@Krystal>
References: <20101026181421.GA30090@Krystal> <Pine.LNX.4.44L0.1010261447090.1634-100000@iolanthe.rowland.org> <20101026213356.GA21495@Krystal> <201010270020.35941.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:49473 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933263Ab0J0Aqa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 20:46:30 -0400
Content-Disposition: inline
In-Reply-To: <201010270020.35941.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Tuesday, October 26, 2010, Mathieu Desnoyers wrote:
> > * Alan Stern (stern@rowland.harvard.edu) wrote:
> > > On Tue, 26 Oct 2010, Mathieu Desnoyers wrote:
> > > 
> > > > * Peter Zijlstra (peterz@infradead.org) wrote:
> > > > > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > > > > 
> > > > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > > > >         atomic_inc(&dev->power.usage_count); 
> > > > > 
> > > > > That's terribly racy..
> > > > 
> > > > Looking at the original code, it looks racy even without considering the
> > > > tracepoint:
> > > > 
> > > > int __pm_runtime_get(struct device *dev, bool sync)
> > > >  {
> > > >         int retval;
> > > > 
> > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > >         atomic_inc(&dev->power.usage_count);
> > > >         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> > > > 
> > > > There is no implied memory barrier after "atomic_inc". So either all these
> > > > inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> > > > why atomic operations are used at all, or it's a racy mess. (I vote for the
> > > > second option)
> > > 
> > > I don't understand.  What's the problem?  The inc/dec are atomic 
> > > because they are not protected by spinlocks, but everything else is 
> > > (aside from the tracepoint, which is new).
> > > 
> > > > kref should certainly be used there.
> > > 
> > > What for?
> > 
> > kref has the following "get":
> > 
> >         atomic_inc(&kref->refcount);
> >         smp_mb__after_atomic_inc();
> > 
> > What seems to be missing in __pm_runtime_get() and pm_runtime_get_noresume() is
> > the memory barrier after the atomic increment. The atomic increment is free to
> > be reordered into the following spinlock (within pm_request_resume or pm_request
> > resume execution) because taking a spinlock only acts as a memory barrier with
> > acquire semantic, not a full memory barrier.
> >
> > So AFAIU, the failure scenario would be as follows (sorry for the 80+ columns):
> > 
> > initial conditions: usage_count = 1
> > 
> > CPU A                                                       CPU B
> > 1) __pm_runtime_get() (sync = true)
> > 2)   atomic_inc(&usage_count) (not committed to memory yet)
> > 3)   pm_runtime_resume()
> > 4)     spin_lock_irqsave(&dev->power.lock, flags);
> > 5)     retval = __pm_request_resume(dev);
> 
> If sync = true this is
>            retval = __pm_runtime_resume(dev);
> which drops and reacquires the spinlock.

Let's see. Upon entry in __pm_runtime_resume, the following condition holds
(remember, the initial condition is that usage_count == 1):

  dev->power.runtime_status == RPM_ACTIVE

so retval is set to 1, which goto directly to "out", without setting "parent".
So there does not seem to be any spinlock reacquire on this path, or am I
misunderstanding how the "runtime_status" works ?

> In the meantime it sets
> ->power.runtime_status so that __pm_runtime_idle() will fail if run at this
> point.

runtime_status will be left at "RPM_ACTIVE", which is the appropriate value
expected by __pm_runtime_idle.

> 
> > 6)     (execute the body of __pm_request_resume and return)
> > 7)                                                          __pm_runtime_put() (sync = true) 
> > 8)                                                          if (atomic_dec_and_test(&dev->power.usage_count))
> >                                                               (still see usage_count == 1 before decrement,
> >                                                                thus decrement to 0)
> > 9)                                                             pm_runtime_idle()
> > 10)  spin_unlock_irqrestore(&dev->power.lock, flags)
> > 11)                                                            spin_lock_irq(&dev->power.lock);
> > 12)                                                            retval = __pm_runtime_idle(dev);
> 
> Moreover, __pm_runtime_idle() checks ->power.usage_count under the spinlock,
> so it will see it's been incremented in the meantime and it will back off.

This is a subtle but important point. Yes, my scenario seems to be dealt with by
the extra usage_count check while the spinlock is held.

How about adding a comment under this atomic_inc() stating that the memory
barriers are implicitely dealt with by the following spinlock release and the
extra check while spinlock is held ?

Commenting memory barriers is important, but commenting why memory barriers are
not needed due to a subtle corner-case looks even more important.

(hrm, but more below considering pm_runtime_get_noresume())

> 
> > 13)                                                            spin_unlock_irq(&dev->power.lock);
> > 
> > So we end up in a situation where CPU A expects the device to be resumed, but
> > the last action performed has been to bring it to idle.
> >
> > A smp_mb__after_atomic_inc() between lines 2 and 3 would fix this.
> 
> I don't think this particular race is possible.  However, there is another one
> that seems to be possible (in a different function) that an explicit barrier
> will prevent from happening.
> 
> It's related to pm_runtime_get_noresume(), but I think it's better to put the
> barrier where it's necessary rather than into pm_runtime_get_noresume() itself.

Quoting your following mail:

> Actually, no.  Since rpm_idle() and rpm_suspend() both check usage_count under
> the spinlock, the race I was thinking about doesn't appear to be possible
> after all.

Hrm, for the extra-usage_count-under-spinlock check to work, all
pm_runtime_get_noresume() callers should grab and release the dev->power.lock
after incrementing the usage_count. This does not seem to be the case though. So
you might really have a race there.

So every code path that does:

1) pm_runtime_get_noresume(dev);

2) ...

3) pm_runtime_put_noidle(dev);

expecting that the device state cannot be changed between 1 and 3 might be
surprised by a concurrent call to __pm_runtime_idle() that would put a device to
idle (or similarly with suspend) due to lack of memory barrier after the atomic
increment.

Or am I missing something else ?

Thanks,

Mathieu

> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-trace-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
