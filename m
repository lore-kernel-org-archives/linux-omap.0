From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
	cache line size
Date: Wed, 13 May 2009 15:50:26 +0300
Message-ID: <94a0d4530905130550s657d9312g664efe6c418b2b61@mail.gmail.com>
References: <94a0d4530905121441n4f1decf2y6c52d915459c1257@mail.gmail.com>
	 <20090513.121025.176657725.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905130413t5bddfee4le797c5083df79226@mail.gmail.com>
	 <20090513.143241.189725295.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:32826 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbZEMMu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 08:50:28 -0400
Received: by fg-out-1718.google.com with SMTP id 16so209704fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 05:50:28 -0700 (PDT)
In-Reply-To: <20090513.143241.189725295.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: h-kanigeri2@ti.com, nm@ti.com, linux-omap@vger.kernel.org

On Wed, May 13, 2009 at 2:32 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment f=
or dsp cache line size
> Date: Wed, 13 May 2009 13:13:35 +0200
>
>> On Wed, May 13, 2009 at 12:10 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.c=
om> wrote:
>> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> > Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignmen=
t for dsp cache line size
>> > Date: Tue, 12 May 2009 23:41:04 +0200
>> >
>> >> On Tue, May 12, 2009 at 8:38 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia=
=2Ecom> wrote:
>> >> > From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
>> >> > Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte align=
ment for dsp cache line size
>> >> > Date: Mon, 11 May 2009 20:26:11 +0200
>> >> >
>> >> >> To summarize the discussion.
>> >> >
>> >> > Thanks
>> >> >
>> >> >> We need to have the check for 128 bytes alignment (upper and
>> >> >> lower). The 2 places that this can be done are in flush functi=
on or
>> >> >> in Map function.
>> >> >>
>> >> >> =C2=A0 =C2=A0 =C2=A0 - I prefer the check is done in Map funct=
ion as Felipe
>> >> >> mentioned this function is bound to be called by MM components=
 as
>> >> >> opposed to Flush function.
>> >> >
>> >> > Mapping is totally another thing from this problem.
>> >> >
>> >> > Any page mapping is being done, forcing PAGE_SIZE as below, bec=
ause
>> >> > PAGE_SIZE(4KB) is the mininum unit from (io)mmu H/W perspective=
=2E This
>> >> > is same as ARM too. They've been aligned on 4KB already. So no =
need to
>> >> > worry about 128-byte alignement for mapping.
>> >>
>> >> It's the same address, you cannot flush an address that has not b=
een
>> >> mapped. Look at the dsp-dummy code[1].
>> >>
>> >> =C2=A0DSPProcessor_ReserveMemory(b->node, to_reserve, &b->reserve=
);
>> >> =C2=A0DSPProcessor_Map(b->node, b->data, b->size, b->reserve, &b-=
>map, 0);
>> >> =C2=A0DSPProcessor_FlushMemory(b->node, b->data, b->size, 0);
>> >>
>> >> See? b->data is used for *both* Map and FlushMemory. The only
>> >> difference is that you can skip FlushMemory, or flush half of the
>> >> memory area:
>> >> =C2=A0DSPProcessor_FlushMemory(b->node, b->data + (b->size / 2), =
b->size, 0);
>> >>
>> >> The only operation you cannot avoid is Map.
>> >>
>> >> > DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, =
u32 ulSize,
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
void *pReqAddr, void **ppMapAddr, u32 ulMapAttr)
>> >> > {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.....
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Calculate the page-aligned PA, VA=
 and size */
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0vaAlign =3D PG_ALIGN_LOW((u32) pReqA=
ddr, PG_SIZE_4K);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0paAlign =3D PG_ALIGN_LOW((u32) pMpuA=
ddr, PG_SIZE_4K);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeAlign =3D PG_ALIGN_HIGH(ulSize +=
 (u32)pMpuAddr - paAlign,
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PG_SIZE_4K);
>> >> >
>> >> > The points which we should take care of are bridge cache
>> >> > operations("PROC_Flush/Invalidate..()") and we should/can handl=
e this
>> >> > problem independently. It would cause another dependency and in=
crease
>> >> > another complexity again if we have to assume something(ex:
>> >> > "read-only" or "write-only" buffer) on other modules or expecti=
ng
>> >> > something on its "protocol".
>> >>
>> >> If we are not going to have a read-only/write-only flag then I'm
>> >> against adding the alignment check. It will only force user-space=
 to
>> >> do memory copies unnecessarily. That would kill performance
>> >> drastically. NAK!
>> >
>> > At least, better than allowing user to crash kernel.
>>
>> The kernel would crash even with that check because it's the softwar=
e
>> running in the *DSP* side that is causing the corruption.
>>
>> It sounds you are still not convinced by that so I'll write a test
>> application to make sure my assumption is correct.
>
> You misunderstood.
>
> There are 2 patterns when kernel crashes from ARM cache flush and DSP
> cache flush(*1).

Let's suppose that's true, if you enforce ARM cache flushes to be
aligned (pattern 1) the DSP cache flushes (pattern 2) can still
corrupt the memory. Therefore even with your check the potential for
memory corruption is still there.

But it doesn't seem it's true; I modified my dsp-dummy test to detect
memory corruption by constantly modifying the data before and after
the buffer sent to the DSP. Map, Flush and Invalidate are unaligned in
the ARM side, and not surprisingly there's memory corruption. *But* if
I modify the DSP socket node to don't flush/invalidate the first/last
128 bytes of the buffer then there's no memory corruption.

So that's proof Flush/Invalidate on ARM side don't cause memory
corruption. Do you want to see the code?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
