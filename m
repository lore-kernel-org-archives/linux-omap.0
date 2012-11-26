From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 07:47:58 +0800
Message-ID: <50B3FFAE.9070401@linaro.org>
References: <20121126123427.18106.4112.stgit@build.warmcat.com> <20121126124534.18106.44137.stgit@build.warmcat.com> <20121126192206.GB11239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:54603 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589Ab2KZXsI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 18:48:08 -0500
In-Reply-To: <20121126192206.GB11239@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

On 11/27/2012 03:22 AM, the mail apparently from Greg KH included:
> On Mon, Nov 26, 2012 at 12:45:34PM +0000, Andy Green wrote:
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
>
> Huh?  A bus "index" does show the connectivity, well, one type of
> connectivity, but perhaps it's not the one _you_ happen to want at th=
e
> moment.  Which is fine, but I don't see why you want to try to figure
> this out using the device path in the first place, surely you have so=
me
> other way that the hardware can describe itself to the kernel as to
> where it needs to be hooked up to?

The bus index is like a counter, it shows logical connectivity inside=20
Linux that isn't repeatable and doesn't reflect hardware routing=20
information directly.

>> For example if more than one driver can generate devices on the same=
 bus,
>> then the ordering of device probing will change the path, despite th=
e
>> connectivity remains the same.
>
> That's an expected thing, I don't see the issue here.

Alan brought up in a thread here the last days, "wouldn't it be nice if=
=20
we could arbitrarily bind regulators to asynchronously probed objects",=
=20
and after discussion proposed this wildcard matching scheme to mask=20
these generated bus numbers.

>> For that reason, to get a deterministic path for matching, wildcards=
 are
>> allowed.  If your target device has the path
>
> Wait, no, why would you want a deterministic path and have that
> hard-coded into the kernel here?  You can't rely on that any more tha=
n
> userspace can, so let's not start making the mistake that lots of
> userspace programmers originally did when they started using sysfs
> please.  We have learned from our past mistakes.

I guess that is a fair point.  I was going to say that it's no differen=
t=20
than using any kernel API in code, which history proves is very mutable=
;=20
people deal with it by changing the usages as they change the API=20
definition.  But it's complicated a bit by DTs meant to be more stable=20
and these paths would turn up in the DT.

In "platform" case though, a heuristic that leaving off the initial /=20
and allowing matches anywhere along the path then to the end would get=20
around it.

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
>>
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
>
> Device tree lists sysfs paths in it's descriptions?  That's news to m=
e.

It does not say that...

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
> Ah, here's the root of your problem, right?  You need a way for your
> hardware to tell the kernel that you have a regulator attached to a
> specific device?  Using the device path and hard-coding it into the
> kernel is not the proper way to solve this, sorry.  Use some other
> unique way to describe the hardware, surely the hardware designers
> couldn't have been that foolish not to provide this [1]?
>
> thanks,
>
> greg k-h
>
> [1] Yeah, I know I'm being hopeful here, and probably wrong, but then
>      you need to push back.  We are not helpless here.

Specific hardware information is something that's kept hidden away and=20
private in the driver for good reasons.

We could add elective, additional information at the driver for every=20
physical interface it represented and match that way.  But I am not sur=
e=20
the effort involved is repaid by the relatively few instances that need=
=20
what is basically asynchronously probed platform_data.

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
