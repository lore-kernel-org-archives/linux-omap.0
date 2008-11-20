From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP Framebuffer memory allocation and mapping
Date: Thu, 20 Nov 2008 16:55:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E8E67B08@dbde02.ent.ti.com>
References: <1227178329.6860.139.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468AbYKTLZP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 06:25:15 -0500
In-Reply-To: <1227178329.6860.139.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> Sent: Thursday, November 20, 2008 4:22 PM
> To: linux-omap@vger.kernel.org
> Subject: OMAP Framebuffer memory allocation and mapping
> 
> Hi,
> 
> I have a couple of questions regarding the memory management for the
> new
> display subsystem.
> 
> The new DSS allocates memory with dma_alloc_writecombine() and mmaps
> it
> to user space with dma_mmap_writecombine(). Allocation is done when
> omapfb starts up. Normally memory gets very quickly too fragmented
> for
> dma_alloc_writecombine() to work, but setting
> CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE helps this.
> 
> However, even when CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE is set to 14,
> I
> am, for some reason, not able to allocate 1280x1024x4 (~5.2M)
> framebuffer. Could the consistent DMA area be already too
> fragmented, or
> is there some size limit there?
> 
[Hiremath, Vaibhav] Similar issue I had also faced while implementing VRFB rotation on new DSS of yours. I increased the value of MAX_ORDER to 12 (currently set to 11), defined in include/linux/mmzone.h file. And it worked for me; I am allocating 2048*720*4 bytes of buffer.

I am not sure community acceptance on this, probably somebody could suggest better way to this.

> There's also support to allocate fb memory in very early phase with
> reserve_bootmem(), which needs a predefined physical address and
> size
> that can come from the bootloader. I've been looking at the old DSS
> to
> see how this memory should be mapped, but I haven't been able to get
> it
> to work. It looks like the DSS DMA and the user space have a bit
> different view of the memory, so my assumption is that there's some
> caching or similar being done.
> 
> So how to setup the memory gotten from reserve_bootmem() (or
> alloc_bootmem()) so that it would work the same way as
> dma_alloc_writecombine()'s memory?
> 
> And generally: any other ideas how to improve the memory management
> of
> the DSS?
> 
>  Tomi
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

