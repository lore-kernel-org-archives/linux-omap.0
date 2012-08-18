From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v7] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Sat, 18 Aug 2012 21:33:37 +0200
Message-ID: <502FEE11.7070305@pengutronix.de>
References: <1344866802-15980-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2F13BED3379E279FC03BDC65"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1344866802-15980-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F13BED3379E279FC03BDC65
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/13/2012 04:06 PM, AnilKumar Ch wrote:
> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> register of C_CAN/D_CAN IP when clock is turned off.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> This patch has been tested on AM335X EVM. Due to lack of hardware
> I am not able to test c_can functionality. I appreciate if anyone
> can test c_can functionality with this patch.
>=20
> This patch is based on "can-next/master"=20
>=20
> Changes from v6:
> 	- Incorporated Marc's commets on v6
> 	  * changed dev pointer to priv

Sorry, I meant not to rename the variable, but change the signature of
the function to:

  static inline void c_can_pm_runtime_get_sync(struct c_can_priv *priv)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2F13BED3379E279FC03BDC65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAv7hQACgkQjTAFq1RaXHMcGgCfb1Q0lRdm5iyJCJOrQhSpiXXW
BsMAn28uTgErpU+gpHK7P1Y0Dg2XEQQd
=IwFI
-----END PGP SIGNATURE-----

--------------enig2F13BED3379E279FC03BDC65--
