From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 17 May 2010 02:15:34 +0300
Message-ID: <AANLkTikAkqatIMvdFPwVvwYV_4Tw3-SsUkBAjwK2Oa_P@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	 <r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	 <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	 <AANLkTikxM8gISXO_wSVNOM6FKC8l5MbLy1nSMmgMB_4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41403 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab0EPXPu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 19:15:50 -0400
Received: by fxm6 with SMTP id 6so3228143fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 16:15:48 -0700 (PDT)
In-Reply-To: <AANLkTikxM8gISXO_wSVNOM6FKC8l5MbLy1nSMmgMB_4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Ohad,

On Mon, May 17, 2010 at 1:35 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Fri, May 14, 2010 at 10:27 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> I looked into the dma code (I guess it's in arch/arm/mm/dma-mapping.c)
>> and I don't understand what dma_unmap_sg is supposed to do.
>
> Portable code must use the dma_unmap_* APIs.
>
> As you mentioned, one of the things it's crucial for
> (but not used in our case) is bounce buffers:
> e.g. when doing a DMA from a device using a buffer
> that is out of the platform's DMA reach,
> the DMA API uses bounce buffers: data DMA'ed to that
> bounce buffer, and then the dma unmap copies it back
> to the original buffer).

Yes, but in dspbridge the most important use-case is video
encoding/decoding, so we definitely don't want bouncing buffers.
Besides, from what I can see very few platforms need them.

> Another thing unmap is taking care of is speculative prefetch:
> modern ARM processors can access the buffer during DMA
> in order to speculatively prefetch data into the cache. Naturally
> this can seriously break a DMA from a device, so unmap is
> invalidating the caches to prevent this.
>
> The current dspbridge cache API is mostly relying on the
> application to do the right thing: application programmer should
> decide when to clean, flush or invalidate the caches in order
> to have a successful DMA operation.
>
> This is prone to mistakes, it's not portable, and of course
> not upstreamable.
>
> Using the standard DMA API we take the freedom from the
> application programmer - we just ask him/her to tell us before
> a DMA operation begins, and after it ends. The DMA API
> is then responsible to do the right thing.

It is a higher level of abstraction, but the application still needs
to do the right thing, and errors can still happen. Anyway, I see now
the changes 2.6.34.
can
> I read at your latest posts that after rebasing to newest dspbridge
> code the issue doesn't reproduce anymore ? Please tell me if it's back.

Yes... I haven't tried in the old commit you started from + the patch
Omar suggested, but I guess there's no need for that any more. I can
play with this code now :)

-- 
Felipe Contreras
