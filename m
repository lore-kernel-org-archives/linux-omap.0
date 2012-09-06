From: Tony Lindgren <tony@atomide.com>
Subject: Re: Converting OMAP's custom vram allocator
Date: Thu, 6 Sep 2012 13:55:14 -0700
Message-ID: <20120906205514.GN1303@atomide.com>
References: <1346839733.32747.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40033 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759876Ab2IFUzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:55:18 -0400
Content-Disposition: inline
In-Reply-To: <1346839733.32747.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120905 03:09]:
> Hi,
> 
> OMAP has a custom video ram allocator, which I'd like to remove and use
> the standard dma allocation functions.
> 
> There are two problems for which I'd like to hear suggestions or
> comments:
> 
> First one is that the dma_alloc_* functions map the allocated memory for
> cpu use. In many cases with OMAP DSS (display subsystem) this is not
> needed: the memory may be written only by the SGX or the DSP, and it's
> only read by the DSS, so it's never touched by the CPU.
> 
> This is even more true when using VRFB on omap3 (and probably TILER on
> omap4) for rotation, as VRFB hides the actual memory and offers rotated
> views. In this case the backend memory is never accessed by anyone else
> than VRFB.
> 
> Is there a way to allocate the memory without creating a mapping? While
> it won't break anything as such, the allocated areas can be quite large
> thus causing large areas of the kernel's memory space to be needlessly
> reserved.
> 
> The second case is passing a framebuffer address from the bootloader to
> the kernel. Often with mobile devices the bootloader will initialize the
> display hardware, showing a company logo or such. To keep the image on
> the screen when kernel starts we need to reserve the same physical
> memory area early at boot, and use that for the framebuffer.
> 
> I'm not sure if there's any actual problem with this one, presuming
> there is a solution for the first case. Somehow the memory is reserved
> at early boot time, and this is passed to the fb driver. But can the
> memory be managed the same way as in normal case (for example freeing
> it), or does it need to be handled as a special case?

Sounds like you might be able to do this all with CMA with some
additional patches?

Tony
