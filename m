From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 09:10:20 +0200
Message-ID: <20101026071020.GC13036@elte.hu>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
 <1288049630-10947-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1288049630-10947-1-git-send-email-trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org


* Thomas Renninger <trenn@suse.de> wrote:

> Changes in V2:
>   - Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
>   - Use u32 instead of u64 for cpuid, state which is by far enough
> 
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
> 
> 
> C-state/idle accounting events:
>   power:power_start
>   power:power_end
> are replaced with:
>   power:processor_idle
> 
> and
>   power:power_frequency
> is replaced with:
>   power:processor_frequency

Could you please name it power:cpu_idle and power:cpu_frequency instead, for 
shortness? We generally use 'cpu' in the kernel and for events.

> power:machine_suspend

How will future PCI (or other device) power saving tracepoints be called?

Might be more consistent to use:

  power:cpu_idle
  power:machine_idle
  power:device_idle

Where machine_idle is the suspend event.

> the type= field got removed from both, it was never
> used and the type is differed by the event type itself.
>
> +#define PWR_EVENT_EXIT 0xFFFFFFFF

Shouldnt this be part of the POWER_ enum? (and you can write -1 there)

> +#ifndef _TRACE_POWER_ENUM_
> +#define _TRACE_POWER_ENUM_
> +enum {
> +	POWER_NONE = 0,
> +	POWER_CSTATE = 1,
> +	POWER_PSTATE = 2,
> +};
> +#endif

Since we are cleaning up all these events, those enum definitions dont really look 
logical. For example, what is 'POWER_NONE'? Can a CPU have 'no power'?

Plus:

> +DECLARE_EVENT_CLASS(processor,
> +
> +	TP_PROTO(unsigned int state, unsigned int cpu_id),
> +
> +	TP_ARGS(state, cpu_id),
> +
> +	TP_STRUCT__entry(
> +		__field(	u32,		state		)
> +		__field(	u32,		cpu_id		)

Trace entries can carry a cpu_id of the current processor already. Can this cpu_id 
ever be different from that CPU id?

> +	),
> +
> +	TP_fast_assign(
> +		__entry->state = state;
> +		__entry->cpu_id = cpu_id;
> +	),
> +
> +	TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
> +		  (unsigned long)__entry->cpu_id)
> +);
> +
> +DEFINE_EVENT(processor, processor_idle,
> +
> +	TP_PROTO(unsigned int state, unsigned int cpu_id),
> +
> +	     TP_ARGS(state, cpu_id)
> +);
> +
> +#define PWR_EVENT_EXIT 0xFFFFFFFF
> +
> +DEFINE_EVENT(processor, processor_frequency,
> +
> +	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
> +
> +	TP_ARGS(frequency, cpu_id)
> +);

So, we have a 'state' field in the class, which is used as 'state' by the 
power::cpu_idle event, and as 'frequency' by the power::cpu_freq event?

Are there any architectures that track frequency in Hz, not in kHz? If yes, might 
there ever be a need for the frequency value to be larger than 4.29 GHz? If yes, 
then it wont fit into u32.

Also, might there be a future need to express different types of frequencies? For 
example, should we decide to track turbo frequencies in Intel CPUs, how would that 
be expressed via these events? Are there any architectures and CPUs that somehow 
have some extra attribute to the frequency value?

> +TRACE_EVENT(machine_suspend,
> +
> +	TP_PROTO(unsigned int state),
> +
> +	TP_ARGS(state),
> +
> +	TP_STRUCT__entry(
> +		__field(	u32,		state		)
> +	),

Hm, this event is not used anywhere in the submitted patches. Where is the patch 
that adds usage, and what are the possible values for 'state'?

	Ingo
