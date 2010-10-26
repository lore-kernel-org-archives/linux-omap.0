From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 15:35:16 +0200
Message-ID: <201010261535.17240.trenn@suse.de>
References: <1287488171-25303-3-git-send-email-trenn@suse.de> <20101026115422.GA2942@elte.hu> <201010261517.44417.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <201010261517.44417.trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 October 2010 15:17:43 Thomas Renninger wrote:
> On Tuesday 26 October 2010 13:54:22 Ingo Molnar wrote:
> > 
> > * Thomas Renninger <trenn@suse.de> wrote:
...
> If cpuidle is not registered, the events you get are arch specific.
> I mean they are arch specific anyway, but with cpuidle you can
> build up an arch independent userspace framework nicely by looking
> up name/desc/power/... of an cpu_idle event in cpuidle sysfs as
> described above.
About cpuidle and cpu_idle events:
There is some oddness that:
arch specific code which registers for cpuidle has to
throw the cpu_idle enter sleep state X event
and the generic cpuidle framework triggers the "exit" event.

So as there are only cpu_idle events in drivers/idle/intel_idle.c,
but not in drivers/acpi/processor_idle.c, I expect that processor.ko
idle driver is broken and only exit states are sent.
Ideally all cpuidle events should be thrown in cpuidle.c like this:

        trace_processor_idle(target_state, smp_processor_id());
        dev->last_residency = target_state->enter(dev, target_state);                                                                     
        trace_processor_idle(PWR_EVENT_EXIT, smp_processor_id());

My patches do not touch this behavior. If, it was broken before.
I'll look at it separately.

      Thomas
