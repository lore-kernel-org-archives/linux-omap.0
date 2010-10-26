From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 20:52:18 +0200
Message-ID: <201010262052.19107.rjw@sisk.pl>
References: <1287488171-25303-3-git-send-email-trenn@suse.de> <1288049630-10947-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55380 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233Ab0JZSx2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 14:53:28 -0400
In-Reply-To: <1288049630-10947-1-git-send-email-trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>

On Tuesday, October 26, 2010, Thomas Renninger wrote:
> Changes in V2:
>   - Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
>   - Use u32 instead of u64 for cpuid, state which is by far enough
> 
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
> 
> 
> C-state/idle accounting events:
>   power:power_start
>   power:power_end
> are replaced with:
>   power:processor_idle
> 
> and
>   power:power_frequency
> is replaced with:
>   power:processor_frequency
> 
> power:machine_suspend
> is newly introduced, a first implementation
> comes from the ARM side, but it's easy to add these events
> in X86 as well if needed.

As I said already somewhere else, I think this one should be done at the
core level rather than in arch-specific code.

Thanks,
Rafael
