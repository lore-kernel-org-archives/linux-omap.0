From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 17:23:43 +0200
Message-ID: <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de>
	<20101007150825.GB12581@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59368 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab0JGPXp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 11:23:45 -0400
In-Reply-To: <20101007150825.GB12581@Krystal>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Oct 7, 2010 at 5:08 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> [ Adding a few more CCs, since this discussion is about a tracepoint
> =A0userspace ABI policy, which is a topic of general interest. ]

To add a little more comment, this is not the first time that
tracepoints ABI changes. You can look at pytimechart sourcecode:
http://gitorious.org/pytimechart/pytimechart/blobs/master/timechart/ftr=
ace.py

from 2.6.31 which is the first kernel I support,

sched_switch:  'task %s:%d [%d] =3D=3D> %s:%d [%d]',
changed to:
sched_switch:  'prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_state=3D=
%s
=3D=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d',

workqueue_execution: 'thread=3D%s
func=3D%s\\+%s/%s','thread','func','func_offset','func_size'),
changed to:
workqueue_execution: 'thread=3D%s func=3D%s','thread','func'),


actually, over all the events pytimechart supports, only power traces
are stable...

Regards,
--=20
Pierre
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
