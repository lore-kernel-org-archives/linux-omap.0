From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Mon, 10 Dec 2012 15:53:37 +0200
Message-ID: <20121210135337.GA10219@arwen.pp.htv.fi>
References: <50C5E23D.5040605@communistcode.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42758 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716Ab2LJOAo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 09:00:44 -0500
Content-Disposition: inline
In-Reply-To: <50C5E23D.5040605@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jack Mitchell <ml@communistcode.co.uk>
Cc: linux-omap@vger.kernel.org

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 10, 2012 at 01:23:09PM +0000, Jack Mitchell wrote:
> Hi,
>=20
> I am currently having issues with the SPI driver on the beaglebone
> using the 3.7-rc8 kernel[1]. I have probed the SPI pins and I have
> found that writing works however reading doesn't. When using DMA the
> program seems to lock hard and no data is sent on the bus. I am
> testing the bus using spidev and the spidev_test[2] application,
> however I first came across spi issues with a custom spi driver which
> stopped working when I transitioned from 3.2-psp to 3.7-rc8.
>=20
> The current output I am seeing from the spidev_test program is just a
> series of 0x00 data, which looks to me like no data is getting in at
> all. The spidev_test program is not using DMA as the buffer size is
> too low, so I forced the dma on when buffer size is > 1 and the
> program hangs hard with the system still responding to other
> commands.I have briged the pins 18 and 21 on the BeagleBone P9
> header.
>=20
> Has anyone seen issues like this, or if not if someone could please
> test the latest 3.7-rc8 from [1] and let me know if it works for them
> and the issue is at my end.
>=20
> To get spidev working with devicetree I applied the patch from [3]
> and changed the dtb as in the patch pasted below.
>=20
> [1] https://github.com/beagleboard/kernel/tree/3.7
> [2] http://lxr.linux.no/#linux+v3.6.9/Documentation/spi/spidev_test.c
> [3] http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/m=
sg09958.html

do you have any debugging output from that driver ? It would be cool to
see if DMA is at least being kicked properly for small transfers.

It would also be nice to have a clear picture of what "custom spi
driver" you're talking about.

cheers

--=20
balbi

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQxelhAAoJEIaOsuA1yqRE0/MP/10eSGtGuHl9MbUNxh5zo64j
kqwefzgKc8xF6pxWBh+RbJYMaDai5U8NsAf6QAnBeKOw9xEaVM0co6BUuYqM5AEr
mkXMCpxcqB4Qyc/zZDAEajHUZSLJi5MVJ/dV47SaJUlCldAgeJGSvMCAKmR10VHS
6J2EsMiww5pWvB93Dwjv9pysPYPCdC9YxUrp6MxYwwAzPVtFEj5BRfvKhVen0JHm
4G3EzMtre5Aswsel/P6BlNls2a6TN7EP59jn6iJwW0Bm+dbUoGoiLz1sW7Q0rfJB
ud2l2t2yw0Nut7i9riHfaKF5ydmSWycILbDM5ScNCjneaunPLLjd86DLYdHq7GIq
xU/qA2w1pfrpjz1xMWLTG/nUUOifO1hKOBwwaSjvnmROSh8KnPDnzsD399S+1KRs
jqzY/AewiiVhJ2rDB9y4M8tbLlLF913ZeMJlE5L0RZqhSrQa2DKvLOPEEHBL3zVZ
vKsbDxDUuT6aXlYkqm5jU4Y4rdlSQmYn0jwDcI18f3JCVVGX4L4rlXfqtcEZEcii
r/XW3y7O3cTTpkEc8YAzE092WIZjK9FoS7uHbTJTl/kJSuIaDsrYmjHjnp8QDbQk
iWbrnKdj3YEgHKCcgCSHJSNUUlE4Lf0U+8fg1WCbOdxFa4LbsUPQGg2Kr6f9+lua
Idsnaeqiw3i3y0R0cb7b
=7Dga
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
