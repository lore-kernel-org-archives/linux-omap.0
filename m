From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sun, 10 Oct 2010 08:41:21 +0200
Message-ID: <1286692881.1998.10.camel@laptop>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	 <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	 <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	 <20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	 <20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	 <20101008134156.GA28724@Krystal> <20101009062836.GB5517@elte.hu>
	 <AANLkTik6nO4i6xTuVYA9kBGFNpxYb70qimNcHPQKqTJ8@mail.gmail.com>
	 <AANLkTimT5Or7gLDMnmLqSzmUoPux0pXrPxUZQpFon+6_@mail.gmail.com>
	 <1286658935.23994.3366.camel@gandalf.stny.rr.com>
	 <AANLkTik8BocxyidcdmWMh2FV2LoEo_HGYGwaawasRH-O@mail.gmail.com>
	 <1286674768.23994.3915.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1286674768.23994.3915.camel@gandalf.stny.rr.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Ingo Molnar <mingo@elte.hu>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 2010-10-09 at 21:39 -0400, Steven Rostedt wrote:
> I've been hesitant in the pass from doing the TRACE_EVENT_ABI()
> before, because Peter Zijlstra (who is currently MIA) has been strongly
> against it. 

I see no point in the TRACE_EVENT_ABI() because if I need to change such
a tracepoint to reflect changes in the kernel then I will freely do so.

Even seemingly stable points like sched_switch(), which we all agree
will stay around forever (gotta have context switches on a multi-tasking
OS) will not stay stable when we add/change scheduling policies.

Sure, the prev and next task thing will stay the same, but the meaning
and interpretation of things like the prio field will not, esp when we
go add something like a deadline scheduler that isn't priority based.

So one possibility is to simply remove all that information from the
tracepoints, remove the prio and state fields, but how useful is that?

I guess what I'm saying is that even if we were to provide _ABI I see us
getting into this very same argument over and over again, making me want
to remove all this trace event muck right now before it gets worse.

