From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Tue, 22 May 2018 22:58:26 +0200
Message-ID: <20180522205824.GA24927@amd>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
List-Id: linux-omap@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-05-22 22:41:39, Aaro Koskinen wrote:
> Hi,
>=20
> On Tue, May 22, 2018 at 10:02:50AM +0200, Pali Roh=E1r wrote:
> > Hi! I remember that in time of migration from platform board code to
> > device tree structures there appeared some bug which caused that
> > sometimes display were not initialized. And somebody figured out that
> > display initialization is failing when some other SPI devices are
> > initialized before or after display... This behavior was observed only
> > on real N900 hardware, not in qemu.
>=20
> Touchscreen needs to be initialized before display. This is documented
> in the DTS, see arch/arm/boot/dts/omap3-n900.dts:
>=20
> 	* For some reason, touchscreen is necessary for screen to work at
> 	* all on real hw. It works well without it on emulator.
> 	*
> 	* Also... order in the device tree actually matters here.
>=20
> > Real reason was never explained. In old platform board code there was
> > hardcoded order of SPI devices in which initialization happened. And in
> > device tree it is probably in (pseudo)-random order. Enabling/disabling
> > various config option can affect some timings and order in which kernel
> > starts probing and initializing devices...
>=20
> The issue was also somewhat present with platform/board code, see e.g.
> commit e65f131a14726e5f1b880a528271a52428e5b3a5.
>=20
> My device worked with v4.17-rc1 (haven't found time to test newer kernels=
),
> but if you say the probe order is random then we must find some proper way
> to express the dependency.

I started bisect, but.. that will probably not be useful.

If your device works ok in v4.17-rc1, it probably works in newer -rcs,
too.

Thanks for the ordering hint, I'll try to figure out what is going on
there.

									Pavel



# bad: [60cc43fc888428bb2f18f08997432d426a243338] Linux 4.17-rc1
# good: [0adb32858b0bddf4ada5f364a84ed60b196dbcda] Linux 4.16
git bisect start 'v4.17-rc1' 'v4.16'
# bad: [ac9053d2dcb9e8c3fa35ce458dfca8fddc141680] Merge tag 'usb-4.17-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad ac9053d2dcb9e8c3fa35ce458dfca8fddc141680
# bad: [bb2407a7219760926760f0448fddf00d625e5aec] Merge tag 'docs-4.17' of =
git://git.lwn.net/linux
git bisect bad bb2407a7219760926760f0448fddf00d625e5aec
# bad: [1c7095d2836baafd84e596dd34ba1a1293a4faa9] Merge airlied/drm-next in=
to drm-misc-next
git bisect bad 1c7095d2836baafd84e596dd34ba1a1293a4faa9



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsEhHAACgkQMOfwapXb+vKgAQCfRTCdEl9IB9Sl7HaxCaakO7cD
9sIAoJejrpAlCItIRa0bnoRqGJcFcvUC
=fwvJ
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
