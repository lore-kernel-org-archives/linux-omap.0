From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 4/9] arm: OMAP: Move dmtimer driver out of plat-omap to drivers under clocksource
Date: Thu, 16 Nov 2017 09:53:37 +0530
Message-ID: <1510806222-22096-5-git-send-email-j-keerthy@ti.com>
References: <1510806222-22096-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1510806222-22096-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: j-keerthy@ti.com, linux@armlinux.org.uk, daniel.lezcano@linaro.org, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, grygorii.strashko@ti.com, sebastian.reichel@collabora.co.uk, ladis@linux-mips.org
List-Id: linux-omap@vger.kernel.org

Move the dmtimer driver out of plat-omap to clocksource.
So that non-omap devices also could use this.

No Code changes done to the driver file.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---

Changes in v3:

  * Added Sebastian's Reviewed-by.

Changes in v2:

  * No code changes in this v2 version. Only enhanced patch
    statistics for renames.

 arch/arm/plat-omap/Kconfig                            | 6 ------
 arch/arm/plat-omap/Makefile                           | 1 -
 drivers/clocksource/Kconfig                           | 6 ++++++
 drivers/clocksource/Makefile                          | 1 +
 {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c | 0
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c (100%)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 7276afe..afc1a1d 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -106,12 +106,6 @@ config OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
 	help
 	  PPA routine service ID for setting L2 auxiliary control register.
 
-config OMAP_DM_TIMER
-	bool "Use dual-mode timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
-	help
-	 Select this option if you want to use OMAP Dual-Mode timers.
-
 config OMAP_SERIAL_WAKE
 	bool "Enable wake-up events for serial ports"
 	depends on ARCH_OMAP1 && OMAP_MUX
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 47e1867..7215ada 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -9,5 +9,4 @@ obj-y := sram.o dma.o counter_32k.o
 
 # omap_device support (OMAP2+ only at the moment)
 
-obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c729a88..4da66cf 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -46,6 +46,12 @@ config DIGICOLOR_TIMER
 	help
 	  Enables the support for the digicolor timer driver.
 
+config OMAP_DM_TIMER
+	bool "Use dual-mode timer"
+	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
+	help
+	 Select this option if you want to use Dual-Mode timers.
+
 config DW_APB_TIMER
 	bool "DW APB timer driver" if COMPILE_TEST
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 72711f1..b077076 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
+obj-$(CONFIG_OMAP_DM_TIMER)	+= dmtimer.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
diff --git a/arch/arm/plat-omap/dmtimer.c b/drivers/clocksource/dmtimer.c
similarity index 100%
rename from arch/arm/plat-omap/dmtimer.c
rename to drivers/clocksource/dmtimer.c
-- 
1.9.1
