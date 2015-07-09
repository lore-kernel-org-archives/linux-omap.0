From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: dra7x-evm: Prevent glitch on DCAN1 pinmux
Date: Thu, 9 Jul 2015 20:34:48 +0200
Message-ID: <559EBEC8.1070609@pengutronix.de>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
 <1436279277-3386-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uTvXSlAplnmhQprIE60xQgdIlvEB4DW69"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1436279277-3386-3-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, wg@grandegger.com, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uTvXSlAplnmhQprIE60xQgdIlvEB4DW69
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2015 04:27 PM, Roger Quadros wrote:
> Driver core sets "default" pinmux on on probe and CAN driver
> sets "sleep" pinmux during register. This causes a small window
> where the CAN pins are in "default" state with the DCAN module
> being disabled.
>=20
> Change the "default" state to be like sleep so this glitch is
> avoided. Add a new "active" state that is used by the driver
> when CAN is actually active.

Who is taking care of this patch? I'm applying 1/2 (v2) to linux-can,
should I take this patch, too?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uTvXSlAplnmhQprIE60xQgdIlvEB4DW69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVnr7IAAoJEP5prqPJtc/HXggH/1F7Wfy5XNlKc0VAtqbT4K7Q
hc6chc/IpjdkTkdfdrSteeiJZyNX4HGrupwkuOtCwle1P6EJfSqCa5r7eEKennCl
s4cPq4rcLuQk/DpiGOL5Moa+Nh/4Io1OZsDe0L6cdsfyiYhcjD4KEJug5Ys6q+lY
BJUmrk5YoNYlh7wR7U5e2kG4yRqm6yx89tb2YPH2PQaupfVXJ2BOLGdSGUYMS7yf
G+Sn+rExGnuuzFL76luus74L9pTGeGvnLiIiRstzObYTbD+d8w85IriCa3FTw2be
2NfAXIKr2dEB+9xbI93XQrAFr5v7SbUgyodfKJTFo97Jwi+YGt2Oq+S8VF3Sxp4=
=lWS4
-----END PGP SIGNATURE-----

--uTvXSlAplnmhQprIE60xQgdIlvEB4DW69--
