From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: OMAP4 SDP regression...
Date: Tue, 18 Mar 2014 08:59:35 +0100
Message-ID: <20140318075935.GG11360@pengutronix.de>
References: <20140317233229.GP21483@n2100.arm.linux.org.uk>
 <20140318013507.GD30471@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49790 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaCRH7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2014 03:59:42 -0400
Content-Disposition: inline
In-Reply-To: <20140318013507.GD30471@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Mark Brown <broonie@linaro.org>


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 17, 2014 at 06:35:07PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140317 16:35]:
> > There's been a couple of regressions on OMAP4430 SDP I've only recently
> > noticed:
> >=20
> > http://www.arm.linux.org.uk/developer/build/result.php?type=3Dboot&idx=
=3D1597
> >=20
> > Configuring network interfaces... udhcpc (v1.9.1) started
> > Sending discover...
> > Sending discover...
> > Sending discover...
> > No lease, failing
> > done.
> >=20
> > No link lights come up either.  The hardware is fine because uboot mana=
ges
> > to successfully tftp the kernel.
> >=20
> > It looks like it was working in -rc4+armsoc and -rc5+armsoc, but not
> > -rc6+armsoc.
> >=20
> > From what I can see, nothing has changed in drivers/net/ethernet/micrel/
> > since rc5.
> >=20
> > I've been through the delta from 3.14-rc5, and I don't see anything
> > obvious.  Any ideas?  Known problem?
>=20
> Seems like plain v3.14-rc6 fails for me while -rc5 works. Bisecting
> points to:
>=20
> 66fda75f regulator: core: Replace direct ops->disable usage
>=20
> Also verified that v3.14-rc6 with 66fda75f reverted also works.
>=20
> Markus & Mark, any ideas?

I just had a look into the specific dts 'omap4-sdp.dts'. It defines a
'vdd_eth' at the top of the file, which is a fixed regulator using gpios
with 'regulator-boot-on'. This regulator is also passed to the ks8851
driver as vdd-supply. But this supply is not used in the driver.

The problem may be that the fixed regulator was never enabled/disabled
before my patch. As the network driver does not enable the regulator
manually, it will be disabled by the regulator framework. A
'regulator-always-on' may help here.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTJ/znAAoJEEpcgKtcEGQQZdAQAIMujsq7OO43oUpaQC87kx2u
tP6sLjncK/hpmBS/GhM2K9G0l5KbNFDqU6Xzq4BEZQZ/rW3vjjwDueKVfg8wngDe
WXrb2o5ZRpYefDt9nT/tBAablozjRqLLQhxUrthoCY/RIi6R7GKwAwbGQyVm1NUn
mV/aeer21T0Lbmm5DsEJvglyouwPq27yfJtrBatVS3W1159yd0EmDsMlZEHZX+0g
S8Ku6+fxHa9jBH9cLX+/ancfaJ3iqE2r8go4zkTkbXRKf+K1k4hqhRgm3i3yW3Qb
/7oTUhWIn4rs1l72t3b3+/dCrC/uLMu+SF+TlDhP/kQbMVA2Fkx/z+Fx1Vbuf1hu
Bn09ev35ZGtMVIS+x+h5X+DjesNG5CSKafIwFH7Uw4yZ51pePxlGBp0QhrokW3Za
NTVZmWe82vQJmYG3siBIFIZ2DtWNZYR5VfBgQKoskFAj+3PIwV1f5XEdoN6pdYxx
RPCAhalwJWa+RhCGmexmKaocosbEYkVXU5vbVQ//bOwxXfeN6K/SB74N6gjotXeN
yB1Hu9xAQ3Y06rEPtm4YRxxOTR71Opi+EaWJbF8xWQiN/FyRlZLOrP99x48wsT/J
8vGpJq2SA7GsWVhJiG4eckuNIjMK7bQ1MxtyRExhiadVlYR+TUuP4dWtDHwg300B
5bAgF4PmBqI0516Ru3Oq
=K81W
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
