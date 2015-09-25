From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: omapdss: Division by zero in kernel
Date: Fri, 25 Sep 2015 13:34:29 +0200
Message-ID: <20150925113429.GF27119@pali>
References: <201507241803.42891@pali>
 <CAHnt0GX6442mtZ=J6CS_60TyTeUu==oROcf4Y=upHGSr71X3EA@mail.gmail.com>
 <20150819081139.GB15712@pali>
 <20150917051644.GA6665@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150917051644.GA6665@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Peter Teoh <htmldeveloper@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 17 September 2015 07:16:44 Pavel Machek wrote:
>=20
> > >         if (image->depth =3D=3D 1) {
> > >                 if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
> > >                     p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
> > >                         fgcolor =3D ((u32*)(p->pseudo_palette))[i=
mage->fg_color];
> > >                         bgcolor =3D ((u32*)(p->pseudo_palette))[i=
mage->bg_color];
> > >                 } else {
> > >                         fgcolor =3D image->fg_color;
> > >                         bgcolor =3D image->bg_color;
> > >                 }
> > >=20
> > >                 if (32 % bpp =3D=3D 0 && !start_index && !pitch_i=
ndex &&
> > >                     ((width & (32/bpp-1)) =3D=3D 0) &&
> > >                     bpp >=3D 8 && bpp <=3D 32)
> > >                         fast_imageblit(image, p, dst1, fgcolor, b=
gcolor);
> > >                 else
> > >                         slow_imageblit(image, p, dst1, fgcolor, b=
gcolor,
> > >                                         start_index, pitch_index)=
;
> > >         } else
> > >                 color_imageblit(image, p, dst1, start_index, pitc=
h_i
> > >=20
> > >=20
> > > Notice that bpp is not checked for zero, and thus bpp=3D=3D0 is t=
otally
> > > feasible?   resulting in 32/bpp crashing the kernel?
> > >=20
> >=20
> > Hm... this could really be a problem! But how to patch it? Which br=
anch
> > should be called (fast_ or slow_ function) if bpp is zero?
> >=20
> > And is there some way to force kernel to dump backtrace into dmesg =
when
> > division by zero occur?
>=20
> You can do WARN_ON(bpp=3D=3D1) ... and should probably return in that
> case.
>=20
> 								Pavel

Does not make sense to call slow_ function? In that if condition check
also that bpp is nonzero...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
