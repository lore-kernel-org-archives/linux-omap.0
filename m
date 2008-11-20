From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: OMAP Framebuffer memory allocation and mapping
Date: Thu, 20 Nov 2008 12:52:09 +0200
Message-ID: <1227178329.6860.139.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24222 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbYKTKwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 05:52:15 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAKApxeh002087
	for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 12:52:13 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have a couple of questions regarding the memory management for the new
display subsystem.

The new DSS allocates memory with dma_alloc_writecombine() and mmaps it
to user space with dma_mmap_writecombine(). Allocation is done when
omapfb starts up. Normally memory gets very quickly too fragmented for
dma_alloc_writecombine() to work, but setting
CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE helps this.

However, even when CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE is set to 14, I
am, for some reason, not able to allocate 1280x1024x4 (~5.2M)
framebuffer. Could the consistent DMA area be already too fragmented, or
is there some size limit there?

There's also support to allocate fb memory in very early phase with
reserve_bootmem(), which needs a predefined physical address and size
that can come from the bootloader. I've been looking at the old DSS to
see how this memory should be mapped, but I haven't been able to get it
to work. It looks like the DSS DMA and the user space have a bit
different view of the memory, so my assumption is that there's some
caching or similar being done.

So how to setup the memory gotten from reserve_bootmem() (or
alloc_bootmem()) so that it would work the same way as
dma_alloc_writecombine()'s memory?

And generally: any other ideas how to improve the memory management of
the DSS?

 Tomi


