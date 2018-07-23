From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: m_can: Fix runtime resume call
Date: Mon, 23 Jul 2018 10:05:42 +0200
Message-ID: <a4e20283-7581-9d29-5b51-66fef7433cb7@pengutronix.de>
References: <20180703111102.26502-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rmBPG1Cwvpk7gHex6hdbx0OFwCnLWt1bb"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703111102.26502-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-omap@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rmBPG1Cwvpk7gHex6hdbx0OFwCnLWt1bb
Content-Type: multipart/mixed; boundary="pU0Z7r7fAwCLRjctdul6c10dS0bUkou14";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-omap@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net
Message-ID: <a4e20283-7581-9d29-5b51-66fef7433cb7@pengutronix.de>
Subject: Re: [PATCH v2] can: m_can: Fix runtime resume call
References: <20180703111102.26502-1-faiz_abbas@ti.com>
In-Reply-To: <20180703111102.26502-1-faiz_abbas@ti.com>

--pU0Z7r7fAwCLRjctdul6c10dS0bUkou14
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/03/2018 01:11 PM, Faiz Abbas wrote:
> pm_runtime_get_sync() returns a 1 if the state of the device is already=

> 'active'. This is not a failure case and should return a success.
>=20
> Therefore fix error handling for pm_runtime_get_sync() call such that
> it returns success when the value is 1.
>=20
> Also cleanup the TODO for using runtime PM for sleep mode as that is
> implemented.
>=20
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pU0Z7r7fAwCLRjctdul6c10dS0bUkou14--

--rmBPG1Cwvpk7gHex6hdbx0OFwCnLWt1bb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVjFkACgkQk9IU1zQo
ZfHmtgf/Zyl2db60KctC3jXzxQ+vMOXNgxhugQML8FK7+FIU9RMj1KDOeIxP8j78
3GeUrJaEtlS0iCR4VVbW2Gn8vuv/E4TYSq/ZbFSOr19noih0HHYNzF2sdEZHgV4J
ruNuMKLB2TrjIgOrd3yVTP5dBvZxYnzphWETq+CQA60Wvda0rD84CGpaXw0vKiwU
6EN4LqRZfysanUplFFAmUGRBk0ghLF7/MczBqn6gGHNkMSBEdlVBq5YU2C/BB7TW
HOsjB2FzxTPAnUSq15BdckWnWK8aLl6T8IFjADjU5WP7yl96zeIXMVxZLOFA8Tg3
hl5YcevAYS5utba8VC+AKQ4kFXddFw==
=EFT5
-----END PGP SIGNATURE-----

--rmBPG1Cwvpk7gHex6hdbx0OFwCnLWt1bb--
