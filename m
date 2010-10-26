From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 17:38:17 -0400
Message-ID: <20101026213817.GB21495@Krystal>
References: <1287488171-25303-3-git-send-email-trenn@suse.de> <1288115894.3673.12.camel@laptop> <20101026181421.GA30090@Krystal> <201010262104.21851.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:52361 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758346Ab0JZViT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 17:38:19 -0400
Content-Disposition: inline
In-Reply-To: <201010262104.21851.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <greg@kroah.com>, Pierre Tardy <tardyp@gmail.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Tuesday, October 26, 2010, Mathieu Desnoyers wrote:
> > * Peter Zijlstra (peterz@infradead.org) wrote:
> > > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > > 
> > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > >         atomic_inc(&dev->power.usage_count); 
> > > 
> > > That's terribly racy..
> > 
> > Looking at the original code, it looks racy even without considering the
> > tracepoint:
> > 
> > int __pm_runtime_get(struct device *dev, bool sync)
> >  {
> >         int retval;
> > 
> > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> >         atomic_inc(&dev->power.usage_count);
> >         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> > 
> > There is no implied memory barrier after "atomic_inc". So either all these
> > inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> > why atomic operations are used at all, or it's a racy mess. (I vote for the
> > second option)
> 
> No, it isn't.
> 
> > kref should certainly be used there.
> 
> No, it shouldn't.
> 
> Please try to understand the code you're commenting on first.

Please see my reply to Alan Stern:

http://www.spinics.net/lists/linux-omap/msg39382.html

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
