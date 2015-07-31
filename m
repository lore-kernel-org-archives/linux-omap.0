From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix bus recovery setup
Date: Fri, 31 Jul 2015 12:51:45 +0200
Message-ID: <20150731105145.GH1522@katana>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436366127-24756-1-git-send-email-jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to
> allow direct access to the SCL and SDA pins. In addition to ST_EN, we
> need to set the TMODE to 0b11 (Loop back & SDA/SCL IO mode select).
> Also, as the reset values of SCL_O and SDA_O are 0 (which means "drive
> low level"), we need to set them to 1 (which means "high-impedance") to
> avoid unwanted changes on the pins.
>=20
> As a precaution, reset all these bits to their default values after
> recovery is complete.
>=20
> Signed-off-by: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied to for-current, thanks!


--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu1NBAAoJEBQN5MwUoCm2WaQP/1Ln7a8dR2DIWk4dXkN6ipS/
AZZT9HD4WOQNWHyNq8uvqixZH3W/XcxhTvtQK+zjrC0N1NVR/tVibGA77xWV33ha
afJgPxh6rA3oxgyA590nnqc1V81FgyjFUBfS3xoQZTGLgB5drxPiG+ZO9hjo0eaY
Wy4nMRVXvcuG6DSAXmuA01YxHslpCvL5xBnPr4n2RHVkItvpBHTA4A9QZgBUPfph
FQFFrk3+sVjXE1mJUc4YWziRiGirUaNyHm49xxcqgB+NwOcJpmi5qOBUJf/Q5SSK
4ddkZwH174Lb9gTOavFj0J6VAQwFskhYtdD2Y94VKxVMB5QNQhJCQtOnP/iD4T/+
VUFB7FeQ73QNLxZndTMLbWJ33j00cdifPzuhWekMfuXMpb+LFioWcT9QW6DB79gD
7vQKDYnzCkNh2/KMS0zCEavnFePo9DgSwE4rJ2L+rXV8sZ2y1mRfj4/Pq8Q4wEV2
8V8Ubf9reSBMo8sx/aT7ZHHRdlS2nsI8Hxf3mknH5Ni+P2MgprI2evuPS8aWpUFO
oq0W6BHHwop4Spel4A7tuhupyK2BBXsGFv9y6KMD8RnRq+En8Hg8CgsVv4LodmhF
Mt1OW/2k4b8Y9oALl4KV9diLYaEVjNzMB+mYqWTpvkYGR78mN9G1ilvGOhXiUmYy
RoWWr0JESNhuTSGauDv2
=aht1
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
