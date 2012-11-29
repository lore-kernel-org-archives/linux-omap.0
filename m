From: Andy Green <andy.green@linaro.org>
Subject: Re: [try#1 PATCH 5/7] omap4: panda: add smsc95xx regulator and reset
 dependent on root hub
Date: Thu, 29 Nov 2012 13:55:27 +0800
Message-ID: <50B6F8CF.8020304@linaro.org>
References: <20121128124744.29569.52739.stgit@build.warmcat.com> <20121128125955.29569.25431.stgit@build.warmcat.com> <50B62865.4070906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:34857 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab2K2Fzh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 00:55:37 -0500
In-Reply-To: <50B62865.4070906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, keshava_mgowda@ti.com, balbi@ti.com, stern@rowland.harvard.edu

On 11/28/2012 11:06 PM, the mail apparently from Roger Quadros included=
:

Hi Roger -

> On 11/28/2012 02:59 PM, Andy Green wrote:
>> This adds regulators which are controlled by the OMAP4 PandaBoard (E=
S)'s
>> EHCI logical root hub existing.
>>
>> The regulators are made a device_asset of the EHCI logical root hub =
by
>> passing them through the hsusb -> mfd path.  Although the ehci-relat=
ed
>> platform_device is created at boot time, it is not instantiated unti=
l the
>> ehci-hcd module is inserted if it is modular.
>>
>> Since the regulator is an asset of the ehci-omap.0 device, it's turn=
ed on
>> during successful probe and off when the device is removed.
>>
>> Without power control, the ULPI PHY + SMSC9614 on the Panda eats 700=
-900mW
>> all the time, which is around the same as the idle power of the SoC =
and
>> rest of the board.
>>
>> This allows us to start off with it depowered, and only power it if =
the
>> ehci-hcd module is inserted.  When the module is removed, it's depow=
ered
>> again.

=2E..

>> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/us=
b-host.c
>> index 98f3287..2a0fdf9 100644
>> --- a/arch/arm/mach-omap2/usb-host.c
>> +++ b/arch/arm/mach-omap2/usb-host.c
>> @@ -501,6 +501,7 @@ void __init usbhs_init(const struct usbhs_omap_b=
oard_data *pdata)
>>   	}
>>   	ehci_data.phy_reset =3D pdata->phy_reset;
>>   	ohci_data.es2_compatibility =3D pdata->es2_compatibility;
>> +	ehci_data.assets =3D pdata->assets;
>
> Just wondering if it makes more sense to tie the regulator and clock
> assets on the Panda to LAN95xx platform device instead of ehci_omap's
> platform device.
>
> The only thing we need to do is add a dummy platform device for the
> LAN9xx chip and probe it in the smsc9xx driver.
>
> The benefit of this is we can choose to power up/down the LAN9xx devi=
ce
> by insmod/rmmod smsc0xx driver and still have other OMAP USB ports
> functional.
>
> what do you think?

I think it's cool but I am not sure it hangs together.  Just to make=20
sure we're on the same page, the "LAN95XX platform device" doesn't exis=
t=20
at the moment, right?

With hsusb mfd -> ehci the platform device can be made from boot becaus=
e=20
the memory-mapped hardware is always there.  As soon as the driver=20
appears, it can be probed and made into a real live device and=20
everything is straight.

But when the platform_device would represent a usb device, that's not=20
quite the same.  AIUI the usb stack only creates the device when it has=
=20
probed a vid:pid and identified a driver that claims to serve it.

If the power for the HUB+ETH was controlled by an asset on the probe fo=
r=20
the HUB+ETH device, isn't that never going to happen?  The usb stack=20
can't see the vid+pid for smsc95xx device until we give it power (it's=20
connected but off), in this scheme we don't give it power until=20
something ran probe for an smsc95xx device?

There's another quirk on Panda that makes trouble too, after enabling=20
power on the HUB+ETH chip, we must reset it.  But the same reset signal=
=20
resets the ULPI PHY too.  So if the powering deadlock was solved we=20
would still run into a problem where we caused ULPI errors bringing up=20
the smsc95xx, if ehci+ULPI was already going.  It's a violation of the=20
independence of the ULPI and [usb device on other side of ulpi] caused=20
by the Panda design using the same reset signal. That is why the curren=
t=20
approach gets power + reset over with once at the time we would anyway=20
want to reset the ULPI PHY.

However I think what you're saying about binding to hub power is good.=20
The hub ports are not devices, but it would be possible to bind an asse=
t=20
array to them and make the pre- and post- code functions.

But AFAIK neither that, nor the platform_device idea for smsc95xx even=20
get off the ground without a device_path type addressing scheme, becaus=
e=20
you are targeting from the board file specific logical devices that onl=
y=20
exist later after other probes.

I think it will be possible to address objections around the "pathiness=
"=20
by being able to seed the path match with a platform_device pointer=20
(there exists in the board file time a platform_device for ehci-omap.0=20
=2E..) and just matching the remainder on a single usb device's name, l=
ike=20
"*-1.1-1".

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
