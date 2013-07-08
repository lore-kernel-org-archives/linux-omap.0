From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] jacinto6 : usb3_phy: Updated dpll M,N values.
Date: Mon, 8 Jul 2013 10:28:48 +0300
Message-ID: <20130708072848.GB16635@arwen.pp.htv.fi>
References: <1371829570-15011-1-git-send-email-ruchika@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371829570-15011-1-git-send-email-ruchika@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ruchika Kharwar <ruchika@ti.com>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, Nikhil Devshatwar <nikhil.nd@ti.com>
List-Id: linux-omap@vger.kernel.org

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2013 at 10:46:10AM -0500, Ruchika Kharwar wrote:
> Addition of the M and N recommended values for the USB3 PHY DPLL.
> Sysclk for DRA7xx is 20MHz.
> This yields:
> Clk =3D 20MHz * M/(N+1) =3D 20MHz * 1000 /(7+1) =3D 2.5 Ghz
>=20
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> Signed-off-by: Ruchika Kharwar <ruchika@ti.com>

this won't apply since you had already sent me another version. Please
send in a fix up patch if that's wrong.

--=20
balbi

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2mowAAoJEIaOsuA1yqREe+IP/j4OrSvrp3GGhejHLNNUxNK+
0zngFaSlJ2KGBoasTS7iLcA8hMcWL6DKuh8KRYSF6zgPs1i7Mxbprk1RJrT2aWIq
l19/MwL6mznZd3YM3l5GZgNgJTp/ITNnH+WHlAR52gennTXPOZuVwsOSfGLXBj5G
LYvjQfod7p9BQPf7kypjPyap/Y4jdVDGd9EnWhqu0BeSnWe9e2toOL3782vmeHsQ
VpdPsic1GPQU70UcKyQe/aeCjiyS/N499in8SJ1YLlFteD7MwudZb2kNymSeD2HR
pjuXf4rvtRgOX0ZnJmuB+xXg5WDcI5WfuZC9p+6eJ8Gk3AEhjCJ40qhHlQeP2ptK
86v4B7T5bymeZmxYlEe+E01raop2GiY54jE7Zicl8okozgIcR/7HdAm8ZnyuqSfP
/E7IRKtD5X+06pBuswMwd2X4c80AWucQ2vUOa/5pHyCnlLzFRp2/dGXDM7UVopFf
7azLfAqwbTds7tgm7Sl8xoxEMKrtNR5ODMbDvi5aeIjsIwklpmB588ACoAO8Sk3I
ADjZYON15E4A1La4rZxbd1ZXEa01lxELcKtfJ7RpWMRn4j2Jjy9mwd6zRcRZMcoK
hJte7pV639Xmv9WDNcUsrErkJX0SrtjMjRy3EC1Qwl17YWkrJlQ1jlVmpNTcTRLu
agEzBZMrb3I1UHDH6uGz
=ieBF
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
