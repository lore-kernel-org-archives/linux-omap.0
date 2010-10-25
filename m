From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Sun, 24 Oct 2010 23:58:00 -0700
Message-ID: <4CC52A78.7060407@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <1287488171-25303-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39407 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab0JYG6E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Oct 2010 02:58:04 -0400
In-Reply-To: <1287488171-25303-3-git-send-email-trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>

On 10/19/2010 4:36 AM, Thomas Renninger wrote:
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
>
>
> C-state/idle accounting events:
>    power:power_start
>    power:power_end
> are replaced with:
>    power:processor_idle
>
I think you need two trace points for this
one to enter idle
one to exit

because using magic encoding games to encode "exit"is a mistake; as can 
be seen in this patch.
You're currently trying to use "0" to signal "end of idle", but "0" is 
also a valid idle state (namely that of polling)

