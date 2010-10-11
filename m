From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCHv2 2/3] iovmm: add superpages support to fixed da address
Date: Mon, 11 Oct 2010 10:33:42 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F47B2BF1@dlee06.ent.ti.com>
References: <1286226137-1233-1-git-send-email-x0095840@ti.com>
	<1286226137-1233-2-git-send-email-x0095840@ti.com>
	<1286226137-1233-3-git-send-email-x0095840@ti.com>
 <AANLkTimF5HqA0pbp7NXOXxOcuMMJWp9yuJPsw8-iPKjh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimF5HqA0pbp7NXOXxOcuMMJWp9yuJPsw8-iPKjh@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "david.cohen@nokia.com" <david.cohen@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

=20

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]=20
> Sent: Sunday, October 10, 2010 10:22 AM
> To: Guzman Lugo, Fernando
> Cc: Hiroshi.DOYU@nokia.com; david.cohen@nokia.com;=20
> felipe.contreras@nokia.com; ameya.palande@nokia.com;=20
> linux-kernel@vger.kernel.org; andy.shevchenko@gmail.com;=20
> linux-omap@vger.kernel.org
> Subject: Re: [PATCHv2 2/3] iovmm: add superpages support to=20
> fixed da address
>=20
> On Tue, Oct 5, 2010 at 12:02 AM, Fernando Guzman Lugo=20
> <x0095840@ti.com> wrote:
> > This patch adds superpages support to fixed ad address inside=20
> > iommu_kmap function.
> >
> > Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> > ---
> > =A0arch/arm/plat-omap/iovmm.c | =A0 61=20
> > ++++++++++++++++++++++++++-----------------
> > =A01 files changed, 37 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/iovmm.c=20
> b/arch/arm/plat-omap/iovmm.c=20
> > index 34f0012..8006a19 100644
> > --- a/arch/arm/plat-omap/iovmm.c
> > +++ b/arch/arm/plat-omap/iovmm.c
> > @@ -87,27 +87,37 @@ static size_t sgtable_len(const struct sg_table=
=20
> > *sgt)
> > =A0}
> > =A0#define sgtable_ok(x) =A0(!!sgtable_len(x))
> >
> > +
> > +static unsigned max_alignment(u32 addr) {
> > + =A0 =A0 =A0 int i;
> > + =A0 =A0 =A0 unsigned pagesize[] =3D { SZ_16M, SZ_1M, SZ_64K, SZ_4=
K, };
> > + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(pagesize) && addr &=20
> (pagesize[i] -=20
> > +1); i++)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> > + =A0 =A0 =A0 return (i < ARRAY_SIZE(pagesize)) ? pagesize[i] : 0; =
}
> > +
> > +
>=20
> I don't think those extra spaces make sense.

Ok, it will be fixed.

>=20
> > =A0/*
> > =A0* calculate the optimal number sg elements from total=20
> bytes based on
> > =A0* iommu superpages
> > =A0*/
> > -static unsigned int sgtable_nents(size_t bytes)
> > +static unsigned int sgtable_nents(size_t bytes, u32 da, u32 pa)
> > =A0{
> > - =A0 =A0 =A0 int i;
> > - =A0 =A0 =A0 unsigned int nr_entries;
> > - =A0 =A0 =A0 const unsigned long pagesize[] =3D { SZ_16M, SZ_1M, S=
Z_64K,=20
> > SZ_4K, };
> > + =A0 =A0 =A0 unsigned int nr_entries =3D 0, ent_sz;
>=20
> How about s/unsigned int/unsigned/?

It is exactly the same, but not problem for me.

>=20
> >
> > =A0 =A0 =A0 =A0if (!IS_ALIGNED(bytes, PAGE_SIZE)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: wrong size %08x\n", __fu=
nc__, bytes);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 nr_entries =3D 0;
> > - =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(pagesize); i++) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bytes >=3D pagesize[i]) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_entries +=3D (byte=
s / pagesize[i]);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes %=3D pagesize[i=
];
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 while (bytes) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ent_sz =3D max_alignment(da | pa);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ent_sz =3D min(ent_sz, (unsigned)iopg=
sz_max(bytes));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_entries++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 da +=3D ent_sz;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pa +=3D ent_sz;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes -=3D ent_sz;
> > =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0BUG_ON(bytes);
> >
> > @@ -115,7 +125,8 @@ static unsigned int sgtable_nents(size_t bytes)
> > =A0}
> >
> > =A0/* allocate and initialize sg_table header(a kind of=20
> 'superblock') */=20
> > -static struct sg_table *sgtable_alloc(const size_t bytes,=20
> u32 flags)
> > +static struct sg_table *sgtable_alloc(const size_t bytes,=20
> u32 flags,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 da, u32=20
> > +pa)
> > =A0{
> > =A0 =A0 =A0 =A0unsigned int nr_entries;
> > =A0 =A0 =A0 =A0int err;
> > @@ -127,9 +138,8 @@ static struct sg_table=20
> *sgtable_alloc(const size_t=20
> > bytes, u32 flags)
> > =A0 =A0 =A0 =A0if (!IS_ALIGNED(bytes, PAGE_SIZE))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-EINVAL);
> >
> > - =A0 =A0 =A0 /* FIXME: IOVMF_DA_FIXED should support 'superpages' =
*/
> > - =A0 =A0 =A0 if ((flags & IOVMF_LINEAR) && (flags & IOVMF_DA_ANON)=
) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_entries =3D sgtable_nents(bytes);
> > + =A0 =A0 =A0 if (flags & IOVMF_LINEAR) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_entries =3D sgtable_nents(bytes, d=
a, pa);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!nr_entries)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-EINV=
AL);
> > =A0 =A0 =A0 =A0} else
> > @@ -409,7 +419,8 @@ static inline void sgtable_drain_vmalloc(struct=
=20
> > sg_table *sgt)
> > =A0 =A0 =A0 =A0BUG_ON(!sgt);
> > =A0}
> >
> > -static void sgtable_fill_kmalloc(struct sg_table *sgt, u32=20
> pa, size_t=20
> > len)
> > +static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, u32=
=20
> > +da,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> =A0 =A0 size_t=20
> > +len)
> > =A0{
> > =A0 =A0 =A0 =A0unsigned int i;
> > =A0 =A0 =A0 =A0struct scatterlist *sg;
> > @@ -420,7 +431,8 @@ static void sgtable_fill_kmalloc(struct=20
> sg_table=20
> > *sgt, u32 pa, size_t len)
> > =A0 =A0 =A0 =A0for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t bytes;
> >
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D iopgsz_max(len);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D max_alignment(da | pa);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D min(bytes, (size_t)iopgsz_m=
ax(len));
>=20
> Why the size_t casting?

To void this warning:
arch/arm/plat-omap/iovmm.c:440: warning: comparison of distinct pointer=
 types lacks a cast

I will update with minor changes and resend.

Thanks and regards,
=46ernando.

>=20
> Otherwise:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>=20
> --
> Felipe Contreras
> --
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
