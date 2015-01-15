From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: c_can: use regmap_update_bits() to modify RAMINIT
 register
Date: Thu, 15 Jan 2015 15:37:28 +0100
Message-ID: <54B7D0A8.8050806@pengutronix.de>
References: <1420641162-8634-1-git-send-email-rogerq@ti.com> <54B52A4F.8030208@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mX0w9hUJtluj2IJSCDROQ60Lhif5hCGCP"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <54B52A4F.8030208@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: wsa@the-dreams.de, Mark Brown <broonie@kernel.org>, linux-can@vger.kernel.org, tomi.valkeinen@ti.com, kernel@pengutronix.de, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mX0w9hUJtluj2IJSCDROQ60Lhif5hCGCP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2015 03:23 PM, Roger Quadros wrote:
> use of regmap_read() and regmap_write() in c_can_hw_raminit_syscon()
> is not safe as the RAMINIT register can be shared between different dri=
vers
> at least for TI SoCs.
>=20
> To make the modification atomic we switch to using regmap_update_bits()=
=2E
>=20
> regmap_update_bits() skips writing to the register if it's read content=
 is the
> same as what is going to be written. This causes an issue for us when w=
e
> need to clear the DONE bit with the initial condition START:0, DONE:1 a=
s
> DONE bit must be written with 1 to clear it.
>=20
> So we defer the clearing of DONE bit to later when we set the START bit=
=2E
> There we are sure that START bit is changed from 0 to 1 so the write of=

> 1 to already set DONE bit will happen.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Applied to linux-can.

Thanks, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mX0w9hUJtluj2IJSCDROQ60Lhif5hCGCP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUt9CtAAoJECte4hHFiupUIwsQAK078XpHdX4AXkbvB+A7T2WW
xcJQTQf6hblo4r6s82b89jEURamdvw7qUrwViWJ8x11dH0/oDFV9vkkgqdOCI5nZ
SKAEOdhZs0v9M3TuZoaz0Z8RL3p2RxPcNSquY4OWfupMGlrLyj/lOvpJiya+/frZ
sF3MAC7t4cq+9getUe7fopRfNSm3Cwsuk27sVKohDZu4QQMdklaHb2WltGuB1dH7
HkhWzL3GIT63gMaT9/JTkoHCBwR3osKWXL7UTOoLPXDAzGU45uoVTwchA7lGojjN
cjI3PIjV8ydPAvLDLVlD/q3FUDkDrYTidbukAWTvXa/xR4QRPzlIwf7s+UL8h0wx
D3cHE/OVVpXAUp4caXNmg5LP+Kf7TVvyVhryFajVLMFeGFj5O+ikiDmQiX6CLqWy
uMb5a81qJhBNcUlqlooNbZFBFLAeecQE5P+dbb1y2gVtV4aR2pJ6c35YG5n3CHR+
WkEe/QYooDo4b1PkOAA1ClwDYco0lO0DE4ZbkijIk55jrB/dTlCitUWGwKmxOvMm
nt4t8RfHruXb94uXF8A9HmbTUfO5tFY4prB3UFpTTU/Jpm5Px0jbfsr+5su9D/MF
vY7oi2yIWw0SeRKiQacrp0nRYfrbxp1zmraB7bZhywM2Ahj/9SgI0/NcTR0dQ6gA
tVuT+k0ZtW/FmlNSqQve
=MInH
-----END PGP SIGNATURE-----

--mX0w9hUJtluj2IJSCDROQ60Lhif5hCGCP--
