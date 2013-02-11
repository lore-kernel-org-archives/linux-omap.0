From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH RFC 1/7] platform: add a device node
Date: Mon, 11 Feb 2013 09:16:32 +0100
Message-ID: <20130211081632.GI1906@pengutronix.de>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1360442671-15216-2-git-send-email-javier.martinez@collabora.co.uk>
 <20130210010246.GA1455@kroah.com>
 <5116FCA1.40703@collabora.co.uk>
 <20130210093708.GL17852@n2100.arm.linux.org.uk>
 <CAAwP0s0fCJmUfTJweGhXj5bXsQ0Gov9JbUJtqYMwL7duNLZv_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32982 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab3BKIQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 03:16:40 -0500
Content-Disposition: inline
In-Reply-To: <CAAwP0s0fCJmUfTJweGhXj5bXsQ0Gov9JbUJtqYMwL7duNLZv_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org

On Sun, Feb 10, 2013 at 12:35:43PM +0100, Javier Martinez Canillas wrote:
> On Sun, Feb 10, 2013 at 10:37 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Feb 10, 2013 at 02:49:21AM +0100, Javier Martinez Canillas wrote:
> >> I knew this would be controversial and that's why I didn't mean it to be a patch
> >> but a RFC :)
> >>
> >> The problem basically is that you have to associate the platform device with its
> >> corresponding DT device node because it can be used in the driver probe function.
> >
> > When DT is being used, doesn't DT create the platform devices for you,
> > with the device node already set correctly?
> >
> 
> Well they usually do but not always just like usually you have a
> platform_device in your board code and call platform_device_register().
> 
> But in some configurations you can't just define the platform_device
> required resources (I/O memory, IRQ, etc) as static platform data.
> In some cases you need a level of indirection.
> 
> In this particular case a SMSC ethernet chip is connected to an
> OMAP3 processor through its General-Purpose Memory Controller.
> 
> You can't just define the I/O memory used by the device since you first
> need to request that address to the GPMC. The same happens with the
> IRQ line since a OMAP GPIO pin is used so you have to first configure
> the GPIO line as input.

For the gpio interrupt you can use, example taken from omap4-var-som.dts:

	interrupt-parent = <&gpio6>;
	interrupts = <11>; /* gpio line 171 */

Other architectures allow to specify the edge/level hi/low active
parameters from the devicetree aswell. The gpio direction should be
handled by the gpio driver as necessary, at least that's what done on
other architectures.

If the SMSC hangs on the GPMC then the SMSC should be a child node of
the GPMC. The GPMC would then act as a bus driver and configure the
chipselects and timings for its children automatically, maybe based
on timing information from the devicetree. I've never tried this before,
but I think that's the way things should be.

No need to manually create platform devices from the devicetree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
