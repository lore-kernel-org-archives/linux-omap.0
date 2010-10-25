From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 16:56:04 +0200
Message-ID: <20101025145604.GB16397@elte.hu>
References: <1287488171-25303-1-git-send-email-trenn@suse.de>
 <201010251141.12429.trenn@suse.de>
 <4CC58C3C.60706@linux.intel.com>
 <201010251636.51468.trenn@suse.de>
 <4CC597FA.7080606@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CC597FA.7080606@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> On 10/25/2010 7:36 AM, Thomas Renninger wrote:
> >>I know that your new API tries to use "0" as exit, but 0 is already
> >>taken (in all power terminology at least on x86 it is) for this.
> >cpuidle indeed misuses C0 as "poll idle" state.
> >That's really bad/misleading, but nothing that can be changed easily.
> >
> >I agree shifting C0 (cpuidle)<->  POLL_IDLE event
> >and              "not idle"<->  real C0 (executing instructions)
> >or however this gets mapped makes things even worse.
> >
> >Damn, it could be that easy and straight forward, but I agree that
> >this kills the approach to trigger state 0 event if C0 is entered
> >(C0 as defined as operational mode executing instructions).
> 
> ok so we have
> 
> "C0 idle"
> and
> "C0 no longer idle"
> 
> I'd propose using the number 0 for the first one (it makes the most
> logical sense, it's the least deep idle state etc etc)
> 
> we could use "-1" or "INT_MAX" for the later
> 
> but as a user of the API I rather like a separate "we're no longer idle" event... 
> but if not, as long as things aren't ambigious I'll find a way to code around it.
>
> basically with a separate event, I demultiplex based on event number between entry 
> and exit.... with a special exit value I would just need a double demultiplex,

Hm, does not sound particularly smart.

> one on "idle" and then a second one on the state number to split between 
> entry/exit.

The thing is, in terms of CPU idle state, if the old tracepoints give us all the 
information that the new tracepoints, why dont we simply add the tracepoints to ARM 
and be done with it? No app needs to be changed in that case, etc.

Plus, lets express the suspend/resume tracepoints as suspend_enter(X)/suspend_exit() 
events as well, to keep it symmetric and consistent with the other enter/exit 
events.

The rename alone isnt a strong enough reason really. 'entering idle state X' and 
'exiting idle' is pretty much synonymous to 'enter idle state X'.

Thanks,

	Ingo
