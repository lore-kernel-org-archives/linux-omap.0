From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RFC/PATCH] NAND bus-width detection extreme makeover
Date: Fri, 29 Nov 2013 10:40:55 -0300
Message-ID: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42475 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753175Ab3K2NlX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 08:41:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, shc_work@mail.ru, Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>, swarren@wwwdotorg.org, rob.herring@calxeda.com, mark.rutland@arm.com, Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Here's my proposal, based in Pekon's latest work.

This patch removes the flash device bus-width configuration, prior to
the device detection. With this modification, a NAND driver is no longer
able to "force" the device width, and instead can only obtain the detected
bus-width after the call to nand_scan_ident().

Flash devices bus-width are specified either by reading an ONFI feature,
or through a flag in the in-kernel flash devices table. Therefore, it doesn't
make any sense to somehow "advise" the NAND core about this parameter.

In addition, the ONFI specification requires to issue the detection commands
using only the lower 8-bits of the data bus. The ONFI specification says:

  "" The Read ID and Read Parameter Page commands only use the lower 8-bits
     of the data bus. The host shall not issue commands that use a word
     data width on x16 devices until the host determines the device supports
     a 16-bit data bus width in the parameter page. ""

IIRC, the current way of setting the device width is to set NAND_BUSWIDTH_AUTO
in chip->options and then let the driver set some width-specific callbacks after
the NAND core has detected the width.

However, as noticed by Pekon Gupta, this means NAND_BUSWIDTH_AUTO should be
always turned on (and hence the option be removed).

That's exactly what this patch is doing.

This patch has been tested on a AM335x board with 8-bit and 16-bit devices,
which were successfully detected and nandtest'ed, using ONFI and flash-based
detection.

Note that some driver's might need fixes to work in both 8-bit and 16-bit
modes, and such work should be done by respective maintainers.

Of course, the memory controller (such as GPMC in the OMAP case) still needs
proper width a-prior configuration, but that's completely unrelated to the
flash device bus width. If some driver wants (and is able to) re-configure
its memory controller after the device has been properly detected, it's free
to do so.

Needless to say, if this work is acceptable we'll be able to finally remove/deprecate
any traces of the NAND bus width setting, include the devicetree nand-bus-width parameter.

Alexander: Could you try this patch and see if it's suitable for your needs?
I think you should be able to use it to set the bus-width, without any need for
a new DT property. You will have to split your nand_scan() call in an initial
call to nand_scan_ident() and a final call to nand_scan_tail().

Typically, a driver would work like this:

	/* scan NAND device connected to chip controller */
	if (nand_scan_ident(mtd, 1, NULL))
		return -ENODEV;

	if (nand_chip->options & NAND_BUSWIDTH_16) {
		nand_chip->read_buf   = xxx_read_buf16;
		nand_chip->write_buf  = xxx_write_buf16;
	}

Pekon Gupta (1):
  mtd: nand: auto-detection of NAND bus-width from ONFI param or
    nand_id[]

 drivers/mtd/nand/nand_base.c | 43 +++++++++++++------------------------------
 include/linux/mtd/nand.h     |  7 -------
 2 files changed, 13 insertions(+), 37 deletions(-)

-- 
1.8.1.5

