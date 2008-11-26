From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP Framebuffer memory allocation and mapping
Date: Wed, 26 Nov 2008 15:07:03 -0800
Message-ID: <20081126230702.GL11997@atomide.com>
References: <1227178329.6860.139.camel@tubuntu> <19F8576C6E063C45BE387C64729E739403E8E67B08@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60808 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYKZXHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 18:07:04 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E8E67B08@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [081120 03:25]:
> 
> 
> Thanks,
> Vaibhav Hiremath
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> > Sent: Thursday, November 20, 2008 4:22 PM
> > To: linux-omap@vger.kernel.org
> > Subject: OMAP Framebuffer memory allocation and mapping
> > 
> > Hi,
> > 
> > I have a couple of questions regarding the memory management for the
> > new
> > display subsystem.
> > 
> > The new DSS allocates memory with dma_alloc_writecombine() and mmaps
> > it
> > to user space with dma_mmap_writecombine(). Allocation is done when
> > omapfb starts up. Normally memory gets very quickly too fragmented
> > for
> > dma_alloc_writecombine() to work, but setting
> > CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE helps this.
> > 
> > However, even when CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE is set to 14,
> > I
> > am, for some reason, not able to allocate 1280x1024x4 (~5.2M)
> > framebuffer. Could the consistent DMA area be already too
> > fragmented, or
> > is there some size limit there?
> > 
> [Hiremath, Vaibhav] Similar issue I had also faced while implementing VRFB rotation on new DSS of yours. I increased the value of MAX_ORDER to 12 (currently set to 11), defined in include/linux/mmzone.h file. And it worked for me; I am allocating 2048*720*4 bytes of buffer.
> 
> I am not sure community acceptance on this, probably somebody could suggest better way to this.

You might want to dump out the start and end address of you memory
area and make sure it does not overlap with anything else. Earlier
you had to reserve large areas during memory init.. I doubt that it's
still the case though. See also Documentation/arm/memory.txt.

Tony


> > There's also support to allocate fb memory in very early phase with
> > reserve_bootmem(), which needs a predefined physical address and
> > size
> > that can come from the bootloader. I've been looking at the old DSS
> > to
> > see how this memory should be mapped, but I haven't been able to get
> > it
> > to work. It looks like the DSS DMA and the user space have a bit
> > different view of the memory, so my assumption is that there's some
> > caching or similar being done.
> > 
> > So how to setup the memory gotten from reserve_bootmem() (or
> > alloc_bootmem()) so that it would work the same way as
> > dma_alloc_writecombine()'s memory?
> > 
> > And generally: any other ideas how to improve the memory management
> > of
> > the DSS?
> > 
> >  Tomi
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
