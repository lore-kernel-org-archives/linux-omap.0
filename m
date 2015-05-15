From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/2] arm: boot: store ATAG structure into DT atags field
Date: Fri, 15 May 2015 22:16:24 +0200
Message-ID: <201505152216.24622@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <1431719407-18230-3-git-send-email-pali.rohar@gmail.com> <3513646.XX80DTTJbc@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3261462.guuoco1GP0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3513646.XX80DTTJbc@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart3261462.guuoco1GP0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 15 May 2015 22:12:41 Arnd Bergmann wrote:
> On Friday 15 May 2015 21:50:07 Pali Roh=C3=A1r wrote:
> >                 }
> >        =20
> >         }
> >=20
> > +       /* include the terminating ATAG_NONE */
> > +       atag_size =3D (char *)atag - (char *)atag_list +
> > sizeof(struct tag_header); +       setprop(fdt, "/", "atags",
> > atag_list, atag_size);
> > +
> >=20
> >         if (memcount) {
> >        =20
> >                 setprop(fdt, "/memory", "reg", mem_reg_property,
> >                =20
> >                         4 * memcount * memsize);
>=20
> The property should probably have a DT binding, and be named
> "linux,atags".
>=20
> It may also help to check if the "linux,atags" property already
> exists and not create it otherwise. That way we can put it into the
> n900 dts file and have it updated by the compat code, but not expose
> the atags on other platforms unless they opt in.
>=20
> 	Arnd

Maybe what would help: Is there a way to tell decompressor/kernel to not=20
touch atag memory and then after kernel/board-code starts it save copy=20
of atags? I think it is not possible right now, but correct me if I'm=20
wrong...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3261462.guuoco1GP0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlVWVBgACgkQi/DJPQPkQ1KW9gCcCeDOPCvWkjlpc7h4iFth3YXG
sxwAoIcKSK3b9yZEHjNpyLTF79mvihYG
=zr54
-----END PGP SIGNATURE-----

--nextPart3261462.guuoco1GP0--
