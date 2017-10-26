From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 09:16:08 +0200
Message-ID: <20171026071607.GB20634@amd>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171025212806.GA21504@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-10-25 14:28:07, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [171025 13:36]:
> > Hi!
> >=20
> > ...hardware should be identical. 3.5.3-nemo kernel seems to work on
> > both. 4.13-rc2 with display and clock patches boots on phone "S", but
> > does not on phone "P"; nothing nothing is received on serial port.
> >=20
> > There is some difference in the bootloaders: S's bootloader provides
> > lots of debug info, P's is silent. R&D settings do _not_ have
> > influence on bootloader. We know P's serial works, as 3.5.3 kernel
> > prints "Uncompressing linux...booting" there.
> >=20
> > I'll need to return "S" phone and serial cable tommorow. If you have
> > any ideas, let me know.
>=20
> If you get nothing out of the uart, chances are the pins are
> not muxed for the uart in nolo and maybe kernel dts is missing the
> pinctrl entries for uart?

"Uart pins not muxed in NOLO" would certainly explain my problems. In
3.5.X, output works even in decompressor ("Uncompressing
kernel... done, booting linux"). Where is the code to do the muxing?
Does it need fixing on v4.x?

Is

 CONFIG_UNCOMPRESS_INCLUDE=3D"debug/uncompress.h"

right setting for me?

> Also try booting with mem=3D512M@0x80000000 or 256M or 768M. Maybe the
> memory is different size or partially broken?

"P" machine runs Hartmann, latest release, and is stable
there... including games. RAM should be ok.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnxi7cACgkQMOfwapXb+vLJ9ACfUag17BGniQNLBt+d/0r2pQt3
+pMAnAsdHjVFsdokhGG4dGddE/wXdR3B
=zO4m
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
