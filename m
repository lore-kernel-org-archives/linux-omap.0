From: Pavel Machek <pavel@ucw.cz>
Subject: Re: i2c-omap.c vs. qemu: too much work in one irq (and broken boot)
Date: Tue, 3 Oct 2017 11:38:24 +0200
Message-ID: <20171003093824.GA3769@amd>
References: <20171001204215.GA9928@amd>
 <20171001221935.GA29628@amd>
 <20171002072331.GB25930@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171002072331.GB25930@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, balbi@ti.com, jlu@pengutronix.de, bigeasy@linutronix.de
List-Id: linux-omap@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I'm trying to get qemu emulation of Nokia N900 to work, but
> > > unfortunately i2c-omap.c breaks boot in the emulator (real hardware
> > > works ok).
> >=20
> > I started bisection. v4.6 works, v4.7 is broken. (It still may be
> > config difference or something).
> >=20
> > This looked suspect, so I tried reverting it, but it did not help. And
> > it is only significant change in i2c-omap.c. So... this may be a lot
> > of fun.
> >=20
> > commit 126a66caec4a00b8d66dbc3174b0efa905cf68c3
> > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Date:   Mon Apr 4 16:55:23 2016 +0300
> >=20
> > Unfortunately, mmc is broken in v4.6, so its useless for
> > emulation... [ 3.236724] mmc1: error -22 whilst initialising SDIO card
>=20
> Hi! You can apply special patch to make mmc work in both qemu and real
> N900 device for previous kernel versions...
>=20
> https://github.com/pali/linux-n900/commit/eb080ecdcfc5868d8e36d0f5f42d9cb=
7f13b4db9

Thanks a lot, this fixes mmc for me.

But I'm still stuck with v4.6 kernel for qemu. Do newer kernels work
there for anyone?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnTWpAACgkQMOfwapXb+vKOBwCfUun49RV2fAlygRcdqBi0imkI
pEoAn0vobNwDICn5lo2QzmldAoDVrSQp
=UpnT
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
