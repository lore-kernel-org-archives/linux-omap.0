From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] spi: Provide core support for runtime PM during
 transfers
Date: Mon, 29 Jul 2013 06:56:02 +0100
Message-ID: <20130729055602.GO9858@sirena.org.uk>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
 <CACRpkdZuUiG0MydJ_k4Br5_10hXr-x4xqNLjWP8D_KFyMPg-zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zL7/4+3/7UwZUZ29"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZuUiG0MydJ_k4Br5_10hXr-x4xqNLjWP8D_KFyMPg-zQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-omap@vger.kernel.org


--zL7/4+3/7UwZUZ29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 28, 2013 at 10:51:31PM +0200, Linus Walleij wrote:
> On Sun, Jul 28, 2013 at 4:43 PM, Mark Brown <broonie@kernel.org> wrote:

> > + * @auto_runtime_pm: the core should ensure a runtime PM reference is held
> > + *                   while the hardware is prepared

> I'd mention here that the reference is taken on the parent
> device of the SPI master, i.e. the very platform or AMBA
> device, so that it will hit upwards to the bus.

Yeah, I was actually contemplating changing that to use the spidev
though I think I'm going to stich with what's there.  On the one hand
runtime PM does do the right thing with children but really the way it's
set up at the minute is more obvious for users.

--zL7/4+3/7UwZUZ29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9gPvAAoJELSic+t+oim9n5QP/jcbIrHAuo7b2ohyG7+mDT3s
4XY6HvUJwoikuB4IB+xJOfS58RaE1Ftj0+ePHMX0m4tLwC6Dy5A39CE90dZZZzsq
pNmbvCZjgiRfDWhC5FMoVoqiu2qwfYr08MPgh5YR5gg5uTMEa0fm5iqujxfxQ2tj
URZ1Sx7Gh2RgZUHGTJk4eF/d7u+592MKEx9ggCSzDwUHGC3WpdmQH8KKtsWReS26
Uqaw2Ei6LQKpjU0q/ufKlcDD3MvgPVaBlBJ/a8WWVJSy/RLinLCWybdw+7XqWQGB
5g7hdy0p4kgQi/ipR5liy+waND1Svk1w/6G/NU4H4Oz9N9DQSQayWoZ0i0Sq6yOP
gOVvcE3XzDy70f0Z9OiEpONSx2qb0Dayv07rs6SMCrVcgf/DgVHaCqCqsV3zt9r4
yT+WdisXkURjkpDRF+MgdnXdkOdI+mpdU5qMB6aiJxKp2XnHHJJYKE3M8/HkIkIb
IqiLWwML2OBfgD921HrDBDlCawp9vb01BT9o9OS+JdbXx7TKqSBNjnt7bHX+5Yl1
5aMkcdzDBDV+2+lH0dzHA+2UJVKOuoDrSOL/KIQz1AFPVljyTN7D2KKDuiT2Wi9P
mbPwBgWx9Q9/51pngiqMMYmctzYiVeRJKogwkhsdyrJCbKJYUDZ1ZZDTzQuiu30d
ZZkr2E4buyQkR8DkHsEJ
=eP3f
-----END PGP SIGNATURE-----

--zL7/4+3/7UwZUZ29--
