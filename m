From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Tue, 04 Dec 2012 11:40:05 +0800
Message-ID: <50BD7095.5090103@linaro.org>
References: <Pine.LNX.4.44L0.1212031154460.1309-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:52672 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab2LDDkS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Dec 2012 22:40:18 -0500
In-Reply-To: <Pine.LNX.4.44L0.1212031154460.1309-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ming Lei <tom.leiming@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>

On 04/12/12 01:09, the mail apparently from Alan Stern included:
> On Mon, 3 Dec 2012, Andy Green wrote:
>
>> Unless someone NAKs it for sure already (if you're already sure you'=
re
>> going to, please do so to avoid wasting time), I'll issue a try#2 of=
 my
>> code later which demonstrates what I mean.  At least I guess it's us=
eful
>> for comparative purposes.
>
> Before you go writing a whole lot more code, we should discuss the
> basics a bit more clearly.  There are several unsettled issues here:

>       1. Should the LAN95xx stuff be associated with the ehci-omap.0'=
s
> 	driver or with the hub port?  The port would be more flexible,
> 	offering the ability to turn the power off and on while the
> 	system is running without affecting anything else.  But the
> 	port code is currently in flux, which could cause this new
> 	addition to be delayed.

I think associating ULPI PHY reset and SMSC power and reset with the hu=
b=20
port power state is good.  Then, you could have the driver in a device=20
with multiple onboard USB devices, and individually control whether=20
they're eating power or not.  In the asset case, you'd associate mux=20
assets with ehci-omap.0.

Yesterday I studied the hub port code and have a couple of patches, one=
=20
normalizes the hub port device to have a stub driver.

The other then puts hub port power state signalling into runtime_pm=20
handlers in the hub port device.  Until now, actually there's no code i=
n=20
hub.c to switch off a port.

Assuming that's not insane, what should the user interface to disable a=
=20
port power look like, something in sysfs?  Until now it doesn't seem to=
=20
exist.

> 	(On the other hand, since the LAN95xx is the only thing
> 	connected to the root hub, it could be powered off and on by
> 	unbinding the ehci-omap.0 device from its driver and rebinding
> 	it.)

We shouldn't get to tied up with Panda case, this will be there for all=
=20
cases like PCs etc.  It should work well if there are multiple ports=20
with onboard assets.

>       2. If we do choose the port, do we want to identify it by match=
ing
> 	against a device name string or by matching a sequence of port
> 	numbers (in this case, a length-1 sequence)?  The port numbers
> 	are fixed by the board design, whereas the device name strings
> 	might  get changed in the future.  On the other hand, the port
> 	numbers apply only to USB whereas device names can be used by
> 	any subsystem.

USB device names contain the port information.  The matching scheme I=20
have currently just uses the right-hand side of the path information an=
d=20
nothing that is not defined by the USB subsystem.  It uses a=20
platform_device ancestor to restrict matches to descendants of the righ=
t=20
host controller.  So unlike try#1 the names are as stable as the=20
subsystem code alone, however stable that is, it's not exposed to=20
changes from anywhere else.  As you mention it's then workable on any=20
dynamically probed bus.

>       3. Should the matching mechanism go into the device core or int=
o
> 	the USB port code?  (This is related to the previous question.)

Currently I am experimenting with having the asset pointer in struct=20
device, but migrating the events into runtime_resume and=20
runtime_suspend.  If it works out that has advantages that assets follo=
w=20
not just the logical device existence but the pm state of the device=20
closely.

It also allows leveraging assets directly to the hub port runtime_pm=20
state, so they follow enable state of the port without any additional c=
ode.

>       4. Should this be implemented simply as a regulator (or a pair =
of
> 	regulators)?  Or should it be generalized to some sort of PM
> 	domain thing?  The generic_pm_domain structure defined in
> 	include/linux/pm_domain.h seems like overkill, but maybe it's
> 	the most appropriate thing to use.

They should be regulators for that I think.  But it's only part the=20
problem since clocks and mux are also going to be commonly associated=20
with device power state, and indeed are in Panda case.

I realize restricting the scope is desirable to get something done, but=
=20
I'm not sure supporting regulators only is enough of the job.

> Until we decide on the answers to these questions, there's no point
> writing detailed patches.

I agree, however I can't get insight into and confidence about what to=20
do without studying and meddling with the code.  Some throwaway code is=
=20
probably a reasonable price.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
