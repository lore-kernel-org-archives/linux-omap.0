From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 13:55:25 +0200
Message-ID: <20101025115525.GB2237@elte.hu>
References: <1287488171-25303-1-git-send-email-trenn@suse.de>
 <1287488171-25303-3-git-send-email-trenn@suse.de>
 <20101025100428.GA24061@elte.hu>
 <201010251303.04019.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201010251303.04019.trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org


* Thomas Renninger <trenn@suse.de> wrote:

> On Monday 25 October 2010 12:04:28 Ingo Molnar wrote:
> > 
> > * Thomas Renninger <trenn@suse.de> wrote:
> > 
> > > New power trace events:
> > > power:processor_idle
> > > power:processor_frequency
> > > power:machine_suspend
> > > 
> > > 
> > > C-state/idle accounting events:
> > >   power:power_start
> > >   power:power_end
> > > are replaced with:
> > >   power:processor_idle
> > 
> > Well, most power saving hw models (and the code implementing them) have this kind of 
> > model:
> > 
> >  enter power saving mode X
> >  exit power saving mode
> > 
> > Where X is some sort of 'power saving deepness' attribute, right?
>
> Sure.

Which is is the 'saner' model?

> But ACPI and afaik this model got picked up for PCI and other (sub-)archs as well, 
> defines state 0 as the non-power saving mode.

But the actual code does not actually deal with any 'state 0', does it? It enters an 
idle function and then exits it, right?

'power state' might be what is used for devices - but even there, we have:

  - enter power state X
  - exit power state

right?

> Same as done here with machine suspend state (S0 is back from suspend) and
> this model should get picked up when device sleep states get tracked at
> some time.
>
> It's consistent and applies to some well known specifications.

What we want it to be is for it to be the nicest, most understandable, most logical 
model - not one matching random hardware specifications.

( Hardware specifications only matter in so far that it should be possible to 
  express all the known hardware state transitions via these events efficiently. )

> Also tracking processor_idle_{start,end} as a separate event makes no sense and 
> there is no need to introduce: processor_idle_start/processor_idle_end 
> machine_suspend_start/machine_suspend_end 
> device_power_mode_start/device_power_mode_end events.

What do you mean by "makes no sense"?

Are they superfluous? Inefficient? Illogical?

> Using state 0 as "exit/end", is much nicer for kernel/ userspace 
> implementations/code and the user.

By that argument we should not have separate fork() and exit() syscalls either, but 
a set_process_state(1) and set_process_state(0) interface?

Thanks,

	Ingo
