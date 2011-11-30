From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] OMAP2, 3: DSS2: Include linux/delay.h and common.h to fix
 build errors
Date: Wed, 30 Nov 2011 20:01:21 +0800
Message-ID: <1322654481.11191.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Include linux/delay.h to fix below build error:

  CC      arch/arm/mach-omap2/display.o
arch/arm/mach-omap2/display.c: In function 'dispc_disable_outputs':
arch/arm/mach-omap2/display.c:283: error: implicit declaration of function 'mdelay'
arch/arm/mach-omap2/display.c: In function 'omap_dss_reset':
arch/arm/mach-omap2/display.c:317: error: implicit declaration of function 'omap_test_timeout'
make[1]: *** [arch/arm/mach-omap2/display.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Include common.h to fix below build error:

  CC      arch/arm/mach-omap2/display.o
arch/arm/mach-omap2/display.c: In function 'omap_dss_reset':
arch/arm/mach-omap2/display.c:318: error: implicit declaration of function 'omap_test_timeout'
make[1]: *** [arch/arm/mach-omap2/display.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I got the build error on linux-next 20111130.
This patch is against linux-next 20111130.
Axel
 arch/arm/mach-omap2/display.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index dce9905..fe44cc2 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 
 #include <video/omapdss.h>
@@ -30,6 +31,7 @@
 #include <plat/common.h>
 
 #include "control.h"
+#include "common.h"
 #include "display.h"
 
 #define DISPC_CONTROL		0x0040
-- 
1.7.5.4
