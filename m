From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 17 May 2010 01:35:40 +0300
Message-ID: <AANLkTikxM8gISXO_wSVNOM6FKC8l5MbLy1nSMmgMB_4w@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	<r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	<AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:37644 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab0EPWgB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 18:36:01 -0400
Received: by ywh36 with SMTP id 36so2082820ywh.4
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 15:36:00 -0700 (PDT)
In-Reply-To: <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Felipe,

On Fri, May 14, 2010 at 10:27 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> I spent some time looking deeper into this patch series, and I have s=
ome doubts.
>
> On Sun, May 2, 2010 at 8:47 PM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
>> On Sun, May 2, 2010 at 4:17 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Sat, May 1, 2010 at 11:44 PM, Ohad Ben-Cohen <ohad@wizery.com> w=
rote:
>>>> =A0 The patchset renames the flush ioctl to begin_dma_to_dsp and
>>>> =A0 the invalidate ioctl to begin_dma_from_dsp. Both functions
>>>> =A0 eventually call dma_map_sg, with the former requesting a
>>>> =A0 DMA_BIDIRECTIONAL direction, and the latter requesting a
>>>> =A0 DMA_FROM_DEVICE direction.
>>>> =A0 In addition, the patchset adds two new APIs which calls dma_un=
map_sg:
>>>> =A0 end_dma_to_dsp and end_dma_from_dsp.
>>>>
>>>> =A0 Ideally, there would be only a single begin_dma command and a =
single
>>>> =A0 end_dma one, which would accept an additional parameter that w=
ill
>>>> =A0 determine the direction of the transfer. Such an approach woul=
d be more
>>>> =A0 versatile and cleaner, but it would also break all user space =
apps that
>>>> =A0 use dspbridge today.
>>>
>>> If I understand correctly all user-space apps would be broken anywa=
y
>>> because they are not issuing the end_dma calls. At the very least t=
hey
>>> need to be updated to use them.
>>
>> Basically you're right, but the patches currently silently allow
>> today's user space
>> to somehow work (because if you don't use dma bounce buffers and you=
 feel lucky
>> about speculative prefetching then you might get away with not calli=
ng
>> dma unmap).
>> I did that on purpose, to ease testing & migration, but didn't
>> explicitely said it because
>> =A0frankly it's just wrong.
>
> I looked into the dma code (I guess it's in arch/arm/mm/dma-mapping.c=
)
> and I don't understand what dma_unmap_sg is supposed to do.

Portable code must use the dma_unmap_* APIs.

As you mentioned, one of the things it's crucial for
(but not used in our case) is bounce buffers:
e.g. when doing a DMA from a device using a buffer
that is out of the platform's DMA reach,
the DMA API uses bounce buffers: data DMA'ed to that
bounce buffer, and then the dma unmap copies it back
to the original buffer).

Another thing unmap is taking care of is speculative prefetch:
modern ARM processors can access the buffer during DMA
in order to speculatively prefetch data into the cache. Naturally
this can seriously break a DMA from a device, so unmap is
invalidating the caches to prevent this.

The current dspbridge cache API is mostly relying on the
application to do the right thing: application programmer should
decide when to clean, flush or invalidate the caches in order
to have a successful DMA operation.

This is prone to mistakes, it's not portable, and of course
not upstreamable.

Using the standard DMA API we take the freedom from the
application programmer - we just ask him/her to tell us before
a DMA operation begins, and after it ends. The DMA API
is then responsible to do the right thing.

> first some "safe buffer" is searched, and if there isn't any... then
> it depends on the direction whether something is actually done or not=
=2E
>
> I guess it depends whether our arch has dmabounce or not, which I hav=
e
> no idea, but if we do, wouldn't skiping dma_unmap calls leak some
> massive amount of "safe buffers"?
>
>>> Also, in Nokia we patched the bridgedriver to be able to have the 3
>>> operations available from user-space (clean, inv, and flush), so we
>>> would be very interested in having the direction of the transfer
>>> available.
>>
>> Thanks, that's important to know.
>
> It's not that critical, but I guess it can't hurt to do the right thi=
ng.
>
>> What do you say about the following plan then:
>> - I'll add a single pair of begin_dma and end_dma commands that will
>> take the additional
>> direction parameter as described above. I'll then covert the existin=
g
>> flush & invalidate commands to use this begin_dma command supplying =
it
>> the appropriate direction argument.
>
> Sounds perfect, but I wonder if the deprecated flush & invalidate
> would really work. See previous comments.
>
>> - In a separate patch, I'll deprecate flush & invalidate entirely
>> (usage of this deprecated
>> API will fail, resulting in a guiding error message).
>>
>> We get a sane and versatile (and platform-independent) implementatio=
n
>> that always work,
>> but breaks user space. If anyone would need to work with current use=
r space,
>> the deprecating patch can always be reverted locally to get back a
>> flush & invalidate
>> implementations that (somehow) work.
>
> User-space API is being broken all the time in dspbridge. The
> difference is that this one might require nontrivial changes. But it
> must be done.
>
> So, I tried your patches, and a simple test app worked fine without
> modification, but a real video decoding hanged the device
> completely... some spinlock was stuck. I don't know if it's because o=
f
> your patches, or because of the state of the bridge at that point.
> I'll try first to rebase to the latest to have a better idea of what'=
s
> happening.

I read at your latest posts that after rebasing to newest dspbridge
code the issue doesn't reproduce anymore ? Please tell me if it's back.

>
> Also, I noticed an important problem. Your code assumes that we would
> always have a bunch of scattered pages, however you are not taking
> into account bridge_brd_mem_map() where vm_flags have VM_IO... in tha=
t
> case get_user_pages() is skipped completely. This code-path is
> important in order to mmap framebuffer memory, which is contiguous.
> So, in this case there are no pages too keep track at all.
>
> This use-case is very important since the dspbridge mmap operation is
> very expensive, and due to GStreamer design, we must do it
> constantly... if the memory is contiguous (VM_IO), the mmap operation
> is really fast (or at least should be... in theory).

Thanks for catching this VM_IO code path. I'll take care of this
and resubmit the patches.

>
> Reading your patches I see the ioctl to start the dmap operations
> would simply error out, but from the looks of it, they would be
> failing already, which is weird, because we are already using
> framebuffer memory for video decoding + rendering. In gst-dsp we are
> not checking the success of clean/invalidate ioctls so it might be
> that it has been failing all this time and seems to work by pure luck=
=2E
>
> Anyway, I'll keep investigating and let you know if I find anything.


Again thanks for your review,
your comments are very helpful.

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
