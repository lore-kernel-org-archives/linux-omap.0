From: Pavel Machek <pavel@ucw.cz>
Subject: Re: i2c-omap.c vs. qemu: too much work in one irq (and broken boot)
Date: Mon, 2 Oct 2017 00:19:35 +0200
Message-ID: <20171001221935.GA29628@amd>
References: <20171001204215.GA9928@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171001204215.GA9928@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, balbi@ti.com, jlu@pengutronix.de, bigeasy@linutronix.de
List-Id: linux-omap@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm trying to get qemu emulation of Nokia N900 to work, but
> unfortunately i2c-omap.c breaks boot in the emulator (real hardware
> works ok).

I started bisection. v4.6 works, v4.7 is broken. (It still may be
config difference or something).

This looked suspect, so I tried reverting it, but it did not help. And
it is only significant change in i2c-omap.c. So... this may be a lot
of fun.

commit 126a66caec4a00b8d66dbc3174b0efa905cf68c3
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon Apr 4 16:55:23 2016 +0300

Unfortunately, mmc is broken in v4.6, so its useless for
emulation... [ 3.236724] mmc1: error -22 whilst initialising SDIO card

Ideas?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnRafcACgkQMOfwapXb+vL0sACgxLfjEGYeg02Iw8EacisoBGBs
G2AAn1WRWKA5MIilbXuSbKM46Fft8HwR
=aEzS
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
