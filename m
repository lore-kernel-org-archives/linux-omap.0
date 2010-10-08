From: Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 8 Oct 2010 10:38:19 +0200
Message-ID: <20101008083819.GA22385@elte.hu>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
 <201010062334.46971.trenn@suse.de>
 <20101007150825.GB12581@Krystal>
 <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
 <20101007155816.GA5351@nowhere>
 <4CAED2F0.9080801@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CAED2F0.9080801@kernel.org>
Sender: linux-trace-users-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org


* Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On 10/07/2010 05:58 PM, Frederic Weisbecker wrote:
> > I really feel uncomfortable with this tracepoint/ABI problem....
> > Mathieu suggested we start a user library that could handle these
> > changes when they are really necessary.
> > 
> > Thoughts?
> > 
> > (Adding Tejun in Cc).
> 
> Given that tracepoints are supposed to make internal operation 
> visible.  I don't think it's a good idea to make it part of fixed ABI.

Yep, exactly.

OTOH since it exports information we can do disciplined versioning and 
extensions only - i.e. leave the old power events around, add the new 
ones with new distinct names, and phase out the old ones in a kernel 
cycle or two. It's not hard to do.

That way apps can support old kernels too (if they want to), but new 
events as well - and all in a controlled, non-disruptive manner.

More importantly, the kernel wont have cruft and will have no ABI 
restrictions - the only 'restriction' is to treat information in an 
append-only manner (i.e. change the event name if you change it 
materially) - and that's not a big deal here.

The fundamental thing about tracing/instrumentation is that there are no 
deep ABI needs: it's all about analyzing development kernels (and a few 
select versions that get the enterprise treatment) but otherwise the 
half-life of this kind of information is very short.

So we dont want to tie ourselves down with excessive ABIs.

> Maybe some core part can be put in stone but I think things like 
> internal workqueue implementation should be changeable without 
> worrying about ABI issues.

That's most definitely so! There is and will be zero back-coupling from 
workqueue tracepoints to workqueue internals. Dont worry about this.

	Ingo
