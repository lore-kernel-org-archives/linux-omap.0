From: Alban <albeu@free.fr>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Date: Mon, 20 Aug 2018 23:27:48 +0200
Message-ID: <20180820232748.608c3667@tock>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
        <20180820202038.5d3dc195@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/x7JZOIPlUQW1dRdErBSmNuH"; protocol="application/pgp-signature"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180820202038.5d3dc195@bbrezillon>
Sender: netdev-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Aban Bedel <albeu@free.fr>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan
List-Id: linux-omap@vger.kernel.org

--Sig_/x7JZOIPlUQW1dRdErBSmNuH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Aug 2018 20:20:38 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Mon, 20 Aug 2018 11:43:34 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>=20
> >=20
> > Overall am still not able to clear visualize on how MTD bindings with=20
> > nvmem cells would look in both partition and un-partition usecases?
> > An example DT would be nice here!! =20
>=20
> Something along those lines:

We must also have a compatible string on the nvmem-cells node to make
sure we don't clash with the old style MTD partitions, or some other
device specific binding.

>=20
> 	mtdnode {
> 		nvmem-cells {
                        compatible =3D "nvmem-cells";
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
>=20
> 			cell@0 {
> 				reg =3D <0x0 0x14>;
> 			};
> 		};
>=20
> 		partitions {
> 			compatible =3D "fixed-partitions";
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
>=20
> 			partition@0 {
> 				reg =3D <0x0 0x20000>;
>=20
> 				nvmem-cells {
                                        compatible =3D "nvmem-cells";
> 					#address-cells =3D <1>;
> 					#size-cells =3D <1>;
>=20
> 					cell@0 {
> 						reg =3D <0x0 0x10>;
> 					};
> 				};
> 			};
> 		};
> 	};


Alban

--Sig_/x7JZOIPlUQW1dRdErBSmNuH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbezJVAAoJEHSUmkuduC28QU4P/3pQiuQbGP9YNsymN3BmbTvP
lreiY+6pCAVvk66pR7GcuW4RurUzlj6FunpMY5XWQOkNDQcceLn6rmS51Ga7Xz+s
c7hwUVgd4XByw2REWTAKNo7ygY8gndcMoQ8AzpPGBjGYSN5lp2hrdhvu6FW6DzWe
8Erm3Xdue074z9ag7LMpQnV0ZURoQeUbEsBgaXbrMCmrYabG6Ahr5/YmyaGavM5H
O5sM2yQa3b+MfVxFvAyrDmrPm/onIAZSs8Mh6Z33CJZHeZOfofYD74iJRB7mNnCJ
oy+xu/BYJ2e7/AX595+T0uCG+5IwG99t6oFoqMkKeqKVkv8wzSlQfYJC8t8d5j4f
IgBydMh+sXDvYGp4ftWFTNLbe6exnISxMSiN8VJUHZPj9sC1RDGA3JFs7oMCCsPv
ctZ7jboJ0U0T1GP3R+67KX4qOh3jgcMvFwZvzCZEvXVaIbCaeNco4Q0MVtdRL3yi
6gD2GC0iS/lYQji3HofodBhSfB9JH4GDwDgT8u2WQ4ZT3fDrp/53pvcHwcZ5rl7o
bxofjh4BYDBNh3eJ8nb5KQeqPvuLZhXi9StmOasBu8IsYAHf/ryGmXhcZJuO21zZ
ywcUVHIGvmNthSrs2gdmVO6FzpjQfP6Qz9T0lhd/RMxj5/BXYf8CtP84mNq+MUge
x387wEAOzjA+iSFiQynX
=RS6x
-----END PGP SIGNATURE-----

--Sig_/x7JZOIPlUQW1dRdErBSmNuH--
