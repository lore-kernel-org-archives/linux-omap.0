From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] I2C: OMAP: remove unneccesary use of pdev
Date: Thu, 4 Aug 2011 01:32:19 +0300
Message-ID: <20110803223219.GA4036@legolas.emea.dhcp.ti.com>
References: <1312394960-21689-1-git-send-email-khilman@ti.com>
 <1312394960-21689-2-git-send-email-khilman@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1312394960-21689-2-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 03, 2011 at 11:09:19AM -0700, Kevin Hilman wrote:
> A pointer to the struct device associated with the i2c device is
> already kept in the struct omap_i2c_dev, so use omap_i2c_device to
> find the pointer to struct device.
>=20
> Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>

Definitely :-)

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOOcxyAAoJEAv8Txj19kN19joH/irInzqjhMNpJIkIQJ+XqXmZ
kwdQ1sjyLx3zBMr+PdS3wxkmKw+DSlSNgRykG5OHNU4pqiH7mY86ihmASOLwkYJ6
wsWAC6n1Q4JROhWw5JcBj1jwiKiI2BbdipHzb/iMA3HyTE62O82gCGSF2Wr27wU3
6YRAmhkk37vsG6Efuox+fUkztPSjoJYIOhFcsm73Y2Y+jD4KlwqGosgZODrzJROD
xMZE6ifgnJgf+0vHjjCSyhVRw+FeY047nn6euy/FgpMT6Bmv3T0GugPWjPe0+HEV
adguxeA4Bx6DiIJakCnQW642SOazK473jWVE/DQYCcjWQeAp8paXPg7SzY0pSWk=
=4mjT
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
