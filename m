From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 03/13] DSPBRIDGE: Moving functions from mem.c to drv.c
Date: Fri, 16 Apr 2010 06:46:19 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B21669A@dlee03.ent.ti.com>
References: <818EF96F5A7CC84789DD014773DB09548F6481CF@dlee01.ent.ti.com>
 <20100416103658.GA18995@lit.local.igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47196 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab0DPLqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 07:46:46 -0400
In-Reply-To: <20100416103658.GA18995@lit.local.igalia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

Ivan,

> In the commit 702b94bff3c50542a6e4ab9a4f4cef093262fe65 (2.6.34) the
> functions
> dmac_inv_range and dmac_clean_range were removed.
>=20
> I'm wondering how to fix this in order to rebase to 2.6.34.
>=20
> Thanks

2 options:

1. Replace dmac_inv_range and dmac_clean_range functions with the new d=
ma map and unmap functions. These are supposed to be the new functions =
to do the same functionality, but in our limited testing some time ago,=
 the dma_unmap function wasn't invalidating the cache. You can check th=
is at your end.

2. Revert the patch that deprecated these APIs to unblock you temporari=
ly.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of V=EDctor M. J=E1quez L.
> Sent: Friday, April 16, 2010 5:37 AM
> To: Gomez Castellanos, Ivan
> Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; Felipe Contreras; Ameya
> Palande; Menon, Nishanth
> Subject: Re: [PATCH 03/13] DSPBRIDGE: Moving functions from mem.c to =
drv.c
>=20
> On Thu, Apr 08, 2010 at 06:47:13PM -0500, Gomez Castellanos, Ivan wro=
te:
>=20
> > +/*
> > + *  =3D=3D=3D=3D=3D=3D=3D=3D mem_flush_cache =3D=3D=3D=3D=3D=3D=3D
> > + *  Purpose:
> > + *      Flush cache
> > + */
> > +void mem_flush_cache(void *pMemBuf, u32 byte_size, s32 FlushType)
> > +{
> > +       if (!pMemBuf)
> > +               return;
> > +
> > +       switch (FlushType) {
> > +               /* invalidate only */
> > +       case PROC_INVALIDATE_MEM:
> > +               dmac_inv_range(pMemBuf, pMemBuf + byte_size);
> > +               outer_inv_range(__pa((u32) pMemBuf), __pa((u32) pMe=
mBuf
> +
> > +                                                         byte_size=
));
> > +               break;
> > +               /* writeback only */
> > +       case PROC_WRITEBACK_MEM:
> > +               dmac_clean_range(pMemBuf, pMemBuf + byte_size);
> > +               outer_clean_range(__pa((u32) pMemBuf), __pa((u32)
> pMemBuf +
> > +                                                           byte_si=
ze));
> > +               break;
> > +               /* writeback and invalidate */
> > +       case PROC_WRITEBACK_INVALIDATE_MEM:
> > +               dmac_flush_range(pMemBuf, pMemBuf + byte_size);
> > +               outer_flush_range(__pa((u32) pMemBuf), __pa((u32)
> pMemBuf +
> > +                                                           byte_si=
ze));
> > +               break;
> > +       }
>=20
> In the commit 702b94bff3c50542a6e4ab9a4f4cef093262fe65 (2.6.34) the
> functions
> dmac_inv_range and dmac_clean_range were removed.
>=20
> I'm wondering how to fix this in order to rebase to 2.6.34.
>=20
> Thanks
>=20
> vmjl
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
