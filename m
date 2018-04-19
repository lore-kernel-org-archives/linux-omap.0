From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/7] i2c: i2c-omap: move header to platform_data
Date: Thu, 19 Apr 2018 22:00:10 +0200
Message-ID: <20180419200015.15095-5-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This header only contains platform_data. Move it to the proper directory.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 MAINTAINERS                                  | 4 ++--
 arch/arm/mach-omap1/common.h                 | 2 +-
 arch/arm/mach-omap1/i2c.c                    | 2 +-
 arch/arm/mach-omap2/common.h                 | 2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   | 2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   | 2 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c   | 2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   | 2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   | 2 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c   | 2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c    | 2 +-
 drivers/i2c/busses/i2c-omap.c                | 2 +-
 include/linux/{ => platform_data}/i2c-omap.h | 0
 13 files changed, 13 insertions(+), 13 deletions(-)
 rename include/linux/{ => platform_data}/i2c-omap.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44b4bb5cf94e..c4b6d379423e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10235,7 +10235,7 @@ F:	arch/arm/mach-omap1/
 F:	arch/arm/plat-omap/
 F:	arch/arm/configs/omap1_defconfig
 F:	drivers/i2c/busses/i2c-omap.c
-F:	include/linux/i2c-omap.h
+F:	include/linux/platform_data/i2c-omap.h
 
 OMAP2+ SUPPORT
 M:	Tony Lindgren <tony@atomide.com>
@@ -10267,7 +10267,7 @@ F:	drivers/regulator/tps65218-regulator.c
 F:	drivers/regulator/tps65910-regulator.c
 F:	drivers/regulator/twl-regulator.c
 F:	drivers/regulator/twl6030-regulator.c
-F:	include/linux/i2c-omap.h
+F:	include/linux/platform_data/i2c-omap.h
 
 ONION OMEGA2+ BOARD
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index d83ff257eaa8..c6537d2c2859 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -27,7 +27,7 @@
 #define __ARCH_ARM_MACH_OMAP1_COMMON_H
 
 #include <linux/mtd/mtd.h>
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 #include <linux/reboot.h>
 
 #include <asm/exception.h>
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 5bdf3c4190f9..9250f263ac51 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -20,7 +20,7 @@
  */
 
 #include <linux/i2c.h>
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 #include <mach/mux.h>
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index fbe0b78bf489..ed1a7e2f176a 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -30,7 +30,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mfd/twl.h>
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 #include <linux/reboot.h>
 #include <linux/irqchip/irq-omap-intc.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index fe66cf247874..d684fac8f592 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -13,7 +13,7 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 #include <linux/omap-dma.h>
 
 #include "omap_hwmod.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 74eefd30518c..abef9f6f9bf5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -13,7 +13,7 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/omap-dma.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 53e1ac3724f2..c9483bc06228 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 23336b6c7125..9c0953de24da 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -15,7 +15,7 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/hsmmc-omap.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e4f8ae9cd637..9e4b4243fec7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 
 #include <linux/omap-dma.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index c72cd84b07ec..890c789485d3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -20,7 +20,7 @@
 #include <linux/io.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 
 #include <linux/omap-dma.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 62352d1e6361..56b141fce973 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -20,7 +20,7 @@
 #include <linux/io.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 
 #include <linux/omap-dma.h>
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b9172f08fd05..65d06a819307 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -36,7 +36,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
-#include <linux/i2c-omap.h>
+#include <linux/platform_data/i2c-omap.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/consumer.h>
 
diff --git a/include/linux/i2c-omap.h b/include/linux/platform_data/i2c-omap.h
similarity index 100%
rename from include/linux/i2c-omap.h
rename to include/linux/platform_data/i2c-omap.h
-- 
2.11.0
