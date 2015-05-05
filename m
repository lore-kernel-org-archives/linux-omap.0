From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 00/35] ARM: OMAP2+: hwmod data module support
Date: Tue, 5 May 2015 08:59:05 -0700
Message-ID: <20150505155905.GE21061@atomide.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49252 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993486AbbEEP7I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 May 2015 11:59:08 -0400
Content-Disposition: inline
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [150415 05:53]:
> Hi,
> 
> This RFC provides support for moving hwmod data into separate modules
> which can be registered later during boot. Only system critical parts
> of the hwmod data remain in omap_hwmod_*_early_data.c file, rest are
> moved into omap_hwmod_*_late_data.c. The late data can alternatively
> be built into a module, or built-in to kernel image, in which case
> the system behaves pretty much the same way as it does currently. Use
> kconfig option OMAP_HWMOD_DATA_MODULES to control the behavior. If
> this approach is something that is seen feasible to follow, rest of
> the SoCs can be converted in similar manner, and eventually all the
> hwmod code should be moved under some driver (drivers/bus/ maybe?)

Interesting to see what it would take to move some of this into
loadable modules or /lib/firmware. I think we should queue the fixes
and anything that makes it easier to initialized hwmods in stages.
Then we should wait on the __init changes until there's a clear use
case.

Meanwhile, to me it seems we can make 81xx/am33x/am437x at least
device tree only for the hwmod with the following two changes:

1. Add parsing for the sysc syss properties along the lines of
   the RFC patches posted by Felipe few months back.

2. Set up the .clkctrl register as a gate clock that gets parsed
   from the dts files.

And then we can also start moving to generic power domains and
simple-pm-bus.

> This RFC set only provides support for omap3 hwmod data split. Please
> note that you probably must use ramdisk rootfs to load the hwmod data
> module itself from, as most of the system devices are not initialized
> in the early boot.

The problem with this is and firmware related approaches is
not having the complete set of boot devices like we all know :)

Regards,

Tony
