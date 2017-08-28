From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH linux-next] fix compilation error in mach-omap2/display.c
Date: Mon, 28 Aug 2017 11:32:07 +0200
Message-ID: <20170828093207.GA29080@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


In linux-next 0828, I get

  CC      arch/arm/mach-omap2/display.o
  arch/arm/mach-omap2/display.c: In function 'omapdss_init_fbdev':
  arch/arm/mach-omap2/display.c:184:2: error: 'r' undeclared (first

Fix it.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 798fc71..b3f6eb5 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -172,6 +172,7 @@ static int __init omapdss_init_fbdev(void)
 		.set_min_bus_tput =3D omap_dss_set_min_bus_tput,
 	};
 	struct device_node *node;
+	int r;
=20
 	board_data.version =3D omap_display_get_version();
 	if (board_data.version =3D=3D OMAPDSS_VER_UNKNOWN) {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmj4xcACgkQMOfwapXb+vLC6QCdEzxxC+oUtIEN7NyWNwLTX9TH
57YAn3AqjTRkLsY3LvQnPaJhJJCalx/6
=SPqr
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
