From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 11:41:11 +0200
Message-ID: <201010251141.12429.trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <1287488171-25303-3-git-send-email-trenn@suse.de> <4CC529AA.9070804@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <4CC529AA.9070804@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-omap@vger.kernel.org

On Monday 25 October 2010 08:54:34 Arjan van de Ven wrote:
> On 10/19/2010 4:36 AM, Thomas Renninger wrote:
> >   static void poll_idle(void)
> >   {
> > -	trace_power_start(POWER_CSTATE, 0, smp_processor_id());
> >   	local_irq_enable();
> >   	while (!need_resched())
> >   		cpu_relax();
> > -	trace_power_end(0);
> >   }
> 
> why did you remove the idle tracepoints from this one ???
Because no idle/sleep state is entered here.
State 0 does not exist or say, it means the machine is not idle.
The new event uses idle state 0 spec conform as "exit sleep state".

If this should still be trackable some kind of dummy sleep state:
#define IDLE_BUSY_LOOP 0xFE
(or similar) must get defined and passed like this:
trace_processor_idle(IDLE_BUSY_LOOP, smp_processor_id());
    cpu_relax()
trace_processor_idle(0, smp_processor_id());

I could imagine this is somewhat worth it to compare idle results
to "no idle state at all" is used.
But nobody should ever use idle=poll, comparing deep sleep states
with C1 with (idle=halt) should be sufficient?

    Thomas
