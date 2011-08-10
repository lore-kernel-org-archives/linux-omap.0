From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arch:arm:plat-omap:iovmm: remove unused variable 'va'
Date: Wed, 10 Aug 2011 04:18:05 -0700
Message-ID: <20110810111804.GG1939@atomide.com>
References: <20110808101546.GA25572@maxin>
 <CAMhs6YwHbFknDpOg9e_5XcB-X9qo+DXX3tAaQy5xQopepeKOxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMhs6YwHbFknDpOg9e_5XcB-X9qo+DXX3tAaQy5xQopepeKOxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxin B John <maxin.john@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Maxin B John <maxin.john@gmail.com> [110810 04:06]:
> ping.

Sorry I've been on vacation, applying to fixes.

Regards,

Tony

=20
> On Mon, Aug 8, 2011 at 1:15 PM, Maxin B. John <maxin.john@gmail.com> =
wrote:
> > The pointer "va" returned from "phys_to_virt(pa)" is never used in
> > "sgtable_fill_kmalloc()".So,it is safe to remove this set-but-unuse=
d variable.
> >
> > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> > ---
> > diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.=
c
> > index c60737c..79e7fed 100644
> > --- a/arch/arm/plat-omap/iovmm.c
> > +++ b/arch/arm/plat-omap/iovmm.c
> > @@ -423,9 +423,6 @@ static void sgtable_fill_kmalloc(struct sg_tabl=
e *sgt, u32 pa, u32 da,
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scatterlist *sg;
> > - =C2=A0 =C2=A0 =C2=A0 void *va;
> > -
> > - =C2=A0 =C2=A0 =C2=A0 va =3D phys_to_virt(pa);
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_sg(sgt->sgl, sg, sgt->nents, i)=
 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned byt=
es;
> >
