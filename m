From: Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Tue, 19 Oct 2010 16:51:09 +0200
Message-ID: <20101019145109.GA4857@elte.hu>
References: <201010062334.46971.trenn@suse.de>
 <4CB095FA.8060803@linux.intel.com>
 <20101010121928.GA2688@elte.hu>
 <201010191331.03080.trenn@suse.de>
 <20101019114501.GA25371@elte.hu>
 <1287488841.1994.5.camel@twins>
 <20101019115200.GC25371@elte.hu>
 <4CBD9CDD.1010300@linux.intel.com>
 <20101019135053.GA665@elte.hu>
 <4CBDA2B6.9000405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CBDA2B6.9000405@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Renninger <trenn@suse.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> >> for some time software needs to support both, especially if popular distros 
> >> stick to an older kernel like *cough* RHEL6
> >
> > Sure, you can support both. But as long as support for the _new_ events is 
> > included in PowerTop there's no need to keep the duality upstream. Running 
> > ancient PowerTop on fresh kernels is not common.
> >
> > An old RHEL kernel will still keep on working as you can keep support for old 
> > events in PowerTop as long as you wish to.
> >
> > The new kernel also wont 'overwrite' old events with new definitions in the 
> > future, so PowerTop will keep working for as long as you want to support older 
> > kernels.
> >
> > Does that sound good?
> 
> this does not scale much long term, eg this only works if this is only done once, 
> and these points are stable afterwards. otherwise we get 25 of those different 
> "workarounds for kernel ABI breakage" into all different projects, and it becomes 
> untestable for all the poor software writers...

I have no intention for this to become common. For the 2+ years tracepoints have 
been upstream this is the first time it has come up. It's a rare occurance, and as 
long as we keep it rare and as long as we have a smooth transition process in place 
it should be good. If it becomes common we are doing something wrong ...

Alternatively you might want to review the new power events and suggest ways to add 
that extra information to existing events that suits your purposes as well. You 
added the old power tracepoints so you sure must have an opinion about it all?

Thanks,

	Ingo
