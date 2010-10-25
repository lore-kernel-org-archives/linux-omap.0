From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 17:48:58 +0200
Message-ID: <201010251748.59218.trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <4CC597FA.7080606@linux.intel.com> <20101025145604.GB16397@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101025145604.GB16397@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On Monday 25 October 2010 16:56:04 Ingo Molnar wrote:
> 
> * Arjan van de Ven <arjan@linux.intel.com> wrote:
> > On 10/25/2010 7:36 AM, Thomas Renninger wrote:
> > ok so we have
> > 
> > "C0 idle"
Ideally this should not be called C0, but expressed
as (#define) POLL_IDLE wherever possible.

In all documentations/specs/white papers about other OSes
C0 is refered to as not being idle.
Linux mis-uses it as a self-defined idle state which
is really confusing.

> > and
> > "C0 no longer idle"
> > 
> > I'd propose using the number 0 for the first one (it makes the most
> > logical sense, it's the least deep idle state etc etc)
I would use a special number for the "Linux only" state.

> > we could use "-1" or "INT_MAX" for the later
> > but as a user of the API I rather like a separate "we're no longer idle" event... 
> > but if not, as long as things aren't ambigious I'll find a way to code around it.
> >
> > basically with a separate event, I demultiplex based on event number between entry 
> > and exit.... with a special exit value I would just need a double demultiplex,
> 
> Hm, does not sound particularly smart.
> 
> > one on "idle" and then a second one on the state number to split between 
> > entry/exit.
> 
> The thing is, in terms of CPU idle state, if the old tracepoints give us all the 
> information that the new tracepoints, why dont we simply add the tracepoints to ARM 
> and be done with it? No app needs to be changed in that case, etc.
> 
> Plus, lets express the suspend/resume tracepoints as suspend_enter(X)/suspend_exit() 
> events as well, to keep it symmetric and consistent with the other enter/exit 
> events.
> 
> The rename alone isnt a strong enough reason really. 'entering idle state X' and 
> 'exiting idle' is pretty much synonymous to 'enter idle state X'.
It's not only that, my patch also:
  - eleminates the never ever used type= field
  - uses a better name, currently it's power:power_{start,end}
    How would you name another power event...

Altogether, it should justify the proposed cleanup(s).
But with this C0 clash, I am not sure whether:
  1) as Ingo said any clean up
  2) a minimal cleanup:
       - rename power:power_{start,end} to power:processor_idle{start,end}
       - get rid of type= field
  3) or a maximum cleanup:
       - plus not use start/end events, but use one state transition
         event.
should be done.
I think best is Jean goes with current definitions.
2. is far less intrusive and if you like to have it, I can
still send another patch.

     Thomas
