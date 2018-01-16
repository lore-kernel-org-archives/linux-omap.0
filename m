From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8 4/5] can: m_can: Add PM Support
Date: Tue, 16 Jan 2018 13:57:40 +0100
Message-ID: <1b879e98-27a9-8117-c159-5473917a20cb@pengutronix.de>
References: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
 <1516102634-6771-5-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fQSy1vzTJjVNAfH6cYSVa7y0OuKculnJY"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1516102634-6771-5-git-send-email-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fQSy1vzTJjVNAfH6cYSVa7y0OuKculnJY
Content-Type: multipart/mixed; boundary="4OZu2jG835O6G0odgoyMGDSztj1ZXGCuF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com,
 fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com,
 sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org,
 b29396@freescale.com
Message-ID: <1b879e98-27a9-8117-c159-5473917a20cb@pengutronix.de>
Subject: Re: [PATCH v8 4/5] can: m_can: Add PM Support
References: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
 <1516102634-6771-5-git-send-email-faiz_abbas@ti.com>
In-Reply-To: <1516102634-6771-5-git-send-email-faiz_abbas@ti.com>

--4OZu2jG835O6G0odgoyMGDSztj1ZXGCuF
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 12:37 PM, Faiz Abbas wrote:
> Add support for CONFIG_PM which is the new way to handle managing clock=
s.
>=20
> Move the clock management to pm_runtime_resume() and pm_runtime_suspend=
()
> callbacks for the driver.
>=20
> CONFIG_PM is required by OMAP based devices to handle clock management.=

> Therefore, this allows future Texas Instruments SoCs that have the MCAN=
 IP
> to work with this driver.
>=20
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Fixed this while applying:

drivers/net/can/m_can/m_can.c:1752:5: warning: symbol
'm_can_runtime_suspend' was not declared. Should it be static?
drivers/net/can/m_can/m_can.c:1763:5: warning: symbol
'm_can_runtime_resume' was not declared. Should it be static?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4OZu2jG835O6G0odgoyMGDSztj1ZXGCuF--

--fQSy1vzTJjVNAfH6cYSVa7y0OuKculnJY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpd9sQACgkQHv7KIOw4
HPZA1AgAlnOPlE2m2BYrMFtembhrq6db/OpAeDdbmoJZqz3FHhKXx6dT7YMqfQhE
/PYFvJOgqScwWOpvx+KCW8B4URx9lQfvqbCGPFpQUu2+R4SvEL/0doLmG9GZZFAf
pY3fjzuDKOfTzjTjopXFpEzfZiAB4Y2dqdm2X0RuCsfw9odzOCbYzxxKY/JKGgvo
gxtEA82IzhjBktjRVA774p8+DPR2rVaXaBLE6ZZ+T0Bm0FaOuSUtMN2rAOqlcO/v
QDmA+CBU7ljsnWRNWchnCWdnZ4Axi5zkv37c0dfMrzmWpzz+UlJjcQWGt6K/+d9C
0IOsrDxH0JgC+9SvxbSTFhCSZ0sj1A==
=/3d8
-----END PGP SIGNATURE-----

--fQSy1vzTJjVNAfH6cYSVa7y0OuKculnJY--
