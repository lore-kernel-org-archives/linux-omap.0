From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 13:03:03 +0200
Message-ID: <201010251303.04019.trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <1287488171-25303-3-git-send-email-trenn@suse.de> <20101025100428.GA24061@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101025100428.GA24061@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Monday 25 October 2010 12:04:28 Ingo Molnar wrote:
> 
> * Thomas Renninger <trenn@suse.de> wrote:
> 
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
> 
> Well, most power saving hw models (and the code implementing them) have this kind of 
> model:
> 
>  enter power saving mode X
>  exit power saving mode
> 
> Where X is some sort of 'power saving deepness' attribute, right?
Sure.
But ACPI and afaik this model got picked up for PCI and other (sub-)archs
as well, defines state 0 as the non-power saving mode.
Same as done here with machine suspend state (S0 is back from suspend) and
this model should get picked up when device sleep states get tracked at
some time.
It's consistent and applies to some well known specifications.

Also tracking processor_idle_{start,end} as a separate event
makes no sense and there is no need to introduce:
processor_idle_start/processor_idle_end
machine_suspend_start/machine_suspend_end
device_power_mode_start/device_power_mode_end
events.
Using state 0 as "exit/end", is much nicer for kernel/
userspace implementations/code and the user.

     Thomas
