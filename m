From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sat, 09 Oct 2010 17:15:35 -0400
Message-ID: <1286658935.23994.3366.camel@gandalf.stny.rr.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	 <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	 <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	 <20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	 <20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	 <20101008134156.GA28724@Krystal> <20101009062836.GB5517@elte.hu>
	 <AANLkTik6nO4i6xTuVYA9kBGFNpxYb70qimNcHPQKqTJ8@mail.gmail.com>
	 <AANLkTimT5Or7gLDMnmLqSzmUoPux0pXrPxUZQpFon+6_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:34514 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab0JIVPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 17:15:40 -0400
In-Reply-To: <AANLkTimT5Or7gLDMnmLqSzmUoPux0pXrPxUZQpFon+6_@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pierre Tardy <tardyp@gmail.com>, Ingo Molnar <mingo@elte.hu>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>

On Sat, 2010-10-09 at 11:36 -0700, Linus Torvalds wrote:
> On Sat, Oct 9, 2010 at 1:14 AM, Pierre Tardy <tardyp@gmail.com> wrote:
> > On Sat, Oct 9, 2010 at 8:28 AM, Ingo Molnar <mingo@elte.hu> wrote:
> >>
> >
> >> The thing is, Arjan is 100% right that a library for this is not a
> >> 'solution', it's an unnecessary complication.
> > Yes. sounds like overengineering.
> 
> I also want to remind people that backwards compatibility should
> always absolutely be the #1 priority. Using libraries to "hide"
> differences is a totally moronic thing to do, because if you can do a
> compatibility library with good interfaces, then damn it, the kernel
> interface should already _be_ that good interface.
> 
> And no, even if you interact purely with open source programs, the
> backwards compatibility requirement doesn't go away. It's a damn pain
> in the ass to have to recompile, and it means that you have a much
> harder time mixing and matching, and just updating the kernel on top
> of a standard distribution.
> 
> So changing kernel interfaces that get exported to user space is
> always a disaster. Anybody who _designs_ for that kind of disaster
> shouldn't be participating in kernel development, because they've
> shown themselves to be unable to understand the pain and suffering.
> 
> Yes, we do it. Sometimes we change interfaces because not changing
> them is too damn painful. But it should absolutely not be the design
> model.

The difference here compared to all other user interfaces, is that this
interface has the sole purpose of showing what is happening inside the
kernel. By saying that "we expose this to userspace, it must too be
stable" is saying that all kernel internals that use trace events must
never change.

The big push against tracepoints/trace-markers/trace-events in the
beginning was the fear that they will hinder kernel development because
they become interfaces for users to see what is happening inside the
kernel. When I wrote the interface, I put it in the debugfs system so
people will know that this is a debug interface and can change without
notice.

Trace-events, unlike syscalls, may change depending on how you compiled
the kernel. There's no guarantee that they will even exist on a system.

If all trace-events are now stable ABI, then I suggest we stop adding
any more events, and only add new ones to places that we do not expect
to develop the kernel on anymore.

Not sure what other solution there is. Trace points have been added way
too freely, because any maintainer could add them to their system any
way they felt like it. Now if they are frozen in stone, then the code
that they expose must also be frozen.

-- Steve


