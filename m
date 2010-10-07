From: Thomas Renninger <trenn@suse.de>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 17:49:34 +0200
Message-ID: <201010071749.35235.trenn@suse.de>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com> <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101007150825.GB12581@Krystal>
Sender: linux-trace-users-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 07 October 2010 17:08:25 Mathieu Desnoyers wrote:
> [ Adding a few more CCs, since this discussion is about a tracepoint
>   userspace ABI policy, which is a topic of general interest. ]
> 
...
> Yes, sadly this debate running in circles hurts contributors.
> 
> Thanks for the summary!
Thanks for yours!

So you (and Peter Zijlstra and some others) prefer the solution I
posted with these two patches:
[PATCH 1/2] PERF(kernel): Cleanup power events
[PATCH 2/2] PERF(userspace): Adjust perf timechart to the new power events

Those should be fine.
Ingo, can you merge them, so that Jean can finally put his ARM
specific implementation on top.

Thanks,

    Thomas
