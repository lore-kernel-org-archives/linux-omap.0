From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [linux-pm] [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 17:33:56 -0400
Message-ID: <20101026213356.GA21495@Krystal>
References: <20101026181421.GA30090@Krystal> <Pine.LNX.4.44L0.1010261447090.1634-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:53780 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760361Ab0JZVd7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 17:33:59 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010261447090.1634-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

* Alan Stern (stern@rowland.harvard.edu) wrote:
> On Tue, 26 Oct 2010, Mathieu Desnoyers wrote:
> 
> > * Peter Zijlstra (peterz@infradead.org) wrote:
> > > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > > 
> > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > >         atomic_inc(&dev->power.usage_count); 
> > > 
> > > That's terribly racy..
> > 
> > Looking at the original code, it looks racy even without considering the
> > tracepoint:
> > 
> > int __pm_runtime_get(struct device *dev, bool sync)
> >  {
> >         int retval;
> > 
> > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> >         atomic_inc(&dev->power.usage_count);
> >         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> > 
> > There is no implied memory barrier after "atomic_inc". So either all these
> > inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> > why atomic operations are used at all, or it's a racy mess. (I vote for the
> > second option)
> 
> I don't understand.  What's the problem?  The inc/dec are atomic 
> because they are not protected by spinlocks, but everything else is 
> (aside from the tracepoint, which is new).
> 
> > kref should certainly be used there.
> 
> What for?

kref has the following "get":

        atomic_inc(&kref->refcount);
        smp_mb__after_atomic_inc();

What seems to be missing in __pm_runtime_get() and pm_runtime_get_noresume() is
the memory barrier after the atomic increment. The atomic increment is free to
be reordered into the following spinlock (within pm_request_resume or pm_request
resume execution) because taking a spinlock only acts as a memory barrier with
acquire semantic, not a full memory barrier.

So AFAIU, the failure scenario would be as follows (sorry for the 80+ columns):

initial conditions: usage_count = 1

CPU A                                                       CPU B
1) __pm_runtime_get() (sync = true)
2)   atomic_inc(&usage_count) (not committed to memory yet)
3)   pm_runtime_resume()
4)     spin_lock_irqsave(&dev->power.lock, flags);
5)     retval = __pm_request_resume(dev);
6)     (execute the body of __pm_request_resume and return)
7)                                                          __pm_runtime_put() (sync = true) 
8)                                                          if (atomic_dec_and_test(&dev->power.usage_count))
                                                              (still see usage_count == 1 before decrement,
                                                               thus decrement to 0)
9)                                                             pm_runtime_idle()
10)  spin_unlock_irqrestore(&dev->power.lock, flags)
11)                                                            spin_lock_irq(&dev->power.lock);
12)                                                            retval = __pm_runtime_idle(dev);
13)                                                            spin_unlock_irq(&dev->power.lock);

So we end up in a situation where CPU A expects the device to be resumed, but
the last action performed has been to bring it to idle.

A smp_mb__after_atomic_inc() between lines 2 and 3 would fix this.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
