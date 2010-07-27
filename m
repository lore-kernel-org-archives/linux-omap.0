From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: Issue with file transfers to a mass storage device on SMP system
Date: Tue, 27 Jul 2010 14:59:40 +0100
Message-ID: <20100727135939.GD11468@n2100.arm.linux.org.uk>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com> <20100727100121.GB7846@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com> <20100727104133.GA10665@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF83C@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF8F3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF8F3-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 27, 2010 at 07:15:25PM +0530, Shilimkar, Santosh wrote:
> > -----Original Message-----
> > From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Shilimkar, Santosh
> > Sent: Tuesday, July 27, 2010 5:31 PM
> > To: Russell King - ARM Linux
> > Cc: Mankad, Maulik Ojas; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > Subject: RE: Issue with file transfers to a mass storage device on SMP
> > system
> > 
> > We have already those patches Russell and still see the issue. I think WMB
> > is helping because data is just 16 bytes which can reside in WB. Had it
> > been a bigger buffer this wouldn't have worked.
> > 
> > Will get back to you with more data on this.
> 
> Maulik and I looked at the code and below is what seems to be an issue.
> The mass storage USB layer is not respecting the DMA/CPU buffer ownership.
> 
> "usb_stor_Bulk_transport" gets "us-iobuf" which is already mapped for DMA.
> But inside this function the buffers is updated by the CPU which should not
> be done as per rule. Same buffer passed down for DMA to transfer where the 
> data might remain in CPU cache/WB. The dma map is not done on this buffer
> because it's being done already before passing it to 'usb_stor_Bulk_transport'

Hang on.

us->iobuf is a DMA coherent buffer, allocated by usb_alloc_coherent(),
in turn hcd_buffer_alloc().  This comes from either a DMA pool, or
dma_alloc_coherent().  These buffers are simultaneously owned by both
the CPU and the DMA agent.

So to talk about the buffer "already being mapped" and "buffer ownership"
is wrong.  It's supposed to be a DMA coherent buffer, and trying to use
dma_map_*() on it definitely won't work.

This memory will be mapped in as 'normal memory, uncached', and with
Catalins IO ordering patches, we rely upon wmb() ensuring that data
written to it becomes visible to the DMA agents.  (wmb() by default
aliases to mb(), which is a dsb() followed by outer_sync().)

I think OMAP overrides the definitions of the mandatory barriers -
the question is whether the OMAP implementation is sufficient to ensure
that data written to a 'normal memory, uncached' mapping makes it out
RAM so that the DMA agents can see it.

As the OMAP mandatory barrier implementation isn't in mainline, I can't
comment on that.  However, I feel certain that this is where the problem
is.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
