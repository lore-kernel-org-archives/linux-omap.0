From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Mon, 25 Oct 2010 18:09:42 -0700
Message-ID: <4CC62A56.7070908@linux.intel.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de> <1288049630-10947-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1288049630-10947-1-git-send-email-trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-omap@vger.kernel.org

On 10/25/2010 4:33 PM, Thomas Renninger wrote:
> Changes in V2:
>    - Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
>    - Use u32 instead of u64 for cpuid, state which is by far enough
>
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
>
>
> C-state/idle accounting events:
>    power:power_start
>    power:power_end
> are replaced with:
>    power:processor_idle
>
> and
>    power:power_frequency
> is replaced with:
>    power:processor_frequency
>
> power:machine_suspend
> is newly introduced, a first implementation
> comes from the ARM side, but it's easy to add these events
> in X86 as well if needed.
>
> the type= field got removed from both, it was never
> used and the type is differed by the event type itself.
>
> perf timechart
> userspace tool gets adjusted in a separate patch.
>

Acked-by: Arjan van de Ven <arjan@linux.intel.com>

