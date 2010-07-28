From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: Issue with file transfers to a mass storage device on SMP	system
Date: Wed, 28 Jul 2010 10:45:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EFAD5@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
 <20100727100121.GB7846@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com>
 <20100727104133.GA10665@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF83C@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF8F3@dbde02.ent.ti.com>
 <20100727135939.GD11468@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF90B@dbde02.ent.ti.com>
 <20100727142113.GE11468@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF91F@dbde02.ent.ti.com>
 <20100727160710.GF11468@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100727160710.GF11468-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org]
> Sent: Tuesday, July 27, 2010 9:37 PM
> To: Shilimkar, Santosh
> Cc: Mankad, Maulik Ojas; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: Issue with file transfers to a mass storage device on SMP
> system
> 
> On Tue, Jul 27, 2010 at 07:59:17PM +0530, Shilimkar, Santosh wrote:
> > Once it's pushed out of L2X WB, it will hit the memory. Just to give an
> additional data point, with CATC analyzer what we see that only those
> > 16 bytes CDB are 0x0. This buffer was memset to 0x0 just before the
> > memcpy.
> >
> > I am just wondering who will issue a barrier(wmb) on this buffer before
> DMA
> > start if we don't use dma-mapping APIs? May be for dma_alloc_coherent
> > buffers, we need to explicitly issue the barrier.
> 
> wmb's don't take addresses - they're a global thing.  All stores before
> the wmb() take effect before stores after the wmb().
> 
> The wmb() is issued by Catalin's IO ordering patches:
> 
> +#define writeb(v,c)            ({ wmb(); writeb_relaxed(v,c); })
> +#define writew(v,c)            ({ wmb(); writew_relaxed(v,c); })
> +#define writel(v,c)            ({ wmb(); writel_relaxed(v,c); })
> 
> So, the wmb() is issued to ensure that all stores to (eg) buffers
> allocated by dma_alloc_coherent() hit memory prior to the store to
> the device.
> 
> Now, if you're writing to registers using something other than
> write[bwl](),
> you'll miss the wmb(), and therefore your DMA buffer won't be up to date.
> 
Yep. 
> And this _is_ the problem:
> 
> drivers/usb/musb/musb_io.h:static inline void musb_writew(void __iomem
> *addr, unsigned offset, u16 data)
> drivers/usb/musb/musb_io.h:     { __raw_writew(data, addr + offset); }
> drivers/usb/musb/musb_io.h:static inline void musb_writel(void __iomem
> *addr, unsigned offset, u32 data)
> drivers/usb/musb/musb_io.h:     { __raw_writel(data, addr + offset); }
> drivers/usb/musb/musb_io.h:static inline void musb_writeb(void __iomem
> *addr, unsigned offset, u8 data)
> drivers/usb/musb/musb_io.h:     __raw_writew(tmp, addr + (offset & ~1));
> drivers/usb/musb/musb_io.h:static inline void musb_writeb(void __iomem
> *addr, unsigned offset, u8 data)
> drivers/usb/musb/musb_io.h:     { __raw_writeb(data, addr + offset); }
> 
> All IO performed by musb misses out on the barriers - so what you
> need to do is either add wmb()s to these, or you need to ensure
> that the driver has the various necessary memory barriers in place.
> The latter solution will be more efficient.

I also agree that patching driver is less impacting and non-intrusive. We will go ahead with the original work-around which adds barrier in the driver.

Thanks for the good discussion on this.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
