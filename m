From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCHv2 2/3] iovmm: add superpages support to fixed da address
Date: Tue, 12 Oct 2010 09:10:15 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F47B2FDA@dlee06.ent.ti.com>
References: <1286226137-1233-1-git-send-email-x0095840@ti.com>
	<1286226137-1233-2-git-send-email-x0095840@ti.com>
	<1286226137-1233-3-git-send-email-x0095840@ti.com>
	<AANLkTimF5HqA0pbp7NXOXxOcuMMJWp9yuJPsw8-iPKjh@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B2BF1@dlee06.ent.ti.com>
 <AANLkTinVzO_B0L09bOG0aWTsQjaXgLeggB+YUgEhL2Sa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinVzO_B0L09bOG0aWTsQjaXgLeggB+YUgEhL2Sa@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "david.cohen@nokia.com" <david.cohen@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

=20

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]=20
> Sent: Tuesday, October 12, 2010 6:09 AM
> To: Guzman Lugo, Fernando
> Cc: Hiroshi.DOYU@nokia.com; david.cohen@nokia.com;=20
> felipe.contreras@nokia.com; ameya.palande@nokia.com;=20
> linux-kernel@vger.kernel.org; andy.shevchenko@gmail.com;=20
> linux-omap@vger.kernel.org
> Subject: Re: [PATCHv2 2/3] iovmm: add superpages support to=20
> fixed da address
>=20
> On Mon, Oct 11, 2010 at 6:33 PM, Guzman Lugo, Fernando=20
> <fernando.lugo@ti.com> wrote:
> >> > @@ -420,7 +431,8 @@ static void sgtable_fill_kmalloc(struct
> >> sg_table
> >> > *sgt, u32 pa, size_t len)
> >> > =A0 =A0 =A0 =A0for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t bytes;
> >> >
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D iopgsz_max(len);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D max_alignment(da | pa);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D min(bytes, (size_t)iopgs=
z_max(len));
> >>
> >> Why the size_t casting?
> >
> > To void this warning:
> > arch/arm/plat-omap/iovmm.c:440: warning: comparison of distinct=20
> > pointer types lacks a cast
>=20
> But how is that possible? iopgsz_max is returning constants,=20
> like SZ_1M, so they should not need casts, if anything, the=20
> cast should be done in iopgsz_max itself.

The min macro make a "typeof" of the parameter, so the typeof of a=20
Constants should be int I think and that's the reason of the warning.

I can use min_t instead to avoid the warning, something like this:

			bytes =3D min_t(size_t, bytes, iopgsz_max(len));

What do you think?

Regards,
=46ernando.

>=20
> --
> Felipe Contreras
> --
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
