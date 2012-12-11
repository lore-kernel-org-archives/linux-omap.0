From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 13:48:10 +0200
Message-ID: <20121211114810.GH19367@arwen.pp.htv.fi>
References: <50C5E23D.5040605@communistcode.co.uk>
 <20121210135337.GA10219@arwen.pp.htv.fi>
 <50C5F6A8.5060701@communistcode.co.uk>
 <20121210145947.GK11038@arwen.pp.htv.fi>
 <50C5FD73.1000408@communistcode.co.uk>
 <20121210183500.GB14303@arwen.pp.htv.fi>
 <50C70846.7010207@communistcode.co.uk>
 <20121211102011.GG19367@arwen.pp.htv.fi>
 <50C70D42.8030400@communistcode.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38353 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585Ab2LKLzU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 06:55:20 -0500
Content-Disposition: inline
In-Reply-To: <50C70D42.8030400@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jack Mitchell <ml@communistcode.co.uk>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 11, 2012 at 10:38:58AM +0000, Jack Mitchell wrote:
> On 11/12/12 10:20, Felipe Balbi wrote:
> >Hi,
> >
> >On Tue, Dec 11, 2012 at 10:17:42AM +0000, Jack Mitchell wrote:
> >
> ><big snip>
> >
> >>Shubhro, Felipe,
> >>
> >>Thank you, the reordering dma patch fixed the dma issue I was having!
> >>However, the bad news, I now get the same results for the dma and
> >>non-dma spidev test. While the scope shows the SPI clk and data is
> >>fine, the reading from the program still shows 0x00 for all words.
> ><removed spidev_test output>
> >
> >>dmesg shows nothing of interest apart from the spi bus setting up.
> >>Any ideas?
> >>
> >>To iterate for my own sanity; I have bridged pins 18 and 21 on the P9
> >>header which should be the d0 and d1 spi data pins for spi0. This
> >>result of 0x00 usually comes from a result of not joining the pins,
> >>but I can assure you they are joined!
> >>
> >>Thank you for the help so far.
> >according to the schematics [1], those pins are muxed as UART2_TXD and
> >I2C1_SDA, have you remuxed them properly ? Can you try with pins 29 and
> >30 on the same header ? That's SPI1, so you will have to add DT data for
> >spidev on that bus too.
> >
> >[1] http://beagleboard.org/static/beaglebone/latest/Docs/Hardware/BONE_S=
CH.pdf
> >
>=20
> No change unfortunately:
>=20
> root@beaglebone:~# ./spidev
> spi mode: 0
> bits per word: 16
> max speed: 24000000 Hz (24000 KHz)
>=20
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00
>=20
> root@beaglebone:~# ./spidev -D /dev/s
> shm/       spidev1.0  spidev2.0  stderr     stdin      stdout
> root@beaglebone:~# ./spidev -D /dev/spidev2.0
> spi mode: 0
> bits per word: 16
> max speed: 24000000 Hz (24000 KHz)
>=20
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00
> root@beaglebone:~#

weird... I'll try to test with my pandaboard and see what's the outcome
of that.

--=20
balbi

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJQxx16AAoJEIaOsuA1yqRE+H0P9A2e2CKW9QQ8rsXzliT72u5L
dSYMOsMpHvCJrbGsgZqpNK7DxHAN9IeHJ2GO/ARHuPwYuBTfQEkAJzhkF59RtRSk
2Ep3/kvhlzAwc6lGUHGveZoZ03uLkAnJH7GlHwQwOOhqsPCmVdrAGwzA0UlIQ0Ub
7zC2GGn5Ks07pBUZplqspksfv1FEIp6XXin7kOnbi0KTCmil2zRuGe2syPnSHwSQ
N+dFXvmS6c8YBv/oPhA/BNgaXNxDr69C9CdzY7ajSgljU7RDcQA5eSXHUBNsUL3w
Hygea6xTeUvfxidkkIyzIkRYq2nLe4NzdZfepH9UxJQyNdQNAHStuDl6WRJ5CFLX
acLYQRyx18nUlNMqUOtUcG9iX9+WV0iWA5BHW+QCwx9kLparqtrSph4q6+9pcp0Y
D/wrIDEvGL6Jelct8f5qbs1HC8SD13MSb+hBtH3KGrDm8LE8jWQWCgj1kNNozsHT
iojvgX03vjHkhRmJ8D77XeOEu7sxGqVtCLvwpjhaDbPCCsV8Yb4P6j5GMRoOmG7c
fXzDZNs6HtTlPO7JkEHvRk1TxfLSZNsVsJck8yTYZmFXbFxlqZ+9s09dA9IWjYxc
EhhgYlxbDQZ2L3ZehbPHF9n4OHb7COqOFdzgZvYWBCRrjmUldw6kUSnJFFWF8TMN
DsP9kilgQuu3EyNVCz8=
=DwCZ
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
