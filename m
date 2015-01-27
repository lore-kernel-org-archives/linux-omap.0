From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Tue, 27 Jan 2015 16:26:12 +0100
Message-ID: <201501271626.12365@pali>
References: <201501232239.55801@pali> <20150127133739.GB25306@amd> <alpine.LFD.2.11.1501271014160.1322@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7652450.5ovlhcguvg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1501271014160.1322@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Laura Abbott <lauraa@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

--nextPart7652450.5ovlhcguvg
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 27 January 2015 16:16:24 Nicolas Pitre wrote:
> On Tue, 27 Jan 2015, Pavel Machek wrote:
> > > > > I would say, problem is because omap3-n900 binary DT
> > > > > is too large
> > >=20
> > > I agree.
> > >=20
> > > > OK if that's the case, then your patch makes sense to
> > > > me. It also seems we can have the temporary stack be
> > > > larger than the initial stack just for atags_to_fdt.
> > >=20
> > > The stack size isn't the issue, but rather its location.=20
> > > We need to position it away from the DT data.  The DT
> > > size is known and we could use that, plus some room for
> > > the insertion of new data coming from the ATAG
> > > conversion.
> >=20
> > > Something like the following would be a more robust=20
solution:
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > (Note, that in 3.19 dts for n900 got too big, so we are
> > actually triggering old bugs. That means that this is a
> > regression fix, and should go in ASAP).
>=20
> It is queued here:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id
> =3D8294/1
>=20
>=20
> Nicolas

I tested your patch and fdt_open_into() does not return error=20
=46DT_ERR_NOSPACE anymore. It is working. So you can add my

Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart7652450.5ovlhcguvg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTHrhQACgkQi/DJPQPkQ1ITGgCgjuACJmD7pKBWO+KaJiKr3h7F
MGMAn3+XQ24od9puhEWNTXwXgguhzZzw
=vNKF
-----END PGP SIGNATURE-----

--nextPart7652450.5ovlhcguvg--
