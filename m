From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Issue with file transfers to a mass storage device on SMP
	system
Date: Tue, 27 Jul 2010 17:07:10 +0100
Message-ID: <20100727160710.GF11468@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com> <20100727100121.GB7846@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com> <20100727104133.GA10665@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF83C@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF8F3@dbde02.ent.ti.com> <20100727135939.GD11468@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF90B@dbde02.ent.ti.com> <20100727142113.GE11468@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF91F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58534 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab0G0QH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 12:07:29 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF91F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Mankad, Maulik Ojas" <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 27, 2010 at 07:59:17PM +0530, Shilimkar, Santosh wrote:
> Once it's pushed out of L2X WB, it will hit the memory. Just to give an additional data point, with CATC analyzer what we see that only those 
> 16 bytes CDB are 0x0. This buffer was memset to 0x0 just before the
> memcpy.
> 
> I am just wondering who will issue a barrier(wmb) on this buffer before DMA
> start if we don't use dma-mapping APIs? May be for dma_alloc_coherent
> buffers, we need to explicitly issue the barrier.

wmb's don't take addresses - they're a global thing.  All stores before
the wmb() take effect before stores after the wmb().

The wmb() is issued by Catalin's IO ordering patches:

+#define writeb(v,c)            ({ wmb(); writeb_relaxed(v,c); })
+#define writew(v,c)            ({ wmb(); writew_relaxed(v,c); })
+#define writel(v,c)            ({ wmb(); writel_relaxed(v,c); })

So, the wmb() is issued to ensure that all stores to (eg) buffers
allocated by dma_alloc_coherent() hit memory prior to the store to
the device.

Now, if you're writing to registers using something other than write[bwl](),
you'll miss the wmb(), and therefore your DMA buffer won't be up to date.

And this _is_ the problem:

drivers/usb/musb/musb_io.h:static inline void musb_writew(void __iomem *addr, unsigned offset, u16 data)
drivers/usb/musb/musb_io.h:     { __raw_writew(data, addr + offset); }
drivers/usb/musb/musb_io.h:static inline void musb_writel(void __iomem *addr, unsigned offset, u32 data)
drivers/usb/musb/musb_io.h:     { __raw_writel(data, addr + offset); }
drivers/usb/musb/musb_io.h:static inline void musb_writeb(void __iomem *addr, unsigned offset, u8 data)
drivers/usb/musb/musb_io.h:     __raw_writew(tmp, addr + (offset & ~1));
drivers/usb/musb/musb_io.h:static inline void musb_writeb(void __iomem *addr, unsigned offset, u8 data)
drivers/usb/musb/musb_io.h:     { __raw_writeb(data, addr + offset); }

All IO performed by musb misses out on the barriers - so what you
need to do is either add wmb()s to these, or you need to ensure
that the driver has the various necessary memory barriers in place.
The latter solution will be more efficient.
