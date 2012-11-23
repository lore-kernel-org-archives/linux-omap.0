From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Sat, 24 Nov 2012 04:37:08 +0800
Message-ID: <50AFDE74.6030805@linaro.org>
References: <Pine.LNX.4.44L0.1211231108000.1734-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:53683 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097Ab2KWUhZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Nov 2012 15:37:25 -0500
In-Reply-To: <Pine.LNX.4.44L0.1211231108000.1734-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 11/24/12 00:25, the mail apparently from Alan Stern included:
> On Fri, 23 Nov 2012, Felipe Balbi wrote:
>
>>> Thanks for the example. The only problem is, how do we associate a
>>> regulator to a specific port in the system.
>>
>> heh, that's the 1 million dollar question, isn't it ? :-)
>>
>> that's what we need to figure out now. Luckily we have Alan Stern
>> helping us out ;-)
>
> Some people might think having me around to interfere was not so luck=
y
> after all...  :-)
>
> First question: Should we worry about individual ports?  Ordinarily I=
'd
> say No, because hubs always power up all of their ports.  But with La=
n
> Tianyu's recent work, that won't be true any more.  In this case, it'=
s
> conceivable that the user might want to power-off the LAN95xx in orde=
r
> to save energy, even though ehci-hcd is still loaded and managing oth=
er
> USB devices.
>
> Either way, the regulator has to be associated with _something_: eith=
er
> a root-hub port or the host controller itself.  And this will most
> likely have to be done before the port's or the controller's struct
> device exists.
>
> Something like Andy's scheme might work.  It would require the kernel
> to parse name strings in various formats, which could get complicated=
=2E
> It would be great if the difficult parts could be stuck in the PM cor=
e
> somewhere.

If we're just looking at fixing the current "magic regulator name"=20
scheme of "hsusb0" so that it can work with abstract devices like any=20
hub / port, we could invert what my original "device path" scheme did.

So instead of having a parser (which boiled down quite small, but is=20
complicated by usb%d being the same for different usb drivers), we coul=
d=20
just add a helper function that walks the device parents to generate a=20
string representing the device instance.  Like

int device_path_generate(struct device *device, char *name, int len);

if you called it from the hub driver's probe function (or anything=20
else's probe function) with the new hub device pointer, it might fill=20
name with "ehci1/usbhub1-1/1-1.1" or somesuch.

That is then used in the hub probe function as the magic regulator name=
,=20
if a regulator exists of that name it gets managed according to logical=
=20
hub device lifecycle, same as the omap bit does at the moment.

That way it'll work with DT alright (you just arrange the regulator nam=
e=20
to be "ehci1/usbhub1-1/1-1.1" or whatever) and you're just trying to=20
sell device_path_generate() to someone else, which should be pretty sma=
ll.

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
