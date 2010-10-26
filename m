From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 12:37:48 +0200
Message-ID: <201010261237.49386.trenn@suse.de>
References: <1287488171-25303-3-git-send-email-trenn@suse.de> <1288049630-10947-1-git-send-email-trenn@suse.de> <20101026071020.GC13036@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101026071020.GC13036@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 October 2010 09:10:20 Ingo Molnar wrote:
> 
> * Thomas Renninger <trenn@suse.de> wrote:
> 
> > Changes in V2:
> >   - Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
> >   - Use u32 instead of u64 for cpuid, state which is by far enough
> > 
> > New power trace events:
> > power:processor_idle
> > power:processor_frequency
> > power:machine_suspend
> > 
> > 
> > C-state/idle accounting events:
> >   power:power_start
> >   power:power_end
> > are replaced with:
> >   power:processor_idle
> > 
> > and
> >   power:power_frequency
> > is replaced with:
> >   power:processor_frequency
> 
> Could you please name it power:cpu_idle and power:cpu_frequency instead, for 
> shortness? We generally use 'cpu' in the kernel and for events.
Sure.
> 
> > power:machine_suspend
> 
> How will future PCI (or other device) power saving tracepoints be called?
> 
> Might be more consistent to use:
> 
>   power:cpu_idle
>   power:machine_idle
>   power:device_idle
device idle is not true. Those may be low power modes
like reduced network throughput, reduced wlan range, the device
needs not to be idle.
Device power states is probably the most complex area, if such
a thing gets introduced, it should makes sense to state
the interface experimental for some time until a wider range of
devices uses it (in contrast to these new ones
which should not change that soon anymore...).

Also machine_idle may be true, but machine_suspend sounds more
familiar and everyone immediately knows what the event is about.

-> *_idle convention is not really worth it.

> Where machine_idle is the suspend event.
Here you name it. You talk about machine_idle but you mean
the suspend event, better just name it what it is.

> > the type= field got removed from both, it was never
> > used and the type is differed by the event type itself.
> >
> > +#define PWR_EVENT_EXIT 0xFFFFFFFF
> 
> Shouldnt this be part of the POWER_ enum? (and you can write -1 there)
No, below enum will vanish, but -1 is nicer.

...

> Plus:
> 
> > +DECLARE_EVENT_CLASS(processor,
> > +
> > +	TP_PROTO(unsigned int state, unsigned int cpu_id),
> > +
> > +	TP_ARGS(state, cpu_id),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(	u32,		state		)
> > +		__field(	u32,		cpu_id		)
> 
> Trace entries can carry a cpu_id of the current processor already. Can this cpu_id 
> ever be different from that CPU id?
Yes. A core's frequency can depend on another one which
will get switched as well (by one command/MSR).
Compare with commit 6f4f2723d08534fd4e407e1e.

This can theoretically also be the case for sleep states.
Afaik such HW does not exist yet, but ACPI spec already
provides interfaces to pass these dependency from BIOS to OS.
-> We want a stable ABI and should be prepared for such stuff.

> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->state = state;
> > +		__entry->cpu_id = cpu_id;
> > +	),
> > +
> > +	TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
> > +		  (unsigned long)__entry->cpu_id)
> > +);
> > +
> > +DEFINE_EVENT(processor, processor_idle,
> > +
> > +	TP_PROTO(unsigned int state, unsigned int cpu_id),
> > +
> > +	     TP_ARGS(state, cpu_id)
> > +);
> > +
> > +#define PWR_EVENT_EXIT 0xFFFFFFFF
> > +
> > +DEFINE_EVENT(processor, processor_frequency,
> > +
> > +	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
> > +
> > +	TP_ARGS(frequency, cpu_id)
> > +);
> 
> So, we have a 'state' field in the class, which is used as 'state' by the 
> power::cpu_idle event, and as 'frequency' by the power::cpu_freq event?
Yes, is this a problem?
Definitions are a bit shorter having one power processor class.
As "frequency" is stated in frequency event definition everything should
be obvious and this one looks like the more elegant way to me.
 
> Are there any architectures that track frequency in Hz, not in kHz? If yes, might 
> there ever be a need for the frequency value to be larger than 4.29 GHz? If yes, 
> then it wont fit into u32.
drivers/cpufreq subsystem is fixed to unsigned int (cmp. include/linux/cpufreq.h):
        unsigned int            min;    /* in kHz */
        unsigned int            max;    /* in kHz */
        unsigned int            cur;    /* in kHz,
        ...
that should be fine.

> Also, might there be a future need to express different types of frequencies? For 
> example, should we decide to track turbo frequencies in Intel CPUs, how would that 
> be expressed via these events? Are there any architectures and CPUs that somehow 
> have some extra attribute to the frequency value?
I wonder whether this ever can/will work in a sane way.
Userspace can compare with:
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
everything above is turbo. So I do not think it's ever needed.
But adding an additional value at the end does not violate
userspace compatibility. This has been done with the cpuid
as well.
 
> > +TRACE_EVENT(machine_suspend,
> > +
> > +	TP_PROTO(unsigned int state),
> > +
> > +	TP_ARGS(state),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(	u32,		state		)
> > +	),
> 
> Hm, this event is not used anywhere in the submitted patches. Where is the patch 
> that adds usage, and what are the possible values for 'state'?
Jean wants to make use of it on ARM.
I also had patch for x86, I can have another look at it, Rafael
already gave me a comment on it. But on X86 you typically realize
when you suspend the machine (could imagine this is more useful on
ARM driven mobile phones and similar), still I can add it..

Values probably should be (include/linux/suspend.h):
#define PM_SUSPEND_ON       0
#define PM_SUSPEND_STANDBY  1
#define PM_SUSPEND_MEM      3
#define PM_SUSPEND_MAX      4

How this strange state Arjan talked about is passed is up
to these guys. Instead of using 0 and above pre-defined such
arch specific special states better should get passed by:

#define X86_MOORESTOWN_STANDBY_S0   0x100
..                                  0x101
#define ARM_WHATEVER_STRANGE_THING  0x200
...

     Thomas
