From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 12:19:11 +0200
Message-ID: <20101026101911.GD16552@elte.hu>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
 <1288049630-10947-1-git-send-email-trenn@suse.de>
 <20101026071020.GC13036@elte.hu>
 <4CC6A640.8040700@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CC6A640.8040700@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> On 10/26/2010 12:10 AM, Ingo Molnar wrote:
> >+
> >>+	TP_STRUCT__entry(
> >>+		__field(	u32,		state		)
> >>+		__field(	u32,		cpu_id		)
> >Trace entries can carry a cpu_id of the current processor already. Can this cpu_id
> >ever be different from that CPU id?
> 
> yes
> 
> esp cpu frequency you can change cross cpu....
> 
> originally we did not have this in the API but Thomas added it for that reason 
> some time ago.

Ok, good! Maybe add this as a comment?

Thanks,

	Ingo
