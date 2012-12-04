From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Tue, 4 Dec 2012 11:06:58 +0800
Message-ID: <CACVXFVPfmRFTE8kUKqD0vAwsJkEod=avhLfD_2NPBna05yd7xw@mail.gmail.com>
References: <50BC3003.80608@linaro.org>
	<Pine.LNX.4.44L0.1212031154460.1309-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53715 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab2LDDHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Dec 2012 22:07:00 -0500
In-Reply-To: <Pine.LNX.4.44L0.1212031154460.1309-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andy Green <andy.green@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>

On Tue, Dec 4, 2012 at 1:09 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 3 Dec 2012, Andy Green wrote:
>
>> Unless someone NAKs it for sure already (if you're already sure you're
>> going to, please do so to avoid wasting time), I'll issue a try#2 of my
>> code later which demonstrates what I mean.  At least I guess it's useful
>> for comparative purposes.
>
> Before you go writing a whole lot more code, we should discuss the
> basics a bit more clearly.  There are several unsettled issues here:
>
>      1. Should the LAN95xx stuff be associated with the ehci-omap.0's
>         driver or with the hub port?  The port would be more flexible,

IMO, it shouldn't be associated with ehci-omap controller driver
because the LAN95xx is a external USB device and should be
nothing to do with ehci, but it is reasonable to be associated with
the hub port because it takes a out of band power control method.

>         offering the ability to turn the power off and on while the
>         system is running without affecting anything else.  But the
>         port code is currently in flux, which could cause this new
>         addition to be delayed.
>
>         (On the other hand, since the LAN95xx is the only thing
>         connected to the root hub, it could be powered off and on by
>         unbinding the ehci-omap.0 device from its driver and rebinding
>         it.)
>
>      2. If we do choose the port, do we want to identify it by matching
>         against a device name string or by matching a sequence of port
>         numbers (in this case, a length-1 sequence)?  The port numbers
>         are fixed by the board design, whereas the device name strings
>         might  get changed in the future.  On the other hand, the port
>         numbers apply only to USB whereas device names can be used by
>         any subsystem.

Alos, the same ehci-omap driver and same LAN95xx chip is used in
beagle board and panda board with different power control
approach, does port driver can distinguish these two cases?
Port device is a general device(not platform device), how does
port driver get platform/board dependent info?

>
>      3. Should the matching mechanism go into the device core or into
>         the USB port code?  (This is related to the previous question.)
>
>      4. Should this be implemented simply as a regulator (or a pair of
>         regulators)?  Or should it be generalized to some sort of PM
>         domain thing?  The generic_pm_domain structure defined in
>         include/linux/pm_domain.h seems like overkill, but maybe it's
>         the most appropriate thing to use.

Not only regulators involved, clock or other things might be involved too.
Also the same power domain might be shared with more than one port,
so it is better to introduce power domain to the problem. Looks
generic_pm_domain is overkill, so I introduced power controller which
only focuses on power on/off and being shared by multiple devices.


Thanks,
-- 
Ming Lei
