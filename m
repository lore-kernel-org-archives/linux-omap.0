From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
	cache line size
Date: Wed, 13 May 2009 00:41:04 +0300
Message-ID: <94a0d4530905121441n4f1decf2y6c52d915459c1257@mail.gmail.com>
References: <20090511.203528.258116329.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905111054x138375e3p5e2b6d08c9b31120@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF66543@dlee03.ent.ti.com>
	 <20090512.083840.42792590.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58487 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbZELVlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 17:41:05 -0400
Received: by fxm2 with SMTP id 2so256191fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 14:41:04 -0700 (PDT)
In-Reply-To: <20090512.083840.42792590.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: h-kanigeri2@ti.com, nm@ti.com, linux-omap@vger.kernel.org

On Tue, May 12, 2009 at 8:38 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment f=
or dsp cache line size
> Date: Mon, 11 May 2009 20:26:11 +0200
>
>> To summarize the discussion.
>
> Thanks
>
>> We need to have the check for 128 bytes alignment (upper and
>> lower). The 2 places that this can be done are in flush function or
>> in Map function.
>>
>> =C2=A0 =C2=A0 =C2=A0 - I prefer the check is done in Map function as=
 Felipe
>> mentioned this function is bound to be called by MM components as
>> opposed to Flush function.
>
> Mapping is totally another thing from this problem.
>
> Any page mapping is being done, forcing PAGE_SIZE as below, because
> PAGE_SIZE(4KB) is the mininum unit from (io)mmu H/W perspective. This
> is same as ARM too. They've been aligned on 4KB already. So no need t=
o
> worry about 128-byte alignement for mapping.

It's the same address, you cannot flush an address that has not been
mapped. Look at the dsp-dummy code[1].

 DSPProcessor_ReserveMemory(b->node, to_reserve, &b->reserve);
 DSPProcessor_Map(b->node, b->data, b->size, b->reserve, &b->map, 0);
 DSPProcessor_FlushMemory(b->node, b->data, b->size, 0);

See? b->data is used for *both* Map and FlushMemory. The only
difference is that you can skip FlushMemory, or flush half of the
memory area:
 DSPProcessor_FlushMemory(b->node, b->data + (b->size / 2), b->size, 0)=
;

The only operation you cannot avoid is Map.

> DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ul=
Size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *=
pReqAddr, void **ppMapAddr, u32 ulMapAttr)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.....
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Calculate the page-aligned PA, VA and s=
ize */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0vaAlign =3D PG_ALIGN_LOW((u32) pReqAddr, P=
G_SIZE_4K);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0paAlign =3D PG_ALIGN_LOW((u32) pMpuAddr, P=
G_SIZE_4K);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeAlign =3D PG_ALIGN_HIGH(ulSize + (u32)=
pMpuAddr - paAlign,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PG_SIZE_4K);
>
> The points which we should take care of are bridge cache
> operations("PROC_Flush/Invalidate..()") and we should/can handle this
> problem independently. It would cause another dependency and increase
> another complexity again if we have to assume something(ex:
> "read-only" or "write-only" buffer) on other modules or expecting
> something on its "protocol".

If we are not going to have a read-only/write-only flag then I'm
against adding the alignment check. It will only force user-space to
do memory copies unnecessarily. That would kill performance
drastically. NAK!

Even mmap has PROT_READ and PROT_WRITE, is that unnecessary complexity?

[1] http://github.com/felipec/dsp-dummy/blob/9806fd01c3bf8129d27a673086=
d286011565fc2c/dmm_buffer.h

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
