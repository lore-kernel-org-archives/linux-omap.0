From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2] i2c: omap: Remove the
 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE flag
Date: Mon, 26 Nov 2012 11:52:34 +0200
Message-ID: <20121126095234.GA16256@arwen.pp.htv.fi>
References: <1353923711-9615-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45552 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab2KZJ7a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 04:59:30 -0500
Content-Disposition: inline
In-Reply-To: <1353923711-9615-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com, w.sang@pengutronix.de

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 26, 2012 at 03:25:11PM +0530, Shubhrajyoti D wrote:
> The OMAP_I2C_FLAG_RESET_REGS_POSTIDLE is not used anymore
> in the i2c driver. Remove the flag.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

looks ok to me:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQszviAAoJEIaOsuA1yqRE4HgQAJ2stHncFvCGgAHQfLknWIA4
9V2cQAh42LQyNpYYvzQJmm1dO/KW7lUn5hlO3XSgY19b/o+lEFUsRCQ8YyfoLW4K
zLf01izw9m49sFAbfGKcNjng704I31B/3W/R9RBishInyqn0uahBkXhMlcOJvCGl
dtBF9eHWyFW7uQ1m2iUf2Q4DI16tc3movWyiSiqfSmrJ0cyQlYJN2MX93ffkK8RX
Swl4zXxZet+66KK22+uVo9GPSQCIsBkop6VCM49l1dgC6h6lpE18pEnylZcFv3r0
UhWk/hvGY79BkBouMtqO8qbrra08AtKXp7yzp3nYf8tFPYNqLfuf591f69SFbJc6
iYellr7KKVJfWvBFbCr+8TThk2nNHZd6OuRIphOOzlSucnatJWJohspWd6QLhiXg
JU0dsxcT4mZqmNhc66XrAcjdS2wx9kduB5lcTjzRxQFkNFoCBTgGQjcrPfmD4FAF
kHJPEnBv8ZdIJ0N5rPiV8IoSNScbYc3kft95n6e2zuCPoxScqtkoIBA7A/0UhCt8
9Du3PcIUVmSV+r3uYk2Sji3hjOaqEU9j5NdSNuW+B2n0TzwWTCUoNI5/SpAhkAhI
/IC0voGWB4dp544gGoIqYNRU1YyxHXWNT101Ryoi8KaJoKfzymxiiC5d97lL3aq+
l77XefyG50OOtgERDG8L
=hrdt
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
