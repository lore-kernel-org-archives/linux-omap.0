From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [CFT 07/11] spi: omap2-mcspi: add DMA engine support
Date: Thu, 14 Jun 2012 13:08:43 +0100
Message-ID: <20120614120842.GF31187@n2100.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk> <20120614115335.GE31187@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56188 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab2FNMIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 08:08:51 -0400
Content-Disposition: inline
In-Reply-To: <20120614115335.GE31187@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net

On Thu, Jun 14, 2012 at 12:53:35PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 07, 2012 at 12:08:35PM +0100, Russell King wrote:
> > Add DMA engine support to the OMAP SPI driver.  This supplements the
> > private DMA API implementation contained within this driver, and the
> > driver can be independently switched at build time between using DMA
> > engine and the private DMA API for the transmit and receive sides.
> > 
> > Tested-by: Shubhrajyoti <shubhrajyoti@ti.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Right, now that we have working OMAP in mainline again...

Another warning:

------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-rmk/drivers/base/dd.c:257 driver_probe_device+0x78/0x21c()
Modules linked in:
Backtrace:
[<c0017d0c>] (dump_backtrace+0x0/0x10c) from [<c033e208>] (dump_stack+0x18/0x1c) r7:00000000 r6:c01ff28c r5:c040050c r4:00000101
[<c033e1f0>] (dump_stack+0x0/0x1c) from [<c00337ec>] (warn_slowpath_common+0x58/0x70)
[<c0033794>] (warn_slowpath_common+0x0/0x70) from [<c0033828>] (warn_slowpath_null+0x24/0x2c)
 r8:c04aa4d8 r7:c04aa63c r6:de70ce00 r5:de70ce34 r4:de70ce00
[<c0033804>] (warn_slowpath_null+0x0/0x2c) from [<c01ff28c>] (driver_probe_device+0x78/0x21c)
[<c01ff214>] (driver_probe_device+0x0/0x21c) from [<c01ff49c>] (__driver_attach+0x6c/0x90)
 r7:de443ec8 r6:c04aa63c r5:de70ce34 r4:de70ce00
[<c01ff430>] (__driver_attach+0x0/0x90) from [<c01fda70>] (bus_for_each_dev+0x58/0x98)
 r6:c04aa63c r5:c01ff430 r4:00000000
[<c01fda18>] (bus_for_each_dev+0x0/0x98) from [<c01ff0f4>] (driver_attach+0x20/0x28)
 r7:de6c9e80 r6:c04aa63c r5:c04aa63c r4:c0465b80
[<c01ff0d4>] (driver_attach+0x0/0x28) from [<c01fe2f4>] (bus_add_driver+0xb4/0x230)
[<c01fe240>] (bus_add_driver+0x0/0x230) from [<c01ffb24>] (driver_register+0xac/0x138)
[<c01ffa78>] (driver_register+0x0/0x138) from [<c0215d4c>] (spi_register_driver+0x4c/0x60)
 r8:0000005b r7:c045f848 r6:00000006 r5:00000018 r4:c0465b80
[<c0215d00>] (spi_register_driver+0x0/0x60) from [<c045414c>] (ks8851_init+0x14/0x1c)
[<c0454138>] (ks8851_init+0x0/0x1c) from [<c0008770>] (do_one_initcall+0x9c/0x164)
[<c00086d4>] (do_one_initcall+0x0/0x164) from [<c0436410>] (kernel_init+0x128/0x210)
[<c04362e8>] (kernel_init+0x0/0x210) from [<c0038754>] (do_exit+0x0/0x72c)
---[ end trace 4dcda79f5e89dd84 ]---
ks8851 spi1.0: message enable is 0
ks8851 spi1.0: eth0: revision 0, MAC 08:00:28:01:4d:c6, IRQ 194, has EEPROM

The relevant line:

        WARN_ON(!list_empty(&dev->devres_head));

Which suggests that someone is using devres against the struct device for
the KS8851 device before the driver is bound.  That's a bug, plain and
simple.  I've not yet been able to track down what it is or where it's
being done, but it is something that has been introduced during the last
merge window.

devm_* APIs should only be used by _drivers_ against the struct device
that they are driving - because the lifetime of these things is bounded
by the point at which the driver is bound to that struct device, to the
point that it is unbound from that struct device (and at that point,
all devm_* stuff against the struct device gets destroyed.)
