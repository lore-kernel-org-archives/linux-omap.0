From: Pavel Machek <pavel@ucw.cz>
Subject: v4.16-rc0: missing includes in framebuffers break N900 compilation
Date: Mon, 26 Feb 2018 14:00:07 +0100
Message-ID: <20180226130007.GA5634@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1824349643=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, arvind.yadav.cs@gmail.com, b.zolnierkie@samsung.com, tomi.valkeinen@ti.com
List-Id: linux-omap@vger.kernel.org


--===============1824349643==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I needed this to get -rc0 to compile.

Signed-off-by: Pavel Machek <pavel@ucw.cz>


diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbd=
ev/omap2/omapfb/dss/dss.c
index 48c6500..990f1c9 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -38,6 +38,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/suspend.h>
 #include <linux/component.h>
=20
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/vide=
o/fbdev/omap2/omapfb/dss/hdmi_phy.c
index 9a13c35..4862b12 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <video/omapfb_dss.h>
=20
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/vide=
o/fbdev/omap2/omapfb/dss/hdmi_pll.c
index eac3665..39014e2 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/clk.h>
=20
 #include <video/omapfb_dss.h>
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/video=
/fbdev/omap2/omapfb/dss/hdmi_wp.c
index 705373e..e93e7a7 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <video/omapfb_dss.h>
+#include <linux/seq_file.h>
=20
 #include "dss.h"
 #include "hdmi.h"

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqUBNcACgkQMOfwapXb+vIfMgCeK1l9FpnfJ/39acGCV5FKdk22
K64AoJMjw+2UKG3qufvKwqtablp84OI9
=A5kN
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============1824349643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1824349643==--
