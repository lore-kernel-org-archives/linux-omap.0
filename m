From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/28] at24: remove at24_platform_data
Date: Wed, 8 Aug 2018 17:55:49 +0200
Message-ID: <20180808155548.s7p4xqsjywz3psrj@ninjato>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lailtggovp2weizg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
List-Id: linux-omap@vger.kernel.org


--lailtggovp2weizg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> This is a follow-up to the previously rejected series[1] which partially
> removed the at24_platform_data structure. After further development and
> taking reviews into account, this series finally removes that struct
> completely but not without touching many different parts of the code
> base.
>=20
> Since I took over maintainership of the at24 driver I've been working
> towards removing at24_platform_data in favor for device properties.

Wooha, nice work. I can't really comment on it but wondered how you want
to upstream it (after reviews)? Pull request of an immutable branch for
nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
it. Probably same situation for arm-soc...


--lailtggovp2weizg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrEoEACgkQFA3kzBSg
KbYbig/+IfP/OzJkJkFg3F1HAr1mBXaWGw4BAZ/b9fFp/VcIEJRZ5B1GZl9uXRts
TRoRnNM+JcJik9Lm4hdCNbsIB50QyqiChTwv+8C4zeMJ8RpN8KkhfHUpZ3C1rsV3
bNoCWk5ShWUUSPbiI6R+vEl3dTmfF2p+jybUVbu3dXD14z4fTKEA41yh2GsiKJ4I
9R1x6T4H9Vz0K1acONTk2ynfy3by8t+avkH5T2BdNtSQHHZ4tGOdRZ/uwV3LY8JK
/29JoqfvTjpzqldZaeu8L70VOLSNlgqEOHQAKa/1BcPT5jL4zGUvKtL0yxvrP7IL
YDP8NEs88p7gZmEL6WBPEZoDANygEu3Aka1ibvN0mj+9Vka7756tonRbYw7w1bMM
O4sqgFeZmx4UL3EfDnnyNe+9C74mY5CoK6XEOe9iRjxPY3HzkEKxDaCmogNLsqQC
9wGACEF7mJqcVykQ4eo+MZXdJ1svL0CUaPg+YmHBLRSzsmhfHh4aww/aFzvUFYNM
1mkZYgbAITrGO3qi7xChbSFcGiOxy3zrgM0IrKE448jM8qDj19hwP6O1Dcsu5B6X
lTq/DDSD+PrscM585jz1ORP3Us/Gr9t/5H+u4dNmshMcHGYyNhxft3KJh39HdqXB
l3L0WaE24LfQSwBt6sVnZQPSQn/9fpT6K8M/IMiepm2/SR7x/s0=
=hiI/
-----END PGP SIGNATURE-----

--lailtggovp2weizg--
