From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sat, 09 Oct 2010 21:39:28 -0400
Message-ID: <1286674768.23994.3915.camel@gandalf.stny.rr.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTik8BocxyidcdmWMh2FV2LoEo_HGYGwaawasRH-O@mail.gmail.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pierre Tardy <tardyp@gmail.com>, Ingo Molnar <mingo@elte.hu>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 2010-10-09 at 16:20 -0700, Linus Torvalds wrote:
> On Sat, Oct 9, 2010 at 2:15 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > The difference here compared to all other user interfaces, is that this
> > interface has the sole purpose of showing what is happening inside the
> > kernel.
> 
> Bogus and dishonest argument.
> 
> Listen to yourself, and read this thread again.
> 
> The thread was about doing some kind of open-source library to allow
> non-open-source access to these events, and keeping backwards
> compatibility in user space. In fact, that is what you yourself said.
> 
> So you claimed it could be backwards-compatible. If that's the case,
> then there is no excuse for not being so in the kernel.
> 
> You can't have it both ways. Stop the f*cking waffling.

Let me rephrase it then, and lets forget about the library. I was just
brain storming ideas.

I'm all for labeling specific trace points as "ABI", such that, these
trace points have had sufficient thought and are not expected to change
in the near future. But I'm against the idea that any tracepoint that
has been shown to userspace can be considered stable.

With or without libraries, I'm for two kinds of interfaces: One that is
stable and has been thoroughly thought through, and one that is free for
the maintainers to have an interface to let them see what is happening
in the kernel, even on a production system, but be able to change them
whenever they feel the need.

That's the basis of my idea. A stable backward-compatible interface, and
an interface that is unstable for developers. Whether we put the stable
interface into a library (to keep the ugliness from developers, which
you obviously do not like), or two, distinctly label the tracepoint as
ABI, to let the developers and everyone else know what tracepoints an
application can count on and what ones they should not.

Thus my waffling is really wanting both, a stable ABI and an unstable
one. I've been hesitant in the pass from doing the TRACE_EVENT_ABI()
before, because Peter Zijlstra (who is currently MIA) has been strongly
against it.

-- Steve
 



