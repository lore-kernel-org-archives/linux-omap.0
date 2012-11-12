From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH linux-next] ARM: OMAP2: Fix compillation error in cm_common
Date: Mon, 12 Nov 2012 16:17:08 +0100
Message-ID: <1352733428-27889-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=46ixes the following error:
  CC      arch/arm/mach-omap2/cm_common.o
arch/arm/mach-omap2/cm_common.c: In function =E2=80=98cm_register=E2=80=
=99:
arch/arm/mach-omap2/cm_common.c:42:11: error: =E2=80=98EINVAL=E2=80=99 =
undeclared (first use in this function)
arch/arm/mach-omap2/cm_common.c:42:11: note: each undeclared identifier=
 is reported only once for each function it appears in
arch/arm/mach-omap2/cm_common.c:45:11: error: =E2=80=98EEXIST=E2=80=99 =
undeclared (first use in this function)
arch/arm/mach-omap2/cm_common.c: In function =E2=80=98cm_unregister=E2=80=
=99:
arch/arm/mach-omap2/cm_common.c:66:11: error: =E2=80=98EINVAL=E2=80=99 =
undeclared (first use in this function)
make[1]: *** [arch/arm/mach-omap2/cm_common.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi,

with today's linux-next the kernel build failed with the abive error fo=
r OMAP.

Regards,
Peter

 arch/arm/mach-omap2/cm_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_c=
ommon.c
index 3246cef..3fafc27 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -13,6 +13,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/errno.h>
=20
 #include "cm2xxx.h"
 #include "cm3xxx.h"
--=20
1.8.0
