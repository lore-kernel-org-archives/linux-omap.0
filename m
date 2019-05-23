From: Pavel Machek <pavel@ucw.cz>
Subject: 5.2-rc1 on droid4: spi crash
Date: Thu, 23 May 2019 11:09:26 +0200
Message-ID: <20190523090926.GA9106@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This was greeting me overnight... I don't yet know how reproducible it
is, it happened once so far.

Best regards,
								Pavel

root@devuan:/sys/class/leds#
Message from syslogd@devuan at May 23 00:11:31 ...
 kernel:[14889.641143] Internal error: Oops: 5 [#1] SMP ARM

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.638275] Process spi0 (pid: 100, stack limit =3D
 0x97305d31)

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.650238] Stack: (0xedee7ed0 to 0xedee8000)

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.652069] 7ec0:
 00000000 00000000 eba35c14 eba35c50

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.662841] 7ee0: edd93000 edd93360 ede3da50 c052683c
 ffffffff edadcc10 edadcc9c 00000004

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.671051] 7f00: 00000000 ede3d800 600f0013 edd93000
 eba35c14 eba35c50 edadcc10 edadcc10

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.679260] 7f20: 00000002 00000001 edd9322c c0526cb4
 edd932a4 edb34600 edd932a0 edd932a4

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.687499] 7f40: 00000000 edd932d0 edd932a0 edd932a4
 00000000 00000001 c0e82d14 edd932b4

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.695709] 7f60: c0e82d14 c0148f40 00000000 edca5580
 00000000 ede39400 edca55a8 edd932a0

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.703918] 7f80: ed88dd48 c0148e74 00000000 c01491ec
 ede39400 c01490dc 00000000 00000000

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.708251] 7fa0: 00000000 00000000 00000000 c01010e8
 00000000 00000000 00000000 00000000

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.720367] 7fc0: 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.724334] 7fe0: 00000000 00000000 00000000 00000000
 00000013 00000000 00000000 00000000

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.807312] Code: e3a08c02 e5954034 e1a01005 e1a00007
 (e5943008)
 Write failed: Broken pipe
 pavel@duo:/data/l/k$
=20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzmY0YACgkQMOfwapXb+vImbACglBJwmJksJUdy7p/yaXHVJm2I
OzEAoLOmo07dE0Zan5Wn0qs3XGq3xV55
=vTr7
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
