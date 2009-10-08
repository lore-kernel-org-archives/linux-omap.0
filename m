From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Query: EHCI clock management approach
Date: Thu, 08 Oct 2009 16:32:44 -0700
Message-ID: <877hv531ib.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A332A93@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:41819 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbZJHXd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 19:33:58 -0400
Received: by pzk26 with SMTP id 26so5822900pzk.4
        for <linux-omap@vger.kernel.org>; Thu, 08 Oct 2009 16:32:46 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A332A93@dbde02.ent.ti.com> (Anand Gadiyar's message of "Thu\, 8 Oct 2009 06\:51\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

"Gadiyar, Anand" <gadiyar@ti.com> writes:

> I'd like to post a patch in a couple of days to refactor the EHCI
> clock management code. This would be useful to do aggressive clock
> management in the idle path.
>
> A current implementation I have is to simply factor out the
> clock_enable/disable calls out. Does it make sense to move this out
> to mach-omap2/* and provide the function pointer through platform
> data? Does the driver need to be aware of the clocks that it needs,
> or is it sufficient for it to just call a platform-specific function
> that turns on/off all the clocks needed by the driver?
>
> The reason I ask is, in a future OMAP, we may need to enable a
> different set of clocks, but we should be able to re-use the rest of
> the code directly.

I am so glad you asked...

The short answer is: use omap_device.

Now that omap_hwmod + omap_device are in mainline (thanks to Paul
Walmsley), all new drivers need to use this.

Once an omap_hwmod and omap_device for EHCI are implemented, the
driver calls would be abstracted just like you are looking for.
Below[3], I extracted the comments dirctly from
arch/arm/plat-omap/omap_device.c which describe how the drivers would
use these.  You can also look at an example of a converted MMC
driver[1] done by Paul.

Note that the abstraction via pdata to omap_device will be going away
by the time we reach 2.6.33 (hopefully.)  By then the runtime PM
framework[2] will be available for OMAP and, drivers will use runtime
PM.  The runtime PM core for OMAP will then call the omap_device layer
directly.

Kevin

[1] http://marc.info/?l=linux-omap&m=124419789124570&w=2

[2] http://elinux.org/OMAP_Power_Management#future_directions

[3] This is extracted directly from the header of
    arch/arm/plat-omap/omap_device.c


Guidelines for usage by driver authors:

1. These functions are intended to be used by device drivers via
function pointers in struct platform_data.  As an example,
omap_device_enable() should be passed to the driver as

struct foo_driver_platform_data {
...
     int (*device_enable)(struct platform_device *pdev);
...
}

Note that the generic "device_enable" name is used, rather than
"omap_device_enable".  This is so other architectures can pass in their
own enable/disable functions here.

This should be populated during device setup:

...
pdata->device_enable = omap_device_enable;
...

2. Drivers should first check to ensure the function pointer is not null
before calling it, as in:

if (pdata->device_enable)
    pdata->device_enable(pdev);

This allows other architectures that don't use similar device_enable()/
device_shutdown() functions to execute normally.

...

Suggested usage by device drivers:

During device initialization:
device_enable()

During device idle:
(save remaining device context if necessary)
device_idle();

During device resume:
device_enable();
(restore context if necessary)

During device shutdown:
device_shutdown()
(device must be reinitialized at this point to use it again)

