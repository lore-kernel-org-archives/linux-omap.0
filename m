From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc3
Date: Mon, 14 Jan 2013 23:18:46 +0200
Message-ID: <20130114211846.GA10699@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
 <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
 <20130114191459.GA9402@arwen.pp.htv.fi>
 <20130114204654.GB18224@blackmetal.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54589 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756871Ab3ANVTF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jan 2013 16:19:05 -0500
Content-Disposition: inline
In-Reply-To: <20130114204654.GB18224@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 14, 2013 at 10:46:54PM +0200, Aaro Koskinen wrote:
> On Mon, Jan 14, 2013 at 09:14:59PM +0200, Felipe Balbi wrote:
> > On Mon, Jan 14, 2013 at 08:40:18PM +0200, Aaro Koskinen wrote:
> > > On Mon, Jan 14, 2013 at 05:59:12PM +0000, Paul Walmsley wrote:
> > > > Here are some basic OMAP test results for Linux v3.8-rc3.
> > > > Logs and other details at:
> > > >=20
> > > >     http://www.pwsan.com/omap/testlogs/test_v3.8-rc3/20130109222058/
> > > >=20
> > > >=20
> > > > Test summary
> > > > ------------
> > > >=20
> > > > Boot to userspace:
> > > >     Pass ( 9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
> > > >   	   	  3730beaglexm, 37xxevm, 4430es2panda, 5912osk,
> > > > 		  4460pandaes
> > > >     FAIL ( 2/11): am335xbone, cmt3517=20
> > >=20
> > > N900 boot is unstable again, I2C issues are back.
> >=20
> > damn!
> >=20
> > > Boot succeeds and fails randomly. Let's see if this can be bisected.
> > > The same kernel works on N950.
> >=20
> > fair enough, it might be something related to some errata fix which
> > might have been missed. Can you apply this small patch just so I know if
> > there is something pending in CNT reg ?
>=20
> [    0.207946] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
> [    0.208129] twl 1-0048: power (irq 343) chaining IRQs 346..353
> [    0.209350] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 35=
4..371
> [    1.218749] omap_i2c omap_i2c.1: timeout waiting for bus ready
> [    1.218811] omap_i2c omap_i2c.1: SA 0049 CON 9602 CNT 0004

here's the issue, there is unloaded data in the FIFO. Can you enable
full I2C debugging logs ?

> > you might also want to try merging my latest i2c patches, which missed
> > the merge window, as they might help with this issue too.
> >=20
> > The following changes since commit 9931faca02c604c22335f5a935a501bb2ace=
6e20:
> >=20
> >   Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-defer=
red-STP
>=20
> I could not reproduce the issue with these. Tested around 20 boots.
> There's a noticeable delay (over 4 secs!) around where I2C is initialized
> and used for the first time, but no errors and the boot completes:
>=20
> [    0.187530] SCSI subsystem initialized
> [    0.188110] usbcore: registered new interface driver usbfs
> [    0.188415] usbcore: registered new interface driver hub
> [    0.188781] usbcore: registered new device driver usb
> [    0.189453] musb-omap2430 musb-omap2430: invalid resource
> [    4.296905] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
> [    4.297088] twl 1-0048: power (irq 343) chaining IRQs 346..353
> [    4.329010] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 35=
4..371
> [    4.470123] VUSB1V5: 1500 mV normal standby
> [    4.470916] VUSB1V8: 1800 mV normal standby

cool, at least it works, but looks like there is something still weird
going on. Can you enable full logs so I see what's happening ?

cheers

--=20
balbi

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ9HY2AAoJEIaOsuA1yqREligQAK8S7JeFsMARAvTBDNg4qxcO
kMfHjPGxDuCTzlsGvaZNFzsT0ET6AeonxLGR5its4AbbRg4+ZgQGtAufkz9ffWTV
AaZK6fdVfswZA6pXCEtLUbo6sCAFtxR9vJmqzBCgp5rkjSSEVDX2S15TabOyH2Bd
cBbmzuIe+u81alzvw+XvGYOgUijY4vjn2CLCz3EvOIk6xyc0yx/hkPeiGamh6uZB
SQgXCqv4PZeFtufuU0F/pCHnmdzmLjfpRc+PNdh0MiPw5Gc4ZOcyhgV4pM+Xc5/6
yF2uPmd7SwqBsIWV1Tv/fudhD1j65J6jiPPdN0DjI7msTi6jvqj8NwEn3TrGeej+
XCCss13IuzIcYTFeeLdST6zwE1hR4vMpSuFioy57ROKbuURrEI4AHCej/hnM/dJZ
eeB/KLLu+FgPZiRMdcQpVRS5c7two7NrLRcbn1oWzynBcV/DMbo/rNtCdiGJ7tVH
ZcffIak4/XI/Ws1tU6jhZsszy8Dfnck2B3PPmipBAxph+bS0nKG8d2V6Bs9d5Dog
WvygZBN+bBtioEdNd3vqc9OGVtySg9vjkU1rwjMVAEJnC4cfIWAFOrvw5TphgUMQ
6bEijuj+hM0oQXowuPwtnqgh/vEQYtK55itfk7F0xh7F6t9zAk2Sg7Edxnfl7fKF
oD3OrOxVvLoS7vuTm88H
=YYpF
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
