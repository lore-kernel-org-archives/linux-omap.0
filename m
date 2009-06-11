From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimization
Date: Thu, 11 Jun 2009 12:24:26 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2F8C01E3@dlee03.ent.ti.com>
References: <20090611.101615.116356068.Hiroshi.DOYU@nokia.com>
 <2C1563023E232C49B9F505633D57C2DA12A209F463@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42868 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZFKRYe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 13:24:34 -0400
In-Reply-To: <2C1563023E232C49B9F505633D57C2DA12A209F463@dlee04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bagadia, Sripal" <bagadia@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sripal,

> Currently, display driver maps the video buffers to userspace with
> VM_RESERVED flag and pgprot_writecombine(). We are considering changi=
ng
> pgprot_writecombine() to pgprot_noncached() to eliminate the need of =
all
> cache maintenance overheads for video buffers.
>
-- Is this change in the current LO kernel ?

I agree there is an overhead of flushing the cache by calling get_user_=
pages function. But there is some additional stuff that this function d=
oes and I am afraid that by-passing this function call for a Buffer tha=
t has VM_RESERVED flag and the BUFFERABLBE flags might create issues.=20

The only reason get_user_pages is not used for the buffer that has VM_I=
O flag set is get_user_pages fails if this flag is set for the buffer. =
I am not sure if it is safe to by-pass the get_user_pages function call=
 for buffer that has VM_RESERVED flag set though.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Bagadia, Sripal
> Sent: Thursday, June 11, 2009 11:24 AM
> To: Hiroshi DOYU; Ramirez Luna, Omar
> Cc: felipe.contreras@gmail.com; ameya.palande@nokia.com; Menon, Nisha=
nth;
> Kanigeri, Hari; linux-omap@vger.kernel.org
> Subject: RE: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimizatio=
n
>=20
> > Would it be possible to tell the case/path, where
> L_PTE_CACHEABLE/L_PTE_BUFFERABLE is set with VM_IO/VM_RESERVED ?
>=20
> Currently, display driver maps the video buffers to userspace with
> VM_RESERVED flag and pgprot_writecombine(). We are considering changi=
ng
> pgprot_writecombine() to pgprot_noncached() to eliminate the need of =
all
> cache maintenance overheads for video buffers.
>=20
> Regarding Felipe's comment:
> > L_PTE_BUFFERABLE is obsolete, isn't it? L_PTE_MT_BUFFERABLE should =
be
> used instead.
>=20
> I was working on 2.6.27.10, and agree that this needs to be updated f=
or
> newer kernels.
>=20
>=20
> Regards,
> Sripal
>=20
> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Thursday, June 11, 2009 2:16 AM
> To: Ramirez Luna, Omar
> Cc: felipe.contreras@gmail.com; ameya.palande@nokia.com; Menon, Nisha=
nth;
> Bagadia, Sripal; Kanigeri, Hari; linux-omap@vger.kernel.org
> Subject: Re: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimizatio=
n
>=20
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Subject: Re: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimizatio=
n
> Date: Wed, 10 Jun 2009 10:25:39 +0300 (EEST)
>=20
> > From: "ext Ramirez Luna, Omar" <omar.ramirez@ti.com>
> > Subject: RE: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimizat=
ion
> > Date: Wed, 10 Jun 2009 01:18:29 +0200
> >
> > > Hi,
> > >
> > > [sending as plain text to l-o]
> > >
> > > Could you please comment on this patch.
> > >
> > > From: Sripal Bagadia <bagadia@ti.com>
> > > Date: Tue, 9 Jun 2009 16:05:09 -0500
> > > Subject: [PATCH] DSPBRIDGE: Video Playback Cache Optimization
> > >
> > > Avoid get_user_pages cache flush overheads for uncached & reserve=
d
> > > buffers (e.g. display & camera buffers).
> >
> > Would it be possible to tell the case/path, where no
> > L_PTE_CACHEABLE/L_PTE_BUFFERABLE is set with VM_IO/VM_RESERVED ?
>=20
> To be correct,
>   "where L_PTE_CACHEABLE/L_PTE_BUFFERABLE is set with VM_IO/VM_RESERV=
ED"
>=20
> > >
> > > Signed-off-by: Sripal Bagadia <bagadia@ti.com>
> > > ---
> > > =A0drivers/dsp/bridge/wmd/tiomap3430.c |=A0=A0=A0 4 +++-
> > > =A01 files changed, 3 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c
> > > b/drivers/dsp/bridge/wmd/tiomap3430.c
> > > index 7a9603d..a2f32e8 100644
> > > --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> > > +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> > > @@ -1461,7 +1461,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct
> > > WMD_DEV_CONTEXT *hDevContext,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto func_cont;
> > > =A0=A0=A0=A0=A0 }
> > >
> > > -=A0=A0=A0=A0 if (vma->vm_flags & VM_IO) {
> > > +=A0=A0=A0=A0 if ((vma->vm_flags & VM_IO) | ((vma->vm_flags & VM_=
RESERVED)
> > > +&&
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (~pgprot_val(vm=
a->vm_page_prot) & L_PTE_CACHEABLE)
> > > +&&
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (~pgprot_val(vm=
a->vm_page_prot) &
> > > +L_PTE_BUFFERABLE))) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 numUsrPgs =3D=A0 ulNumBytes / P=
G_SIZE_4K;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mpuAddr =3D ulMpuAddr;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DBG_Trace(DBG_LEVEL4,
> "WMD_BRD_MemMap:numOfActualTabEntries=3D%d,"
> > > --
> > > 1.6.2.4
> > >

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
