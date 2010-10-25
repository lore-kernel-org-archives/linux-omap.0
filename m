From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 22:33:23 +0200
Message-ID: <201010252233.23960.rjw@sisk.pl>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <201010251303.04019.trenn@suse.de> <4CC58CEE.9080507@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <4CC58CEE.9080507@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On Monday, October 25, 2010, Arjan van de Ven wrote:
> On 10/25/2010 4:03 AM, Thomas Renninger wrote:
> > On Monday 25 October 2010 12:04:28 Ingo Molnar wrote:
> >> * Thomas Renninger<trenn@suse.de>  wrote:
> >>
> >>> New power trace events:
> >>> power:processor_idle
> >>> power:processor_frequency
> >>> power:machine_suspend
> >>>
> >>>
> >>> C-state/idle accounting events:
> >>>    power:power_start
> >>>    power:power_end
> >>> are replaced with:
> >>>    power:processor_idle
> >> Well, most power saving hw models (and the code implementing them) have this kind of
> >> model:
> >>
> >>   enter power saving mode X
> >>   exit power saving mode
> >>
> >> Where X is some sort of 'power saving deepness' attribute, right?
> > Sure.
> > But ACPI and afaik this model got picked up for PCI and other (sub-)archs
> > as well, defines state 0 as the non-power saving mode.
> 
> correct ,... "C0" is not power efficient... but it's still a valid OS 
> idle state!
> Also tracking processor_idle_{start,end} as a separate event!
> 
> same for "S0"... S0 as standby state is still valid... sure it doesn't 
> save you much power... but that does not mean it's not valid.

If you mean ACPI S0, it is not a standby state.  It actually is the full-power
state.

> (as indication, the Intel Moorestown platform, which is currently in 
> production and available to OEMs, has such a S0 standby state)

Another naming confusion.  How smart.

> > makes no sense and there is no need to introduce:
> > processor_idle_start/processor_idle_end
> > machine_suspend_start/machine_suspend_end
> > device_power_mode_start/device_power_mode_end
> > events.
> > Using state 0 as "exit/end", is much nicer for kernel/
> > userspace implementations/code and the user.
> actually no; having written a few of these in userspace so far, having a 
> separate end event is easier to deal with;
> the actions you take on entry and exit are complete separate code paths.

That's correct, unless you go directly from one low-power state to another
(which is possible for example for PCI).  We don't do that at the moment,
but it's possible in principle and we may want to start doing that at one
point.

Thanks,
Rafael
