From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: m_can: Move accessing of message ram to after
 clocks are enabled
Date: Mon, 23 Jul 2018 10:07:55 +0200
Message-ID: <2e770ca2-59aa-e508-81ca-f4afb06be4ef@pengutronix.de>
References: <20180703111710.27084-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ADYtKyxI9trJLispn7lffr662Og7fPcw9"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180703111710.27084-1-faiz_abbas@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-omap@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ADYtKyxI9trJLispn7lffr662Og7fPcw9
Content-Type: multipart/mixed; boundary="aNxSNlSKLd6ipkBU8ELMi2sLKHx24d3Et";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-omap@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net
Message-ID: <2e770ca2-59aa-e508-81ca-f4afb06be4ef@pengutronix.de>
Subject: Re: [PATCH v2] can: m_can: Move accessing of message ram to after
 clocks are enabled
References: <20180703111710.27084-1-faiz_abbas@ti.com>
In-Reply-To: <20180703111710.27084-1-faiz_abbas@ti.com>

--aNxSNlSKLd6ipkBU8ELMi2sLKHx24d3Et
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/03/2018 01:17 PM, Faiz Abbas wrote:
> MCAN message ram should only be accessed once clocks are enabled.
> Therefore, move the call to parse/init the message ram to after
> clocks are enabled.
>=20
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

applied to linux-can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--aNxSNlSKLd6ipkBU8ELMi2sLKHx24d3Et--

--ADYtKyxI9trJLispn7lffr662Og7fPcw9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVjNsACgkQk9IU1zQo
ZfEGFQgAwcQ9QH0248tb60Mo0YAtr/sgwqTSemu1dA+50cB7RRUxxuDKtjGWMaGn
z70ChsSZ8puZ/dzdzbC2fHZ/C/8z3bPW8A7cy5KlFA78Q/pvz/mHflcd794a62Nn
ZEhOGCYmDtpOKQyr7bmArKMDY6WIpvbu3R10x5GoSPBhqgiFyl9O02lJE1AlCz7K
xZphOaZcDST5uz82ptRPJfxKKAGJq8fiHPivg7Fy4i+VsLC+hTQ2nKnGDL6oEYG7
nrmZW8EPMVO9/X1zIWCXtOq9maAtJg3KKM49JMsTnzC9i3ao85wrZWF4Jw5dBSk+
+IcfHsXjqsTQyfRL9zHxqiGYUvyHKw==
=66GW
-----END PGP SIGNATURE-----

--ADYtKyxI9trJLispn7lffr662Og7fPcw9--
