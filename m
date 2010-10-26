From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 14:50:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010261447090.1634-100000@iolanthe.rowland.org>
References: <20101026181421.GA30090@Krystal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101026181421.GA30090@Krystal>
Sender: linux-trace-users-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 26 Oct 2010, Mathieu Desnoyers wrote:

> * Peter Zijlstra (peterz@infradead.org) wrote:
> > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > 
> > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > >         atomic_inc(&dev->power.usage_count); 
> > 
> > That's terribly racy..
> 
> Looking at the original code, it looks racy even without considering the
> tracepoint:
> 
> int __pm_runtime_get(struct device *dev, bool sync)
>  {
>         int retval;
> 
> +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
>         atomic_inc(&dev->power.usage_count);
>         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> 
> There is no implied memory barrier after "atomic_inc". So either all these
> inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> why atomic operations are used at all, or it's a racy mess. (I vote for the
> second option)

I don't understand.  What's the problem?  The inc/dec are atomic 
because they are not protected by spinlocks, but everything else is 
(aside from the tracepoint, which is new).

> kref should certainly be used there.

What for?

Alan Stern

