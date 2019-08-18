From: Pavel Machek <pavel@ucw.cz>
Subject: wifi on Motorola Droid 4 in 5.3-rc2
Date: Sun, 18 Aug 2019 12:46:29 +0200
Message-ID: <20190818104629.GA27360@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: linux-wireless@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First, I guess I should mention that this is first time I'm attempting
to get wifi going on D4.

I'm getting this:

user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
user@devuan:~/g/ofono$ sudo ifconfig wlan0 up
user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
wlan0     Interface doesn't support scanning.

user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
wlan0     Interface doesn't support scanning.

user@devuan:~/g/ofono$

I'm getting this warning during bootup:

[   13.733703] asoc-audio-graph-card soundcard: No GPIO consumer pa
found
[   14.279724] wlcore: WARNING Detected unconfigured mac address in
nvs, derive from fuse instead.
[   14.293273] wlcore: WARNING Your device performance is not
optimized.
[   14.304443] wlcore: WARNING Please use the calibrator tool to
configure your device.
[   14.317474] wlcore: loaded
[   16.977325] motmdm serial0-0: motmdm_dlci_send_command: AT+VERSION=3D
got MASERATIBP_N_05.25.00R,026.0R,XSAMASR01VRZNA026.0R,???

Any ideas?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1ZLIUACgkQMOfwapXb+vKeEACeJJ3HEUEGDtIKmgSfesXs0VH+
NJgAoIr8AhZlKZt6EoTHuPl5lOSxfXNI
=etkx
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
