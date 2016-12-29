From: Pavel Machek <pavel@ucw.cz>
Subject: 4.10-rc1 on Nokia N900: regression, WARN_ON() omap_l3_smx.c
Date: Fri, 30 Dec 2016 00:14:11 +0100
Message-ID: <20161229231411.GA6865@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I forgot I had v4.10-rc1 running, and now I got warning on all the
consoles (hand-copied).


Unhandled fault: external abort on non-linefetch (0x1028) at
0xfa0ab060
=2E..
Comm: kworker/0:0 Not tainted.
Workqueue: events musb_irq_work
=2E..
PC is at musb_default_readb().
=2E..
WARNING: CPU: 0 ... at drivers/bus/omap_l3_smx.c:166
omap3_l3_app_irq+0xcc/...
Tainted: GDW.

I do have patches to allow nfsroot over usb. But they worked ok in
v4.9... Does anyone see it, too?

Best regards,

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhlmMMACgkQMOfwapXb+vKROgCggMfseN8PrVryDSyZwBdW0SW2
i+sAn3BdiDOHu5QtfQDQQiwUP7HlpV8O
=IQGa
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
