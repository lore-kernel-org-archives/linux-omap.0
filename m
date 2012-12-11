From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 11 Dec 2012 14:42:44 +0530
Message-ID: <CABb+yY3u2QB0JqXrznDGHXqH3crkYk54whC0GTwkBHqjdEzhbg@mail.gmail.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
	<Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
	<20121127170223.GB2687@kroah.com>
	<CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com>
	<50BF55B3.1030205@ti.com>
	<CABb+yY1xVMGFbedq8Wp2Muz13XAxJUKOk_=Z_UCEBkpzrtVz4A@mail.gmail.com>
	<50C5B003.9060904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49199 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab2LKJMp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 04:12:45 -0500
In-Reply-To: <50C5B003.9060904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <tom.leiming@gmail.com>, Felipe Balbi <balbi@ti.com>, Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, USB list <linux-usb@vger.kernel.org>

On Mon, Dec 10, 2012 at 3:18 PM, Roger Quadros <rogerq@ti.com> wrote:
> On 12/06/2012 04:34 PM, Jassi Brar wrote:
>>>
>>> Yes, this is where we can think of a generic PHY driver to make sure thy
>>> PHY has necessary resources enabled. In the Panda case it would be the
>>> PHY clock and RESET gpio.
>>>
>> I wonder if ehci-omap should assume, besides regulator, a clock might
>> also be need to setup for the transceiver chip.
>> Maybe "usbhs_bdata" in board-omap4panda.c should have
>> .reset_gpio_port[0]  = GPIO_HUB_NRESET ?
>>
>
> Just like the regulator, reset_gpio_port has nothing to do with OMAP
> EHCI. So we would want to get rid of that too from the OMAP USB driver.
>
Looking at the code I realized we already book resources only for
populated ports. Saving power from LAN9514 chip would come from a
separate solution. So, for now when our transceiver, USB3320, has
simple hardwired configuration probably just platform_data/DT would
do. When we come across some programmable transceiver (like USB3503
over i2c), that might warrant a separate PHY driver. Still I don't
think we could have a 'generic' phy driver.

>>
>>> The LAN95xx chip still needs to be powered up and the PHY driver isn't
>>> the right place for that (though it could be done there as a hack). The
>>> closest we can get to emulating right USB behavior is to map the
>>> SET/CLEAR PORT_FEATURE of the root hub port to the regulator that powers
>>> the LAN95xx.
>>>
>>> This way, we still don't fall in the dynamically probed space, so we
>>> could still provide the regulator information to the ehci hub via
>>> platform data and handle the regulator in ehci_hub_control
>>> (Set/ClearPortFeature). I'm looking at this as a software workaround for
>>> all platforms not implementing the EHCI set port power feature
>>> correctly. The same could be repeated for other HCDs as well if required.
>>>
>> IMHO it's not a matter of platforms not implementing EHCI set port
>> power feature correctly, we should think about onboard devices
>> connected to onboard non-root hubs. Setups like LAN9514 on Panda (HSIC
>> too ?) that don't run on VBUS of USB, would like their local supply to
>> be treated as if it came from the parent hub's port  i.e, tie together
>> the USB's set port power control with their OOB regulated power supply
>> (U9 on PandaBoard).
>>
>
> On Pandaboards we are still talking about root hub ports.
>
> Do you know any of such platforms which power their USB devices out of
> band for _non_ root hub ports?
>
I don't know of any. But I do believe we shouldn't discount that scenario.
IIANW lan9514 doesn't take in VBUS because it wants to avoid 5V->3.3V
regulating. What if someone designs an omap4 platform with 3
high-speed devices and the same concern in mind ?

> Assuming they do exist, the only solution is to match platform data for
> dynamically probed devices and deal with the regulators in the hub/port
> driver. Something like Andy already proposed.
>
Yes, but I doubt if that is the only implementation.
One USB specific solution could be to abstract out OOB port power
control in, say, port-power.c which constructs a regulator topology
mapped directly onto onboard devices', from a generic DT binding,
platform_data, ACPI whatever. And then catch any
set/clear_port_feature(POWER) call to enable/disable the regulator
corresponding to that port. Where each regulator could be a
board-specific virtual one, that does all that is necessary (like
clock/reg hierarchy setup) to power up the device.

Regards.
