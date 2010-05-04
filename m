From: Tony Lindgren <tony@atomide.com>
Subject: Upcoming merge window and omap NAND patches
Date: Tue, 4 May 2010 15:08:03 -0700
Message-ID: <20100504220803.GN29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62888 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934232Ab0EDWIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 18:08:14 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimal.newwork@gmail.com>, Steve Sakoman <sakoman@gmail.com>, Mike Rapoport <mike@compulab.co.il>, Artem Bityutski <Artem.Bityutskiy@nokia.com>

Hi all,

There are several omap NAND patches pending, but some basic things
should be fixed first.

1. The NAND driver needs to stop tinkering with the GPMC registers

The omap General Purpose Memory Controller (GPMC) registers are omap
specific, and not driver specific. Tinkering with these registers
can cause issues with the other devices on the GPMC.

To find out what needs to disappear fomr the NAND driver, just do:

$ grep baseaddr drivers/mtd/nand/omap2.c

Any GPMC register tinkering needs to happen in arch/arm/mach-omap2/gpmc.c.
If there are not currently GPMC functions to do something in gpmc.c, then
let's add the necessary support there.

2. Passing hardcoded GPMC_CS0_BASE needs to go from the board files

Passing hardcoded GPMC virtual addressess is sure way to mess up
things. This should all become unnecessary once the NAND drivers
stops messing with the GPMC registers directly.

So, as a result, I'm not planning on pushing any omap NAND related
patches until these basic issues are fixed. I'll mark these patches
as "Changes requested" in patchwork.kernel.org even if these patches
don't have anything else wrong with them.

Let's fix the basic things for good, and put the other patches on
hold for a while. Sorry if this causes problems!

Cheers,

Tony
