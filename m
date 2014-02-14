From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH] ARM: dts: omap3 clocks: simplify ssi aliases
Date: Fri, 14 Feb 2014 02:25:46 +0100
Message-ID: <20140214012546.GA7996@earth.universe>
References: <52DE24DA.8050104@ti.com>
 <1390315061-14441-1-git-send-email-sre@debian.org>
 <20140213224914.GD28216@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:56949 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbaBNBZv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 20:25:51 -0500
Content-Disposition: inline
In-Reply-To: <20140213224914.GD28216@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, mturquette@linaro.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 02:49:14PM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [140121 06:39]:
> > update aliases for the ssi clocks ssi_ssr_fck, ssi_sst_fck and ssi_ick
> > to make them consistent for omap34xx and omap36xx. This makes it
> > possible to reference the clocks from generic omap3 dts files.
>=20
> Is this needed as a fix for v3.14-rc? If so, please let me know
> and ack if you want me to take it.

The SSI driver will not arrive before 3.15 and 3.14 dts files do not
contain any SSI nodes.

Thus it should be enough to queue it for 3.15 if it goes via the
same tree as the SSI dts patches.

-- Sebastian

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS/XCaAAoJENju1/PIO/qauL8P/0GuoERRyYGfiX1jsxga8OoN
DSP13kLFV94HW5FvCp4tPLnFxYk110uNNP4+frhbXO6Dpt27+UIpoKieL+Pahreb
1BMcpen/y3TQmiuEZG7wCpSDDNOe5Sf3e/aj78FSyD4l1A1uszDy63eXezAf3+Zq
X+cyI37tYgA33Eri9XECEJlzOjObU/+GfS4nmqFyfoDQLhEDUOKhz1AyduGtOZJY
E6IVLKcwCIm3/IXL6b2fwnGKWQP5Ij15kvkojMqbYg1SjWxZ7+OCpzh/D/rRbj5J
bl7KdUE8lRczFyArVTvk/4thwH5cxREouYIbISOfKtnXGU4wu8u1uWXK5MmUPMf3
1gbfXMMYK7Bo1VaBTEQHAlaogD1FaKaeH7iqzr/IigaIt2zOU/09T06ye9k5ujwN
vpd6Tz+fvQRPc0LzcqcnRsE51VHXWHUw8j2XD22W45fAOxNoqISzHVfTOIcpXzPt
yW/IjyvBhZhOin6hkFzY6y2nof3rskphb3067sMUj0AveAon/M9DSNjJPJ7SiNci
Dp7ZcI8FT5UatcMQsfQiyEv0IIMzOX4b405hFHT/+jnORJBYTcclu2SMsKh0vyta
7LDiuci6UVQo+dXp+d4chx/TGaPZoal630yaIsNpR5TvHnnM3vo+fHG2vEHzN7XQ
Fys2cQO9PTqOrPq4vQHz
=Pu0r
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
