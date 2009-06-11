From: "Bagadia, Sripal" <bagadia@ti.com>
Subject: RE: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimization
Date: Thu, 11 Jun 2009 11:24:19 -0500
Message-ID: <2C1563023E232C49B9F505633D57C2DA12A209F463@dlee04.ent.ti.com>
References: <20090611.101615.116356068.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36663 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476AbZFKQ0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 12:26:40 -0400
In-Reply-To: <20090611.101615.116356068.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Would it be possible to tell the case/path, where L_PTE_CACHEABLE/L_P=
TE_BUFFERABLE is set with VM_IO/VM_RESERVED ?

Currently, display driver maps the video buffers to userspace with VM_R=
ESERVED flag and pgprot_writecombine(). We are considering changing pgp=
rot_writecombine() to pgprot_noncached() to eliminate the need of all c=
ache maintenance overheads for video buffers.

Regarding Felipe's comment:
> L_PTE_BUFFERABLE is obsolete, isn't it? L_PTE_MT_BUFFERABLE should be=
 used instead.=20

I was working on 2.6.27.10, and agree that this needs to be updated for=
 newer kernels.=20


Regards,
Sripal

-----Original Message-----
=46rom: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]=20
Sent: Thursday, June 11, 2009 2:16 AM
To: Ramirez Luna, Omar
Cc: felipe.contreras@gmail.com; ameya.palande@nokia.com; Menon, Nishant=
h; Bagadia, Sripal; Kanigeri, Hari; linux-omap@vger.kernel.org
Subject: Re: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimization

=46rom: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimization
Date: Wed, 10 Jun 2009 10:25:39 +0300 (EEST)

> From: "ext Ramirez Luna, Omar" <omar.ramirez@ti.com>
> Subject: RE: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimizatio=
n
> Date: Wed, 10 Jun 2009 01:18:29 +0200
>=20
> > Hi,
> >=20
> > [sending as plain text to l-o]
> >=20
> > Could you please comment on this patch.
> >=20
> > From: Sripal Bagadia <bagadia@ti.com>
> > Date: Tue, 9 Jun 2009 16:05:09 -0500
> > Subject: [PATCH] DSPBRIDGE: Video Playback Cache Optimization
> >=20
> > Avoid get_user_pages cache flush overheads for uncached & reserved=20
> > buffers (e.g. display & camera buffers).
>=20
> Would it be possible to tell the case/path, where no=20
> L_PTE_CACHEABLE/L_PTE_BUFFERABLE is set with VM_IO/VM_RESERVED ?

To be correct,
  "where L_PTE_CACHEABLE/L_PTE_BUFFERABLE is set with VM_IO/VM_RESERVED=
"

> >=20
> > Signed-off-by: Sripal Bagadia <bagadia@ti.com>
> > ---
> > =A0drivers/dsp/bridge/wmd/tiomap3430.c |=A0=A0=A0 4 +++-
> > =A01 files changed, 3 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c=20
> > b/drivers/dsp/bridge/wmd/tiomap3430.c
> > index 7a9603d..a2f32e8 100644
> > --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> > +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> > @@ -1461,7 +1461,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct=20
> > WMD_DEV_CONTEXT *hDevContext,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto func_cont;
> > =A0=A0=A0=A0=A0 }
> > =A0
> > -=A0=A0=A0=A0 if (vma->vm_flags & VM_IO) {
> > +=A0=A0=A0=A0 if ((vma->vm_flags & VM_IO) | ((vma->vm_flags & VM_RE=
SERVED)=20
> > +&&
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (~pgprot_val(vma-=
>vm_page_prot) & L_PTE_CACHEABLE)=20
> > +&&
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (~pgprot_val(vma-=
>vm_page_prot) &=20
> > +L_PTE_BUFFERABLE))) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 numUsrPgs =3D=A0 ulNumBytes / PG_=
SIZE_4K;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mpuAddr =3D ulMpuAddr;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DBG_Trace(DBG_LEVEL4, "WMD_BRD_Me=
mMap:numOfActualTabEntries=3D%d,"
> > --
> > 1.6.2.4
> >=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
