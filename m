From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sat, 9 Oct 2010 10:14:23 +0200
Message-ID: <AANLkTik6nO4i6xTuVYA9kBGFNpxYb70qimNcHPQKqTJ8@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de>
	<20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere>
	<4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu>
	<4CAF19E7.3070103@linux.intel.com>
	<20101008134156.GA28724@Krystal>
	<20101009062836.GB5517@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101009062836.GB5517@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 9, 2010 at 8:28 AM, Ingo Molnar <mingo@elte.hu> wrote:
>

> The thing is, Arjan is 100% right that a library for this is not a
> 'solution', it's an unnecessary complication.
Yes. sounds like overengineering.

> If we need to change events, we can add a new event. The old events will
> lose their relevance without us having to do much - and without us
> having to break powertop, pytimechart, etc. We can even have periods of
> overlap when both events are available - to give instrumentation apps
> time to learn the new events.
>
> I.e. it's not an ABI in the classic sense - we do not (because we
> cannot) guarantee the infinite availability of these events. But we can
> guarantee that the fields do not change in some stupid, avoidable way.
>
> Changing an existing event in some non-append way is just sloppy and we
> can do better.
>
> Arjan, Pierre, does that sound OK to you?
Yes. Its reasonable.
Note that pytimechart patch for new power API is already ready and
just waiting for this issue to be decided.

Regards,
Pierre
