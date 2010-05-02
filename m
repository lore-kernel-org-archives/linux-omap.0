From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Sun, 2 May 2010 20:47:38 +0300
Message-ID: <r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:39555 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758345Ab0EBRr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 13:47:59 -0400
Received: by gxk9 with SMTP id 9so1025592gxk.8
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 10:47:58 -0700 (PDT)
In-Reply-To: <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Sun, May 2, 2010 at 4:17 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, May 1, 2010 at 11:44 PM, Ohad Ben-Cohen <ohad@wizery.com> wro=
te:
>> This patchset introduces an approach to eliminate the direct calls
>> to follow_page and to the low level cache APIs.
>>
>> The patchset works by caching the page information while memory
>> is mapped, and then using that information later when needed
>> instead of calling follow_page. The low level cache API is then repl=
aced
>> by the standard DMA API.
>
> Finally! Very interesting patch indeed.

Thanks!

>
>> A few key points in the current approach that I'd be happy to hear
>> your feedback about:
>> 1. The new mapping + page information is currently cached in the
>> =A0 proc object, but it might fit better inside dmm map objects
>> =A0 (by enhancing the DMM layer to support the required data caching=
,
>> =A0 storing and retrieving).
>
> Sounds like a good idea.

Great, I'll look into this.

>
>> 2. The information is stored in a linked list. That's pretty fine
>> =A0 as long as the number of memory mappings per application is not
>> =A0 extremely high. If that assumption is wrong, a different underly=
ing
>> =A0 data structure might be better (hash table, priority tree, etc..=
).
>
> I think a linked list is fine for now. AFAIK only a limited number of
> mmaps happen at the same time, usually 4.

Thanks for confirming.

>
>> 3. Moving to standard DMA API completely changes the user's point
>> =A0 of view; users should no longer think in terms of which cache
>> =A0 manipulation is required, but instead, they should just tell dsp=
bridge
>> =A0 before a DMA transfer begins, and after it ends. Between the beg=
in
>> =A0 and end calls, the buffer "belongs" to the DSP and should not
>> =A0 be accessed by the user.
>
> This is really nice. That API should have been that way since the beg=
inning.
>
>> =A0 The patchset renames the flush ioctl to begin_dma_to_dsp and
>> =A0 the invalidate ioctl to begin_dma_from_dsp. Both functions
>> =A0 eventually call dma_map_sg, with the former requesting a
>> =A0 DMA_BIDIRECTIONAL direction, and the latter requesting a
>> =A0 DMA_FROM_DEVICE direction.
>> =A0 In addition, the patchset adds two new APIs which calls dma_unma=
p_sg:
>> =A0 end_dma_to_dsp and end_dma_from_dsp.
>>
>> =A0 Ideally, there would be only a single begin_dma command and a si=
ngle
>> =A0 end_dma one, which would accept an additional parameter that wil=
l
>> =A0 determine the direction of the transfer. Such an approach would =
be more
>> =A0 versatile and cleaner, but it would also break all user space ap=
ps that
>> =A0 use dspbridge today.
>
> If I understand correctly all user-space apps would be broken anyway
> because they are not issuing the end_dma calls. At the very least the=
y
> need to be updated to use them.

Basically you're right, but the patches currently silently allow
today's user space
to somehow work (because if you don't use dma bounce buffers and you fe=
el lucky
about speculative prefetching then you might get away with not calling
dma unmap).
I did that on purpose, to ease testing & migration, but didn't
explicitely said it because
 frankly it's just wrong.

>
> Also, in Nokia we patched the bridgedriver to be able to have the 3
> operations available from user-space (clean, inv, and flush), so we
> would be very interested in having the direction of the transfer
> available.

Thanks, that's important to know.

What do you say about the following plan then:
- I'll add a single pair of begin_dma and end_dma commands that will
take the additional
direction parameter as described above. I'll then covert the existing
flush & invalidate commands to use this begin_dma command supplying it
the appropriate direction argument.
- In a separate patch, I'll deprecate flush & invalidate entirely
(usage of this deprecated
API will fail, resulting in a guiding error message).

We get a sane and versatile (and platform-independent) implementation
that always work,
but breaks user space. If anyone would need to work with current user s=
pace,
the deprecating patch can always be reverted locally to get back a
flush & invalidate
implementations that (somehow) work.

Anyway, I'm sure that breaking user space can be somewhat traumatic so
let's make sure
we get an across-the-board support for this.

Thanks a lot for the comments!
Ohad.

>
> Cheers.
>
> --
> Felipe Contreras
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
