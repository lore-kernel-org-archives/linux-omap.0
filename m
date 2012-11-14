From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: omap: adopt pinctrl support
Date: Wed, 14 Nov 2012 12:14:44 +0100
Message-ID: <20121114111444.GF5954@pengutronix.de>
References: <1350401000-9453-1-git-send-email-s-guiriec@ti.com>
 <20121022074201.GW14033@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57060 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab2KNLOx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 06:14:53 -0500
Content-Disposition: inline
In-Reply-To: <20121022074201.GW14033@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 10:42:01AM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Oct 16, 2012 at 05:23:20PM +0200, Sebastien Guiriec wrote:
> > Some GPIO expanders need some early pin control muxing. Due to
> > legacy boards sometimes the driver uses subsys_initcall instead of
> > module_init. This patch takes advantage of defer probe feature
> > and pin control in order to wait until pin control probing before
> > GPIO driver probing. It has been tested on OMAP5 board with TCA6424
> > driver.
> >=20
> > log:
> >=20
> > [0.482299] omap_i2c i2c.15: could not find pctldev for node /ocp/pinmux=
@4a00
> > 2840/pinmux_i2c5_pins, deferring probe
> > [0.482330] platform i2c.15: Driver omap_i2c requests probe deferral
> > [0.484466] Advanced Linux Sound Architecture Driver Initialized.
> >=20
> > [4.746917] omap_i2c i2c.15: bus 4 rev2.4.0 at 100 kHz
> > [4.755279] gpiochip_find_base: found new base at 477
> > [4.761169] gpiochip_add: registered GPIOs 477 to 500 on device: tca6424a
> >=20
> > Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
>=20
> looks good to me also, should go in v3.8 merge window:
>=20
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Applied to for-next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjfSQACgkQD27XaX1/VRvAaACgplUux5DaW4qrk8OAHkEHSfHe
Ks8An3Be2QJ56zSnqdwAms8RizlxnWih
=LI2R
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
