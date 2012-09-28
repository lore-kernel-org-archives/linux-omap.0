From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: remove unnecessary plat/clock.h includes
Date: Fri, 28 Sep 2012 09:24:26 +0300
Message-ID: <1348813466.2437.1.camel@deskari>
References: <20120927162800.21755.62891.stgit@dusk.lan>
	 <20120927163329.21755.34776.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-U2MryFLf2rf04OaewJ2k"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:34133 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab2I1GYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 02:24:36 -0400
Received: by lagh6 with SMTP id h6so858383lag.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 23:24:32 -0700 (PDT)
In-Reply-To: <20120927163329.21755.34776.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-U2MryFLf2rf04OaewJ2k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-27 at 10:33 -0600, Paul Walmsley wrote:
> The OMAP DSS video drivers include <plat/clock.h> but don't use any
> information from that file.  These includes are causing problems with
> ARM single image kernels - remove them.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    1 -
>  drivers/video/omap2/dss/dsi.c   |    1 -
>  drivers/video/omap2/dss/dss.c   |    1 -
>  3 files changed, 3 deletions(-)

Hi Paul. I already have the below patch in omapdss branch, and it's also
in linux-next.

 Tomi


commit fe6a466283cf1ced93360bd5f5055d6543021a6a
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Thu Aug 30 10:52:47 2012 +0300

    OMAPDSS: remove unnecessary includes
   =20
    Remove unnecessary includes from omapdss.
   =20
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/disp=
c.c
index 0de9a7e..e934abb 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -37,8 +37,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
=20
-#include <plat/clock.h>
-
 #include <video/omapdss.h>
=20
 #include "dss.h"
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 25fb895..99b9851 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -31,7 +31,6 @@
 #include <linux/regulator/consumer.h>
=20
 #include <video/omapdss.h>
-#include <plat/cpu.h>
=20
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 254666f..8d815e3 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -41,7 +41,6 @@
=20
 #include <video/omapdss.h>
 #include <video/mipi_display.h>
-#include <plat/clock.h>
=20
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 31a553a..759dbee 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -36,7 +36,6 @@
 #include <video/omapdss.h>
=20
 #include <plat/cpu.h>
-#include <plat/clock.h>
=20
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/ov=
erlay.c
index 952c6fa..94e74be 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
=20
 #include <video/omapdss.h>
-#include <plat/cpu.h>
=20
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.=
c
index 4a6caf9..45252cf 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -36,7 +36,6 @@
 #include <linux/pm_runtime.h>
=20
 #include <video/omapdss.h>
-#include <plat/cpu.h>
=20
 #include "dss.h"
 #include "dss_features.h"


--=-U2MryFLf2rf04OaewJ2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZUKaAAoJEPo9qoy8lh71KnoP/1LOZUjLnjIeBEOBR73jP6uO
5N+7eK0Uv7aqI58NgBb4B+tB7100Dxrghla6kZXKRUHnls7hkgJ2nwPEjsN3o7oq
auNrLKhOVrGQh3+nFwH99tcfHAynNrn6gVyDI8mOd7/diDBBG+W2Uhsv/Yi+WA/+
GZOGhDtpljVYyYkyS8m7AQwAzAarWQWuedpPIIBc8BavsNMurCz3V5zHsM+VEfB+
/DQGzCkbJW0GmZldxeeu6NTYYtc+wPxrkiDsfow3N5TeYa8NCSlPybHhWdc9dT/a
8tYJe6CC6SelK4P4KvMqiopJvj2XFWQUOCHabXFhQrkRGjfBi9PJ/Jnb1Dx7iOHl
+JMvPPgxyxKbcTMKoYjIkX85OWhC+prvj2kuKQRIF+yPos539CR3jX4ShJNLYdjn
KLchoo9k0Q1fK10m8jFrM2tOqmLJ4M/g6y5L/GtuvdOWe2Fa7l518bZFweoGBGU3
wyWRIzqauWNWEtdRw5v88CKnsxsElUQr5GBeSeHhMzuW17IgJQzDqJS8zIcY0kre
djDd4SIp/cYpebXNCtU0IKkyK09uZnMAw3W0ALL01tTQ9SfPpXIE5/jeFsiBlK8d
YtKtXr4HkAWi7YMtDf2kguE2Tf05BYxQiHXawm9MDtOhH6hzkXQcQk/qX/xDyl7X
7GhimoN/Lory79jgYIA2
=aVsa
-----END PGP SIGNATURE-----

--=-U2MryFLf2rf04OaewJ2k--

