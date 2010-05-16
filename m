From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 17 May 2010 01:57:36 +0300
Message-ID: <AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	<r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	<AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	<AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58879 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab0EPW55 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 18:57:57 -0400
Received: by gyg13 with SMTP id 13so1844480gyg.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 15:57:56 -0700 (PDT)
In-Reply-To: <AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Felipe,

On Sun, May 16, 2010 at 8:35 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, May 14, 2010 at 10:27 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> I spent some time looking deeper into this patch series, and I have =
some doubts.
>>
>> On Sun, May 2, 2010 at 8:47 PM, Ohad Ben-Cohen <ohad@wizery.com> wro=
te:
>>> Basically you're right, but the patches currently silently allow
>>> today's user space
>>> to somehow work (because if you don't use dma bounce buffers and yo=
u feel lucky
>>> about speculative prefetching then you might get away with not call=
ing
>>> dma unmap).
>>> I did that on purpose, to ease testing & migration, but didn't
>>> explicitely said it because
>>> =A0frankly it's just wrong.
>>
>> I looked into the dma code (I guess it's in arch/arm/mm/dma-mapping.=
c)
>> and I don't understand what dma_unmap_sg is supposed to do. I see th=
at
>> first some "safe buffer" is searched, and if there isn't any... then
>> it depends on the direction whether something is actually done or no=
t.
>>
>> I guess it depends whether our arch has dmabounce or not, which I ha=
ve
>> no idea, but if we do, wouldn't skiping dma_unmap calls leak some
>> massive amount of "safe buffers"?
>
> Now I understand better; arch/arm/mm/dma-mapping.c will not be used
> unless CONFIG_DMABOUNCE=3Dy, which is not the case for OMAP3.
>
> So, as you can see in arch/arm/include/asm/dma-mapping.h, dma_unmap_s=
g
> is a noop.

This has changed since 2.6.34, when support was added
to ARM speculative prefetching. dma_unmap_* API is now
responsible to invalidate caches when data was moved in from the device
(regardless of CONFIG_DMABOUNCE).

Dspbridge really must support this, and applications should start
using it.

Whether to deprecate the old API ? Eventually I think we should,
but probably not anytime soon. Let's take the kernel approach of minimi=
zing
user space pain: keep the old API around, mark it as candidate for
deprecation, and rethink in the future.

Thanks,
Ohad.

>
> static inline void dma_unmap_single(struct device *dev, dma_addr_t ha=
ndle,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t size, enum dma_data_direction d=
ir)
> {
> =A0 =A0 =A0 =A0/* nothing to do */
> }
>
> So, in the end, PROC_BEGINDMATODSP and PROC_BEGINDMAFROMDSP would do
> exactly the same as PROC_FLUSHMEMORY and PROC_INVALIDATEMEMORY
> (dmac_op_range/outer_io_range). And
> PROC_ENDDMATODSP/PROC_ENDDMAFROMDSP don't do anything. Therefore even
> if user-space updates to the new API, there's no change.
>
> I don't think it makes sense to push for this new API since there wil=
l
> be absolutely no gain.
>
>>> What do you say about the following plan then:
>>> - I'll add a single pair of begin_dma and end_dma commands that wil=
l
>>> take the additional
>>> direction parameter as described above. I'll then covert the existi=
ng
>>> flush & invalidate commands to use this begin_dma command supplying=
 it
>>> the appropriate direction argument.
>>
>> Sounds perfect, but I wonder if the deprecated flush & invalidate
>> would really work. See previous comments.
>
> Actually it would work. I like this approach because it doesn't break
> ABI, and doesn't change the semantics unless the new ioctls are used.
>
>>> - In a separate patch, I'll deprecate flush & invalidate entirely
>>> (usage of this deprecated
>>> API will fail, resulting in a guiding error message).
>
> I don't think there's any need for deprecation.
>
>>> We get a sane and versatile (and platform-independent) implementati=
on
>>> that always work,
>>> but breaks user space. If anyone would need to work with current us=
er space,
>>> the deprecating patch can always be reverted locally to get back a
>>> flush & invalidate
>>> implementations that (somehow) work.
>
> I still would like the new API for the reason I mentioned before: so
> that user-space can clean/invalidate/flush.
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
