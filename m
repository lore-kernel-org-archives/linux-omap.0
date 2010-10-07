From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 17:58:22 +0200
Message-ID: <20101007155816.GA5351@nowhere>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com> <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal> <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab0JGP6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 11:58:32 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>

On Thu, Oct 07, 2010 at 05:23:43PM +0200, Pierre Tardy wrote:
> On Thu, Oct 7, 2010 at 5:08 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > [ Adding a few more CCs, since this discussion is about a tracepoin=
t
> > =A0userspace ABI policy, which is a topic of general interest. ]
>=20
> To add a little more comment, this is not the first time that
> tracepoints ABI changes. You can look at pytimechart sourcecode:
> http://gitorious.org/pytimechart/pytimechart/blobs/master/timechart/f=
trace.py
>=20
> from 2.6.31 which is the first kernel I support,
>=20
> sched_switch:  'task %s:%d [%d] =3D=3D> %s:%d [%d]',
> changed to:
> sched_switch:  'prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_stat=
e=3D%s
> =3D=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d',
>=20
> workqueue_execution: 'thread=3D%s
> func=3D%s\\+%s/%s','thread','func','func_offset','func_size'),
> changed to:
> workqueue_execution: 'thread=3D%s func=3D%s','thread','func'),
>=20



Seems to be only formatting changes, but no field has been removed and
no tracepoint has been renamed, etc...

So these are no stable ABI changes because the formatting can be change=
d
anytime. We want that flexibility and it stands on top of the per event
"format" files.

Tools are not supposed to read ascii formatted traces from trace/trace_=
pipe
files. Instead they need to read binary traces from trace_pipe_raw file=
s
and look at the format file to know how to format this.

This is why we have these format files: to let tools adapt with changes
like format change or fields added.

And we have a library in perf and trace-cmd that let you

- request a field value in a raw trace, by its name. So the field doesn=
't
  need to have a stable offset in the trace.
- request ascii format info, so that if ascii format changes, the tool
  adapt.
- record binary traces, much more leightweight for the writer (kernel)
  and for the reader (user).


I did told you that it would be better you make PyTimeChart use the per=
f
scripting facilities, it handles all the above things + it would
avoid you to handle a lot of things.

Now it's up to you, but don't count on us to make the ascii formatting
a stable ABI.

=20
> actually, over all the events pytimechart supports, only power traces
> are stable...


Now one problem is that we have really broken the workqueue tracepoints
in this release. I thought nobody was using them so we could
refactor this tracepoint subsystem, my bad.

workqueue_execution has become workqueue_execution_start and
workqueue_execution_end. workqueue_insertion is going to
suffer a similar split.

workqueue_creation and workqueue_destruction have disappear but
I can probably restore them, but for the rest, what should we do?

I really feel uncomfortable with this tracepoint/ABI problem....
Mathieu suggested we start a user library that could handle these
changes when they are really necessary.

Thoughts?

(Adding Tejun in Cc).

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
