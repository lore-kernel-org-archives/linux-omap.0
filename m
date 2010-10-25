From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 07:11:10 -0700
Message-ID: <4CC58FFE.2050700@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <201010251303.04019.trenn@suse.de> <20101025115525.GB2237@elte.hu> <201010251455.17421.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <201010251455.17421.trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On 10/25/2010 5:55 AM, Thomas Renninger wrote:


>> But the actual code does not actually deal with any 'state 0', does it?
> It does. Not being idle is tracked by cpuidle driver as state 0
> (arch independent):
> /sys/devices/system/cpu/cpu0/cpuidle/state0/
> halt/C1 on X86 is:
> /sys/devices/system/cpu/cpu0/cpuidle/state1/
> ...
state0 is still OS idle!


the API is just weird for this, from a userspace perspective

if the kernel picks this state 0 for the idle handler, the userspace app 
gets
two events

one for going to state 0 to enter the idle state
one for going to state 0 to exit idle

but they're the exact same event in your API.

rather unpleasant from a userspace program perspective....
now I need to start tracking even more state on top in powertop to be 
able to make a guess at which of the two meanings a state 0 entry has.

