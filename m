From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 06:55:08 -0700
Message-ID: <4CC58C3C.60706@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <1287488171-25303-3-git-send-email-trenn@suse.de> <4CC529AA.9070804@linux.intel.com> <201010251141.12429.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54229 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab0JYNzK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Oct 2010 09:55:10 -0400
In-Reply-To: <201010251141.12429.trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>

On 10/25/2010 2:41 AM, Thomas Renninger wrote:
> On Monday 25 October 2010 08:54:34 Arjan van de Ven wrote:
>> On 10/19/2010 4:36 AM, Thomas Renninger wrote:
>>>    static void poll_idle(void)
>>>    {
>>> -	trace_power_start(POWER_CSTATE, 0, smp_processor_id());
>>>    	local_irq_enable();
>>>    	while (!need_resched())
>>>    		cpu_relax();
>>> -	trace_power_end(0);
>>>    }
>> why did you remove the idle tracepoints from this one ???
> Because no idle/sleep state is entered here.
> State 0 does not exist or say, it means the machine is not idle.
> The new event uses idle state 0 spec conform as "exit sleep state".
>
> If this should still be trackable some kind of dummy sleep state:
> #define IDLE_BUSY_LOOP 0xFE
> (or similar) must get defined and passed like this:
> trace_processor_idle(IDLE_BUSY_LOOP, smp_processor_id());
>      cpu_relax()
> trace_processor_idle(0, smp_processor_id());
>
> I could imagine this is somewhat worth it to compare idle results
> to "no idle state at all" is used.
> But nobody should ever use idle=poll, comparing deep sleep states
> with C1 with (idle=halt) should be sufficient?

this is not idle=poll on the command line only.
this also gets used normally, in two cases
1) during real time operations, for some short periods of time
     (think wallstreet trading)
2) by the menu governor when the next event is less than a few 
microseconds away, so short that even C1 is too much

I know that your new API tries to use "0" as exit, but 0 is already 
taken (in all power terminology at least on x86 it is) for this.

why isn't your "exit" a special define?


also, if you look at many other similar perf events, they ever separate 
entry/exit points:

process/do_process.cpp:         
perf_events->add_event("irq:irq_handler_entry");
process/do_process.cpp:         
perf_events->add_event("irq:irq_handler_exit");
process/do_process.cpp:         perf_events->add_event("irq:softirq_entry");
process/do_process.cpp:         perf_events->add_event("irq:softirq_exit");
process/do_process.cpp:         
perf_events->add_event("timer:timer_expire_entry");
process/do_process.cpp:         
perf_events->add_event("timer:timer_expire_exit");
process/do_process.cpp:         
perf_events->add_event("timer:hrtimer_expire_entry");
process/do_process.cpp:         
perf_events->add_event("timer:hrtimer_expire_exit");
process/do_process.cpp:         perf_events->add_event("power:power_start");
process/do_process.cpp:         perf_events->add_event("power:power_end");
process/do_process.cpp:         
perf_events->add_event("workqueue:workqueue_execute_start");
process/do_process.cpp:         
perf_events->add_event("workqueue:workqueue_execute_end");

so there is already an API consistency precedent
(and frankly, trying to multiplex in "exit" via a magic value is asking 
for trouble API wise)

