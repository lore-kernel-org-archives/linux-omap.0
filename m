From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Sat, 01 Dec 2012 16:37:04 +0800
Message-ID: <50B9C1B0.3080605@linaro.org>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com> <Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org> <20121127170223.GB2687@kroah.com> <CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:44023 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab2LAIh1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 1 Dec 2012 03:37:27 -0500
In-Reply-To: <CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <tom.leiming@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, USB list <linux-usb@vger.kernel.org>, rogerq@ti.com

On 12/01/2012 03:49 PM, the mail apparently from Jassi Brar included:
> On Tue, Nov 27, 2012 at 10:32 PM, Greg KH <gregkh@linuxfoundation.org=
> wrote:
>> On Tue, Nov 27, 2012 at 11:30:11AM -0500, Alan Stern wrote:
>>>
>>> We should have a more generic solution in a more central location, =
like
>>> the device core.
>>>
>>> For example, each struct platform_device could have a list of resou=
rces
>>> to be enabled when the device is bound to a driver and disabled whe=
n
>>> the device is unbound.  Such a list could include regulators, clock=
s,
>>> and whatever else people can invent.
>>>
>>> In this case, when it is created the ehci-omap.0 platform device co=
uld
>>> get an entry pointing to the LAN95xx's regulator.  Then the regulat=
or
>>> would automatically be turned on when the platform device is bound =
to
>>> the ehci-omap driver.
>>>
>>> How does this sound?
>>
>> That sounds much better, and it might come in handy for other types =
of
>> devices than platform devices, so feel free to put this on the core
>> 'struct device' instead if needed.
>>
> Isn't enabling/disabling of clocks and regulators what
> dev.probe()/remove() of any driver already does?

The particular issue this tries to address is stuff that is not part of=
=20
the generic driver function, but which is tied to the device instance b=
y=20
hardware connection choices on the physical platform.  External clocks,=
=20
regulators and mux settings needed to make the device instance work on=20
the board may all be out of scope for the generic driver, even when the=
=20
generic driver has a SoC-specific part as in this case.

So no, enabling regulators, clock and mux it has no idea about because=20
the dependency only exists as a board feature is not the job of probe /=
=20
remove in drivers already.

> If we mean only board specific setup/teardown, still it would mean
> having the device core to do an extra 'probe' call when the current
> probe() is already meant to do whatever it takes to bring the device
> up. To my untrained eyes, it seem like messing with the
> probe()/remove()'s semantics.

It's in the way of automating and simplifying code that would be=20
repeated in each driver probe routine according to what you're=20
suggesting.  In fact the pre-probe activity happens at the start of the=
=20
actual probe code, and post remove at the end of the actual remove,=20
there is no duplicated activity.  It's just a helper.

>   IMHO, if we really must implement something like that, may be we
> should employ some 'broadcast mechanism' so that anything anywhere in
> kernel knows which new device has been probed()/removed()
> successfully. I haven't thought exactly how because I am not sure eve=
n
> that would be the right way to approach PandaBoard's problem.

I think this stuff is a bit more multifacted than you're giving it=20
credit for, and indeed this thread has gone right into this aspect.  Sa=
y=20
we hooked to a device creation notifier, we still must identify the=20
correct device, in the case the device is on a dynamic bus.  Hence the=20
discussion about device paths.  Just throwing a notifier at it itself=20
doesn't scratch the problem.  The stuff I completed yesterday does solv=
e=20
this dynamic matching issue inexpensively.

> Looking at "Figure 15 =E2=80=93 Panda USBB1 Interface Block Diagram" =
of
> http://pandaboard.org/sites/default/files/board_reference/pandaboard-=
es-b/panda-es-b-manual.pdf
> gives me visions ...
>
>   1) OMAP doesn't provide the USB root-hub, but only ULPIPHY. It is
> USB3320C chip that employs OMAP's ULPIPHY to provide the root-hub. So
> we should have a platform device for USB3320C, the probe() of which
> should simply
>     a) Enable REFCLK (FREF_CLK3_OUT)
>     b) Reset itself by cycling RESETB (GPIO_62)
>     c) Create one "ehci-omap" platform device
>   (or in appropriate order if the above isn't)
> That way insmod/rmmod'ing the USB3320C driver would power-up/down the
> whole subsystem.

=46irst there's the issue that Panda has the same signal to reset the U=
LPI=20
PHY and the SMSC device, and that we must operate that reset after=20
powering the SMSC device.  The only nice way to do that is to arrange=20
for the reset to happen once for both, at a time after the SMSC chip is=
=20
powered, so we have no need to interrupt ULPI operation or touch the=20
reset subsequently, until next powerup of the ULPI PHY + SMSC.

That is why tying "foreign-to-the-generic-driver" assets to a device=20
instantiation can get us out of the hole, even when we want a hub port=20
device that is impossible to have as a platform_device to control the=20
power and clock for the SMSC device.

With Panda just trying to cleanly deal with ULPI reset in ULPI driver=20
and SMSC reset in SMSC driver (how're you going to let that dynamically=
=20
created smsc device know the gpio again?) are complicated by both=20
getting reset by the same signal.

Second, the choices of Panda about providing a refclock and reset to th=
e=20
ULPI PHY are not SoC level choices but board level ones.

> 2) Just like the user has to manually power-on/off any externally
> powered hub connected to a PC, maybe we should implement a user
> controlled 'soft' switch (reacting to UDEV events from ehci-omap?) to
> emulate LAN9514 power-on/off. I do realize it would be cool to have i=
t
> automatically toggle in kernel when we (de)power the hub but isn't
> that outside of scope of Linux USB implementation?
>
> The above solution isn't most optimal for Panda but it seems a design
> more consistent with what we already have. Or so do I think.

Not sure why you think that's out of scope for USB when USB allows hubs=
=20
to control port power.

Hub port power state seems like the right thing to control the=20
"enablement" of the stuff wired to the hub port afaics, it's a great=20
indication if we transition a hub port from depowered to powered, even=20
if that only has a logical effect rather than actually switching 5V, we=
=20
can understand from that we should power + clock (+ anything else=20
needed) the thing connected to the port then so it can be probed... it'=
s=20
definitely what is wanted.

The device_asset stuff is able to do that and control similarly the=20
lifecycle of arbitrary mux, clocks and regulators to go along with it,=20
without contaminiating the hub driver (except with 2 calls to work=20
around the fact that hub port devices have no driver).

The power domain stuff will also work, but only as far as hooking up th=
e=20
regulator and not the clock and mux stuff.  If there's a plan to allow=20
to bind clocks and mux to a regulator, well, OK you can do it all that=20
way, gluing it together by magic names for the power domain assets.

Anyway there's a lot of angles to it, the device_asset technique is=20
powerful and will definitely solve "out of band" prerequisites setup=20
nicely without involving the driver.

But I can't say I can see deep enough into the other considerations=20
(especially other subsystems understanding all this thinking) that just=
=20
trying to solve the regulator angle with a power domain is "wrong".=20
However it won't properly solve even the Panda case by itself as well a=
s=20
device_asset - external clock will stay permanently up and the forest o=
f=20
mux code - it's code, not tables - in mach-omap2 will stay as a _init=20
one-off.

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
