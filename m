From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Sun, 24 Oct 2010 23:54:34 -0700
Message-ID: <4CC529AA.9070804@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <1287488171-25303-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2011 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab0JYGyg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Oct 2010 02:54:36 -0400
In-Reply-To: <1287488171-25303-3-git-send-email-trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>

On 10/19/2010 4:36 AM, Thomas Renninger wrote:
>   static void poll_idle(void)
>   {
> -	trace_power_start(POWER_CSTATE, 0, smp_processor_id());
>   	local_irq_enable();
>   	while (!need_resched())
>   		cpu_relax();
> -	trace_power_end(0);
>   }

why did you remove the idle tracepoints from this one ???

