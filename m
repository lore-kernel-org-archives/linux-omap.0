From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Remove duplicate omap34xx.h entry
Date: Thu, 7 Jun 2007 19:11:09 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470112180E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Please apply this on top of OMAP3430 patch set.

Remove duplicate omap34xx.h from hardware.h

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 hardware.h |    1 -
 1 files changed, 1 deletion(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/include/asm-arm/arch-omap/hardware.h	2007-06-07 =
19:04:50.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/hardware.h	2007-06-07 =
19:05:20.000000000 -0500
@@ -284,7 +284,6 @@
 #include "omap730.h"
 #include "omap1510.h"
 #include "omap16xx.h"
-#include "omap34xx.h"
=20
 #ifdef CONFIG_ARCH_OMAP24XX
 #include "omap24xx.h"
