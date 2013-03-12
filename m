From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/8] usb: phy: nop: Add some parameters to platform data
Date: Tue, 12 Mar 2013 12:54:37 +0100
Message-ID: <513F177D.40500@pengutronix.de>
References: <1363087466-32444-1-git-send-email-rogerq@ti.com> <1363087466-32444-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UKGFGHIUNOEIEPLFKHJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363087466-32444-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UKGFGHIUNOEIEPLFKHJP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/12/2013 12:24 PM, Roger Quadros wrote:
> Add clk_rate parameter to platform data. If supplied, the
> NOP phy driver will program the clock to that rate during probe.
>=20
> Also add 2 flags, needs_vcc and needs_reset.
> If the flag is set and the regulator couldn't be found
> then the driver will bail out with -EPROBE_DEFER.

Is there a platform which fills out pdata.needs_vcc and
pdata.needs_reset? IMHO it makes no sense to add features for the non DT
case, if there isn't any user for it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2UKGFGHIUNOEIEPLFKHJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE/F4AACgkQjTAFq1RaXHOC4wCdEOm1cScGwIpWrSQG+S12Xbk/
/sIAnR0i4Rld+2VGgg6V2jhOD/hv8ExZ
=9+6l
-----END PGP SIGNATURE-----

------enig2UKGFGHIUNOEIEPLFKHJP--
