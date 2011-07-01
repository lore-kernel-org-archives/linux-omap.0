From: Kevin Hilman <khilman@ti.com>
Subject: Re: runtime PM usage_count during driver_probe_device()?
Date: Thu, 30 Jun 2011 17:09:09 -0700
Message-ID: <87vcvmaml6.fsf@ti.com>
References: <87k4c3dktm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58491 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752533Ab1GAAJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 20:09:15 -0400
Received: by mail-iy0-f173.google.com with SMTP id 3so3088771iyb.32
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 17:09:14 -0700 (PDT)
In-Reply-To: <87k4c3dktm.fsf@ti.com> (Kevin Hilman's message of "Thu, 30 Jun
	2011 15:19:01 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@ti.com> writes:

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

Oops, I'm not quite right here. 

The doc is actually right here if the driver uses pm_runtime_suspend()
or pm_runtime_idle() in ->probe().  It's only when drivers use
pm_runtime_put_sync() where there wouldn't be an -EAGAIN, but that seems
correct.  Sorry for the noise.

I'm still confused about the usage_count increment around ->probe
though.

Kevin


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
