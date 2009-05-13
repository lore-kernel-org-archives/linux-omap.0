From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
 cache line size
Date: Wed, 13 May 2009 14:32:41 +0300 (EEST)
Message-ID: <20090513.143241.189725295.Hiroshi.DOYU@nokia.com>
References: <94a0d4530905121441n4f1decf2y6c52d915459c1257@mail.gmail.com>
	<20090513.121025.176657725.Hiroshi.DOYU@nokia.com>
	<94a0d4530905130413t5bddfee4le797c5083df79226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31659 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756098AbZEMLc4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 07:32:56 -0400
In-Reply-To: <94a0d4530905130413t5bddfee4le797c5083df79226@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: h-kanigeri2@ti.com, nm@ti.com, linux-omap@vger.kernel.orgnm@ti.com

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for=
 dsp cache line size
Date: Wed, 13 May 2009 13:13:35 +0200

> On Wed, May 13, 2009 at 12:10 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
> > Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment=
 for dsp cache line size
> > Date: Tue, 12 May 2009 23:41:04 +0200
> >
> >> On Tue, May 12, 2009 at 8:38 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.=
com> wrote:
> >> > From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> >> > Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignm=
ent for dsp cache line size
> >> > Date: Mon, 11 May 2009 20:26:11 +0200
> >> >
> >> >> To summarize the discussion.
> >> >
> >> > Thanks
> >> >
> >> >> We need to have the check for 128 bytes alignment (upper and
> >> >> lower). The 2 places that this can be done are in flush functio=
n or
> >> >> in Map function.
> >> >>
> >> >> =A0 =A0 =A0 - I prefer the check is done in Map function as Fel=
ipe
> >> >> mentioned this function is bound to be called by MM components =
as
> >> >> opposed to Flush function.
> >> >
> >> > Mapping is totally another thing from this problem.
> >> >
> >> > Any page mapping is being done, forcing PAGE_SIZE as below, beca=
use
> >> > PAGE_SIZE(4KB) is the mininum unit from (io)mmu H/W perspective.=
 This
> >> > is same as ARM too. They've been aligned on 4KB already. So no n=
eed to
> >> > worry about 128-byte alignement for mapping.
> >>
> >> It's the same address, you cannot flush an address that has not be=
en
> >> mapped. Look at the dsp-dummy code[1].
> >>
> >> =A0DSPProcessor_ReserveMemory(b->node, to_reserve, &b->reserve);
> >> =A0DSPProcessor_Map(b->node, b->data, b->size, b->reserve, &b->map=
, 0);
> >> =A0DSPProcessor_FlushMemory(b->node, b->data, b->size, 0);
> >>
> >> See? b->data is used for *both* Map and FlushMemory. The only
> >> difference is that you can skip FlushMemory, or flush half of the
> >> memory area:
> >> =A0DSPProcessor_FlushMemory(b->node, b->data + (b->size / 2), b->s=
ize, 0);
> >>
> >> The only operation you cannot avoid is Map.
> >>
> >> > DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u=
32 ulSize,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *pReqAddr, void **ppMap=
Addr, u32 ulMapAttr)
> >> > {
> >> > =A0 =A0 =A0 =A0.....
> >> > =A0 =A0 =A0 =A0/* Calculate the page-aligned PA, VA and size */
> >> > =A0 =A0 =A0 =A0vaAlign =3D PG_ALIGN_LOW((u32) pReqAddr, PG_SIZE_=
4K);
> >> > =A0 =A0 =A0 =A0paAlign =3D PG_ALIGN_LOW((u32) pMpuAddr, PG_SIZE_=
4K);
> >> > =A0 =A0 =A0 =A0sizeAlign =3D PG_ALIGN_HIGH(ulSize + (u32)pMpuAdd=
r - paAlign,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
PG_SIZE_4K);
> >> >
> >> > The points which we should take care of are bridge cache
> >> > operations("PROC_Flush/Invalidate..()") and we should/can handle=
 this
> >> > problem independently. It would cause another dependency and inc=
rease
> >> > another complexity again if we have to assume something(ex:
> >> > "read-only" or "write-only" buffer) on other modules or expectin=
g
> >> > something on its "protocol".
> >>
> >> If we are not going to have a read-only/write-only flag then I'm
> >> against adding the alignment check. It will only force user-space =
to
> >> do memory copies unnecessarily. That would kill performance
> >> drastically. NAK!
> >
> > At least, better than allowing user to crash kernel.
>=20
> The kernel would crash even with that check because it's the software
> running in the *DSP* side that is causing the corruption.
>=20
> It sounds you are still not convinced by that so I'll write a test
> application to make sure my assumption is correct.

You misunderstood.

There are 2 patterns when kernel crashes from ARM cache flush and DSP
cache flush(*1).

1: https://omapzoom.org/gf/download/docmanfileversion/52/985/DSP_cache.=
pdf
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
