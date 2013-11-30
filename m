From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [RFC/PATCH] NAND bus-width detection extreme makeover
Date: Sat, 30 Nov 2013 00:35:37 -0800
Message-ID: <20131130083537.GB29397@norris.computersforpeace.net>
References: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:33072 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3K3Ifo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Nov 2013 03:35:44 -0500
Content-Disposition: inline
In-Reply-To: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Pekon Gupta <pekon@ti.com>, shc_work@mail.ru, Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>, swarren@wwwdotorg.org, rob.herring@calxeda.com, mark.rutland@arm.com, Tony Lindgren <tony@atomide.com>, u.kleine-koenig@pengutronix.de

Hi Ezequiel,

On Fri, Nov 29, 2013 at 10:40:55AM -0300, Ezequiel Garcia wrote:
> Here's my proposal, based in Pekon's latest work.
> 
> This patch removes the flash device bus-width configuration, prior to
> the device detection. With this modification, a NAND driver is no longer
> able to "force" the device width, and instead can only obtain the detected
> bus-width after the call to nand_scan_ident().
> 
> Flash devices bus-width are specified either by reading an ONFI feature,
> or through a flag in the in-kernel flash devices table. Therefore, it doesn't
> make any sense to somehow "advise" the NAND core about this parameter.

Hmm, I think there are a few factors at play here. First of all, the
hardware driver knows the best about the physical buswidth. It should
know if there are 8 or 16 data lines connected to the device, so it
could, for instance, know that it does not have enough data lines to
support x16 buswidth. (You could possibly devise hardware that can
support x16 but not x8, I suppose.) So this is one way in which the
driver must "advise" the NAND core about the buswidth.

On the other hand, the hardware/driver doesn't know what buswidth the
flash chip is. That's nand_base's job. So in that sense, we don't need
to "advise" the NAND core.

But there are certainly cases where the driver should advise, and if
there is a mismatch, bail.

> In addition, the ONFI specification requires to issue the detection commands
> using only the lower 8-bits of the data bus. The ONFI specification says:
> 
>   "" The Read ID and Read Parameter Page commands only use the lower 8-bits
>      of the data bus. The host shall not issue commands that use a word
>      data width on x16 devices until the host determines the device supports
>      a 16-bit data bus width in the parameter page. ""

This does not really say that *all* NAND transactions must be performed
on the lower 8 bits (a true x8 buswidth), but only that all ONFI
transactions must be.

> IIRC, the current way of setting the device width is to set NAND_BUSWIDTH_AUTO
> in chip->options and then let the driver set some width-specific callbacks after
> the NAND core has detected the width.
> 
> However, as noticed by Pekon Gupta, this means NAND_BUSWIDTH_AUTO should be
> always turned on (and hence the option be removed).

No, I think you can solve the x16 ONFI detection problem without
requiring NAND_BUSWIDTH_AUTO. And in fact, NAND_BUSWIDTH_AUTO only helps
you wil part of the problem: performing ONFI transactions during the
initial detection, where you pretend like you're an x8 device.

But what happens if a driver needs to use ONFI SET_FEATURES or
GET_FEATURES after initial probe?

So I think the problem may need to be divided into 2 parts:

 1) How do we best handle ONFI transactions, so that they are always
    performed on the lower 8 bits of the bus **regardless of actual
    buswidth**? (I think Uwe's patch + my response in [1] might solve
    this.)

 2) Can/should we relax the old restrictions where drivers have to
    configure the buswidth correctly before running nand_scan_ident(),
    in the spirit of NAND_BUSWIDTH_AUTO? And why do we need this
    flexibility?

I think problem (1) is solvable independently of (2). So we don't
inherently *need* BUSWIDTH_AUTO just to support ONFI correctly; we can
just enforce that we ignore the upper 8 bits.

Now, what do we have NAND_BUSWIDTH_AUTO for, anyway? It seems like its
best use case is for a driver that (a) knows it might encounter either
x8 or x16 flash chips and (b) is equipped to handle this change at
runtime (e.g., it only needs to re-assign some call-backs after
nand_scan_ident()). This means, for one, that it should have at least
all 16 data lines connected.

However, not all hardware/drivers fit (a) and (b). For such systems, we
probably want to just indicate the expected buswidth and error out
automatically if we detect this is incorrect.

So I think we still want to support the following three configurations:

  !NAND_BUSWIDTH_16 && !NAND_BUSWIDTH_AUTO: device must use 8-bit
  buswidth

  NAND_BUSWIDTH_16 && !NAND_BUSWIDTH_AUTO: device must use 16-bit
  buswidth

  NAND_BUSWIDTH_AUTO: can support either buswidth (auto-detectable)

But I think these selections should only be restricted by hardware
limitations (lack of I/O pin connections, inflexible controller) and not
enforced because of software limitations in handling ONFI. This brings
be back to problem (1), where I think we need resolve it along the lines
of Uwe's + my patch (see [1]), not by forcing NAND_BUSWIDTH_AUTO on all
drivers.

> That's exactly what this patch is doing.

...

> Note that some driver's might need fixes to work in both 8-bit and 16-bit
> modes, and such work should be done by respective maintainers.

I think this is one problem of the NAND_BUSWIDTH_AUTO-by-default
approach; it is better to avoid unnecessary work on old drivers. Many
of these drivers don't re-configure their x8 vs. x16 callback methods
automatically. So I think NAND_BUSWIDTH_AUTO should still be opt-in.

> Of course, the memory controller (such as GPMC in the OMAP case) still needs
> proper width a-prior configuration, but that's completely unrelated to the
> flash device bus width.

I would disagree.

> If some driver wants (and is able to) re-configure
> its memory controller after the device has been properly detected, it's free
> to do so.

The key point here is "if it is able to". Some hardware is unable to be
reconfigured, and so nand_base should take that into account. Such
inflexible systems are not good candidates for NAND_BUSWIDTH_AUTO.

> Needless to say, if this work is acceptable we'll be able to finally remove/deprecate
> any traces of the NAND bus width setting, include the devicetree nand-bus-width parameter.

I think we need to leave the infrastructure in place to enforce a
particular buswidth, since some systems may need it. How would a driver
ever signify that it is only wired for x8 buswidth? We would have to
wait until its BBT scan fails on an x16 device.

So I think individual drivers should still opt in to using
NAND_BUSWIDTH_AUTO.

> Alexander: Could you try this patch and see if it's suitable for your needs?
> I think you should be able to use it to set the bus-width, without any need for
> a new DT property. You will have to split your nand_scan() call in an initial
> call to nand_scan_ident() and a final call to nand_scan_tail().

FWIW, gpio.c does not need to split nand_scan(), as it doesn't need any
custom call-backs. nand_base should do all the work.

> Typically, a driver would work like this:
> 
> 	/* scan NAND device connected to chip controller */
> 	if (nand_scan_ident(mtd, 1, NULL))
> 		return -ENODEV;
> 
> 	if (nand_chip->options & NAND_BUSWIDTH_16) {
> 		nand_chip->read_buf   = xxx_read_buf16;
> 		nand_chip->write_buf  = xxx_write_buf16;
> 	}
...

Brian

[1] http://lists.infradead.org/pipermail/linux-mtd/2013-November/050507.html
