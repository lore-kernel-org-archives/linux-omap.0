From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/4] Input: tsc2005 - convert to regmap
Date: Wed, 15 Jul 2015 23:54:20 +0200
Message-ID: <20150715215420.GB2591@earth>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-3-git-send-email-sre@kernel.org>
 <20150715212955.GA24393@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715212955.GA24393@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Wed, Jul 15, 2015 at 02:29:55PM -0700, Dmitry Torokhov wrote:
> I also got:
>=20
>   CC [M]  drivers/input/touchscreen/tsc2005.o
>   Building modules, stage 2.
> Kernel: arch/x86/boot/bzImage is ready  (#1383)
>   MODPOST 1403 modules
> ERROR: "devm_regmap_init_spi" [drivers/input/touchscreen/tsc2005.ko]
> undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
>=20
> I guess we need "select REGMAP_SPI".

Right. I will add this in PATCHv2.

-- Sebastian

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVptaJAAoJENju1/PIO/qaASgP/1/PjGRHmssNsXdcZiv5x2UH
zTPvBqkG+FwqaLQpl/YtkiR3w4MnAUXYxIf6reeqcZ14qxE+JkBVFw8wKU7CiXEj
g1aRWe9pmX+EQwnTBjdarf9hhz43iuB25jY+H0mCzv5oThot9+91FEIoD788HMf/
dmG9lsEnkg8d1LO+QIwrPlufZ2zUEqlAQWAnzT5qqEXli5xY6Pkunx5Iaro1eQtA
yaL4YkULQvpz1w7GQON1G8HA7Os9BOXGwJM71S6p7sRYIEKQBBZ3OY1CKprZNlYx
dZqMK9gJMa7y8zL9fiz3PlEx1Zj/FbMJOidVd+V14w4F2hyzrc0pRQ+ZFZ6vXNcf
okDbkFvMHzFu95SHEyA+nlONDEbFxtvZofBxUGY4o+z6HwV4BF50sAmhQP8xVJUR
u6ZyjOMuVxUhZmRjGf9Z6rYkIWN7FwcuzabiD9gPfnaRWMs54b5wTAR6GCNJ7Ble
5sR+maTXOMlGlKZ8C84wFi/iOH8oLjhow+z0z93k05QiyGKpCrxcvVdaxC0Om/xH
VRKbww+CqsH9LP1qDoKGQ5uKksAtmfNsDe2nO+3X/AP0Bj3gPTKHLFPOBsdkdbrB
c6TU/ZZoa2J5EjFrlNbSGjYfYqLBW1L86rq9ByX3TkEpgfE74x00h6rk8cUng28x
vqnwCasnR2R8+SFjQa9d
=o1GS
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
