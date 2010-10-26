From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 13:54:22 +0200
Message-ID: <20101026115422.GA2942@elte.hu>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
 <AANLkTiknZ5t24j44hhDrbocJSJv1d=9LtvcSrd2QPcq2@mail.gmail.com>
 <20101026112129.GB27258@elte.hu>
 <201010261348.49240.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201010261348.49240.trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org


* Thomas Renninger <trenn@suse.de> wrote:

> On Tuesday 26 October 2010 13:21:29 Ingo Molnar wrote:
> > 
> > * Jean Pihet <jean.pihet@newoldbits.com> wrote:
> ..
> > > >> +#ifndef _TRACE_POWER_ENUM_
> > > >> +#define _TRACE_POWER_ENUM_
> > > >> +enum {
> > > >> +     POWER_NONE = 0,
> > > >> +     POWER_CSTATE = 1,
> > > >> +     POWER_PSTATE = 2,
> > > >> +};
> > > >> +#endif
> > > >
> > > > Since we are cleaning up all these events, those enum definitions dont really look
> > > > logical. For example, what is 'POWER_NONE'? Can a CPU have 'no power'?
> > >
> > > The enum belongs to the deprecated API so I would rather not touch it.
> > > Keeping the deprecated code isolated will make it easier to remove
> > > later.
> > 
> > So what will replace it? We still have a state field.
>
> Nothing, this is part of the cleanup.

I mean, what will go into the state field of the power:cpu_idle event?

> As you state above: POWER_NONE does not make sense at all.
> The whole thing (type= attribute that vanishes now) is
> passed to userspace, but never gets used there because the
> same info is in the event name:
> cpu_frequency <-> frequency_switch      <-> PSTATE
> cpu_idle      <-> power_start/power_end <-> CSTATE 

Ah, i see, so this 'state' enum went into the type field.

So my question is, and ignore this particular enum for now, what values go into the 
state field, which field is still kept in the new events as well.

[ I'd like to avoid us having to define a third set of power events a few years down 
  the road ;-) ]

Thanks,

	Ingo
