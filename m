From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 15/15] ARM: OMAP2+: gpmc: localize gpmc header
Date: Fri, 5 Oct 2012 21:24:56 +0530
Message-ID: <5b6e54e44dc29cb3a169909fa89f486b25cee637.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52684 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756461Ab2JEPzK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 11:55:10 -0400
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Requirement of gpmc header outside of mach-omap2 has been
cutoff, move gpmc header file in plat-omap folder to local
mach-omap2 folder

Objective - common zImage participation of omap

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c                    | 2 +-
 arch/arm/mach-omap2/board-3430sdp.c                    | 2 +-
 arch/arm/mach-omap2/board-apollon.c                    | 2 +-
 arch/arm/mach-omap2/board-cm-t35.c                     | 2 +-
 arch/arm/mach-omap2/board-cm-t3517.c                   | 2 +-
 arch/arm/mach-omap2/board-devkit8000.c                 | 2 +-
 arch/arm/mach-omap2/board-flash.c                      | 2 +-
 arch/arm/mach-omap2/board-flash.h                      | 2 +-
 arch/arm/mach-omap2/board-h4.c                         | 2 +-
 arch/arm/mach-omap2/board-igep0020.c                   | 2 +-
 arch/arm/mach-omap2/board-ldp.c                        | 2 +-
 arch/arm/mach-omap2/board-omap3beagle.c                | 2 +-
 arch/arm/mach-omap2/board-omap3logic.c                 | 2 +-
 arch/arm/mach-omap2/board-omap3stalker.c               | 2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c             | 2 +-
 arch/arm/mach-omap2/board-overo.c                      | 2 +-
 arch/arm/mach-omap2/board-rm680.c                      | 2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c           | 2 +-
 arch/arm/mach-omap2/board-rx51.c                       | 2 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c            | 2 +-
 arch/arm/mach-omap2/gpmc-nand.c                        | 3 +--
 arch/arm/mach-omap2/gpmc-nand.h                        | 2 +-
 arch/arm/mach-omap2/gpmc-onenand.c                     | 3 +--
 arch/arm/mach-omap2/gpmc-smc91x.c                      | 2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c                    | 2 +-
 arch/arm/mach-omap2/gpmc.c                             | 3 +--
 arch/arm/{plat-omap/include/plat => mach-omap2}/gpmc.h | 0
 arch/arm/mach-omap2/pm34xx.c                           | 2 +-
 arch/arm/mach-omap2/usb-tusb6010.c                     | 2 +-
 29 files changed, 28 insertions(+), 31 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/gpmc.h (100%)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 95b384d..49e49d0 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -34,7 +34,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <plat/usb.h>
 #include "gpmc-smc91x.h"
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 96cd369..5ad0901 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -33,7 +33,7 @@
 #include <plat/usb.h>
 #include "common.h"
 #include <plat/dma.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index cea3aba..8cdd186 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -35,7 +35,7 @@
 
 #include <plat/led.h>
 #include "common.h"
-#include <plat/gpmc.h>
+#include "gpmc.h"
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index fef68de..73e2ba9 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -40,7 +40,7 @@
 
 #include "common.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 3a19e80..b5495e4 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -41,7 +41,7 @@
 #include "common.h"
 #include <plat/usb.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 
 #include "am35xx.h"
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 9933966..3eedb8f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -39,7 +39,7 @@
 #include <asm/mach/flash.h>
 
 #include "common.h"
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 776e57a..c56986f 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -18,7 +18,7 @@
 #include <linux/io.h>
 
 #include <plat/cpu.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <plat/tc.h>
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
index a3aa5fc..2fb5d41 100644
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -12,7 +12,7 @@
  */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 
 #define PDC_NOR		1
 #define PDC_NAND	2
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 8d04bf8..65ebf58 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -33,7 +33,6 @@
 
 #include <plat/menelaus.h>
 #include <plat/dma.h>
-#include <plat/gpmc.h>
 #include "debug-devices.h"
 
 #include <video/omapdss.h>
@@ -42,6 +41,7 @@
 #include "common.h"
 #include "mux.h"
 #include "control.h"
