From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Thu, 29 Nov 2012 10:05:19 +0800
Message-ID: <CACVXFVN6Dh5pwB_Pg2f0_N2iDU4oyCDusFWLMHRJmajnhDOpKQ@mail.gmail.com>
References: <50B5F1DB.8090502@ti.com>
	<Pine.LNX.4.44L0.1211281134240.2192-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:48975 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab2K2CFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 21:05:21 -0500
In-Reply-To: <Pine.LNX.4.44L0.1211281134240.2192-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Roger Quadros <rogerq@ti.com>, Andy Green <andy.green@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com

On Thu, Nov 29, 2012 at 12:43 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 28 Nov 2012, Roger Quadros wrote:
>
>> > board file:
>> >
>> >     static struct regulator myreg = {
>> >         .name = "mydevice-regulator",
>> >     };
>> >
>> >     static struct device_asset mydevice_assets[] = {
>> >         {
>> >             .name = "mydevice-regulator",
>> >             .handler = regulator_default_asset_handler,
>> >         },
>> >         { }
>> >     };
>> >
>> >     static struct platform_device mydevice = {
>> >     ...
>> >         .dev = {
>> >             .assets = mydevice_assets,
>> >         },
>> >     ...
>> >     };
>> >
>>
>> From Pandaboard's point of view, is mydevice supposed to be referring to
>> ehci-omap, LAN95xx or something else?
>
> ehci-omap.0.
>
>> Strictly speaking, the regulator doesn't belongs neither to ehci-omap
>> nor LAN95xx. It belongs to a power domain on the board. And user should
>> have control to switch it OFF when required without hampering operation
>> of ehci-omap, so that the other USB ports are still usable.
>
> That is the one disadvantage of the approach we are discussing.
>
> But what API would you use to give the user this control?  Neither the
> GPIO nor the regulator has a struct device, so you can't use sysfs
> directly.  And even if you could, it would probably be a bad idea
> because the user might turn off power to the LAN95xx while the chip was
> being used.

After Tianyu introduced the power power on/off mechanism, sometimes
one port power need to be switched off/on. Embedded system is more
power sensitive than PC, sounds we have no reason to reject applying
the mechanism on embedded world(non ACPI). Looks better to associate
the power domain thing(regulator, clock, ...) with one usb port device in
this USB problem.

>
> The natural answer is to associate the regulator with the USB port that
> the LAN95xx is connected to, so that the new port-power mechanism could
> provide the control you want.  Then how should that association be set
> up?

As I suggested in below link, the association can be set up easily with one
structure of 'struct port_power_domain'.

         http://www.spinics.net/lists/linux-omap/msg83158.html

>
> Lei Ming provided a partial answer, but his suggestion is tied to USB.

If we want to set up the association between usb port and power domain,
usb knowledge is required, at least bus info and port topology are needed.

One difficulty is the fact that the device(such as usb port) is independent
with the 'power domain', for example, the device isn't created(ports of the
root hub is created after ehci-omap probe, and port device of non-root
hub may depend on powering on the power domain) when defining the regulator
things, so could we figure out one general way in theory to describe the
associated device with the 'power domain'? Andy has tried the wildcard dev
path, and port topology string is introduced in my suggestion, looks both
are not general.

I admit the suggestion is partial because we still have not a general abstract
on 'power domain' in this problem, and once it is ready, the solution might be
in a shape at least for USB. In PC world, ACPI might do sort of something of
the 'power domain'

Maybe we need to create a new thread on this discussion and make more
guys involved(PM/USB/driver core/OMAP/....). I will study the problem further,
and hope I can post something for starting the discussion later.

> It would be better to have a more general approach.  So far nobody has

Yes, I agree. IMO, my suggestion is still in the direction to being general,
because a general 'power domain' concept is introduced in it, for example
the 'struct power_domain' is associated with 'struct port_power_domain'.

I understand the same 'power domain' concept should be applied to other
device or bus too, and the power associated with this device can be switched off
sometimes too for saving power consumption. But still looks specific
device/subsystem knowledge is required to set up the association.

Alan, so could the above be your concern on a more general approach?
Or you hope a more general way(such as, do it in driver core or dev PM core)
to associate the 'power domain' with one device(for example, usb port in
the LAN95xx problem) too? Or other things?


Thanks,
-- 
Ming Lei
