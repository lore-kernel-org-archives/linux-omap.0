From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 16:36:50 +0200
Message-ID: <201010251636.51468.trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <201010251141.12429.trenn@suse.de> <4CC58C3C.60706@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <4CC58C3C.60706@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-omap@vger.kernel.org

On Monday 25 October 2010 15:55:08 Arjan van de Ven wrote:
> On 10/25/2010 2:41 AM, Thomas Renninger wrote:
> > On Monday 25 October 2010 08:54:34 Arjan van de Ven wrote:
> >> On 10/19/2010 4:36 AM, Thomas Renninger wrote:
> >>>    static void poll_idle(void)
> >>>    {
> >>> -	trace_power_start(POWER_CSTATE, 0, smp_processor_id());
> >>>    	local_irq_enable();
> >>>    	while (!need_resched())
> >>>    		cpu_relax();
> >>> -	trace_power_end(0);
> >>>    }
> >> why did you remove the idle tracepoints from this one ???
> > Because no idle/sleep state is entered here.
> > State 0 does not exist or say, it means the machine is not idle.
> > The new event uses idle state 0 spec conform as "exit sleep state".
> >
> > If this should still be trackable some kind of dummy sleep state:
> > #define IDLE_BUSY_LOOP 0xFE
> > (or similar) must get defined and passed like this:
> > trace_processor_idle(IDLE_BUSY_LOOP, smp_processor_id());
> >      cpu_relax()
> > trace_processor_idle(0, smp_processor_id());
> >
> > I could imagine this is somewhat worth it to compare idle results
> > to "no idle state at all" is used.
> > But nobody should ever use idle=poll, comparing deep sleep states
> > with C1 with (idle=halt) should be sufficient?
> 
> this is not idle=poll on the command line only.
> this also gets used normally, in two cases
> 1) during real time operations, for some short periods of time
>      (think wallstreet trading)
> 2) by the menu governor when the next event is less than a few 
> microseconds away, so short that even C1 is too much
> 
> I know that your new API tries to use "0" as exit, but 0 is already 
> taken (in all power terminology at least on x86 it is) for this.
cpuidle indeed misuses C0 as "poll idle" state.
That's really bad/misleading, but nothing that can be changed easily.

I agree shifting C0 (cpuidle) <-> POLL_IDLE event
and              "not idle"   <-> real C0 (executing instructions)
or however this gets mapped makes things even worse.

Damn, it could be that easy and straight forward, but I agree that
this kills the approach to trigger state 0 event if C0 is entered
(C0 as defined as operational mode executing instructions).

     Thomas
