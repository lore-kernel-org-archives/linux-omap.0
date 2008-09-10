From: "Singh, Vimal" <vimalsingh@ti.com>
Subject: RE: [Resend][PATCH - Omapzoom][NAND] Add prefetch and DMA support
Date: Wed, 10 Sep 2008 16:17:47 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD517C42@dbde02.ent.ti.com>
References: <1220897015-14338-1-git-send-email-nskamat@ti.com>,<20080908181319.GH8266@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44008 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbYIJKsD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 06:48:03 -0400
In-Reply-To: <20080908181319.GH8266@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Kamat, Nishant" <nskamat@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> On Mon, Sep 08, 2008 at 01:03:35PM -0500, nskamat@ti.com wrote:
> > +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
> > +     static int use_prefetch = 1;
> > +
> > +     /* "modprobe ... use_prefetch=0" etc */
> > +     module_param(use_prefetch, bool, 0);
> > +     MODULE_PARM_DESC(use_prefetch, "enable/disable use of PREFETCH");
> 
> Don't indent C code just because there's preprocessor stuff around it.

Ok, I will remove it.


> > +     init_completion(&info->comp);
> > +     dma_sync_single_for_cpu(&info->pdev->dev,
> > +                             virt_to_phys(addr), count, DMA_TO_DEVICE);
> 
> Please read the DMA API and use the proper functions.  This is an abuse
> of the DMA API.
> 
> > +     omap_start_dma(info->dma_ch);
> > +     wait_for_completion(&info->comp);
> > +     if (!is_write)
> > +             dma_sync_single_for_cpu(&info->pdev->dev,
> > +                             virt_to_phys(addr), count, DMA_FROM_DEVICE);
> 
> Ditto.  This is an abuse of the API.  This is how it's supposed to work:
> 
> 
>         enum dma_direction dir = is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>         dma_addr_t dma_addr;
> 
>         dma_addr = dma_map_single(&info->pdev->dev, addr, count, dir);
> 
>         /* setup and start DMA using dma_addr */
> 
>         wait_for_completion(&info->comp);
> 
>         dma_unmap_single(&info->pdev->dev, dma_addr, count, dir);
> 

I will fix this in my next patch.


> > @@ -201,11 +304,33 @@
> >       struct omap_nand_info *info = container_of(mtd,
> >                                       struct omap_nand_info, mtd);
> >       u16 *p = (u16 *) buf;
> > -
> > -     len >>= 1;
> > -
> > -     while (len--)
> > -             *p++ = cpu_to_le16(readw(info->nand.IO_ADDR_R));
> 
> This driver needs work (see endianness explaination below.)

This has been fixed by David Brownell, and I will re-base my patch on top of it.

> > +                     while (len) {
> > +                             bytes_to_read  = ((prefetch_status >> 24) & 0x7F) >> 1;
> > +                             for (i = 0; (i < bytes_to_read) && (len); i++, len -= 2)
> > +                                     *p++ = cpu_to_le16(*(volatile u16 *)(info->nand_pref_fifo_add));
> 
> Yet you dereference it.  This is illegal according to the Linux APIs.
> Use __raw_readw() here.

Ok, I will do this.

> Moreover, 'p' is a pointer to CPU endian memory, not le16 memory, so
> using cpu_to_le16 is wrong here.  What endian is there data in flash?

Accessing nand flash is done by prefetch engine, which is also part of omap,
so has same endianness.
Yes I will remove cpu_to_le16 in my next patch.



Thanks,
vimal