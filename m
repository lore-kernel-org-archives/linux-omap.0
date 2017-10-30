From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: omap: Trigger bus recovery in lockup case
Date: Mon, 30 Oct 2017 15:19:34 +0100
Message-ID: <20171030141934.t4wnl2dqazhusobd@ninjato>
References: <e9b43138-6c01-bc99-9bac-355823bc0c19@ti.com>
 <1507110225-3050-1-git-send-email-claudio.foellmi@ergon.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ze7pevaym4fbybkk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507110225-3050-1-git-send-email-claudio.foellmi@ergon.ch>
Sender: linux-i2c-owner@vger.kernel.org
To: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org


--ze7pevaym4fbybkk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 11:43:45AM +0200, Claudio Foellmi wrote:
> A very conservative check for bus activity (to prevent interference
> in multimaster setups) prevented the bus recovery methods from being
> triggered in the case that SDA or SCL was stuck low.
> This defeats the purpose of the recovery mechanism, which was introduced
> for exactly this situation (a slave device keeping SDA pulled down).
>=20
> Also added a check to make sure SDA is low before attempting recovery.
> If SDA is not stuck low, recovery will not help, so we can skip it.
>=20
> Note that bus lockups can persist across reboots. The only other options
> are to reset or power cycle the offending slave device, and many i2c
> slaves do not even have a reset pin.
>=20
> If we see that one of the lines is low for the entire timeout duration,
> we can actually be sure that there is no other master driving the bus.
> It is therefore save for us to attempt a bus recovery.
>=20
> Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Vignesh R <vigneshr@ti.com>

Applied with the discussed change to for-next, thanks!


--ze7pevaym4fbybkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln3NPIACgkQFA3kzBSg
KbZyzBAAgDDUab4Tzbuzww8QzZvIF1w/wN52ssIx5X8CU+KO58cAguVEEDoVlyph
5jP+bwdoz2ZOypYr00UAIcttDQDqjHxrLCSmRtNKYJziZQTUwClf0i3j9ZKALzqq
Mi0RGSTuCPlhWKpU8K/yQdAjpZ1riDffiEI7zXRSyTdx4bmQI02YDqUqTiVcyJxI
fZmyhRK8a3noKD/5XnT7aaaPQGjp1DNoPdzfM3N2JYBQ4QqnVlwYXKJshl/K6RhK
rhKe+6w6Jq3bBhjQGMhN3ONmjT4+/mzFoE+TIWCX3pnGzPRSW6f39NrGRxV3pGUO
tA6U68Q8ePu4uLRX9I1XYppX5lI1qroexvUvLII8RDc7B/GbfGiNXrz+X7T+sbAD
ZlbOEBDUmi9T804rTaqJKe8eEKeCWTJIiqODM9S2zW14Bm/zRoWrXDqx16YWTAGm
zKhpCsMqqWxbALPsyK1XEwGcd7J8xICfoilY3+bDu/FxxjnZ4LFNd3yirUtUWQTm
da/81+yytQ16epbRE0wjwo+99Kasroke4lkvfD4YAUloU5sUOGbkSsctqlMQ8kkq
F1GNSo/+ccG21Ek42jBmBrHMGYQ5VqGswNNXkIo5/rkWQVOKNQEIrMx1CKBSFXWe
Bw2swp9faMmKzduGGeIO9NPhQc0NFihZ+SJ2rfYWKhVY/7Ufv+Q=
=n/ZT
-----END PGP SIGNATURE-----

--ze7pevaym4fbybkk--
