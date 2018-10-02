From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: ti-lmu: Remove LM3697
Date: Tue, 2 Oct 2018 09:28:27 +0200
Message-ID: <20181002072827.GA19677@amd>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-3-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928182954.25446-3-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-09-28 13:29:47, Dan Murphy wrote:
> Remove support for the LM3697 LED device
> from the ti-lmu.  The LM3697 will be supported
> via a stand alone LED driver.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

NAK, for reasons I explained before. Please add it to the patch so
that it does not get applied by mistake. Ouch and AFAICT Rob was not
happy with this either.

Yes, you are creating new drivers, ok; but that does _not_ mean you
should create new binding.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzHhsACgkQMOfwapXb+vKklgCeIvPQ1q4qktH+N0rwTB34zw83
fckAnR4JcCIl2eF+evx3eR/tsO/sWjtA
=Z0W9
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
