From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [CFT 07/11] spi: omap2-mcspi: add DMA engine support
Date: Thu, 14 Jun 2012 12:53:35 +0100
Message-ID: <20120614115335.GE31187@n2100.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56176 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab2FNLxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 07:53:43 -0400
Content-Disposition: inline
In-Reply-To: <E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net

On Thu, Jun 07, 2012 at 12:08:35PM +0100, Russell King wrote:
> Add DMA engine support to the OMAP SPI driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be independently switched at build time between using DMA
> engine and the private DMA API for the transmit and receive sides.
> 
> Tested-by: Shubhrajyoti <shubhrajyoti@ti.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Right, now that we have working OMAP in mainline again...

------------[ cut here ]------------
WARNING: at lib/dma-debug.c:865 check_unmap+0x1a0/0x6f8()
ks8851 spi1.0: DMA-API: device driver tries to free DMA memory it has not allocated [device address=0x000000009f5c3002] [size=592 bytes]
Modules linked in:
Backtrace:
[<c0017dd0>] (dump_backtrace+0x0/0x10c) from [<c0346870>] (dump_stack+0x18/0x1c)
 r7:df79fd78 r6:c01a2200 r5:c04036bd r4:00000361
[<c0346858>] (dump_stack+0x0/0x1c) from [<c0033c48>] (warn_slowpath_common+0x58/0x70)
[<c0033bf0>] (warn_slowpath_common+0x0/0x70) from [<c0033d04>] (warn_slowpath_fmt+0x38/0x40)
 r8:df79fdf8 r7:00000000 r6:00000250 r5:00000000 r4:9f5c3002
[<c0033ccc>] (warn_slowpath_fmt+0x0/0x40) from [<c01a2200>] (check_unmap+0x1a0/0x6f8)
 r3:c040ea22 r2:c0403a0f
[<c01a2060>] (check_unmap+0x0/0x6f8) from [<c01a2978>] (debug_dma_unmap_page+0x74/0x80)
[<c01a2904>] (debug_dma_unmap_page+0x0/0x80) from [<c021bd64>] (omap2_mcspi_txrx_dma+0x33c/0x54c)
[<c021ba28>] (omap2_mcspi_txrx_dma+0x0/0x54c) from [<c021c590>] (omap2_mcspi_work+0x1b8/0x2b8)
[<c021c3d8>] (omap2_mcspi_work+0x0/0x2b8) from [<c021c974>] (omap2_mcspi_transfer_one_message+0x2e4/0x310)
[<c021c690>] (omap2_mcspi_transfer_one_message+0x0/0x310) from [<c021a9f8>] (spi_pump_messages+0x130/0x154)
[<c021a8c8>] (spi_pump_messages+0x0/0x154) from [<c00508dc>] (kthread_worker_fn+0x108/0x188)
 r7:df6a3d94 r6:df79e000 r5:df6a3d90 r4:df6a3da4
[<c00507d4>] (kthread_worker_fn+0x0/0x188) from [<c0050a60>] (kthread+0x8c/0x98)
[<c00509d4>] (kthread+0x0/0x98) from [<c0039134>] (do_exit+0x0/0x314)
 r7:00000013 r6:c0039134 r5:c00509d4 r4:df443d78
---[ end trace 1b75b31a2719ed1f ]---

So, trying to figure this out... the result is not nice.

If the spi message has is_dma_mapped = false, then we potentially map the
DMA buffers against mcspi->dev.  This struct device is the same as the
master->dev.parent.

However, when we come to complete a transfer, we unmap them against the
spi_device's struct device - in other words a different device.

That's the reason for the warning.  However, when using DMA engine, both
of these struct device's are the wrong one to be using - the right one to
use is the one assocated with the DMA engine.

However, this presents a problem with transfers with is_dma_mapped = true.
SPI device drivers appear to assume that the right struct device to use
to map for DMA is master->dev.parent.  That's fine if your SPI master
device is the struct device performing the DMA, but with DMA engine
involved, this is not true.  Not sure at the moment what to do about
that one.
