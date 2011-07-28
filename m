From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/4] dt: i2c-omap: Convert i2c driver to use device tree
Date: Thu, 28 Jul 2011 15:32:46 -0600
Message-ID: <CACxGe6speWWuhSL1m3ysc6zrTvxYRyNf8Qj3Rt0jjdUGYi_v8g@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
 <1310592975-25773-5-git-send-email-manjugk@ti.com> <CACxGe6vG9BKUDvthOKFtx3u=Vq0EfBaZakxVqx8AYfRe_ruNdg@mail.gmail.com>
 <4E319DA7.5050608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53871 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab1G1VdG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 17:33:06 -0400
Received: by yia27 with SMTP id 27so2150861yia.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 14:33:06 -0700 (PDT)
In-Reply-To: <4E319DA7.5050608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jul 28, 2011 at 11:34 AM, Cousson, Benoit <b-cousson@ti.com> wr=
ote:
> Hi Grant,
>
> On 7/14/2011 1:20 AM, Grant Likely wrote:
>>
>> On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah<manjugk@ti.co=
m>
>> =A0wrote:
>>>
>>> The i2c-omap driver is converted for supporting both
>>> dt and non dt builds and driver is modified to use dt
>>> data partially.
>
> [...]
>
>>> =A0 =A0 =A0 =A0/* NOTE: driver uses the static register mapping */
>>> =A0 =A0 =A0 =A0mem =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
>>> =A0 =A0 =A0 =A0if (!mem) {
>>> @@ -1011,11 +1026,25 @@ omap_i2c_probe(struct platform_device *pdev=
)
>>> =A0 =A0 =A0 =A0if (pdata !=3D NULL) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0speed =3D pdata->clkrate;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->set_mpu_wkup_lat =3D pdata->set=
_mpu_wkup_lat;
>>> +#if defined(CONFIG_OF)
>>> + =A0 =A0 =A0 } else if (pdev->dev.of_node) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 prop;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.o=
f_node,
>>> "clock-frequency",
>>> +&prop))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D prop/100;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D 100;
>
> Do we have to modify every drivers in order to take advantage of the =
DT bus?
> Cannot we init the already existing pdata during device creation and =
let the
> driver untouched?
>
> I think it is a pity to add all that #ifdefry in the driver to be abl=
e to
> support two kinds of bus.

It's not supporting 2 different kinds of bus.  There is no such think
as a dt bus type (anymore. there used to be and of_platform_bus_type,
but that was a mistake).  DT is only a different configuration
representation.

> Cannot we have an intermediate phase that will deal only with the dev=
ice
> creation with DT?
>
> That will allow us to clean the omap_device creation from hwmod we ha=
ve
> today spread everywhere in plat-omap and mach-omap2.

Consider what you're suggesting...  Pretty much every driver that
needs platform data has as a unique platform_data structure.  That
means that for every driver there needs to be a separate block of code
to translate from DT data into struct <driver>_platform_data.  There
is no way to make that generic.  That translation code needs to live
somewhere, and something needs to be responsible for executing it when
relevant devices appear.  It can either be built into the driver, or
it can be done sometime before the driver is probed.

Option 1: If it is part of the driver, the sequence looks like this:
=2E..early boot:
1) allocate and register platform_devices for DT nodes (generic code,
attach device_node)
=2E.. boot progresses to initcalls...
2) probe platform_driver (DT translation code to obtain
<device>_platform_data from device_node)

Option 2: If it is part of platform_device registration, the sequence
looks something like:
=2E..early boot:
1) allocate and register platform_devices for DT nodes (call device
specific translation code for each device to create
<device>_platform_data)
=2E..boot progresses to initcalls
2) probe platform_driver (use platform_data, nothing changes here)

Option 3: decoupled from device registration and the device driver:
=2E..early boot:
1) allocate and register platform_devices for DT nodes (generic code,
attach device_node)
=2E..boot progresses to initcalls
2) hook into device model *before* drivers get probed to call device
specific translation code.
3) probe platform_driver (use platform_data, nothing changes here)

I understand the desire to not change the drivers, but going with
either option 2 or 3 causes a giant mess in figuring out how to make
sure the correct translation code gets called.  Option 2 is a disaster
because the translation code for any device that may possibly be
attached to the kernel must be statically linked in.  It cannot be in
modules because it must be available during early init.  Option 2 is
similarly a no-go because it requires a new hunk of infrastructure to
take care of finding and executing translation code before the device
can get probed by the device driver.

Besides, no matter how you look at it, the DT translation code is
always device-driver-specific.  It isn't something that can be handled
by generic code for all devices, and the *whole point* of the DT
transition is to get away from board specific code during early init.
Why wouldn't DT translation code live inside the one device driver
that it supports?

g.

Note: This is only an issue if a driver requires platform data.
Drivers that only need register and irq resources work without any
additional code.

As for the #ifdef issue, yes it can look ugly if it is done in the
wrong way.  Generally, I split the translation code out into a
separate function that can be made an empty static inline when
CONFIG_OF is not selected so that all the DT specific code can be
factored out into a single #ifdef block.

g.

>
> Regards
> Benoit
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
