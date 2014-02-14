From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] arm: dtsi: am335x-bone-common, usb0 is peripheral only
Date: Fri, 14 Feb 2014 11:02:48 +0100
Message-ID: <20140214100248.GO31787@pengutronix.de>
References: <1389448851-20010-1-git-send-email-mpa@pengutronix.de>
 <20140213225438.GF28216@atomide.com>
 <20140213231333.GK31787@pengutronix.de>
 <20140213232552.GR28216@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43621 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaBNKCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 05:02:53 -0500
Content-Disposition: inline
In-Reply-To: <20140213232552.GR28216@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi,

On Thu, Feb 13, 2014 at 03:25:52PM -0800, Tony Lindgren wrote:
> * Markus Pargmann <mpa@pengutronix.de> [140213 15:16]:
> > Hi,
> > 
> > On Thu, Feb 13, 2014 at 02:54:38PM -0800, Tony Lindgren wrote:
> > > * Markus Pargmann <mpa@pengutronix.de> [140111 06:03]:
> > > > The PMIC is using usb0 vbus line as power source. It is also connected
> > > > to the am335x processor as vbus sense. But there is no possibility to
> > > > pullup usb0 vbus to operate as host. This patch fixes the dr_mode of usb0.
> > > 
> > > That's the MUSB? AFAIK it's not possible to operate MUSB in peripheral
> > > only mode because the hardware does what it wants based on the ID
> > > pin state.
> > 
> > Yes that's MUSB. The am335x reference manual describes that it is
> > possible to force peripheral/host mode by setting bit 7 (IDDIG_MUX) in
> > register USBnMODE to 1. Then it uses the bit written in bit 8 (IDDIG) of
> > register USBnMODE to set host/peripheral mode.
> 
> OK
>  
> > I am not sure if the driver supports it yet but I think the DTS should
> > contain the correct mode nevertheless, especially to avoid starting the
> > otg loops in the musb driver.
> 
> Well there's one more thing to consider.. I think in the OTG role change
> case the VBUS is still driven externally from the original host, so the
> lack of VBUS does not always mean that host mode should be disabled.

I thought more about the hardware description than the possible role
changes through software protocols. In a hardware perspective, this USB
port is only in peripheral mode, as it can't drive VBUS. However is
there any support for role change protocols in the kernel yet?

Perhaps we have to add a seperate DT binding for usb role changes when
they are supported. This would help to describe the hardware
capabilities (host, peripheral or OTG) and the role change protocols
supported.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
