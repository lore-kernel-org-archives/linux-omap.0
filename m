From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Add 3430 support in hardware.h
Date: Wed, 20 Jun 2007 22:16:59 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47012A5137@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add 3430 support in hardware.h

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 include/asm-arm/arch-omap/hardware.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/include/asm-arm/arch-omap/hardware.h	2007-06-08 =
08:09:45.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/hardware.h	2007-06-20 =
21:38:55.000000000 -0500
@@ -283,8 +283,9 @@
=20
 #include "omap730.h"
 #include "omap1510.h"
-#include "omap24xx.h"
 #include "omap16xx.h"
+#include "omap24xx.h"
+#include "omap34xx.h"
=20
 #ifndef __ASSEMBLER__
=20
@@ -322,6 +323,10 @@
 #include "board-2430sdp.h"
 #endif
=20
+#ifdef CONFIG_MACH_OMAP_3430SDP
+#include "board-3430sdp.h"
+#endif
+
 #ifdef CONFIG_MACH_OMAP_APOLLON
 #include "board-apollon.h"
 #endif
