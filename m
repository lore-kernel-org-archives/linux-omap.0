From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] USB: ehci-omap: Select USB_PHY
Date: Fri, 12 Apr 2013 02:22:13 +0200
Message-ID: <516753B5.2040002@ahsoftware.de>
References: <5166856C.3080906@ti.com> <20130411100435.GB14394@arwen.pp.htv.fi> <516695A4.2050804@ti.com> <20130411105557.GE14394@arwen.pp.htv.fi> <5166AFD2.4070108@ti.com> <5166B450.1000404@ahsoftware.de> <5166CC30.4060507@ti.com> <5166F3EC.8040807@ahsoftware.de> <20130411182946.GA20264@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130411182946.GA20264@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Roger Quadros <rogerq@ti.com>, Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Am 11.04.2013 20:29, schrieb Felipe Balbi:

> and who said OMAP USB depends on CONFIG_USB_PHY ? Some platforms need to
> control a PHY and some don't.

I've read that so.

> Go check out kernel 2.6.39 (maybe even 3.1 and 3.2) and you'll see that
> we're much better off today where we can actually have multiple PHY
> drivers and multiple UDC drivers enabled (either as modules or
> built-in), but the fact is that changing all of this over takes time and
> sometimes people make mistakes, but that's alright, since we have the
> -rc series to catch those unwanted errors.

I'll still have to stick to 3.2 because nothing afterwards boots from
EHCI on my beagleboard.

> 
> Without the help of the rest of the community, though, it'll just get
> slower and slower. With the whole single zImage effort going on in the
> ARM land, things have gotten much more critical WRT getting rid of
> "selects" and turning legacy "drivers" into real drivers, not just a
> bunch of exported functions which a single architecture uses.
> 
> Add to that all the rework going on in the Gadget Framework, PHY layer
> and EHCI drivers (which now has a core re-usable library thanks to Alan
> Stern) and you have a lot of work to do.
> 
> Next time you consider ranting about something, use that 'frustration'
> and turn it into motivation to write patches, then we all win. Also

I frequently tried and gave up. But thanks for the good suggestions.

Regards,

Alexander
