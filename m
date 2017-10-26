From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 11:53:43 +0200
Message-ID: <20171026095343.GA31065@amd>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026091325.GA26929@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-10-26 11:13:26, Pavel Machek wrote:
> On Wed 2017-10-25 14:28:07, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [171025 13:36]:
> > > Hi!
> > >=20
> > > ...hardware should be identical. 3.5.3-nemo kernel seems to work on
> > > both. 4.13-rc2 with display and clock patches boots on phone "S", but
> > > does not on phone "P"; nothing nothing is received on serial port.
> > >=20
> > > There is some difference in the bootloaders: S's bootloader provides
> > > lots of debug info, P's is silent. R&D settings do _not_ have
> > > influence on bootloader. We know P's serial works, as 3.5.3 kernel
> > > prints "Uncompressing linux...booting" there.
> > >=20
> > > I'll need to return "S" phone and serial cable tommorow. If you have
> > > any ideas, let me know.
> >=20
> > If you get nothing out of the uart, chances are the pins are
> > not muxed for the uart in nolo and maybe kernel dts is missing the
> > pinctrl entries for uart?
> >=20
> > Also try booting with mem=3D512M@0x80000000 or 256M or 768M. Maybe the
> > memory is different size or partially broken?
>=20
> Uhuh. It looks like "P" nokia really wants initrd, otherwise it will
> not boot.

No. Nokia "P" really hates command line on 0xffff command line. initrd
is optional. It also forces delay on "Warning! You have modified"
=2E.. screen.

I configured serial port. Now I get up-to working userspace (initrd)
on both "S" and "P" devices.


Welcome to MOSLO vNEMO_MOSLO-N9_0.0.13.2
Could not ioctl(OMAPFB_UPDATE_WINDOW): Inappropriate ioctl for device
check wiki.merproject.org/wiki/Nemo
Could not ioctl(OMAPFB_UPDATE_WINDOW): Inappropriate ioctl for device

Could not ioctl(OMAPFB_UPDATE_WINDOW): Inappropriate ioctl for device
Waiting for eMMC device...
Could not ioctl(OMAPFB_UPDATE_WINDOW): Inappropriate ioctl for device
eMMC device not found!

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnxsKcACgkQMOfwapXb+vLxfACfYGveckFxDC6KNke+JnwzFf9J
gb4AoMEl12+X8VztcGRs+pTA5W5zu1o9
=GUfG
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
