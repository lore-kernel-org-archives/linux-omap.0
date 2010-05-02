From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Sun, 2 May 2010 16:17:40 +0300
Message-ID: <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54399 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab0EBNRm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 09:17:42 -0400
Received: by bwz19 with SMTP id 19so861726bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 06:17:41 -0700 (PDT)
In-Reply-To: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Sat, May 1, 2010 at 11:44 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> This patchset introduces an approach to eliminate the direct calls
> to follow_page and to the low level cache APIs.
>
> The patchset works by caching the page information while memory
> is mapped, and then using that information later when needed
> instead of calling follow_page. The low level cache API is then repla=
ced
> by the standard DMA API.

=46inally! Very interesting patch indeed.

> A few key points in the current approach that I'd be happy to hear
> your feedback about:
> 1. The new mapping + page information is currently cached in the
> =C2=A0 proc object, but it might fit better inside dmm map objects
> =C2=A0 (by enhancing the DMM layer to support the required data cachi=
ng,
> =C2=A0 storing and retrieving).

Sounds like a good idea.

> 2. The information is stored in a linked list. That's pretty fine
> =C2=A0 as long as the number of memory mappings per application is no=
t
> =C2=A0 extremely high. If that assumption is wrong, a different under=
lying
> =C2=A0 data structure might be better (hash table, priority tree, etc=
=2E.).

I think a linked list is fine for now. AFAIK only a limited number of
mmaps happen at the same time, usually 4.

> 3. Moving to standard DMA API completely changes the user's point
> =C2=A0 of view; users should no longer think in terms of which cache
> =C2=A0 manipulation is required, but instead, they should just tell d=
spbridge
> =C2=A0 before a DMA transfer begins, and after it ends. Between the b=
egin
> =C2=A0 and end calls, the buffer "belongs" to the DSP and should not
> =C2=A0 be accessed by the user.

This is really nice. That API should have been that way since the begin=
ning.

> =C2=A0 The patchset renames the flush ioctl to begin_dma_to_dsp and
> =C2=A0 the invalidate ioctl to begin_dma_from_dsp. Both functions
> =C2=A0 eventually call dma_map_sg, with the former requesting a
> =C2=A0 DMA_BIDIRECTIONAL direction, and the latter requesting a
> =C2=A0 DMA_FROM_DEVICE direction.
> =C2=A0 In addition, the patchset adds two new APIs which calls dma_un=
map_sg:
> =C2=A0 end_dma_to_dsp and end_dma_from_dsp.
>
> =C2=A0 Ideally, there would be only a single begin_dma command and a =
single
> =C2=A0 end_dma one, which would accept an additional parameter that w=
ill
> =C2=A0 determine the direction of the transfer. Such an approach woul=
d be more
> =C2=A0 versatile and cleaner, but it would also break all user space =
apps that
> =C2=A0 use dspbridge today.

If I understand correctly all user-space apps would be broken anyway
because they are not issuing the end_dma calls. At the very least they
need to be updated to use them.

Also, in Nokia we patched the bridgedriver to be able to have the 3
operations available from user-space (clean, inv, and flush), so we
would be very interested in having the direction of the transfer
available.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
