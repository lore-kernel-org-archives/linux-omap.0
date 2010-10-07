From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 18:10:59 +0200
Message-ID: <AANLkTik1FULW6Fm7Dwgb+xW5GSDzgSdF_a8z86_-SRNd@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de>
	<20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44369 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab0JGQLA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 12:11:00 -0400
In-Reply-To: <20101007155816.GA5351@nowhere>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>

> I did told you that it would be better you make PyTimeChart use the perf
> scripting facilities, it handles all the above things + it would
> avoid you to handle a lot of things.

Actually, perf scripting  facility is already supported by pytimechart
but does not make it that easier to maintain.
event name changes => must update, event fields added/removed => must update

>
> Now it's up to you, but don't count on us to make the ascii formatting
> a stable ABI.
I'm not against adding 1 line in pytimechart each time there is some
change in ascii formatting

>
>
>> actually, over all the events pytimechart supports, only power traces
>> are stable...
>
>
> Now one problem is that we have really broken the workqueue tracepoints
> in this release. I thought nobody was using them so we could
> refactor this tracepoint subsystem, my bad.
No problem. I'll update pytimechart whenever someone sends me traces
that does not work (I'm okay with pre 2.6.31 traces too...)


Regards,
Pierre
