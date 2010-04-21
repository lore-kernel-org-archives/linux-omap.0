From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] dma: fix scope of errata i88 upto 3430ES1.0
Date: Wed, 21 Apr 2010 14:14:13 -0700
Message-ID: <20100421211413.GJ18272@atomide.com>
References: <w2g618f0c911004020435qd281c5deoc3e0ade84cc2d0b1@mail.gmail.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C4C33347@dbde02.ent.ti.com>
 <p2i618f0c911004050819u9af37b57ob399a52006f40017@mail.gmail.com>
 <o2h618f0c911004050836ge9222b05i6520c8c7de9336ed@mail.gmail.com>
 <v2g618f0c911004190351h438b8d14o83a57d631eef3a2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50396 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab0DUVOQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 17:14:16 -0400
Content-Disposition: inline
In-Reply-To: <v2g618f0c911004190351h438b8d14o83a57d631eef3a2c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

* Venkatraman S <svenkatr@ti.com> [100419 03:47]:
> Hi Tony,
> > Venkatraman S <svenkatr@ti.com> wrote:
> > From 2799506180649cbb61d24cf2b4171425b2e1fa80 Mon Sep 17 00:00:00 2=
001
> > From: Venkatraman S <svenkatr@ti.com>
> > Date: Mon, 5 Apr 2010 20:56:27 +0530
> > Subject: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0
> >
> > DMA errata for special end of block programming is applicable
> > only for OMAP2430 & OMAP3430 ES1.0.
> > This patch does the necessary checks before the workaround
> > is applied. Tested on 3430 SDP
> >
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Venkatraman S <svenkatr@ti.com>
> > Reviewed-by: Shilimkar Santosh <santosh.shilimkar@ti.com>
> > ---
> > From v1, removed the redundant omap3430() check
> >
> > =C2=A0arch/arm/plat-omap/dma.c | =C2=A0 20 ++++++++++++--------
> > =C2=A01 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index 2ab224c..a9b480a 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -1663,14 +1663,17 @@ int omap_stop_dma_chain_transfers(int chain=
_id)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0channels =3D dma_linked_lch[chain_id].li=
nked_dmach_q;
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA Errata:
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0* Special programming model needed to =
disable DMA before end of block
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA Errata: i88
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Special programming model needed
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* to disable DMA before end of block
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0sys_cf =3D dma_read(OCP_SYSCONFIG);
> > - =C2=A0 =C2=A0 =C2=A0 l =3D sys_cf;
> > - =C2=A0 =C2=A0 =C2=A0 /* Middle mode reg set no Standby */
> > - =C2=A0 =C2=A0 =C2=A0 l &=3D ~((1 << 12)|(1 << 13));
> > - =C2=A0 =C2=A0 =C2=A0 dma_write(l, OCP_SYSCONFIG);
> > + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap2430() || (omap_rev() =3D=3D =
OMAP3430_REV_ES1_0)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l =3D sys_cf;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Middle mode r=
eg set no Standby */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l &=3D ~((1 << 1=
2)|(1 << 13));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_write(l, OCP=
_SYSCONFIG);
> > + =C2=A0 =C2=A0 =C2=A0 }
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < dma_linked_lch[chain_i=
d].no_of_lchs_linked; i++) {
> >

What about other omaps? It seems that we're currently doing the workaro=
und
for all omaps. Seems like "Tested on 3430 SDP" is not quite safe enough
for making change that might affect other omaps.

Tony


> > @@ -1689,8 +1692,9 @@ int omap_stop_dma_chain_transfers(int chain_i=
d)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Reset the Queue pointers */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_DMA_CHAIN_QINIT(chain_id);
> >
> > - =C2=A0 =C2=A0 =C2=A0 /* Errata - put in the old value */
> > - =C2=A0 =C2=A0 =C2=A0 dma_write(sys_cf, OCP_SYSCONFIG);
> > + =C2=A0 =C2=A0 =C2=A0 /* Errata: put back the old value */
> > + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap2430() || (omap_rev() =3D=3D =
OMAP3430_REV_ES1_0))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_write(sys_cf=
, OCP_SYSCONFIG);
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > =C2=A0}
> > --
> > 1.6.3.3
> >
>=20
> If there are no other concerns about this patch, can you please inclu=
de it ?
> Many thanks,
> Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
