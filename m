From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v5 3/8] arm: omap: Move dmtimer.h out of plat-omap
Date: Tue, 12 Dec 2017 11:42:12 +0530
Message-ID: <1513059137-21593-4-git-send-email-j-keerthy@ti.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

The header file is currently under plat-omap directory
under arch/omap. Move this out to an accessible place.

No Code changes done to the header file.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes in v3:

  * Added Sebastian's Reviewed-by.

Changes in v2:

  * No code changes in this v2 version. Only enhanced patch
    statistics for renames.

 arch/arm/mach-omap1/pm.c                                           | 2 +-
 arch/arm/mach-omap1/timer.c                                        | 2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c                         | 2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c                         | 2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c                 | 2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c                         | 2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c                         | 2 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c                         | 2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c                          | 2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c                         | 2 +-
 arch/arm/mach-omap2/pdata-quirks.c                                 | 2 +-
 arch/arm/mach-omap2/timer.c                                        | 2 +-
 arch/arm/plat-omap/dmtimer.c                                       | 2 +-
 {arch/arm/plat-omap/include/plat => include/clocksource}/dmtimer.h | 0
 14 files changed, 13 insertions(+), 13 deletions(-)
 rename {arch/arm/plat-omap/include/plat => include/clocksource}/dmtimer.h (100%)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index f1135bf..a07d47cf 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -55,7 +55,7 @@
 #include <mach/tc.h>
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 8fb1ec6..7c057ab 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -27,7 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 1a15a34..45c1043 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -16,7 +16,7 @@
 #include <linux/i2c-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 3801850..892ca58 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -18,7 +18,7 @@
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index beec4cd..82b51c0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -11,7 +11,7 @@
 
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "omap_hwmod.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 52c9d58..310aef5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -25,7 +25,7 @@
 #include "l4_3xxx.h"
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "soc.h"
 #include "omap_hwmod.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c477096..22e0e38 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -30,7 +30,7 @@
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 988e7ea..530334e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -26,7 +26,7 @@
 #include <linux/omap-dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d05e553d..adabdef 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -26,7 +26,7 @@
 #include <linux/omap-dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 77a515b..d05dd2d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -18,7 +18,7 @@
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod_common_data.h"
 #include "cm81xx.h"
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6b433fc..ad9df86 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -27,7 +27,7 @@
 #include <linux/platform_data/pwm_omap_dmtimer.h>
 #include <linux/platform_data/media/ir-rx51.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "common.h"
 #include "common-board-devices.h"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ece09c9..31c1b01 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -26,6 +26,7 @@
  * License. See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <clocksource/dmtimer.h>
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
@@ -49,7 +50,6 @@
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/counter-32k.h>
-#include <plat/dmtimer.h>
 #include "omap-pm.h"
 
 #include "soc.h"
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 72565fc..afe1dc9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -47,7 +47,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/include/clocksource/dmtimer.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/dmtimer.h
rename to include/clocksource/dmtimer.h
-- 
1.9.1
