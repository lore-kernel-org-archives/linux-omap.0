From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: Issue with file transfers to a mass storage device on SMP	system
Date: Tue, 27 Jul 2010 17:30:59 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF83C@dbde02.ent.ti.com>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
 <20100727100121.GB7846@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com>
 <20100727104133.GA10665@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100727104133.GA10665-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org]
> Sent: Tuesday, July 27, 2010 4:12 PM
> To: Shilimkar, Santosh
> Cc: Mankad, Maulik Ojas; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: Issue with file transfers to a mass storage device on SMP
> system
> 
> On Tue, Jul 27, 2010 at 03:49:29PM +0530, Shilimkar, Santosh wrote:
> > > On Tue, Jul 27, 2010 at 03:08:54PM +0530, Shilimkar, Santosh wrote:
> > > > As discussed, the main reason is the cache maintenance isn't done on
> > > >  "bcb->CDB"  buffers and hence the data remains in CPU write buffer
> > > > instead of the physical memory on which DMA operates.
> > >
> > > struct bulk_cb_wrap {
> > >         __le32  Signature;              /* contains 'USBC' */
> > >         __u32   Tag;                    /* unique per command id */
> > >         __le32  DataTransferLength;     /* size of data */
> > >         __u8    Flags;                  /* direction in bit 0 */
> > >         __u8    Lun;                    /* LUN normally 0 */
> > >         __u8    Length;                 /* of of the CDB */
> > >         __u8    CDB[16];                /* max command */
> > > };
> > >
> > > So, CDB is contained within bcb...bcb+sizeof(*bcb).
> > >
> > > The bcb is passed to usb_stor_bulk_transfer_buf:
> > >
> > >         result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
> > >                                 bcb, cbwlen, NULL);
> > >
> > > which fills it into a URB:
> > >
> > >         usb_fill_bulk_urb(us->current_urb, us->pusb_dev, pipe, buf,
> > > length,
> > >                       usb_stor_blocking_completion, NULL);
> > >
> > > This sets the URB buffer pointers:
> > >
> > >         urb->transfer_buffer = transfer_buffer;
> > >         urb->transfer_buffer_length = buffer_length;
> > >
> > > And this buffer should be dma-mapped and dma-unmapped as appropriate.
> > >
> > > Wasn't there an issue with the DMA mapping being used with a PIO USB
> > > host recently?  Is that the problem here?
> > That's correct.
> > The last issue was otherway round where we were doing map/unmpap on PIO
> buffer.
> 
> That's exactly what I said.
> 
> > This issue is because "CDB[16]", is not cleaned up before merging it
> into CBW.
> 
> The CDB array is part of the CBW (struct bulk_cb_wrap).  When the
> struct bulk_cb_wrap is mapped for DMA, the CDB will also be as it
> is contained entirely within the CBW structure.
> 
> As USB deals with the whole of the CBW as one block, it can't be that
> half of it is being DMA-mapped and the other half isn't - something
> else must be going on.  If the CDB was a separate chunk of memory, I
> could believe what you're suggesting.
> 
> What we _do_ know is that 2.6.35-rc5 misses Catalin's barrier patches
> for readl+writel, which means that there are ordering issues between
> writing to memory and writing to devices.  This is what is going on
> here, and it is confirmed by this:
> 
> | (3)Using wmb() (Write memory barrier) before starting DMA transfer in
> MUSB
> | driver fixes the issue.
> 
> from Maulik.  The fix is to have Catalin's ordered IO accessors which
> add the wmb() internally to writel() to ensure that memory accesses
> are visible.
We have already those patches Russell and still see the issue. I think WMB 
is helping because data is just 16 bytes which can reside in WB. Had it been a bigger buffer this wouldn't have worked.

Will get back to you with more data on this.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
