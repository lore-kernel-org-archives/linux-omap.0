From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 6/6] PM / AVS / OMAP: move Smartreflex-class3 driver to power/avs
Date: Mon, 5 Nov 2012 09:02:14 -0600
Message-ID: <1352127734-30103-8-git-send-email-nm@ti.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1352127734-30103-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Move the AVS class 3 driver to AVS directory

Acked-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    1 -
 arch/arm/plat-omap/Kconfig                         |    9 ---------
 drivers/power/avs/Kconfig                          |    9 +++++++++
 drivers/power/avs/Makefile                         |    1 +
 .../power/avs}/smartreflex-class3.c                |    0
 5 files changed, 10 insertions(+), 10 deletions(-)
 rename {arch/arm/mach-omap2 => drivers/power/avs}/smartreflex-class3.c (100%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fe40d9e..1eae31d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o sleep44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
-obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index b49cff3..cd2c60d 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -47,15 +47,6 @@ config OMAP_DEBUG_LEDS
 	depends on OMAP_DEBUG_DEVICES
 	select LEDS_CLASS
 
-config POWER_AVS_OMAP_CLASS3
-	bool "Class 3 mode of Smartreflex Implementation"
-	depends on POWER_AVS_OMAP && TWL4030_CORE
-	help
-	  Say Y to enable Class 3 implementation of Smartreflex
-
-	  Class 3 implementation of Smartreflex employs continuous hardware
-	  voltage calibration.
-
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index 466a391..4f1c1b4 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -32,3 +32,12 @@ config POWER_AVS_OMAP
 	  Optionally autocompensation can be enabled in the kernel
 	  by default during system init via the enable_on_init flag
 	  which an be passed as platform data to the smartreflex driver.
+
+config POWER_AVS_OMAP_CLASS3
+	bool "Class 3 mode of Smartreflex Implementation"
+	depends on POWER_AVS_OMAP && TWL4030_CORE
+	help
+	  Say Y to enable Class 3 implementation of Smartreflex
+
+	  Class 3 implementation of Smartreflex employs continuous hardware
+	  voltage calibration.
diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
index 0843386..ac72ec5 100644
--- a/drivers/power/avs/Makefile
+++ b/drivers/power/avs/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_POWER_AVS_OMAP)		+= smartreflex.o
+obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)	+= smartreflex-class3.o
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/drivers/power/avs/smartreflex-class3.c
similarity index 100%
rename from arch/arm/mach-omap2/smartreflex-class3.c
rename to drivers/power/avs/smartreflex-class3.c
-- 
1.7.9.5

