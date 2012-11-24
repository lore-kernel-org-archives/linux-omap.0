From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Sun, 25 Nov 2012 06:00:53 +0800
Message-ID: <50B14395.4010404@linaro.org>
References: <Pine.LNX.4.44L0.1211241032490.4291-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1211241032490.4291-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/24/12 23:38, the mail apparently from Alan Stern included:
> On Sat, 24 Nov 2012, Andy Green wrote:
>
>> If we're just looking at fixing the current "magic regulator name"
>> scheme of "hsusb0" so that it can work with abstract devices like an=
y
>> hub / port, we could invert what my original "device path" scheme di=
d.
>>
>> So instead of having a parser (which boiled down quite small, but is
>> complicated by usb%d being the same for different usb drivers), we c=
ould
>> just add a helper function that walks the device parents to generate=
 a
>> string representing the device instance.  Like
>>
>> int device_path_generate(struct device *device, char *name, int len)=
;
>>
>> if you called it from the hub driver's probe function (or anything
>> else's probe function) with the new hub device pointer, it might fil=
l
>> name with "ehci1/usbhub1-1/1-1.1" or somesuch.
>
> It's not that simple.  In your example, the very same device might sh=
ow
> up, after rebooting, as "ehci2/usbhub2-1/2-1.1".  Even if a more or
> less stable name for the controller is used, the bus-number parts of
> the name (the '2's in this example) are always subject to change.  Th=
e

Agreed; I pointed this out in a previous mail in this thread already,=20
after someone else pointed it out to me some months ago.  Indeed we=20
can't use "usb%d", the nth "usb" bus because the ordering of driver=20
insertion for the various drivers that can create "usb%d"s breaks the=20
determinism of it.

So we can only use in the matching paths a %d that represents the nth=20
instance of a device from a specific driver, the "nth ehci host=20
controller" for example.

> device_path_generate routine would have to possess special knowledge
> about the USB subsystem's naming scheme to generate a truly stable
> name.

I think there's enough info exposed to do everything generically with n=
o=20
access to driver-private info.

When walking struct device "path" one of the things we know at each=20
stage is matched driver name.  So we might meet a device of name "usb2"=
=20
but afaik we can trivially also see the matched driver has the name=20
"ehci-hcd".

If we can walk a list of "usb%d"s, we can determine that our device is=20
the nth device of that type belonging to "ehci-hcd" driver.  That list=20
may be nondeterministic in terms of drivers getting modprobed in and=20
out, say inserting themselves randomly in the ordering of the list=20
before and after we modprobe ehci-hcd, but afaics no amount of insertio=
n=20
or removal will change the sequencing of other entries of the same type=
=20
already there (first ehci-hcd one will always appear in the list in the=
=20
same relative order to the second ehci-hcd one).  I think this would be=
=20
reliable for getting as far as "ehci1/" and it's generic code walking=20
device path and bus member lists that will work on all buses with that=20
problem.

> Presumably the same would hold for other subsystems too.

Although it looks like that method will bounce off of usbhub%d since th=
e=20
driver name does not vary, I think it can also be alright.

If we can walk a list of usbhubs finding the ones that have the same=20
parent pointer as the parent we arrived at in our walking, we should=20
again get an ordinal we can use representing the nth hub on that=20
particular host controller.  Afaics that should work for m hub levels=20
too if we just filter by an opaque parent device pointer.

Of course the code should not particularly know it's looking at "usb%d"=
=20
or "usbhub" just generic buses or classes or whatever it sees in use=20
while walking the device path.  And although there's some walking aroun=
d=20
described, we only do it at probe time and only for devices that are=20
interested in getting a deterministic device name to bind assets with.

The above is logically workable I think but to find out if it's=20
practical to "walk usbhubs" and so on for me anyway the code needs to b=
e=20
attempted.  So I'm curious if you see any flaw already with this scheme=
=2E

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
