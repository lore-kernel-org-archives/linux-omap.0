From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv9 1/2] drivers: spi: Add qspi flash controller
Date: Mon, 19 Aug 2013 13:55:01 -0500
Message-ID: <20130819185501.GL26587@radagast>
References: <1375606690-834-1-git-send-email-sourav.poddar@ti.com>
 <1375606690-834-2-git-send-email-sourav.poddar@ti.com>
 <20130813152624.GG27954@radagast>
 <521244DC.9080600@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UeXZ3FjlYZvuln/G"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49628 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122Ab3HSSzk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Aug 2013 14:55:40 -0400
Content-Disposition: inline
In-Reply-To: <521244DC.9080600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: balbi@ti.com, broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, rnayak@ti.com, linux-omap@vger.kernel.org

--UeXZ3FjlYZvuln/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 19, 2013 at 09:46:28PM +0530, Sourav Poddar wrote:
> >>+	} else if (wlen =3D=3D 32) {
> >if else if else if else if .... this looks like a switch to me. I know
> >someone else commented that switch wasn't the best construct, but to my
> >eyes, switch looks a lot cleaner.
> >
> My previous switch implementation was implemented as a seperate
> function, as a result of which there was the need to pass pointers, other
> variables, then collect it as a double pointer, making things a bit untid=
y.
>=20
> What I can do is to convert these portion into switch here itself,
> which will
> make the code a lot more cleaner. ?

perhaps, at least to me it looks cleaner.

--=20
balbi

--UeXZ3FjlYZvuln/G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEmoFAAoJEIaOsuA1yqREQAEP/3V7Uq5eklq3oq3I7m/GL3jI
P+bnklWvucKlK2vjx+acI9JKqY62oqfmfWPb4Y3a5LMosAlZ+mMKzPfW1Sysp5XE
Pk2x7oL0CY3MJmjiqMHiY8F4RPBPUe9H40X6j1D1+u+uRebQ7To++DuppZF6iK8g
W9NUYnTB+WL4SVIkOPLtmqualbuUNoPEoPi4mVHQTqB96H2K1DoGFxFZy7TFyMeG
d2JeJEQy7HpsoXeC+wNKwNiLbiA1J6UuGWTLjceIaru/rPy522Zpfw0B5BR0VR+C
wQW149JTWjrFQzAlFOBuRS9m/iHY22TlnTg2WVANB44VMLloKpooFdWwt9tTFiTY
r0S9LYPal8E8e5prI2TZKWJT5SUXDmsy5Ar5kdSUEvSpFuiI1+U19A1ThdphpCai
tMMo2iWcoEspJawMdvEjJM/p7lNKHgzIXt17MRSUyNJxBF5D817t9IACv5Sx3xxC
P5QUzJ6TaEWJ9+vRrI/1NqCqJIyT327cO43QGLQrek7v6DWYWZddiyZwsk/+oG41
X3vEn0w++LO3KQVGl/2GWD5L66xfWg8M0zi2LwVRgSQ2mUfUdj6iKNnt9X9Fz2R5
cHMqw0AxHG+UxnGwRqPbpJXCElp/GZVyHpzTE13zHZl6it4hcqDVR46xH7GYUp7P
BnSytaEBTs1fEr9Gsi1b
=8pXZ
-----END PGP SIGNATURE-----

--UeXZ3FjlYZvuln/G--
