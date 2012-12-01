From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Sat, 1 Dec 2012 13:19:15 +0530
Message-ID: <CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
	<Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
	<20121127170223.GB2687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37114 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab2LAHtR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Dec 2012 02:49:17 -0500
In-Reply-To: <20121127170223.GB2687@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Ming Lei <tom.leiming@gmail.com>, Felipe Balbi <balbi@ti.com>, Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, USB list <linux-usb@vger.kernel.org>, rogerq@ti.com

On Tue, Nov 27, 2012 at 10:32 PM, Greg KH <gregkh@linuxfoundation.org> =
wrote:
> On Tue, Nov 27, 2012 at 11:30:11AM -0500, Alan Stern wrote:
>>
>> We should have a more generic solution in a more central location, l=
ike
>> the device core.
>>
>> For example, each struct platform_device could have a list of resour=
ces
>> to be enabled when the device is bound to a driver and disabled when
>> the device is unbound.  Such a list could include regulators, clocks=
,
>> and whatever else people can invent.
>>
>> In this case, when it is created the ehci-omap.0 platform device cou=
ld
>> get an entry pointing to the LAN95xx's regulator.  Then the regulato=
r
>> would automatically be turned on when the platform device is bound t=
o
>> the ehci-omap driver.
>>
>> How does this sound?
>
> That sounds much better, and it might come in handy for other types o=
f
> devices than platform devices, so feel free to put this on the core
> 'struct device' instead if needed.
>
Isn't enabling/disabling of clocks and regulators what
dev.probe()/remove() of any driver already does?
If we mean only board specific setup/teardown, still it would mean
having the device core to do an extra 'probe' call when the current
probe() is already meant to do whatever it takes to bring the device
up. To my untrained eyes, it seem like messing with the
probe()/remove()'s semantics.
 IMHO, if we really must implement something like that, may be we
should employ some 'broadcast mechanism' so that anything anywhere in
kernel knows which new device has been probed()/removed()
successfully. I haven't thought exactly how because I am not sure even
that would be the right way to approach PandaBoard's problem.

Looking at "Figure 15 =E2=80=93 Panda USBB1 Interface Block Diagram" of
http://pandaboard.org/sites/default/files/board_reference/pandaboard-es=
-b/panda-es-b-manual.pdf
gives me visions ...

 1) OMAP doesn't provide the USB root-hub, but only ULPIPHY. It is
USB3320C chip that employs OMAP's ULPIPHY to provide the root-hub. So
we should have a platform device for USB3320C, the probe() of which
should simply
   a) Enable REFCLK (FREF_CLK3_OUT)
   b) Reset itself by cycling RESETB (GPIO_62)
   c) Create one "ehci-omap" platform device
 (or in appropriate order if the above isn't)
That way insmod/rmmod'ing the USB3320C driver would power-up/down the
whole subsystem.

2) Just like the user has to manually power-on/off any externally
powered hub connected to a PC, maybe we should implement a user
controlled 'soft' switch (reacting to UDEV events from ehci-omap?) to
emulate LAN9514 power-on/off. I do realize it would be cool to have it
automatically toggle in kernel when we (de)power the hub but isn't
that outside of scope of Linux USB implementation?

The above solution isn't most optimal for Panda but it seems a design
more consistent with what we already have. Or so do I think.

Cheers.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
