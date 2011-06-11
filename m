From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Sat, 11 Jun 2011 12:27:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106111212340.3439-100000@netrider.rowland.org>
References: <8739jhs2hv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:38093 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750835Ab1FKQ1w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Jun 2011 12:27:52 -0400
In-Reply-To: <8739jhs2hv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Fri, 10 Jun 2011, Kevin Hilman wrote:

> So here's an interesting scenario which I think it triggers the same
> problem as you highlight above.
> 
> Assume you have a driver that's using runtime PM on a per-xfer basis.
> Before each xfer, it does a pm_runtime_get_sync(), after each xfer it
> does a pm_runtime_put_sync() (for this example, it's important that it's
> a _put_sync()).  The _put_sync() might happen in an ISR, or possibly in
> a thread waiting on a completion which is awoken by the ISR, etc. etc.
> (the runtime PM callbacks are IRQ safe, and device is marked as such.)
> 
> The driver is in the middle of an xfer and a system suspend request
> happens.
> 
> The driver's ->suspend() callback happens, and the driver
> 
> - enables/disables wakeups based on device_may_wakeup()
> - prevents future xfers
> - waits for current xfer to finish
> 
> As soon as the xfer finishes, the driver gets notified (completion,
> callback, IRQ, whatever) and calls pm_runtime_put_sync(), which triggers
> subsys->runtime_suspend --> driver->runtime_suspend.
> 
> While the driver's ->suspend() callback doesn't directly call
> pm_runtime_put_sync(), the act of waiting for the xfer to finish
> causes the subsystem/driver->runtime_suspend callbacks to be called
> during the subsytem/driver->suspend callback, which is the same problem
> as you highlight above.  
> 
> Based on your commit that removed incrementing the usage count across
> suspend[1], you mentioned "we can rely on subsystems and device drivers
> to avoid doing that unnecessarily."  The above example shows that this
> type of thing might not be that obvious to detect and thus avoid.

As with so many other things, this depends entirely on how the 
subsystem and driver are designed.  If they are written to allow this 
sort of thing and handle it properly, there's no problem.

Nothing in the PM core itself cares whether the runtime PM routines are
invoked during system sleep.

> I suspect the solution to the above will be to add back the usage count
> increment across system suspend, but I'm hoping not.  IMO, it would be
> more flexible to allow the subsystems to decide.  The subsystems could
> provide locking (or manage dev->power.usage_count) themselves if
> necessary.  For example, leave it to the subsystem->prepare() to
> pm_runtime_get_noresume() if it wants to avoid the "nesting" of
> callbacks.

Exactly.

> A related question: does the pm_wq need to be freezable?  From
> Documentation/power/runtime_pm.txt:
> 
> * The power management workqueue pm_wq in which bus types and device drivers can
>   put their PM-related work items.  It is strongly recommended that pm_wq be
>   used for queuing all work items related to run-time PM, because this allows
>   them to be synchronized with system-wide power transitions (suspend to RAM,
>   hibernation and resume from system sleep states).  pm_wq is declared in
>   include/linux/pm_runtime.h and defined in kernel/power/main.c.
> 
> Is "synchronized with system-wide power transistions" correct here?
> Rather than synchronize, using a freezable workqueue actually _prevents_
> runtime PM events (at least async ones.)

Which prevents races -- the goal of synchronization.  If you use pm_wq 
for your asynchronous runtime PM events, you never have to worry about 
one of them occurring in the middle of a system sleep transition.

> Again, proper locking (or management of dev->power.usage_count) at the
> subsystem level would get you the same effect, but still leave
> flexibility to the subsystem/pwr_domain layer.

I'm not so sure about that.  For example, how would you prevent an 
async resume from interfering with a system suspend?

> Kevin
> 
> P.S. the commit below[1] removed the usage count increment/decrement
>      across system suspend/resume, but Documentation/power/runtime_pm.txt 
>      still refers to it.   Patch below[2] removes it, ssuming you're
>      not planning on adding it back.  ;)

...

> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index 654097b..22accb3 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -566,11 +566,6 @@ to do this is:
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
>  
> -The PM core always increments the run-time usage counter before calling the
> -->prepare() callback and decrements it after calling the ->complete() callback.
> -Hence disabling run-time PM temporarily like this will not cause any run-time
> -suspend callbacks to be lost.
> -

Thank you for pointing this out.  I had forgotten about this; it
implies that temporarily disabling runtime PM during system resume is
no longer safe!

Maybe we should put the get_noresume and put_sync calls back into the
PM core, but only during the system resume stages.

Alan Stern

