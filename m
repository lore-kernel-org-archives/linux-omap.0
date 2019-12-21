From: Pavel Machek <pavel@ucw.cz>
Subject: Re: TI omap compile problem in 5.5-rc1? was Re: [PATCH] ARM:
 davinci: select CONFIG_RESET_CONTROLLER
Date: Sat, 21 Dec 2019 17:20:55 +0100
Message-ID: <20191221162055.GA28997@amd>
References: <20191210195202.622734-1-arnd@arndb.de>
 <20191217104520.GA6812@amd>
 <20191217164640.GX35479@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191217164640.GX35479@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz, Sekhar Nori <nsekhar@ti.com>, stable@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, David Lechner <david@lechnology.com>
List-Id: linux-omap@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Selecting RESET_CONTROLLER is actually required, otherwise we
> > > can get a link failure in the clock driver:
> > >=20
> > > drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks=
':
> > > psc.c:(.text+0x9a0): undefined reference to `devm_reset_controller_re=
gister'
> > > drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
> > > psc-da850.c:(.text+0x24): undefined reference to
> > > `reset_controller_add_lookup'
> >=20
> > Does omap need similar handing in 5.5-rc1?
> >=20
> >   LD      .tmp_vmlinux1
> >   drivers/soc/ti/omap_prm.o: In function `omap_prm_probe':
> >   omap_prm.c:(.text+0x4d0): undefined reference to
> >   `devm_reset_controller_register'
> >   /data/fast/l/k/Makefile:1077: recipe for target 'vmlinux' failed
> >   make[1]: *** [vmlinux] Error 1
> >=20
> > Enabling reset controller seems to help::
> >=20
> > Reset Controller Support (RESET_CONTROLLER) [Y/n/?] (NEW)
> >   TI SYSCON Reset Driver (RESET_TI_SYSCON) [N/m/y/?] (NEW)
>=20
> Yes see the patch Arnd recently posted to do that.

Thanks for the hint and sorry for the noise.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3+RmcACgkQMOfwapXb+vKm5gCdFEsAX+EXEf7Ut87c0ONSz54l
qhkAn1USmYq8ChLyUnMRl1fbdwed6pTk
=PjuJ
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
