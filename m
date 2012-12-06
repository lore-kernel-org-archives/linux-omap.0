From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Thu, 06 Dec 2012 08:05:45 +0800
Message-ID: <50BFE159.1010009@linaro.org>
References: <Pine.LNX.4.44L0.1212051129140.1659-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:52197 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab2LFAFx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 19:05:53 -0500
In-Reply-To: <Pine.LNX.4.44L0.1212051129140.1659-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ming Lei <tom.leiming@gmail.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On 06/12/12 00:42, the mail apparently from Alan Stern included:
> On Wed, 5 Dec 2012, Andy Green wrote:
>
>>> The details of this aren't clear yet.  For instance, should the dev=
ice
>>> core try to match the port with the asset info, or should this be d=
one
>>> by the USB code when the port is created?
>>
>> Currently what I have (this is before changing it to pm domain, but =
this
>> should be unchanged) lets the asset define a callback op which will
>> receive notifications for all added child devices that have the devi=
ce
>> the asset is bound to as an ancestor.
>>
>> So you would bind an asset to the host controller device...
>>
>> static struct device_asset assets_ehci_omap0[] =3D {
>> 	{
>>                   .name =3D "-0:1.0/port1",
>>                   .asset =3D assets_ehci_omap0_smsc_port,
>>                   .ops =3D &device_descendant_attach_default_asset_o=
ps,
>> 	},
>>           { }
>> };
>>
>> ...with this descendant filter callback pointing to a generic "end o=
f
>> the device path" matcher.
>>
>> when device_descendant_attach_default_asset_ops() sees the child tha=
t
>> was foretold has appeared (and it only hears about children of
>> ehci-omap.0 in this case), it binds the assets pointed to by .asset =
to
>> the new child before its probe.  assets_ehci_omap0_smsc_port is an a=
rray
>> of the actual regulator and clock that need switching by the child. =
 So
>> the effect is to magic the right assets to the child device just bef=
ore
>> it gets added (and probe called etc).
>>
>> This is working well and the matcher helper is small and simple.
>
> Right.  The question is should it be done in this somewhat roundabout
> way (you've got two separate assets for setting up this one thing), o=
r
> should the USB port code be responsible for explicitly checking if
> there are any applicable assets when the port is created?
>
> The advantange of the second approach is that it doesn't involve
> checking all the ancestors every time a new device is added (and it
> involves only one asset).  The disadvantage is that it works only for
> USB ports.

It's done in two steps to strongly filter candidate child devices=20
against being children of a known platform device.  If you go around=20
that, you will be back to full device path matching with wildcards at=20
the USB child to determine if he is "the one".  So that's a feature not=
=20
an issue I think.

I can see doing it generically or not is equally a political issue as a=
=20
technical one, but I think if we bother to add this kind of support we=20
should prefer to do it generally.  It's going to be about the same=20
amount of code.

As Tony Lindgren said, even board-omap4panda.c itself is deprecated, to=
=20
project platform info into USB stack you either have to add DT code int=
o=20
usb stack then to go find things directly, or provide a generic=20
methodology like assets which have the dt bindings done outside of any=20
subsystem and apply their operations outside the subsystem too.

> To answer the question, we need to know how other subsystems might
> want to use the asset-matching approach.  My guess is that only a sma=
ll
> number of device types would care about assets (in the same way that
> assets matter to USB ports but not to other USB device types).  And i=
t
> might not be necessary to check against every ancestor; we might know
> beforehand where to check (just as the USB port would know to look fo=
r
> an asset attached to the host controller device).

Yes I think it boils down to "buses" in general can benefit from this.=20
They're the thing that dynamically - later - create child devices you=20
might need to target with what was ultimately platform information.

On Panda the other bus thing that can benefit is the WLAN module on=20
SDIO.  In fact that's a very illuminating case for your question above.=
=20
  Faced with exactly the same problem, that they needed to project=20
platform info on to SDIO-probed device instance to tell it what clock=20
rate it had been given, they invented an api which you can see today in=
=20
board-omap4panda.c and other boards there, wl12xx_set_platform_data().=20
This is from board-4430sdp:

static struct wl12xx_platform_data omap4_sdp4430_wlan_data __initdata =3D=
 {
         .board_ref_clock =3D WL12XX_REFCLOCK_26,
         .board_tcxo_clock =3D WL12XX_TCXOCLOCK_26,
};

=2E..

	ret =3D wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);

You can find the other end of it here in=20
drivers/net/wireless/ti/wlcore/wl12xx_platform_data.c

static struct wl12xx_platform_data *platform_data;

int __init wl12xx_set_platform_data(const struct wl12xx_platform_data *=
data)
{
	if (platform_data)
		return -EBUSY;
	if (!data)
		return -EINVAL;

	platform_data =3D kmemdup(data, sizeof(*data), GFP_KERNEL);
	if (!platform_data)
		return -ENOMEM;

	return 0;
}

when the driver for the device instance wants to "get" its platform dat=
a=20
it reads the static pointer via another api.  Obviously if you want two=
=20
modules on your platform that's not so good.

I doubt that's the only SDIO device that wants to know platform info.=20
So I think by providing a generic way we help other buses and devices.

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
