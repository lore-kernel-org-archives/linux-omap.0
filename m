From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Wed, 05 Dec 2012 15:32:52 +0800
Message-ID: <50BEF8A4.5090506@linaro.org>
References: <Pine.LNX.4.44L0.1212041150430.1800-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:59210 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab2LEHdO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 02:33:14 -0500
In-Reply-To: <Pine.LNX.4.44L0.1212041150430.1800-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ming Lei <tom.leiming@gmail.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On 05/12/12 01:10, the mail apparently from Alan Stern included:
> [CC: list trimmed; the people who were on it should be subscribed to =
at
> least one of the lists anyway.]
>
> On Tue, 4 Dec 2012, Andy Green wrote:
>
>> I think associating ULPI PHY reset and SMSC power and reset with the=
 hub
>> port power state is good.  Then, you could have the driver in a devi=
ce
>> with multiple onboard USB devices, and individually control whether
>> they're eating power or not.  In the asset case, you'd associate mux
>> assets with ehci-omap.0.
>>
>> Yesterday I studied the hub port code and have a couple of patches, =
one
>> normalizes the hub port device to have a stub driver.
>>
>> The other then puts hub port power state signalling into runtime_pm
>> handlers in the hub port device.  Until now, actually there's no cod=
e in
>> hub.c to switch off a port.
>
> In fact that's not quite true.  You simply weren't aware of the new
> code; you can find a series of patches starting here:
>
> 	http://marc.info/?l=3Dlinux-usb&m=3D135314427413307&w=3D2
>
> The parts of interest to us begin in patch 7/10.

Yes I have been looking in usb-next.

>> Assuming that's not insane, what should the user interface to disabl=
e a
>> port power look like, something in sysfs?  Until now it doesn't seem=
 to
>> exist.
>
> It will be implemented through PM QOS.

OK.  I saw "[PATCH 09/10] usb: expose usb port's pm qos flags to user=20
space" now.

>>> 	(On the other hand, since the LAN95xx is the only thing
>>> 	connected to the root hub, it could be powered off and on by
>>> 	unbinding the ehci-omap.0 device from its driver and rebinding
>>> 	it.)
>>
>> We shouldn't get to tied up with Panda case, this will be there for =
all
>> cases like PCs etc.  It should work well if there are multiple ports
>> with onboard assets.
>
> Okay, I'm fine with tying this to the port.

OK.

>>>        2. If we do choose the port, do we want to identify it by ma=
tching
>>> 	against a device name string or by matching a sequence of port
>>> 	numbers (in this case, a length-1 sequence)?  The port numbers
>>> 	are fixed by the board design, whereas the device name strings
>>> 	might  get changed in the future.  On the other hand, the port
>>> 	numbers apply only to USB whereas device names can be used by
>>> 	any subsystem.
>>
>> USB device names contain the port information.  The matching scheme =
I
>> have currently just uses the right-hand side of the path information=
 and
>> nothing that is not defined by the USB subsystem.  It uses a
>> platform_device ancestor to restrict matches to descendants of the r=
ight
>> host controller.  So unlike try#1 the names are as stable as the
>> subsystem code alone, however stable that is, it's not exposed to
>> changes from anywhere else.  As you mention it's then workable on an=
y
>> dynamically probed bus.
>>
>>>        3. Should the matching mechanism go into the device core or =
into
>>> 	the USB port code?  (This is related to the previous question.)
>>
>> Currently I am experimenting with having the asset pointer in struct
>> device, but migrating the events into runtime_resume and
>> runtime_suspend.  If it works out that has advantages that assets fo=
llow
>> not just the logical device existence but the pm state of the device
>> closely.
>>
>> It also allows leveraging assets directly to the hub port runtime_pm
>> state, so they follow enable state of the port without any additiona=
l code.
>
> If we use a PM domain then there won't be any need to hook the runtim=
e
> PM events.  The domain will automatically be notified about power
> changes.

OK.

>>>        4. Should this be implemented simply as a regulator (or a pa=
ir of
>>> 	regulators)?  Or should it be generalized to some sort of PM
>>> 	domain thing?  The generic_pm_domain structure defined in
>>> 	include/linux/pm_domain.h seems like overkill, but maybe it's
>>> 	the most appropriate thing to use.
>>
>> They should be regulators for that I think.  But it's only part the
>> problem since clocks and mux are also going to be commonly associate=
d
>> with device power state, and indeed are in Panda case.
>>
>> I realize restricting the scope is desirable to get something done, =
but
>> I'm not sure supporting regulators only is enough of the job.
>
> Then why not use a PM domain?  It will allow us to do whatever we wan=
t
> in the callbacks.

I see, I never met them before now is the reason ^^.  You're right it's=
=20
already in struct device too, and it's much more plumbed into the futur=
e=20
apis than what I have been doing.  I'll study how to change what I have=
=20
to fit this and do so.

> On Tue, 4 Dec 2012, Ming Lei wrote:
>
>> Alos, the same ehci-omap driver and same LAN95xx chip is used in
>> beagle board and panda board with different power control
>> approach, does port driver can distinguish these two cases?
>> Port device is a general device(not platform device), how does
>> port driver get platform/board dependent info?
>
> This is the part that Andy has been working on.  The board-dependent
> info will be registered by the board file, and it will take effect
> either when the port is registered or when it is bound to a driver.
>
> The details of this aren't clear yet.  For instance, should the devic=
e
> core try to match the port with the asset info, or should this be don=
e
> by the USB code when the port is created?

Currently what I have (this is before changing it to pm domain, but thi=
s=20
should be unchanged) lets the asset define a callback op which will=20
receive notifications for all added child devices that have the device=20
the asset is bound to as an ancestor.

So you would bind an asset to the host controller device...

static struct device_asset assets_ehci_omap0[] =3D {
	{
                 .name =3D "-0:1.0/port1",
                 .asset =3D assets_ehci_omap0_smsc_port,
                 .ops =3D &device_descendant_attach_default_asset_ops,
	},
         { }
};

=2E..with this descendant filter callback pointing to a generic "end of=
=20
the device path" matcher.

when device_descendant_attach_default_asset_ops() sees the child that=20
was foretold has appeared (and it only hears about children of=20
ehci-omap.0 in this case), it binds the assets pointed to by .asset to=20
the new child before its probe.  assets_ehci_omap0_smsc_port is an arra=
y=20
of the actual regulator and clock that need switching by the child.  So=
=20
the effect is to magic the right assets to the child device just before=
=20
it gets added (and probe called etc).

This is working well and the matcher helper is small and simple.

>> Not only regulators involved, clock or other things might be involve=
d too.
>> Also the same power domain might be shared with more than one port,
>> so it is better to introduce power domain to the problem. Looks
>> generic_pm_domain is overkill, so I introduced power controller whic=
h
>> only focuses on power on/off and being shared by multiple devices.
>
> Even though it is overkill, it may be better than introducing a new
> abstraction.  After all, this is exactly the sort of thing that PM
> domains were originally created to handle.

It's looking good to me.

-Andy

> Rafael, do you have any advice on this?  The generic_pm_domain
> structure is fairly complicated, there's a lot of code in
> drivers/base/power/domain.c (it's the biggest source file in its
> directory), and I'm not aware of any documentation.
>
> Alan Stern
>


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
