From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x
 devices.
Date: Wed, 21 Mar 2012 19:38:40 +0000
Message-ID: <20120321193839.GM3226@opensource.wolfsonmicro.com>
References: <4F6324D5.9010106@uni-dortmund.de>
 <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
 <20120321181259.GJ3226@opensource.wolfsonmicro.com>
 <A9E31EDE-A279-41FB-9EBE-3370A587ADA7@ti.com>
 <20120321183957.GM9859@atomide.com>
 <20120321190028.GK3226@opensource.wolfsonmicro.com>
 <20120321193046.GN9859@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5V5c01chtBAiSHoy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58439 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754305Ab2CUTim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 15:38:42 -0400
Content-Disposition: inline
In-Reply-To: <20120321193046.GN9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Porter, Matt" <mporter@ti.com>, "Dill, Russ" <russ.dill@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<robert.marklund@stericsson.com>" <robert.marklund@stericsson.com>, "<linus.walleij@linaro.org>" <linus.walleij@linaro.org>


--5V5c01chtBAiSHoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 12:30:47PM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [120321 12:03]:

> > That should be changed to pass in a boolean flag rather than a pointer
> > to platform device - the board may not have direct access to the
> > relevant regulator (eg, if it's part of a MFD) or the regulator may be
> > on another bus like I2C (for simpler regulator only devices).

> Hmm I see. This means that we need to patch some board files anyways
> for the boolean flag to use the fixed regulator. This is because for
> some cases vddvario and vdd33a regulators can come from the mfd/tps/twl
> chip and it's unsafe to assume that gpmc-smsc911x.c can set up these
> regulators automatically. Passing a boolean flag to not set up the
> default regulator would work too, but we'd rather eventually see
> the real board specific regulators being patched in.

Yes, ideally the boards would do everything and gpmc-smsc911x.c should
be able to completely ignore regulators.

> So if that's the case, we might as well patch the board files
> to add the fixed regulators for each one and drop all the regulator
> code from gpmc-smsc911x.c.

That's my preferred option, hopefully with the helpers we have for
regulator registration we shouldn't need to add device specific helpers.

--5V5c01chtBAiSHoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPai3IAAoJEBus8iNuMP3dtOMP/jQSiqBx9/PZfirlknTZVJRt
ZR37kpkFc8bBGAKRV6uysx3QXp4IQv+Um2Mp4BL6YT2C+1QnOltYLADyyCJbiP2q
r5Bb9ha3DpTgM9tIOdwnfu2zizDA7fFrtrUbBqs3EdxWTOfezpYTsAIteDo9iFiA
6tYrMmae4Mea43PV6t67nroME8pgFyRrhKPIUb9xG23tT7mvwmrNREye7Y+XhyxM
2zsnqfKskpaQJbAU5w+fV773Jyms8rTtaUzWr/c+fhOVSzVkyDJzaj7ydUMh4GZ+
Gh6u+WIGe9WTsBGW2TCgGmiT/GPouZTZe+7eNKV2GgpItOyz3YgwiqaZQfLUo2g2
gU+uDRPXs6VLKStD8HCRDJmuXuY62oBD2E7/Qkrr53omQID5AexT1BakBPBzoZ5e
RMVYXgwyEglgnSrhdci8FUZiQeawlwedGFHWcwP5TRWf7/bH0kNObESoS5O+qhm3
8ADLOBsjNpMIThaGBwCuTWnN9B2hP0bGBhWtxtVQ2x/KXCSChHn/n517nib3uSdd
57TDyG9v/5XQm4rco1NgRgzAb7iEPi5k6AqCtuV5pJZkpOYqP3L8Gf/wZXvWauy1
OSMFR4OOeaNmY+Q292hTZ/gxM7kW8DOCrZ5W8yf8KFxWz2P/oHgAfLcN2bWB+/Ad
3RJKSYH1VGA4Mv708LOG
=sTKs
-----END PGP SIGNATURE-----

--5V5c01chtBAiSHoy--
