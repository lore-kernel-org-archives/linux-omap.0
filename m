From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 21:08:23 +0200
Message-ID: <201010262108.23537.rjw@sisk.pl>
References: <1287488171-25303-3-git-send-email-trenn@suse.de> <1288115894.3673.12.camel@laptop> <AANLkTikAGsdm7HS7Au-6CHw5n0OC1c1L_j2AJgZKE_=K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTikAGsdm7HS7Au-6CHw5n0OC1c1L_j2AJgZKE_=K@mail.gmail.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday, October 26, 2010, Pierre Tardy wrote:
> On Tue, Oct 26, 2010 at 12:58 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> >>
> >> +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> >>         atomic_inc(&dev->power.usage_count);
> >
> > That's terribly racy..
> >
> I know. I'm not proud of this.. As I said, this is preliminary patch.
> We dont really need to have this prev_usage. This is just for debug.
> It mayprobably endup with something like:
> 
>          atomic_inc(&dev->power.usage_count);
> +       trace_power_device_usage(dev);

Well, please tell me what you're trying to achieve.

Thanks,
Rafael
