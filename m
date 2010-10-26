From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 19:58:14 +0200
Message-ID: <1288115894.3673.12.camel@laptop>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	 <1288049630-10947-1-git-send-email-trenn@suse.de>
	 <20101026071020.GC13036@elte.hu>
	 <AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
	 <4CC6FC03.708@linux.intel.com>
	 <AANLkTinrmhBkjnXE+xQGgrsv_OR_ckz=dyH4EoDB59X_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTinrmhBkjnXE+xQGgrsv_OR_ckz=dyH4EoDB59X_@mail.gmail.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> 
> +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
>         atomic_inc(&dev->power.usage_count); 

That's terribly racy..
