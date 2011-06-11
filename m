From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Sun, 12 Jun 2011 01:13:38 +0200
Message-ID: <201106120113.38356.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org> <201106072332.30464.rjw@sisk.pl> <8739jhs2hv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48860 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab1FKXM5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jun 2011 19:12:57 -0400
In-Reply-To: <8739jhs2hv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Saturday, June 11, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> [...]
> 
> > Whether or not user space has disabled runtime PM _doesn't_ _matter_ for
> > system suspend, because _you_ _can't_ call pm_runtime_suspend(), or
> > pm_runtime_put_sunc(), from a driver's .suspend() callback _anyway_.
> > The reason is that doing that would cause the subsystem's (or power
> > domain's in this case) .runtime_suspend() callback to be invoked and
> > that's incorrect.  Namely, it would require the subsystem (power domain)
> > to expect that its .runtime_suspend() would always be executed indirectly
> > as a result of calling its .suspend() (through the driver's callback)
> > and that expectation may or may not be met (depending on the driver's
> > design).
> 
> So here's an interesting scenario which I think it triggers the same
> problem as you highlight above.
> 
> Assume you have a driver that's using runtime PM on a per-xfer basis.
> Before each xfer, it does a pm_runtime_get_sync(), after each xfer it
> does a pm_runtime_put_sync() (for this example, it's important that it's
> a _put_sync()).  The _put_sync() might happen in an ISR,

It can't happen in an ISR, to be precise.

> or possibly in a thread waiting on a completion which is awoken by the ISR,
> etc. etc. (the runtime PM callbacks are IRQ safe, and device is marked as such.)
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

It's not exactly the same.  The difference is that you're talking about race
conditions between runtime PM and system suspend (I kind of know why I wanted
system suspend to block runtime PM now :-)) that may be prevented by
subsystem-level code from happening (by using locking and some flags etc.),
while that code cannot do much if its .runtime_suspend() callback, for example,
is executed directly from the system suspend code path.
 
> Based on your commit that removed incrementing the usage count across
> suspend[1], you mentioned "we can rely on subsystems and device drivers
> to avoid doing that unnecessarily."  The above example shows that this
> type of thing might not be that obvious to detect and thus avoid.
> 
> I suspect the solution to the above will be to add back the usage count
> increment across system suspend, but I'm hoping not.  IMO, it would be
> more flexible to allow the subsystems to decide.  The subsystems could
> provide locking (or manage dev->power.usage_count) themselves if
> necessary.  For example, leave it to the subsystem->prepare() to
> pm_runtime_get_noresume() if it wants to avoid the "nesting" of
> callbacks.

I agree.

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
> 
> Again, proper locking (or management of dev->power.usage_count) at the
> subsystem level would get you the same effect, but still leave
> flexibility to the subsystem/pwr_domain layer.

No, please.

The problem here is that I don't want runtime PM stuff to be called during
the "noirq" stages of system suspend and resume which the freezing of the
workqueue takes care of nicely.


> P.S. the commit below[1] removed the usage count increment/decrement
>      across system suspend/resume, but Documentation/power/runtime_pm.txt 
>      still refers to it.   Patch below[2] removes it, ssuming you're
>      not planning on adding it back.  ;)

No, I'm not.  In fact, I'm going to apply your patch. :-)

Thanks,
Rafael


> [1]
> commit e8665002477f0278f84f898145b1f141ba26ee26
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Sat Feb 12 01:42:41 2011 +0100
> 
>     PM: Allow pm_runtime_suspend() to succeed during system suspend
>     
>     The dpm_prepare() function increments the runtime PM reference
>     counters of all devices to prevent pm_runtime_suspend() from
>     executing subsystem-level callbacks.  However, this was supposed to
>     guard against a specific race condition that cannot happen, because
>     the power management workqueue is freezable, so pm_runtime_suspend()
>     can only be called synchronously during system suspend and we can
>     rely on subsystems and device drivers to avoid doing that
>     unnecessarily.
>     
>     Make dpm_prepare() drop the runtime PM reference to each device
>     after making sure that runtime resume is not pending for it.
>     
>     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>     Acked-by: Kevin Hilman <khilman@ti.com>
> 
> [2]
> From 8968e3e41d785e7e5ce7584d64f6a55b303e7060 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Fri, 10 Jun 2011 16:05:51 -0700
> Subject: [PATCH] PM / Runtime: update doc: usage count no longer incremented across system PM
> 
> commit e8665002477f0278f84f898145b1f141ba26ee26 (PM: Allow
> pm_runtime_suspend() to succeed during system suspend) removed usage
> count increment across system PM.
> 
> Update doc to reflect this.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies on v3.0-rc2
> 
>  Documentation/power/runtime_pm.txt |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
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
>  7. Generic subsystem callbacks
>  
>  Subsystems may wish to conserve code space by using the set of generic power
> 

