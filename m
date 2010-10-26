From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 15:17:43 +0200
Message-ID: <201010261517.44417.trenn@suse.de>
References: <1287488171-25303-3-git-send-email-trenn@suse.de> <201010261348.49240.trenn@suse.de> <20101026115422.GA2942@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101026115422.GA2942@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 October 2010 13:54:22 Ingo Molnar wrote:
> 
> * Thomas Renninger <trenn@suse.de> wrote:
> 
..
> As you state above: POWER_NONE does not make sense at all.
> > The whole thing (type= attribute that vanishes now) is
> > passed to userspace, but never gets used there because the
> > same info is in the event name:
> > cpu_frequency <-> frequency_switch      <-> PSTATE
> > cpu_idle      <-> power_start/power_end <-> CSTATE 
> 
> Ah, i see, so this 'state' enum went into the type field.
> 
> So my question is, and ignore this particular enum for now, what values go into the 
> state field, which field is still kept in the new events as well.
Same as before:
cpu_idle:
                trace_power_start(POWER_CSTATE, 1, smp_processor_id());
+               trace_processor_idle(1, smp_processor_id());
(Ooops found a copy and paste bug in my patch where I reverted
the poll_idle event, but it should be zero...).

State in cpu_idle is identical with cpuidle registered
state. If cpuidle got registered, one should be able to calculate the
same C-state residency time and usage via state=X (cpu_idle event)
which you can grab via:
cat /sys/devices/system/cpu/cpu0/cpuidle/stateX/{time,usage}
The cpu_idle event additionally gives you the timestamps of the state
changes.
This is rather nice as userspace can grab additional info from
cpuidle sysfs layer like:
/sys/devices/system/cpu/cpu0/cpuidle/stateX/{desc,power,name}

If cpuidle is not registered, the events you get are arch specific.
I mean they are arch specific anyway, but with cpuidle you can
build up an arch independent userspace framework nicely by looking
up name/desc/power/... of an cpu_idle event in cpuidle sysfs as
described above.

   Thomas
