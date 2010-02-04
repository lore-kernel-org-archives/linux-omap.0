From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Thu, 4 Feb 2010 14:33:13 -0600
Message-ID: <20100204203313.GB711@lixom.net>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com> <20100128032242.GA9070@lixom.net> <50326.192.168.10.89.1265296150.squirrel@dbdmail.itg.ti.com> <20100204152847.GA711@lixom.net> <40204.192.168.10.88.1265298323.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:50544 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933389Ab0BDU3z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 15:29:55 -0500
Content-Disposition: inline
In-Reply-To: <40204.192.168.10.88.1265298323.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Thu, Feb 04, 2010 at 09:15:23PM +0530, Govindraj.R wrote:

> > Ah. Care to update the comment to mention that? I guess the case above is similar.
> 
> 
> Before accessing FCR we need to write 0x00 to LCR,
> 
> I will correct it as,
> 
> /**** Access to FCR requires writing Ox00 to LCR *****/

Sounds good (but please use standard comment format, no extra *:s).

> >
> >> > Nearly every OMAP setup seems to prefer 115200 as default baudrate, right?
> >>
> >> Yes, but shouldn't we initialize to lowest possible baud?
> >
> > I don't see why that should be done. It's easiest if it's initialized
> > to the most commonly used speed, that way people can drop the annoying
> > ",115200" from the console bootarg string.
> >
> >> >> +static
> >> >> +int serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
> >> >
> >> > No linewrap (checkpatch should have caught this)
> >>
> >> I use checkpatch --strict,
> >> don't know how this passed
> >
> >
> > Yeah, seems like it doesn't check for it. :-) No big deal but since I was already
> > commenting on other things in the patch I mentioned it.
> >
> >> >> + ? ? ? ? ? ? ? ? ? ? up->uart_dma.tx_buf_dma_phys + UART_XMIT_SIZE)
> >> >> + ? ? ? ? ? ? up->uart_dma.tx_buf_size =
> >> >> + ? ? ? ? ? ? ? ? ? ? (up->uart_dma.tx_buf_dma_phys + UART_XMIT_SIZE) - start;
> >> >> + ? ? omap_set_dma_dest_params(up->uart_dma.tx_dma_channel, 0,
> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_AMODE_CONSTANT,
> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->uart_dma.uart_base, 0, 0);
> >> >> + ? ? omap_set_dma_src_params(up->uart_dma.tx_dma_channel, 0,
> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_AMODE_POST_INC, start, 0, 0);
> >> >> + ? ? omap_set_dma_transfer_params(up->uart_dma.tx_dma_channel,
> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_DATA_TYPE_S8,
> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->uart_dma.tx_buf_size, 1,
> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_SYNC_ELEMENT,
> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->uart_dma.uart_dma_tx, 0);
> >> >
> >> >
> >> > Isn't there a dma_sync call missing somewhere around here? Same for
> >> > the similar RX setup (both before DMA is started, as well as once it is
> >> > completed on the RX side).
> >>
> >> Sorry i didn't get you here as don't see any such dma_sync call
> >> in arch/arm/plat-omap/dma.c.
> >
> > It's not part of the OMAP dma driver, but instead it's part of the
> > DMA mapping API.  You have to make sure that the buffers (as well as
> > descriptors) that the DMA engine are going to access will be written to
> > the level of coherency (i.e. memory) before the operation begins (for
> > dma-from-memory), and you have to make sure any caches are invalidated
> > after the operation completes and you wish to read the resulting data
> > (for dma-to-memory).
> >
> 
> Could you refer me to any omap driver that currently use dma_sync?

Actually, I think this is an issue that most of them have to date, and
that something that will sting and burn and need fixing. It'll cause
weird and hard to diagnose problems for down the road.

So, while it's something that needs fixing, a clear FIXME comment might
be sufficient for now while the rest is cleaned up as well.

/* FIXME: Cache maintenance needed here? */

Or similar.


-Olof
