From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 08:02:40 +0800
Message-ID: <50B40320.2020206@linaro.org>
References: <Pine.LNX.4.44L0.1211261555400.2168-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1211261555400.2168-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/27/2012 05:07 AM, the mail apparently from Alan Stern included:
> On Mon, 26 Nov 2012, Greg KH wrote:
>
>> Ah, here's the root of your problem, right?  You need a way for your
>> hardware to tell the kernel that you have a regulator attached to a
>> specific device?  Using the device path and hard-coding it into the
>> kernel is not the proper way to solve this, sorry.  Use some other
>> unique way to describe the hardware, surely the hardware designers
>> couldn't have been that foolish not to provide this [1]?
>
> As far as I know, the kernel has no other way to describe devices.
>
> What about using partial matches?  In this example, instead of doing =
a
> wildcard match against
>
> 	/platform/usbhs_omap/ehci-omap.0/usb*
>
> (which would fail if the "platform" part of the path changes), suppos=
e
> the string "ehci-omap.0/usb*" could be associated with the usbhs_omap
> component somehow.  Or even better, the string "usb*" could be
> associated with the ehci-omap.0 device.
>
> Then the path-matching code could restrict its attention to that part
> of the path and to devices below the specified one.  Naming changes
> wouldn't be an issue, because the changes themselves would be made in
> the same source file that contains the partial path string.

Yes just dropping the starting / on the match and allowing a fragment t=
o=20
match further up the string would solve it.  ehci-omap.0 won't appear=20
down any other earlier device paths than the right one.

> On the other hand, this may be way more general than we really need.
> For this particular case, all we need to do is take special action th=
e
> first time any device is registered below the ehci-omap.0 platform
> device.  There ought to be a more direct way to accomplish this,
> without using string pattern-matching or sysfs pathnames (and without
> adding overhead every time a device is added or deleted).

There are no sysfs pathnames involved here at all.  Greg invented that.

> I don't know if such an approach would be sufficiently general for
> future requirements, but it would solve the problem at hand.

We can get a notification about device creation and do things there.=20
But the cost of that is like the tuple suggestion, they'll only be able=
=20
to do a fixed thing like operate on regulators.

Actually the targeted device may have arbitrary associated assets like=20
generic GPIO to turn on a "flash" for built-in webcam controlled=20
out-of-band.  These also can be reached by known names.  And the driver=
=20
may wish to do things with them that are more complex than enable /=20
disable or follow logical lifecycle of the hub or whatever.

However when the guidance from Greg is that we can do nothing except=20
complain at hardware designers for some reason I failed to quite=20
identify, I fear we are moving deckchairs on the titanic.

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
