From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Tue, 26 Oct 2010 01:32:02 +0200
Message-ID: <201010260132.03816.trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <201010251748.59218.trenn@suse.de> <4CC5A991.5090109@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <4CC5A991.5090109@linux.intel.com>
Content-Disposition: inline
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

@Ingo: Can you queue up 1/3, it's an independent fix.

On Monday 25 October 2010 06:00:17 pm Arjan van de Ven wrote:
> On 10/25/2010 8:48 AM, Thomas Renninger wrote:
> 
> sure naming is one thing
Yes it should get renamed to not show:
cat /sys/devices/system/cpu/cpu0/cpuidle/state0/name
C0
This is wrong and confusing

> >>> and
> >>> "C0 no longer idle"
> >>>
> >>> I'd propose using the number 0 for the first one (it makes the most
> >>> logical sense, it's the least deep idle state etc etc)
> > I would use a special number for the "Linux only" state.
> 
> that special number is 0 though..
> it makes sense in ordering, 0 < 1, 1 < 2 etc
As long as it stays a kernel and perf processor_idle internal number
it does not hurt.
But userspace tools catching the perf idle event of state 0 should never
refer to it as processor idle state 0 (or even worse C0).
Instead they should try to get the name/description of:
/sys/../state0/name
or directly refer to it as "poll idle" state.

Processor idle state C0 is not only defined as "not being idle" in the
specs, also turbostat and cpufreq-aperf use it correctly and refer to C0 when 
they show accounted "not idle" time.

Encouraged by your suggestions I send another version.
It's not a big deal to send 0xFFFFFFFF instead of 0 as "non power saving" 
state. If you can handle compatibility with it in powertop, it doesn't make 
things more complicated in kernel and perf timechart as I first thought it 
does.

      Thomas
