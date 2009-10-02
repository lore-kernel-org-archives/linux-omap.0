From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] SDMA: Fixing bug in omap_dma_set_global_params()
Date: Fri, 2 Oct 2009 14:42:29 -0700
Message-ID: <20091002214229.GU16865@atomide.com>
References: <1253690346-17865-1-git-send-email-anuj.aggarwal@ti.com> <618f0c910909230124q773b90f6xd377e67a758e1237@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60431 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbZJBVm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 17:42:28 -0400
Content-Disposition: inline
In-Reply-To: <618f0c910909230124q773b90f6xd377e67a758e1237@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Venkatraman S <svenkatr@ti.com> [090923 01:25]:
> On Wed, Sep 23, 2009 at 12:49 PM, Anuj Aggarwal <anuj.aggarwal@ti.com=
> wrote:
> > Argument tparams was not being used to program
> > global register GCR.HI_THREAD_RESERVED. This patch fixes the same.
> >
> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > ---
> > =A0arch/arm/plat-omap/dma.c | =A0 13 +++++++------
> > =A01 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index bf08634..7a7b6df 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -829,10 +829,10 @@ EXPORT_SYMBOL(omap_free_dma);
> > =A0*
> > =A0* @param arb_rate
> > =A0* @param max_fifo_depth
> > - * @param tparams - Number of thereads to reserve : DMA_THREAD_RES=
ERVE_NORM
> > - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_THREAD_RESERVE_ONET
> > - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_THREAD_RESERVE_TWOT
> > - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_THREAD_RESERVE_THREET
> > + * @param tparams - Number of threads to reserve : DMA_THREAD_RESE=
RVE_NORM
> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_THREAD_RESERVE_ONET
> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_THREAD_RESERVE_TWOT
> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_THREAD_RESERVE_THREET
> > =A0*/
> > =A0void
> > =A0omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int=
 tparams)
> > @@ -847,8 +847,9 @@ omap_dma_set_global_params(int arb_rate, int ma=
x_fifo_depth, int tparams)
> > =A0 =A0 =A0 =A0if (arb_rate =3D=3D 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arb_rate =3D 1;
> >
> > - =A0 =A0 =A0 reg =3D (arb_rate & 0xff) << 16;
> > - =A0 =A0 =A0 reg |=3D (0xff & max_fifo_depth);
> > + =A0 =A0 =A0 reg =3D 0xff & max_fifo_depth;
> > + =A0 =A0 =A0 reg |=3D (0x3 & tparams) << 12;
> > + =A0 =A0 =A0 reg |=3D (arb_rate & 0xff) << 16;
> >
> > =A0 =A0 =A0 =A0dma_write(reg, GCR);
> > =A0}
>=20
> max_fifo_depth should not be set to zero. Perhaps it deserves a check
> similar to arb_rate ?

Any news on updating this patch to also check the max_fifo_depth?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
