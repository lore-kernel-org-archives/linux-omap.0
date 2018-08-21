From: Alban <albeu@free.fr>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Date: Tue, 21 Aug 2018 13:39:16 +0200
Message-ID: <20180821133916.3a1c51b1@eos>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
        <20180820202038.5d3dc195@bbrezillon>
        <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/H3emaZsLss0.QG=/IEiqnC1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Alban Bedel <albeu@free.fr>, Boris Brezillon <boris.brezillon@bootlin.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan>
List-Id: linux-omap@vger.kernel.org

--Sig_/H3emaZsLss0.QG=/IEiqnC1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Aug 2018 10:50:07 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> Just curious...Is there a reason why we can't do it like this?:
> Is this because of issue of #address-cells and #size-cells Or mtd=20
> bindings always prefer subnodes?
>=20
> 	mtdnode {
> 		reg =3D <0x0123000 0x40000>;
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		cell@0 {
> 			compatible =3D "nvmem-cell";
> 			reg =3D <0x0 0x14>;
> 		};
>=20
> 		partitions {
> 			compatible =3D "fixed-partitions";
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
>=20
> 			partition@0 {
> 				reg =3D <0x0 0x20000>;
> 				cell@0 {
> 					compatible =3D "nvmem-cell";
> 					reg =3D <0x0 0x10>;
> 				};
> 			};
> 		};
> 	};

That would work, the MTD partitions parser ignore child nodes with a
compatible string when looking for "old style" partitions, see [1].
However we still have the a potential address space clash between the
nvmem cells and the main device binding.

Alban

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/mtd/ofpart.c#L28

--Sig_/H3emaZsLss0.QG=/IEiqnC1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE0W61GceYqNjiMSkodJSaS524LbwFAlt7+eQACgkQdJSaS524
Lbw8Eg/+LksOLDz4/cK1Hv2Osee6M3szNFj3GJYOMAb+35h4qvp3QUEQDLsGQ3Kd
XDdsoRPCc0iuMkN+CWH1mC8/02oufsP1e55OhYcIyMxdCi4PORyCzlkjuWZBBdsU
tw7NP2/zWTaboRVe8nWCRd8gVEDxyfPqlLJXrk+N4ZBuB35LOOOHHH8GbGCay5cp
uZgRZDpS7QgHQbDQU7lHH6yKT6oYx/GTY3BKZU5Q3FoFrQ9vEne9ZO/xJf2JNhjY
5vS8hhhsHbFhfo9CwUOQuisWsdvZEyB0EKtmeF7Wq6NuvFv7VE/hrIjklZY3d1Kx
bNy12FyRvIgX43q9arV8FTNOOGJkyJbiBUm9B4FnBFzmpWqg6QmY4AmIqhuIDZi3
TiOHBp9gARLX+lJNZeqEY46hZoHJp/eWAqHtdlTfVGxAecApwMH/gZw5Ad62N8qB
K0dVL0JVUWR15TfnqOkaPWGsnpRdEf9hvqbPWroND+FKppBH+weVzC/H2aalmQyQ
Td9OVH0wyLI5SoyCptcw/12g5icNhsxmcIGxQfidbsric9lpFJH/D/jm0BPDAoVo
E8rAEARYGaaBG3+FXXRD8pHVJIX0JmqgHAp/9qmnyBYM/F9CaiGt/7oc89fFKO7h
mYUKeBXbMfNEalg1UuyN5mMvDaFFp/uFBmvq/LXKyeJW94RCwJA=
=Ecun
-----END PGP SIGNATURE-----

--Sig_/H3emaZsLss0.QG=/IEiqnC1--
