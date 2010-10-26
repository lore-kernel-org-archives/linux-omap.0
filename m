From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PERF(kernel): Cleanup power events V2
Date: Wed, 27 Oct 2010 00:20:35 +0200
Message-ID: <201010270020.35941.rjw@sisk.pl>
References: <20101026181421.GA30090@Krystal> <Pine.LNX.4.44L0.1010261447090.1634-100000@iolanthe.rowland.org> <20101026213356.GA21495@Krystal>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101026213356.GA21495@Krystal>
Sender: linux-trace-users-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Alan Stern <stern@rowland.harvard.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On Tuesday, October 26, 2010, Mathieu Desnoyers wrote:
> * Alan Stern (stern@rowland.harvard.edu) wrote:
> > On Tue, 26 Oct 2010, Mathieu Desnoyers wrote:
> > 
> > > * Peter Zijlstra (peterz@infradead.org) wrote:
> > > > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > > > 
> > > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > > >         atomic_inc(&dev->power.usage_count); 
> > > > 
> > > > That's terribly racy..
> > > 
> > > Looking at the original code, it looks racy even without considering the
> > > tracepoint:
> > > 
> > > int __pm_runtime_get(struct device *dev, bool sync)
> > >  {
> > >         int retval;
> > > 
> > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > >         atomic_inc(&dev->power.usage_count);
> > >         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> > > 
> > > There is no implied memory barrier after "atomic_inc". So either all these
> > > inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> > > why atomic operations are used at all, or it's a racy mess. (I vote for the
> > > second option)
> > 
> > I don't understand.  What's the problem?  The inc/dec are atomic 
> > because they are not protected by spinlocks, but everything else is 
> > (aside from the tracepoint, which is new).
> > 
> > > kref should certainly be used there.
> > 
> > What for?
> 
> kref has the following "get":
> 
>         atomic_inc(&kref->refcount);
>         smp_mb__after_atomic_inc();
> 
> What seems to be missing in __pm_runtime_get() and pm_runtime_get_noresume() is
> the memory barrier after the atomic increment. The atomic increment is free to
> be reordered into the following spinlock (within pm_request_resume or pm_request
> resume execution) because taking a spinlock only acts as a memory barrier with
> acquire semantic, not a full memory barrier.
>
> So AFAIU, the failure scenario would be as follows (sorry for the 80+ columns):
> 
> initial conditions: usage_count = 1
> 
> CPU A                                                       CPU B
> 1) __pm_runtime_get() (sync = true)
> 2)   atomic_inc(&usage_count) (not committed to memory yet)
> 3)   pm_runtime_resume()
> 4)     spin_lock_irqsave(&dev->power.lock, flags);
> 5)     retval = __pm_request_resume(dev);

If sync = true this is
           retval = __pm_runtime_resume(dev);
which drops and reacquires the spinlock.  In the meantime it sets
->power.runtime_status so that __pm_runtime_idle() will fail if run at this
point.

> 6)     (execute the body of __pm_request_resume and return)
> 7)                                                          __pm_runtime_put() (sync = true) 
> 8)                                                          if (atomic_dec_and_test(&dev->power.usage_count))
>                                                               (still see usage_count == 1 before decrement,
>                                                                thus decrement to 0)
> 9)                                                             pm_runtime_idle()
> 10)  spin_unlock_irqrestore(&dev->power.lock, flags)
> 11)                                                            spin_lock_irq(&dev->power.lock);
> 12)                                                            retval = __pm_runtime_idle(dev);

Moreover, __pm_runtime_idle() checks ->power.usage_count under the spinlock,
so it will see it's been incremented in the meantime and it will back off.

> 13)                                                            spin_unlock_irq(&dev->power.lock);
> 
> So we end up in a situation where CPU A expects the device to be resumed, but
> the last action performed has been to bring it to idle.
>
> A smp_mb__after_atomic_inc() between lines 2 and 3 would fix this.

I don't think this particular race is possible.  However, there is another one
that seems to be possible (in a different function) that an explicit barrier
will prevent from happening.

It's related to pm_runtime_get_noresume(), but I think it's better to put the
barrier where it's necessary rather than into pm_runtime_get_noresume() itself.

Thanks,
Rafael
