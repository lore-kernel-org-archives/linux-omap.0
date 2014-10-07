From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/4] dwc3: exynos: Add support for SCLK present on
 Exynos7
Date: Tue, 7 Oct 2014 09:11:18 -0500
Message-ID: <20141007141118.GD24720@saruman>
References: <1412677176-3850-1-git-send-email-gautam.vivek@samsung.com>
 <1412677176-3850-2-git-send-email-gautam.vivek@samsung.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412677176-3850-2-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, kgene.kim@samsung.com, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 03:49:33PM +0530, Vivek Gautam wrote:
> Exynos7 also has a separate special gate clock going to the IP
> apart from the usual AHB clock. So add support for the same.
>=20
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

I'll take this one once -rc1 is tagged. The others have no direct
dependency on this so I'll leave them to Kishon.

--=20
balbi

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUM/SGAAoJEIaOsuA1yqREvX4P/RVgtnSXBdISraqbxtUS55Fs
A2s4SsiKJu7YOyMUhjvAaxD6yyXUBrlHwVPJ+fCgjRxBByiVoUim0rJ3I0Z+vVeS
F+WqnwZJB9QdhhsDiZreNmikQ7toD6n1Va2PGop6Djd/VkJP4l5MuN/KDKMtbtAt
RNQE463LlIS7h+OVtXLAUbRQCITjwq0VRxdMnQfnYpps73Cquyw89kfgl/fB1F94
fdupFPVKJM153ExAQXWeKejuF2q0bdGyIg8QVDpGfMWV0Sf2AUqKWGtXqznBMrKp
92ptlX5YSPYKH2/854wJhOSMDyw/0SjojMLqo4qxld3+FEAHll3wiZHsOX++vJvY
Bw7ZgrlxdJpYdbOJaHn4D6tdjznGewWHcybjtLkEWNIdctKKRyKlvyxmUQS5d+ae
J1k5QjPZ5oiBD/FJkXpQSovtDgEaI5A054ZDjn8mmh6BlWM2PT8mM9zJCxRPdIB/
2mHKmMIWxIu7CDxCMc1UL/y0Pv+ScdS/RtwCYfScv2jaHJejt/2qnOWTFggQ/nzU
qKmoKf+t+qimJ8xq06eQ4HyOa6QW3e0NJTOsFr9r4JGDN/ZBuWhb2szSFgTBPzqy
1UAj0TUG0VrRC4aOoP00emix7Eo5obf8FLUbiDHYQgfQlBmqAF1RGrObj2z/3nrK
5GUjOskMAp9cos8jSkkI
=bVzM
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
