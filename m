From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 14:55:16 +0200
Message-ID: <201010251455.17421.trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <201010251303.04019.trenn@suse.de> <20101025115525.GB2237@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101025115525.GB2237@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Monday 25 October 2010 13:55:25 Ingo Molnar wrote:
> 
> * Thomas Renninger <trenn@suse.de> wrote:
> 
> > On Monday 25 October 2010 12:04:28 Ingo Molnar wrote:
> > > 
> > > * Thomas Renninger <trenn@suse.de> wrote:
> > > 
> > > > New power trace events:
> > > > power:processor_idle
> > > > power:processor_frequency
> > > > power:machine_suspend
> > > > 
> > > > 
> > > > C-state/idle accounting events:
> > > >   power:power_start
> > > >   power:power_end
> > > > are replaced with:
> > > >   power:processor_idle
> > > 
> > > Well, most power saving hw models (and the code implementing them) have this kind of 
> > > model:
> > > 
> > >  enter power saving mode X
> > >  exit power saving mode
> > > 
> > > Where X is some sort of 'power saving deepness' attribute, right?
> >
> > Sure.
> 
> Which is is the 'saner' model?
> 
> > But ACPI and afaik this model got picked up for PCI and other (sub-)archs as well, 
> > defines state 0 as the non-power saving mode.
> 
> But the actual code does not actually deal with any 'state 0', does it?
It does. Not being idle is tracked by cpuidle driver as state 0
(arch independent):
/sys/devices/system/cpu/cpu0/cpuidle/state0/
halt/C1 on X86 is:
/sys/devices/system/cpu/cpu0/cpuidle/state1/
...

> It enters an idle function and then exits it, right?
> 'power state' might be what is used for devices - but even there, we have:
> 
>   - enter power state X
>   - exit power state
> 
> right?
That is not true for PCI, probably others as well.
There you have D0 (being the maximum powered state) up to D3.
Same for PCI Bus Power States (B0, B1, B2, and B3).

Look at drivers/pci/pci.c:pci_raw_set_power_state()
To "exit" a power state you call:
pci_raw_set_power_state(dev, PCI_D0);

Same for suspend. "Exit" suspend is:
#define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
so on resume we enter suspend_state_t 0.

> > Same as done here with machine suspend state (S0 is back from suspend) and
> > this model should get picked up when device sleep states get tracked at
> > some time.
> >
> > It's consistent and applies to some well known specifications.
> 
> What we want it to be is for it to be the nicest, most understandable, most logical 
> model - not one matching random hardware specifications.
> 
> ( Hardware specifications only matter in so far that it should be possible to 
>   express all the known hardware state transitions via these events efficiently. )
> 
> > Also tracking processor_idle_{start,end} as a separate event makes no sense and 
> > there is no need to introduce: processor_idle_start/processor_idle_end 
> > machine_suspend_start/machine_suspend_end 
> > device_power_mode_start/device_power_mode_end events.
> 
> What do you mean by "makes no sense"?
> 
> Are they superfluous?
Yes, you do not need two different events to track one thing.

> Illogical?
Yes, A user who wants to enable processor idle tracking does
want to enable it via:
echo power:processor_idle >/sys/kernel/debug/tracing/events/enable
what do you intend to track with a:
power:power_start
event?

    Thomas
