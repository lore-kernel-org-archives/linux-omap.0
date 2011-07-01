From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 23:42:46 +0200
Message-ID: <201107012342.46292.rjw@sisk.pl>
References: <87k4c3dktm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48861 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757610Ab1GAVmD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:42:03 -0400
In-Reply-To: <87k4c3dktm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday, July 01, 2011, Kevin Hilman wrote:
> Continuing on the theme of runtime PM interactions with other parts of
> the driver core...
> 
> In drivers/base/dd.c:driver_probe_device(), the driver core increments
> the usage count around ->probe():
> 
>         [...]
> 	pm_runtime_get_noresume(dev);
> 	pm_runtime_barrier(dev);
> 	ret = really_probe(dev, drv);
> 	pm_runtime_put_sync(dev);
> 
> I'm not following the reason for this.  On driver's I'm familar with,
> it's not until ->probe where pm_runtime_enable() is called.  What is
> being protected against here?
> 
> These seem to exist since the introduction of the runtime PM core, but I
> can't find any explanation.
> 
> The documentation refers to the increment by the core, but not the
> reasons why:
> 
>     If the device bus type's or driver's ->probe() or ->remove()
>     callback runs pm_runtime_suspend() or pm_runtime_idle() or their
>     asynchronous counterparts, they will fail returning -EAGAIN, because
>     the device's usage counter is incremented by the core before
>     executing ->probe() and ->remove().  Still, it may be desirable to
>     suspend the device as soon as ->probe() or ->remove() has finished,
>     so the PM core uses pm_runtime_idle_sync() to invoke the
>     subsystem-level idle callback for the device at that time.
> 
> On a side note, the bit about -EAGAIN above is not accurate with today's
> code.  For example, __pm_runtime_suspend() returns zero when the usage
> count decrement is non-zero, so callers can't currently know that doing
> a pm_runtime_suspend() or pm_runtime_put_sync() in their ->probe()
> actually didn't happen.
> 
> Another curiosity is that, contrary to the above documentation, there is
> no usage_count increment before the bus/driver ->remove() (although
> there is a _get_sync/_put_sync around the sysfs_remove and notifier just
> before the bus/driver->remove().
> 
> Also, below is a patch for a typo in the above Documentation exerpt.
> 
> Kevin
> 
> 
> 
> From 069484f8d2bb86473a271c27733e10fbfd410c2c Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Thu, 30 Jun 2011 15:07:31 -0700
> Subject: [PATCH] PM: Documentation: fix typo: pm_runtime_idle_sync() doesn't exist.
> 
> Replace reference to pm_runtime_idle_sync() in the driver core with
> pm_runtime_put_sync() which is used in the code.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Applied to suspend-2.6/linux-next.

Thanks,
Rafael


> ---
>  Documentation/power/runtime_pm.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index 22accb3..518d9be 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -506,7 +506,7 @@ pm_runtime_suspend() or pm_runtime_idle() or their asynchronous counterparts,
>  they will fail returning -EAGAIN, because the device's usage counter is
>  incremented by the core before executing ->probe() and ->remove().  Still, it
>  may be desirable to suspend the device as soon as ->probe() or ->remove() has
> -finished, so the PM core uses pm_runtime_idle_sync() to invoke the
> +finished, so the PM core uses pm_runtime_put_sync() to invoke the
>  subsystem-level idle callback for the device at that time.
>  
>  The user space can effectively disallow the driver of the device to power manage
> 

