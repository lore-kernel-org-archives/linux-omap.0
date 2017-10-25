From: Pavel Machek <pavel@ucw.cz>
Subject: 4.13 (and probably all recent) kernels refuse to boot on one Nokia
 N950, work or another
Date: Wed, 25 Oct 2017 22:34:59 +0200
Message-ID: <20171025203459.GA22035@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

=2E..hardware should be identical. 3.5.3-nemo kernel seems to work on
both. 4.13-rc2 with display and clock patches boots on phone "S", but
does not on phone "P"; nothing nothing is received on serial port.

There is some difference in the bootloaders: S's bootloader provides
lots of debug info, P's is silent. R&D settings do _not_ have
influence on bootloader. We know P's serial works, as 3.5.3 kernel
prints "Uncompressing linux...booting" there.

I'll need to return "S" phone and serial cable tommorow. If you have
any ideas, let me know.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnw9XMACgkQMOfwapXb+vLTqACgwgAnPX+NU6guhq4wMr5sraB+
Eg8Anj1f2CmdwcFlRZWAdwjA5bHaMObx
=J63D
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
