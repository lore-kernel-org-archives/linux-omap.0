From: Rob Clark <robdclark@gmail.com>
Subject: Re: Converting OMAP's custom vram allocator
Date: Thu, 6 Sep 2012 16:35:04 -0500
Message-ID: <CAF6AEGuaWO=8yueQQiCC=dr7pYaMRjTTdLzySfGd3PmX-R3P6Q@mail.gmail.com>
References: <1346839733.32747.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:65065 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933246Ab2IFVfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 17:35:05 -0400
Received: by vbbff1 with SMTP id ff1so2050473vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 14:35:04 -0700 (PDT)
In-Reply-To: <1346839733.32747.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, linaro-mm-sig@lists.linaro.org

On Wed, Sep 5, 2012 at 5:08 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
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

see dma_alloc_attrs() and DMA_ATTR_NO_KERNEL_MAPPING

> This is even more true when using VRFB on omap3 (and probably TILER on
> omap4) for rotation, as VRFB hides the actual memory and offers rotated
> views. In this case the backend memory is never accessed by anyone else
> than VRFB.

just fwiw, we don't actually need contiguous memory on o4/tiler :-)

(well, at least if you ignore things like secure playback)

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

with a bit of handwaving, this is possible.  You can pass a base
address to dma_declare_contiguous() when you setup your device's CMA
pool.  Although that doesn't really guarantee you're allocation from
that pool is at offset zero, I suppose.

> I'm not sure if there's any actual problem with this one, presuming
> there is a solution for the first case. Somehow the memory is reserved
> at early boot time, and this is passed to the fb driver. But can the
> memory be managed the same way as in normal case (for example freeing
> it), or does it need to be handled as a special case?

special-casing it might be better.. although possibly a dma attr could
be added for this to tell dma_alloc_from_contiguous() that we need a
particular address within the CMA pool.  It seems a bit like a hack,
but OTOH I guess pretty much every consumer device would need a hack
like this.

BR,
-R

>  Tomi
>
