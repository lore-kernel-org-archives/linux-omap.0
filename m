From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 17 May 2010 02:51:20 +0300
Message-ID: <AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	 <r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	 <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	 <AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
	 <AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:50210 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0EPXvW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 19:51:22 -0400
Received: by ewy8 with SMTP id 8so1601633ewy.28
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 16:51:21 -0700 (PDT)
In-Reply-To: <AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hello,

On Mon, May 17, 2010 at 1:57 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Sun, May 16, 2010 at 8:35 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Now I understand better; arch/arm/mm/dma-mapping.c will not be used
>> unless CONFIG_DMABOUNCE=y, which is not the case for OMAP3.
>>
>> So, as you can see in arch/arm/include/asm/dma-mapping.h, dma_unmap_sgprefetching
>> is a noop.
>
> This has changed since 2.6.34, when support was added
> to ARM speculative prefetching. dma_unmap_* API is now
> responsible to invalidate caches when data was moved in from the device
> (regardless of CONFIG_DMABOUNCE).

Yes, I just realized that the implementation of dma_unmap changed. In
2.6.34 issues with speculative prefetching should be handled better
with dma_map/dma_unmap.

However, the situations the speculative prefetching fixes are supposed
to avoid, are present in any kernel <= 2.6.33, right? So, sure, it
would be nice to avoid those issues, but before that, the priority is
to get dspbridge working on 2.6.34.

So, in theory the easiest thing to do is to reach the deprecated API
dmac_flush_range/dmac_inv_range somehow.

Now, to simplify the analysis I'll ignore the portability arguments,
and concentrate on OMAP3, which is the only platform really supported
by the dspbridge. Here OUTER_CACHE=n, so, outer_*_range are no ops.

So currently (v2.6.33), before sending a read-olny buffer (TO_DEVICE),
we do dmac_flush_range (should be clean, but whatever), and before
sending a write-only (FROM_DEVICE), we do dmac_inv_range.

On v2.6.33 the same could be achieved with only dma_map_* functions,
but on v2.6.34 that's not the case.

This is what a properly implemented application with dma_map_* and
dma_map_* functions would end up doing to achieve similar behavior:

in: begin BIDI:
	dma_clean_range

out: begin FROM_DEV:
	dma_clean_range

out: end FROM_DEV:
	dma_inv_range

in: end BIDI:
	dma_inv_range

>From my reduced experience in caches I already see a problem there,
but that's irrelevant right now. Wouldn't the old
PROC_FLUSHMEMORY/PROC_INVALIDATEMEMORY behavior be achieved by calling
the begin and end operations at the same time? Or even easier, just
call dmac_flush_range (which is not obsolete yet)?

I'm not saying this should be the final solution... we should
definitely go for the right API, but in the meantime, I think the old
applications that still use the old API can work just fine if we call
dmac_flush_range(). This is only for compatibility reasons.

Here I'm assuming that applications would call PROC_INVALIDATEMEMORY
*before* sending the buffer to the DSP, which is the case for both
openmax and gst-dsp.

> Dspbridge really must support this, and applications should start
> using it.
>
> Whether to deprecate the old API ? Eventually I think we should,
> but probably not anytime soon. Let's take the kernel approach of minimizing
> user space pain: keep the old API around, mark it as candidate for
> deprecation, and rethink in the future.

Now that I see the changes for speculative prefetching, yeah, I agree.
But I think we can minimize the pain even more by providing an old
compatible API that actually works well (almost as good as before).

Cheers.

-- 
Felipe Contreras
