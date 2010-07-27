From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Issue with file transfers to a mass storage device on SMP
	system
Date: Tue, 27 Jul 2010 11:41:33 +0100
Message-ID: <20100727104133.GA10665@n2100.arm.linux.org.uk>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com> <20100727100121.GB7846@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52635 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab0G0Klu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 06:41:50 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Mankad, Maulik Ojas" <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 27, 2010 at 03:49:29PM +0530, Shilimkar, Santosh wrote:
> > On Tue, Jul 27, 2010 at 03:08:54PM +0530, Shilimkar, Santosh wrote:
> > > As discussed, the main reason is the cache maintenance isn't done on
> > >  "bcb->CDB"  buffers and hence the data remains in CPU write buffer
> > > instead of the physical memory on which DMA operates.
> > 
> > struct bulk_cb_wrap {
> >         __le32  Signature;              /* contains 'USBC' */
> >         __u32   Tag;                    /* unique per command id */
> >         __le32  DataTransferLength;     /* size of data */
> >         __u8    Flags;                  /* direction in bit 0 */
> >         __u8    Lun;                    /* LUN normally 0 */
> >         __u8    Length;                 /* of of the CDB */
> >         __u8    CDB[16];                /* max command */
> > };
> > 
> > So, CDB is contained within bcb...bcb+sizeof(*bcb).
> > 
> > The bcb is passed to usb_stor_bulk_transfer_buf:
> > 
> >         result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
> >                                 bcb, cbwlen, NULL);
> > 
> > which fills it into a URB:
> > 
> >         usb_fill_bulk_urb(us->current_urb, us->pusb_dev, pipe, buf,
> > length,
> >                       usb_stor_blocking_completion, NULL);
> > 
> > This sets the URB buffer pointers:
> > 
> >         urb->transfer_buffer = transfer_buffer;
> >         urb->transfer_buffer_length = buffer_length;
> > 
> > And this buffer should be dma-mapped and dma-unmapped as appropriate.
> > 
> > Wasn't there an issue with the DMA mapping being used with a PIO USB
> > host recently?  Is that the problem here?
> That's correct.
> The last issue was otherway round where we were doing map/unmpap on PIO buffer.

That's exactly what I said.

> This issue is because "CDB[16]", is not cleaned up before merging it into CBW.

The CDB array is part of the CBW (struct bulk_cb_wrap).  When the
struct bulk_cb_wrap is mapped for DMA, the CDB will also be as it
is contained entirely within the CBW structure.

As USB deals with the whole of the CBW as one block, it can't be that
half of it is being DMA-mapped and the other half isn't - something
else must be going on.  If the CDB was a separate chunk of memory, I
could believe what you're suggesting.

What we _do_ know is that 2.6.35-rc5 misses Catalin's barrier patches
for readl+writel, which means that there are ordering issues between
writing to memory and writing to devices.  This is what is going on
here, and it is confirmed by this:

| (3)Using wmb() (Write memory barrier) before starting DMA transfer in MUSB
| driver fixes the issue.

from Maulik.  The fix is to have Catalin's ordered IO accessors which
add the wmb() internally to writel() to ensure that memory accesses
are visible.
