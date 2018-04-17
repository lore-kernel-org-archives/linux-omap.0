From: Pavel Machek <pavel@ucw.cz>
Subject: atmel_mxt_ts on droid4: powersave seems to break the driver
Date: Tue, 17 Apr 2018 09:38:11 +0200
Message-ID: <20180417073811.GA9450@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mutt@amd.karlin.mff.cuni.cz, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, nick@shmanahar.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

v4.17-rc1 on motorola droid 4.

If I disable/reenable touschreen with xinput, it fails, with this in
the logs:

[ 1633.749450] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[ 1655.938751] atmel_mxt_ts 1-004a: __mxt_read_reg: i2c transfer
failed (-121)
[ 1655.945800] atmel_mxt_ts 1-004a: Failed to read T44 and T5 (-121)
[ 1663.829498] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host

Unfortunately, xscreensaver seems to break it in a similar way.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrVpGMACgkQMOfwapXb+vLhzwCgnnaXi77vp+AXvDtspVtoqAoc
1igAoJsCXQGyDClCDFDJ6+oqyOf3cSZ5
=zQue
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
