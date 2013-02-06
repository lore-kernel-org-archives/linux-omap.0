From: =?ISO-8859-15?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: [PATCH] arm: Include soc.h to fix compiling
Date: Wed, 06 Feb 2013 23:43:01 +0100
Message-ID: <5112DC75.8070806@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I needed this when compiling for pandaboard at commit: 0944c0a034657189=
09ba8e800a5230528aeabafb

Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>From: =3D?UTF-8?q?An=
dr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de>
=46rom: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de>
Date: Wed, 6 Feb 2013 23:16:20 +0100
Subject: [PATCH] arm: Include soc.h to fix compiling

---
 arch/arm/mach-omap2/drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 4c7566c..b4faf96 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -27,6 +27,7 @@
=20
 #include "omap_device.h"
 #include "omap_hwmod.h"
+#include "soc.h"
=20
 #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
=20
--=20
1.8.0

Best Regards, Andr=E9 Hentschel