+#include "gpmc.h"
 
 #define H4_FLASH_CS	0
 #define H4_SMC91X_CS	1
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 83c6efa..9a9a9b5 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -30,7 +30,7 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <plat/usb.h>
 
 #include <video/omapdss.h>
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 83383f3..e1628cd 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -35,7 +35,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <mach/board-zoom.h>
 #include <plat/usb.h>
 #include "gpmc-smsc911x.h"
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index f240e21..65eaaee 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -41,7 +41,7 @@
 #include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <plat/usb.h>
 #include <plat/omap_device.h>
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 7bd8253..5cfade2 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -35,7 +35,7 @@
 #include <asm/mach/map.h>
 
 #include "gpmc-smsc911x.h"
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <plat/sdrc.h>
 #include <plat/usb.h>
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index c7f3d02..11fcc73 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -40,7 +40,7 @@
 #include <asm/mach/flash.h>
 
 #include "common.h"
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 3f013c8..cd282ae 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -44,7 +44,7 @@
 #include <asm/system_info.h>
 
 #include "common.h"
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <plat/usb.h>
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e2cf0f7..3a9d1fa 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -49,7 +49,7 @@
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 #include <video/omap-panel-tfp410.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <plat/usb.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 154cf33..3c3a473 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -25,7 +25,7 @@
 #include <plat/i2c.h>
 #include <plat/mmc.h>
 #include <plat/usb.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include "common.h"
 #include <plat/serial.h>
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index aa6a2a4..5ba8942 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,7 +32,7 @@
 
 #include "common.h"
 #include <plat/dma.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <plat/omap-pm.h>
 #include "gpmc-smc91x.h"
 
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 7bbb05d..88ba5be 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -25,7 +25,7 @@
 
 #include "common.h"
 #include <plat/dma.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <plat/usb.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index afb2278..be9f71d 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -17,7 +17,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include "gpmc-smsc911x.h"
 
 #include <mach/board-zoom.h>
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 7983d54..db969a5 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -17,8 +17,7 @@
 
 #include <asm/mach/flash.h>
 
-#include <plat/gpmc.h>
-
+#include "gpmc.h"
 #include "soc.h"
 #include "gpmc-nand.h"
 
diff --git a/arch/arm/mach-omap2/gpmc-nand.h b/arch/arm/mach-omap2/gpmc-nand.h
index 11a377f..d59e128 100644
--- a/arch/arm/mach-omap2/gpmc-nand.h
+++ b/arch/arm/mach-omap2/gpmc-nand.h
@@ -10,7 +10,7 @@
 #ifndef	__OMAP2_GPMC_NAND_H
 #define	__OMAP2_GPMC_NAND_H
 
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
 
 #if IS_ENABLED(CONFIG_MTD_NAND_OMAP2)
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 29671cc..54e2255 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -20,8 +20,7 @@
 
 #include <asm/mach/flash.h>
 
-#include <plat/gpmc.h>
-
+#include "gpmc.h"
 #include "soc.h"
 #include "gpmc-onenand.h"
 
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index 5654753..6eed907 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 #include <linux/smc91x.h>
 
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include "gpmc-smc91x.h"
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index 249a0b4..ef99011 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -20,7 +20,7 @@
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include "gpmc-smsc911x.h"
 
 static struct resource gpmc_smsc911x_resources[] = {
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1121248..285070e 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -29,15 +29,14 @@
 #include <linux/platform_data/mtd-nand-omap2.h>
 
 #include <asm/mach-types.h>
-#include <plat/gpmc.h>
 
 #include <plat/cpu.h>
-#include <plat/gpmc.h>
 #include <plat/sdrc.h>
 #include <plat/omap_device.h>
 
 #include "soc.h"
 #include "common.h"
+#include "gpmc.h"
 
 #define	DEVICE_NAME		"omap-gpmc"
 
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/mach-omap2/gpmc.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/gpmc.h
rename to arch/arm/mach-omap2/gpmc.h
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ba670db..ed98f4f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -40,7 +40,7 @@
 #include "powerdomain.h"
 #include <plat/sdrc.h>
 #include <plat/prcm.h>
-#include <plat/gpmc.h>
+#include "gpmc.h"
 #include <plat/dma.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 7a85ebe..8ee73fc 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -18,7 +18,7 @@
 
 #include <linux/usb/musb.h>
 
-#include <plat/gpmc.h>
+#include "gpmc.h"
 
 #include "mux.h"
 
-- 
1.7.12

