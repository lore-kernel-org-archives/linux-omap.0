From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 14:15:55 -0400
Message-ID: <1285179355.26872.27.camel@gandalf.stny.rr.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	 <201009171736.14170.trenn@suse.de>	<20100917162412.GB3341@elte.hu>
	 <201009180026.59482.trenn@suse.de>
	 <AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com>
	 <4C9A21AD.1000800@linux.intel.com>
	 <AANLkTim6B+Je=LykgJb9=0vK5Br1rkft619BRJkBcHdP@mail.gmail.com>
	 <4C9A2FB3.105@linux.intel.com> <1285173835.2275.1026.camel@laptop>
	 <4C9A37AE.2010509@linux.intel.com>  <1285176629.2275.1033.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1285176629.2275.1033.camel@laptop>
Sender: linux-trace-users-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Jean Pihet <jean.pihet@newoldbits.com>, Thomas Renninger <trenn@suse.de>, Ingo Molnar <mingo@elte.hu>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-09-22 at 19:30 +0200, Peter Zijlstra wrote:
> On Wed, 2010-09-22 at 10:06 -0700, Arjan van de Ven wrote:
> 

> That said, I really didn't read this discussion much, but your stance
> seems to be that any tracepoint you use must stay valid, and I object to
> that.

We could add a TRACE_EVENT_ABI() as Ingo has been suggesting. If
anything, it could mean that the given tracepoint will always have the
same name. And perhaps the data it holds will always be there, but may
also be extended.

> 
> What will do you do when we include a new scheduling policy and all the
> scheduler tracepoints need to change? (yes that's really going to
> happen)

The tracepoint sched_switch should stay the same. We may add more data,
but the comm, pid, prio => comm, pid, prio, I don't see going away.

> 
> I'm not going to carry double tracepoints, and I'm not going to not
> merge that policy. 

Not sure what you mean by "double tracepoints"

-- Steve


