From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: RE: [PATCHv2 2/3] iovmm: add superpages support to fixed da address
Date: Wed, 13 Oct 2010 19:43:50 +0300
Message-ID: <1286988203-notmuch-felipe.contreras@nokia.com>
References: <1286226137-1233-1-git-send-email-x0095840@ti.com> <1286226137-1233-2-git-send-email-x0095840@ti.com> <1286226137-1233-3-git-send-email-x0095840@ti.com> <AANLkTimF5HqA0pbp7NXOXxOcuMMJWp9yuJPsw8-iPKjh@mail.gmail.com> <496565EC904933469F292DDA3F1663E602F47B2BF1@dlee06.ent.ti.com> <AANLkTinVzO_B0L09bOG0aWTsQjaXgLeggB+YUgEhL2Sa@mail.gmail.com> <496565EC904933469F292DDA3F1663E602F47B2FDA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <496565EC904933469F292DDA3F1663E602F47B2FDA@dlee06.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: fernando.lugo@ti.com, felipe.contreras@gmail.com
Cc: hiroshi.doyu@nokia.com, david.cohen@nokia.com, ameya.palande@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

fernando.lugo@ti.com wrote:
> > On Mon, Oct 11, 2010 at 6:33 PM, Guzman Lugo, Fernando=20
> > <fernando.lugo@ti.com> wrote:
> > >> > @@ -420,7 +431,8 @@ static void sgtable_fill_kmalloc(struct
> > >> sg_table
> > >> > *sgt, u32 pa, size_t len)
> > >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_sg(sgt->sgl, sg, sgt->nent=
s, i) {
> > >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t =
bytes;
> > >> >
> > >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes =3D i=
opgsz_max(len);
> > >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes =3D m=
ax_alignment(da | pa);
> > >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes =3D m=
in(bytes, (size_t)iopgsz_max(len));
> > >>
> > >> Why the size_t casting?
> > >
> > > To void this warning:
> > > arch/arm/plat-omap/iovmm.c:440: warning: comparison of distinct=20
> > > pointer types lacks a cast
> >=20
> > But how is that possible? iopgsz_max is returning constants,=20
> > like SZ_1M, so they should not need casts, if anything, the=20
> > cast should be done in iopgsz_max itself.
>=20
> The min macro make a "typeof" of the parameter, so the typeof of a=20
> Constants should be int I think and that's the reason of the warning.
>=20
> I can use min_t instead to avoid the warning, something like this:
>=20
> 			bytes =3D min_t(size_t, bytes, iopgsz_max(len));
>=20
> What do you think?

Right, I forgot about that one... much better.

--=20
=46elipe Contreras
