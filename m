From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Fri, 25 Jul 2014 11:53:04 -0500
Message-ID: <20140725165304.GD29132@saruman.home>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55079 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932120AbaGYQxs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jul 2014 12:53:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, Sathya Prakash M R <sathyap@ti.com>

--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2014 at 09:14:20PM +0000, Paul Walmsley wrote:
> On Tue, 17 Jun 2014, Tomi Valkeinen wrote:
>=20
> > From: Sathya Prakash M R <sathyap@ti.com>
> >=20
> > Add DSS hwmod data for AM43xx.
> >=20
> > Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> > [tomi.valkeinen@ti.com: added missing dispc flags]
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Acked-by: Rajendra Nayak <rnayak@ti.com>
>=20
> This one didn't compile on an AM43xx-only build:
>=20
> ----
> arch/arm/mach-omap2/built-in.o:(.data+0x3f2c): undefined reference to `om=
ap2_dss_hwmod_class'
> arch/arm/mach-omap2/built-in.o:(.data+0x405c): undefined reference to `om=
ap2_rfbi_hwmod_class'
> make: *** [vmlinux] Error 1
> test_build: Tue Jul 22 13:48:50 MDT 2014: FAILED on omap2plus_defconfig_a=
m43xx_only hwmod-a-v3.17
> ----
>=20
> Have queued the following patch instead.

queued for v3.17, I assume. Still not available from linux-next though.

--=20
balbi

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT0otwAAoJEIaOsuA1yqRErVIQAJvyUF7uCOZIfygitSjPiFRR
RkLuGjqM6AH9gX9/SA4czKQfIEIGKUibEfjnprTkOV3/zdtSj0cylVTC75gJAZi0
c27icdN8YzQ4f3DFP+TbTWNpBDFCULETYlRxCzScV65AlOyEEJCGfyJInnJPQG+h
fw64eUjBNugY+fLXgNT/74PKiSjPmzcrlgwTCX4HVamA2/QgsEcbPXmSeGC1N3gW
+ylcZkNUGe7iGkxHue/ES36U5divKmZJxY75Q7gDo9Z19i+pPtabp6Huu8SJaNKp
/YsPOhFvJcoGRcDqAw4Tdhian6QrulIv5ksw3ra7dT5zFmjys6aPT0Ywdj0utQAQ
CMxqvGTAFy+wzmKxWOWAw2fRILjM2d4yigC5KcM5pozcDkijL0iPVO4yI9jCYhNh
M26h754Y/jpuj4rn0fSJpI8H4ThzgMfQEQBbSPRgFqX06vBBIbSPJfB18VID/PG3
Tka2Yu7UQKpnufpkmUaEOO4ls/YK7k/z2gbAwTz+l73B9WQZZHT8X3RUVDGDlT9u
j88JcHkRF4YixJa0hVaslThQZtBcAkVlZ0t9xw14DG2fG5KUxqA7NS21dvUv2C89
aTLBR3vBQvrTM77yb1ejrgJXwJOOyFZ1niE081rVJdGf6U9HEVIQ7lTZm3Qd89G2
S3ClyEewLukkeCVQrrW6
=zhW7
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
