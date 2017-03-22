From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: cpcap-charger: Add minimal CPCAP PMIC
 battery charger
Date: Wed, 22 Mar 2017 03:15:14 +0100
Message-ID: <20170322021514.ewipilqbfm2cwua6@earth>
References: <20170317022152.21427-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="baxxlrf32bzdp76x"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317022152.21427-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--baxxlrf32bzdp76x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 07:21:52PM -0700, Tony Lindgren wrote:
> The custom CPCAP PMIC used on Motorola phones such as Droid 4 has a
> USB battery charger. It can optionally also have a companion chip that
> is used for wireless charging.
>=20
> The charger on CPCAP also can feed VBUS for the USB host mode. This
> can be handled by the existing kernel phy_companion interface.
>=20
> Cc: devicetree@vger.kernel.org
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Driver looks ok and works for me, but values are not scaled
correctly. The power-supply subsystem exposes values in microamps
and microvolt. IIO provides values in millivolt/milliamps instead,
so it should be scaled with 1000.

-- Sebastian

--baxxlrf32bzdp76x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljR3i8ACgkQ2O7X88g7
+prR2Q/8CZFujxOHcUhDM0TjDwBl1NPV20gEWc7/iCk1MAd75jLfeV67YtFRT4bR
0d1ipCrM7R+rf2kDcrZ7mR4+AJpKSTXdFxLGxEqGkojmUKkVRJpXSyR3grEmlLk3
XBpIeOV1xCN9w/F+w/JK3YMjzdX0e7NTtz/S7mhhKzuDs23Hnq0QTeh/vFJ9rHk6
3jruFaGoG7r1f5AEgtvBpUyF8gye2iV4B3LznGVCmD3fxzk9XOJ9a5WKuPiwRMB1
2b0oj7X04wwgOO5K1VF1u/s6jochXSHO6Tn3huzjZAOpNgwFnEaurPhCZ2EtQqc/
tJ9dbgoaD47GEjE5s+6QSddRlO6mgOguC/yYUyZS8Rfj7E8U41R+dWeGze1iqarg
X2W4aIL0KGPdVJb1LMMbUKsVjI+jEuypptAZ8DOYLDo246bd9FH220YwkijzUGvw
6WQgkXe2X3h4b6cxscJr2rd5ORspv2dSdGKUc9KvdHtGkZWEjjlwHnVxjDhbBfiC
BbSHxQmamNEbAIyxuBFdBQKnVibPFKv392h9i1207KaLrT98SFDHvL9pSM2SOBcu
nm3XZrj5p01C4r8t+OJ5XzL6g9Fq56GHL/4LYV0w7DMu25oJ4735e/qWsV/qwh/d
qgABvU5GmYfV1KQAirS8yzd0i3CENUgB8mZTl8I45bDmREi0YMg=
=enRp
-----END PGP SIGNATURE-----

--baxxlrf32bzdp76x--
