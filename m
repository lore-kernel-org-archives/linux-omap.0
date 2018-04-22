From: Pavel Machek <pavel@ucw.cz>
Subject: FM radio on Droid 4 (in v4.17-rc1)
Date: Sun, 22 Apr 2018 10:36:40 +0200
Message-ID: <20180422083640.GA23303@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is my first attempt at setting up FM radio on Droid
4. Unfortunately I get:

[   29.614959] power_supply usb: uevent: failed to send synthetic
uevent
[   32.678100] (stc): gdata/new_proto/recv or reg_complete_cb not
ready
[   32.678222] fmdrv: Failed to get ST write func pointer
[   32.703948] (stc):  chnl_id 8 not supported
[   32.703948] fmdrv: st_unregister failed -93
[   32.724578] fmdrv: Unable to prepare FM CORE
[   33.382476] Requested mode 2

=2E..so I guess it is not going to work. I use configuration with all
drivers built in.

FM radio is not a priority for me, but if you know how to get it to
work, I'll try...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrcSZgACgkQMOfwapXb+vI1/gCfZ1a7zIhGo2Pnqsxc/lce2Jdz
6+wAoIFHfFaZjI44LWlcvc4N1eGEVv1w
=uLU3
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
