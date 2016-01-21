From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns
 back on
Date: Thu, 21 Jan 2016 20:15:25 +0100
Message-ID: <20160121191525.GA26215@earth>
References: <20160121184234.GA17679@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160121184234.GA17679@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 21, 2016 at 07:42:34PM +0100, Pavel Machek wrote:
> In 4.4, n900 battery charging works. If indicator is turned off, it
> stays off, and if I select 1.8A charge, it sticks. (There may be
> problems after system suspend and resume. But normal operation seems
> to be pretty reliable).
>=20
> In 4.5-rc0 (7fdec82af6a9e190e53d07a1463d2a9ac49a8750) battery charging
> works for few hours. But then indicator (yellow light on 3color LED)
> turns back on, and if I ask for 1.8A charge, it goes back to .1A,
> discharging battery.
>=20
> Any ideas?

Maybe a side-effect of isp1704 driver actually doing what was
intended, which is is 88025632515a ("power: isp1704_charger: Fix
isp1704_write()").

P.S.: No need to Cc me two times and when you update your
script/contacts, please use sre@kernel.org :)

-- Sebastian

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWoS5KAAoJENju1/PIO/qa2mYP/35tOXZISHxdHVXIQgcJ4UGn
+AjmwsTTlH8MoeQk6292f9RyPyE+2r5yDZdDvOVIPFYFzfzz9iSBzrI4qCo8G6Mj
AAjN5L4Uew1ol1jKbQi5nYDyzhU4WAjVYZN9Eh6u/lKTNZC6EuFrhyqpfOkHoD3z
cQGL4V7tOIPBgSyIOR9NFZEu2mP39h9u/PvK9k/4OUkfnMiIAS9/iTuyaQu8M/XU
WdNcJuRw8ebhmS7NdJ24XoMUp6j0Zp2E3l0jLOj+P0ntfupTohI9YsK3cqNmGI1F
a26cAxxBywvdxywYezNdDaEIKcLJW+dhTeKJN5/2VV2VwvKHVl/+VgKobAZ2y4is
jP9DabCLF8zH/CNUhdRGA46HRRpbjgv+1+ZoLpRerXFecyOWHwWtE59+xb0Ewqzq
wv4RLvYwYoratAUfcL4VLN1DUW9xz8owcyWbVPpHurA3Id6wzHI9tM26xXDHt2TK
I6rHuJFdlsv7s1xVNned8AEw0QD+jYfx9ZoMRiUPOmybWtqYSI8rZrmJpoz5znLY
d1jyfkHxteDU6Pd2P//QBvW+cJgCtlsz7YX3GR/q/43BOXD/HncCAa4cGvNrph07
Hmshpo3PrajYt442/Dw810xtZSS9SzGcATV/QBNgXhcwb+xc86GiiQJ9hVdY5ZcL
GA017VnDVIuINmf7xzvq
=9vwZ
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
