From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 16:51:53 +0200
Message-ID: <201010251651.53467.trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <201010251455.17421.trenn@suse.de> <4CC58FFE.2050700@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <4CC58FFE.2050700@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On Monday 25 October 2010 16:11:10 Arjan van de Ven wrote:
> On 10/25/2010 5:55 AM, Thomas Renninger wrote:
> 
> 
> >> But the actual code does not actually deal with any 'state 0', does it?
> > It does. Not being idle is tracked by cpuidle driver as state 0
> > (arch independent):
> > /sys/devices/system/cpu/cpu0/cpuidle/state0/
> > halt/C1 on X86 is:
> > /sys/devices/system/cpu/cpu0/cpuidle/state1/
> > ...
> state0 is still OS idle!
Yes, I just realized that.
Which is very unfortunate.
The whole cpuidle stuff is based on ACPI C-states and
cat /sys/devices/system/cpu/cpu0/cpuidle/state0/name
C0
is plain wrong if it's used as "poll idle" time.
C0 is defined as (in the ACPI spec):
----------
2.5 Processor Power State Definitions
C0 Processor Power State
While the processor is in this state, it executes instructions.
----------

> the API is just weird for this, from a userspace perspective
> 
> if the kernel picks this state 0 for the idle handler, the userspace app 
> gets
> two events
> 
> one for going to state 0 to enter the idle state
> one for going to state 0 to exit idle
> 
> but they're the exact same event in your API.
> 
> rather unpleasant from a userspace program perspective....
Yeah. But the re-definition of C0 being "Linux poll idle"
will confuse users as well. Not sure whether this should get
touched, though.

Thanks for clarification, I wasn't aware of that...

    Thomas
