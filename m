From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sat, 09 Oct 2010 17:34:58 -0400
Message-ID: <1286660098.23994.3413.camel@gandalf.stny.rr.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	 <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	 <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	 <20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	 <20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	 <20101008134156.GA28724@Krystal> <20101009062836.GB5517@elte.hu>
	 <4CB095FA.8060803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <4CB095FA.8060803@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 2010-10-09 at 09:19 -0700, Arjan van de Ven wrote:

> > I.e. it's not an ABI in the classic sense - we do not (because we
> > cannot) guarantee the infinite availability of these events. But we can
> > guarantee that the fields do not change in some stupid, avoidable way.
> 
> also I have to say that some events are more likely to change than others
> 
> "function foo in the kernel called" is more likely to change than "the 
> processor went to THIS frequency".
> The concept of CPU frequencies has been with us fora long time and is 
> going to be there for a long time as well ......

Perhaps for basic concepts, we need a standard trace-event. Are people
willing to have a TRACE_EVENT_ABI() (it's trivial to write), and we can
mark those events with that macro that we know tools depend on.

These events can be exposed in a /sys/kernel/events/... directory, to
let tools know what what events they can rely on.

We've talked about doing this before, I've just been waiting to hear a
consensus on if we should. I know Peter Zijlstra was against the idea,
and too bad he's off gallivanting to share his input now.

-- Steve
 

