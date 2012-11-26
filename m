From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 07:26:44 +0800
Message-ID: <50B3FAB4.7060904@linaro.org>
References: <Pine.LNX.4.44L0.1211261348310.2168-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1211261348310.2168-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/27/2012 03:12 AM, the mail apparently from Alan Stern included:
> On Mon, 26 Nov 2012, Andy Green wrote:
>
>> This adds a small optional API into drivers/base which deals with ge=
nerating,
>> matching and registration of wildcard device paths.
>>
>> >From a struct device * you can generate a string like
>>
>>   /platform/usbhs_omap/ehci-omap.0/usb1/1-1
>>
>> which enapsulates the path of the device's connection to the board.
>>
>> These can be used to match up other assets, for example struct regul=
ators,
>> that have been registed elsewhere with a device instance that is pro=
bed
>> asynchronously from the other board assets.
>>
>> If your device is on a bus, as it probably is, the device path will =
feature
>> redundant bus indexes that do not contain information about the conn=
ectivity.
>>
>> For example if more than one driver can generate devices on the same=
 bus,
>> then the ordering of device probing will change the path, despite th=
e
>> connectivity remains the same.
>>
>> For that reason, to get a deterministic path for matching, wildcards=
 are
>> allowed.  If your target device has the path
>>
>>   /platform/usbhs_omap/ehci-omap.0/usb1/1-1
>>
>> generated, in the asset you wish to match with it you can instead us=
e
>>
>> /platform/usbhs_omap/ehci-omap.0/usb*/*-1
>>
>> in order to only leave the useful, invariant parts of the path to ma=
tch
>> against.
>
> Have you considered limiting these wildcards in various useful ways?
> In this example, the wildcard must match a string of decimal digits.
> (Furthermore the two wildcard strings will always match each other,
> although it's probably not necessary to add this sort of constraint.)
>
> I don't know what sort of matches people will want in the future.
> Perhaps one for hex digits, or one for arbitrary text with the
> exception of a few characters (such as '/' but perhaps others too).
>
> To do what you want for now, the match should be restricted to digits=
=2E

I'm not sure what we'd use that for... it doesn't seem the biggest=20
problem we have at the moment ^^

>> To avoid having to adapt every kind of "search by string" api to als=
o use
>> the wildcards, the api takes the approach you can register your wild=
card,
>> and if a matching path is generated for a device, the wildcard itsel=
f is
>> handed back as the device path instead.
>>
>> So if your board code or a (not yet done) DT binding registers this =
wildcard
>>
>>   /platform/usbhs_omap/ehci-omap.0/usb*
>>
>> and the usb hub driver asks to generate its device path
>>
>> 	device_path_generate(dev, name, sizeof name);
>>
>> that is actually
>>
>>   /platform/usbhs_omap/ehci-omap.0/usb1
>>
>> then what will be returned is
>>
>>   /platform/usbhs_omap/ehci-omap.0/usb*
>>
>> providing the same literal string for ehci-omap.0 hub no matter how =
many\
>> usb buses have been registered before.
>>
>> This wildcard string can then be matched to regulators or other stri=
ng-
>> searchable assets intended for the device on that hardware path.
>
> That's not how I would do it, at least, not for this application.  I
> would register tuples containing a name, a pointer, and two callback
> routines.  For example,
>
> 	("/platform/usbhs_omap/ehci-omap.0/usb*", &omap_vhub_device,
> 		turn_on_regulator, turn_off_regulator)
>
> The when a device is registered whose path matches the string in such=
 a
> tuple, the device core would know to invoke the first callback.  The
> arguments would be a pointer to the device being registered and the
> pointer in the tuple.  Similarly, the device core would invoke the
> second callback when the device is unregistered.
>
> There doesn't have to be anything in this scheme that's specific to
> hubs or even to USB.  In particular, no changes to the hub driver wou=
ld
> be needed.

By just using paths, it's not restricted to regulators or binary=20
operations on them but anything that needs a "floating" binding to=20
another named kernel object can leverage it.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
