From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 16:27:26 +0200
Message-ID: <20121211142725.GA17708@arwen.pp.htv.fi>
References: <50C5E23D.5040605@communistcode.co.uk>
 <20121210135337.GA10219@arwen.pp.htv.fi>
 <50C5F6A8.5060701@communistcode.co.uk>
 <20121210145947.GK11038@arwen.pp.htv.fi>
 <50C5FD73.1000408@communistcode.co.uk>
 <20121210183500.GB14303@arwen.pp.htv.fi>
 <50C70846.7010207@communistcode.co.uk>
 <20121211102011.GG19367@arwen.pp.htv.fi>
 <50C70D42.8030400@communistcode.co.uk>
 <20121211114810.GH19367@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44663 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab2LKOef (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 09:34:35 -0500
Content-Disposition: inline
In-Reply-To: <20121211114810.GH19367@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jack Mitchell <ml@communistcode.co.uk>, linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

On Tue, Dec 11, 2012 at 01:48:10PM +0200, Felipe Balbi wrote:
> On Tue, Dec 11, 2012 at 10:38:58AM +0000, Jack Mitchell wrote:
> > On 11/12/12 10:20, Felipe Balbi wrote:
> > >Hi,
> > >
> > >On Tue, Dec 11, 2012 at 10:17:42AM +0000, Jack Mitchell wrote:
> > >
> > ><big snip>
> > >
> > >>Shubhro, Felipe,
> > >>
> > >>Thank you, the reordering dma patch fixed the dma issue I was having!
> > >>However, the bad news, I now get the same results for the dma and
> > >>non-dma spidev test. While the scope shows the SPI clk and data is
> > >>fine, the reading from the program still shows 0x00 for all words.
> > ><removed spidev_test output>
> > >
> > >>dmesg shows nothing of interest apart from the spi bus setting up.
> > >>Any ideas?
> > >>
> > >>To iterate for my own sanity; I have bridged pins 18 and 21 on the P9
> > >>header which should be the d0 and d1 spi data pins for spi0. This
> > >>result of 0x00 usually comes from a result of not joining the pins,
> > >>but I can assure you they are joined!
> > >>
> > >>Thank you for the help so far.
> > >according to the schematics [1], those pins are muxed as UART2_TXD and
> > >I2C1_SDA, have you remuxed them properly ? Can you try with pins 29 and
> > >30 on the same header ? That's SPI1, so you will have to add DT data f=
or
> > >spidev on that bus too.
> > >
> > >[1] http://beagleboard.org/static/beaglebone/latest/Docs/Hardware/BONE=
_SCH.pdf
> > >
> >=20
> > No change unfortunately:
> >=20
> > root@beaglebone:~# ./spidev
> > spi mode: 0
> > bits per word: 16
> > max speed: 24000000 Hz (24000 KHz)
> >=20
> > 00 00 00 00 00 00
> > 00 00 00 00 00 00
> > 00 00 00 00 00 00
> > 00 00 00 00 00 00
> > 00 00 00 00 00 00
> > 00 00 00 00 00 00
> > 00 00
> >=20
> > root@beaglebone:~# ./spidev -D /dev/s
> > shm/       spidev1.0  spidev2.0  stderr     stdin      stdout
> > root@beaglebone:~# ./spidev -D /dev/spidev2.0

one thing caught my attention, shouldn't you be passing '-l' argument
here for loopback testing ? That would mean you need to make sure your
"spi->mode" has SPI_LOOP flag set. Currently there is no way to do that
via DeviceTree (AFAICT), so please apply ths patch to your tree and set
spi-loopback; property for your spidev entry:

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentat=
ion/devicetree/bindings/spi/spi-bus.txt
index 296015e..1949586 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -55,6 +55,8 @@ contain the following properties.
     		chip select active high
 - spi-3wire       - (optional) Empty property indicating device requires
     		    3-wire mode.
+- spi-loopback    - (optional) Empty property indicating device requires
+    		    loopback mode.
=20
 If a gpio chipselect is used for the SPI slave the gpio number will be pas=
sed
 via the cs_gpio
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3f1b9ee..6bcdc03 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -868,6 +868,8 @@ static void of_register_spi_devices(struct spi_master *=
master)
 			spi->mode |=3D SPI_CS_HIGH;
 		if (of_find_property(nc, "spi-3wire", NULL))
 			spi->mode |=3D SPI_3WIRE;
+		if (of_find_property(nc, "spi-loopback", NULL))
+			spi->mode |=3D SPI_LOOP;
=20
 		/* Device speed */
 		prop =3D of_get_property(nc, "spi-max-frequency", &len);

--=20
balbi

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQx0LNAAoJEIaOsuA1yqREk8cP/0ZEINb0JLkZxzCHrYhLu/p8
MeCPHHBJ4YWP03z2rAVHtFKRUU1XqQhNw3azNnmq/vHtWflWKmp9Ad3LWg47OldI
SSoLi5Ee4/wZn+sijlk8CgU+bLcbaMCrIDcLf0KSmRQSSsTxmS0EwLyIVwdLRI0G
+htDSob2onJtr/tcoavmHM26PhngNTh0PWE/06fjzTPGpsvM6GPsPGspdx9KR8vq
/hMXWioGjGlMN1yK1CJA/GB2vHIDA23hybkLQzZcTkuXfw0cnKA5GAfamWd0RLCI
6bsfGOnpKEuoRavoqwnYoymfLPiRzv/r+qkX3R90ZswsJy2L7e83JriAgivTTB+c
9U9aO5hu7UGe0590lp3orEPXqlMF5Ter3uYxLUYaG8HUxjMIqthhXfmlR4xibE9s
DZeK6NzJuOWrDySvv7ZCGI6Mxd5dZnp+YertZKPDMO8hwGwR0FXJYofRng46ZCJu
ZwlsUwfT3+c8xHtc0YUaCqIYU9Tqi1PDV4YDh/GUPcoI5AS359HFErQupgX64Fbi
dcXWU1R/V39CMMxVkCeIwGcC0YUNfrShaaar+D4pm0qpawHg2p5seqLJhbeKGJ0w
Ax2MC3If7E+xhvvchWd3NzOpyc7Rsb7kCtjKPn8E6bnsO290B9rour/C2j8n9b3c
VTx6Bo3rKbLKUFslr/47
=e0kp
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
