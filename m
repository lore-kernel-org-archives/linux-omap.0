From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/6] Small fixes for Nokia N900 power supply drivers
Date: Sun, 21 Feb 2016 20:41:20 +0100
Message-ID: <20160221194120.GC15242@earth>
References: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 21, 2016 at 12:28:17PM +0100, Pali Roh=E1r wrote:
> This patch series add debug error output for isp1704 driver and
> fix module aliases for power supply drivers uses on Nokia N900.
>=20
> Pali Roh=E1r (6):
>   power_supply: isp1704_charger: Error messages when probe fail
>   power_supply: isp1704_charger: Add compatible of match for nxp,isp1707
>   power_supply: bq2415x_charger: Do not add acpi modalias when CONFIG_ACP=
I is not enabled
>   power_supply: bq2415x_charger: Add of modalias and match table when CON=
FIG_OF is enabled
>   power_supply: bq27xxx_battery: Add of modalias and match table when CON=
FIG_OF is enabled
>   ARM: dts: n900: Rename isp1704 to isp1707 to match correct name

I queued the power-supply patches for 4.6 applying Pavel's commit
message changes and his Acked-By.

-- Sebastian

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWyhLdAAoJENju1/PIO/qaBhMP/izWMBi7PhfSiSA7jL7Xae6J
GsmnLZfM5hSXIIwPjGHjnZ1firheOI5m0l1mASXnC0mCvS5wsoKE/eB8oEL9HTnI
2nJIA2ZaYLlsCk763ZqPeEZrhn7sTrg+a/+Ug35gT7O4WxB7eLu1hDuLj9VaxUZX
7g/0Vo3PjPmgJTPGw+XzpnwhcEV9eBbqGV9ZPf4kBGhJZo5yJOyLBYQTOh54YZs5
7bYdEXFug/7KiTXKk+JminPn/iSWYFqIwHxRdkh6F7Q3o5Z8b/KWFu1FXqnaeLAF
7/a40y/kKt5u9YhPhJua3ODk42FE0Wy8m/EcOa3emOotJv7BujDvPTgFB9IMMhnK
lYyjfS5b8eUEuTYhqLjZh1V2boF/morlOoNVPZyAcUUMir+Ek1XuY8H5SrmrxQxp
BY2xXi5bfNuUhifXiMmXBuPgqIdn86TMb1Wi7gkMzshUp3rw0XFfk4ljy3i0F4Sy
xYO5EYzmQgVzmml4nb59Fs2/QCHK2OQ7JTlgRbvnRdAWS263VdBw9iMJZpKB+lBx
eMEqw+1ByKLjCg8Mjn23BSEvYid6gzDTT55APdsDw/WSdUN032WivqhOsO8qioC4
zhfc5PjKS8crQrhrHwlc8WycijFwVz5lIryk/Me+Wi+5ymxezcZMW2KMIyCJbohr
QlfFlXnB+y+L27zjG/HZ
=h0HV
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
