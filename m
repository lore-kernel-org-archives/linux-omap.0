From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 21:04:21 +0200
Message-ID: <201010262104.21851.rjw@sisk.pl>
References: <1287488171-25303-3-git-send-email-trenn@suse.de> <1288115894.3673.12.camel@laptop> <20101026181421.GA30090@Krystal>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55471 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080Ab0JZTFe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 15:05:34 -0400
In-Reply-To: <20101026181421.GA30090@Krystal>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <greg@kroah.com>, Pierre Tardy <tardyp@gmail.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>

On Tuesday, October 26, 2010, Mathieu Desnoyers wrote:
> * Peter Zijlstra (peterz@infradead.org) wrote:
> > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > 
> > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > >         atomic_inc(&dev->power.usage_count); 
> > 
> > That's terribly racy..
> 
> Looking at the original code, it looks racy even without considering the
> tracepoint:
> 
> int __pm_runtime_get(struct device *dev, bool sync)
>  {
>         int retval;
> 
> +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
>         atomic_inc(&dev->power.usage_count);
>         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> 
> There is no implied memory barrier after "atomic_inc". So either all these
> inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> why atomic operations are used at all, or it's a racy mess. (I vote for the
> second option)

No, it isn't.

> kref should certainly be used there.

No, it shouldn't.

Please try to understand the code you're commenting on first.

Thanks,
Rafael
