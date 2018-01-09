From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v7 3/9] arm: omap: Move dmtimer.h out of plat-omap
Date: Tue, 9 Jan 2018 11:53:01 +0530
Message-ID: <1515478987-5786-4-git-send-email-j-keerthy@ti.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: j-keerthy@ti.com, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, ladis@linux-mips.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

The header file is currently under plat-omap directory
under arch/omap. Move this out to an accessible place.

No Code changes done to the header file.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
---
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
index 0afb014..0a8b95f 100644
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
index 013b26b..16e3d8c 100644
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
index 4b094cb..8a65f70 100644
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
index 1a2f224..b030137 100644
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
index a1901c2..51c7d62 100644
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
index 4c2a05b..2452649 100644
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
index 84f1182..94f3bb1 100644
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
