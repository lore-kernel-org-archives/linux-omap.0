From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v3 0/4] LG Optimus Black codename sniper support series
Date: Sun, 28 Feb 2016 13:38:58 +0100
Message-ID: <1456663138.1022.12.camel@paulk.fr>
References: <1456654827-11349-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-TFOKW0Yfbx9fdFeD44lU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456654827-11349-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-TFOKW0Yfbx9fdFeD44lU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Will send out v4 soon, with minor changes.

Le dimanche 28 f=C3=A9vrier 2016 =C3=A0 11:20 +0100, Paul Kocialkowski a =
=C3=A9crit=C2=A0:
> This series requires lp872x regulator patches from the regulator tree[0] =
to
> work
> at run-time but can be applied as-is.
>=20
> Changes since v2:
> * Add USB OTG support
> * Add TWL4030 keypad support
> * Drop references to P970 since other devices (e.g. KU5900) are supported=
 too
>=20
> Changes since v1:
> * Remove lp872x patches that were accepted already from the series
> * Explain why removing the invalid DVS GPIO warning is enough
> * Update copyright notice on omap3-sniper.dts
> * Rename the devicetree property for the enable GPIO to enable-gpios
> * Rename function to enable GPIO to lp872x_hw_enable
> * Add enable delays after requesting the enable GPIO
> * Use IOPAD macros for pinmux description
> * Mux the dp3t uart selection pins to gpio
> * Restrict not-reset gpio controllers to only avoid reset when needed
>=20
> This series introduces support for the LG Optimus Black, as described in =
the
> patch adding devicetree support for the device.
>=20
> In order to power the external mmc (mmc1), the lp872x regulator is used.
> Its code had to be improved a bit to work on the device.
>=20
> Note that the patch adding devicetree support for the device requires the
> changes applied to the lp872x regulator, so all this is sent in one serie=
s
> despite the fact they're different parts of the code.
>=20
> [0]: https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/l=
og/?h
> =3Dtopic/lp872x
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-info.h=
tml
--=-TFOKW0Yfbx9fdFeD44lU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0upjAAoJEIT9weqP7pUMD1IP/RvMDVCgYvZU+PY7EhGL8HVC
g0+IKK4g7PVkMA985ExVNbII3wQQhVcYApecSbthj3s9gj7sGbFZV/ZCPTG9FoJQ
81Dq2oN4UgYsk1VAEQuT9rU9HNuYdh58yOHW1mWT0HgQGLgV1Jj2OAAkgpY6uc3z
Aoa+anNKIAwZvFR2fGIc27w1xX9zZ3gj4kzg/j3fHoKfhpVnQxiLBuNFc9y84bUg
IGBA5+LS6JeQVMmpm8w2MDkmMSA+q0OadLCb9w8IZa7JaVzPCDUf+qUzIk9QTygH
oR1o7DrE5wN4tFuNSLIBTrh4RRBzve7pgPVtUY5MVLd4q2G42/BUZ5vT8ClWeRPo
YcyEQQ2w4FXGl8goGP3q8AeiEqLG9cjcEfkPBvewzhsv6T4uhnLipk6wJ754tjQk
8FON44cdXq0uMWX+Yt2iguaJdPQIKNUi/suf+FjQrKJVZ/Fikv4DR15PHdkX64wl
lhYLvavSIWubpst2Vtz0LXW0261UOaeltBJyaa9v9n0vMBBF9d52h0MZ9eYXLzAo
gsyTiS4eOjh8CgBGApCMvzUMA43VqQCCa9MBFE8O9lOpYSjMFndaz6K/PY2qNRmO
R25otdk114s/bazvFhGeBOIHAleSD56Y3dJFjR7QCbiEiU614I4/s0IReqm5VjcJ
zmkJqp6/mhL4jFvseJfv
=ukbz
-----END PGP SIGNATURE-----

--=-TFOKW0Yfbx9fdFeD44lU--
