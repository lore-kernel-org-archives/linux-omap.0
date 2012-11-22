From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 17:00:45 +0200
Message-ID: <50AE3E1D.9000607@ti.com>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org> <50ACFC5D.1090406@ti.com> <20121121195436.GF14290@arwen.pp.htv.fi> <50AD7C2C.7000608@linaro.org> <20121122121845.GB18022@arwen.pp.htv.fi> <50AE2D51.5060001@linaro.org> <20121122135603.GA20066@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121122135603.GA20066-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/22/2012 03:56 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Nov 22, 2012 at 09:49:05PM +0800, Andy Green wrote:
>>> Again it sounds like something that should be done at the hub driver
>>> level. I mean using the GPIO (for reset) and Power Regulator.
>>>
>>> not implementing the regulator part itself, but using it.
>>
>> If you mean change the regulator managing code from living in
>> omap-hsusb to ehci-hcd, it sounds like a good idea.
> 
> I mean that drivers/usb/core/hub.c should manage it, since that's what
> actually manages the HUB entity.

Yes. I agree that powering up the on-board hubs should be done
generically and not in ehci-omap.c. I'm not sure how it can be done in
hub.c.

I'm assuming that such problem is limited to root hub ports where system
designers have the flexibility to provide power to the peripherals
outside the USB Hub specification.

I can think of two solutions

1) Associate the regulators with the root hub _ports_ and enable them as
part of port's power-up routine.

2) Have a global list of regulators that are registered by platform code
and enabled them all at once on hcd init.

Any clues on how (1) could be implemented?

--
cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
