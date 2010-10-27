From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PERF(kernel): Cleanup power events V2
Date: Wed, 27 Oct 2010 23:43:20 +0200
Message-ID: <201010272343.20968.rjw@sisk.pl>
References: <20101026181421.GA30090@Krystal> <201010271222.08921.rjw@sisk.pl> <20101027122115.GA10722@Krystal>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59314 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab0J0VoV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 17:44:21 -0400
In-Reply-To: <20101027122115.GA10722@Krystal>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Wednesday, October 27, 2010, Mathieu Desnoyers wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
...
> 
> Hrm, then why export pm_runtime_get_noresume() at all ?

Basically, the PM core needs it for some obscure stuff.  Beyond that people
really should use it with care (preferably avoid using it at all).

> I don't feel comfortable with some of the pm_runtime_get_noresume() callers.
> 
> > 
> > So if you don't want to resume the device immediately after increasing its
> > usage_count (in which case it's better to use pm_runtime_get_sync()), you
> > should do something like this:
> > 
> > 1) pm_runtime_get_noresume(dev);
> > 1a) pm_runtime_barrier(dev);  // That takes care of all pending requests etc.
> > 
> > 2) ...
> >  
> > 3) pm_runtime_put_noidle(dev);
> > 
> > [The meaning of pm_runtime_barrier() is that all of the runtime PM activity
> > started before the barrier has been completed when it returns.]
> > 
> > There's one place in the PM core where that really is necessary, but I wouldn't
> > recommend anyone doing anything like it in a driver.
> 
> grep -r pm_runtime_get_noresume drivers/    hands out very interesting info.
> 
> e.g.:
> 
> drivers/usb/core/drivers.c: usb_autopm_get_interface_async()
> 
>         pm_runtime_get_noresume(&intf->dev);
>         s = ACCESS_ONCE(intf->dev.power.runtime_status);
>         if (s == RPM_SUSPENDING || s == RPM_SUSPENDED)
>                 status = pm_request_resume(&intf->dev);
> 
> How is this supposed to work ?
> 
> If the ACCESS_ONCE can be reordered before the atomic_inc(), then I fear the
> device can be suspended even after the check.
> 
> My point is that a get/put semantic should imply memory barriers, especially if
> these are exported APIs.

Well, IMO adding a memory barrier to pm_runtime_get_noresume() wouldn't really
change a lot (it still would be racy with respect to some other runtime PM helper
funtions).  That said I guess we should put a "handle with care" sticker on it.

Thanks,
Rafael
