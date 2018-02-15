From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v11 05/10] arm: OMAP: Move dmtimer driver out of plat-omap to drivers under clocksource
Date: Thu, 15 Feb 2018 11:31:46 +0530
Message-ID: <1518674511-26421-6-git-send-email-j-keerthy@ti.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: j-keerthy@ti.com, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, ladis@linux-mips.org, s-anna@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

Move the dmtimer driver out of plat-omap to clocksource.
So that non-omap devices also could use this.

No Code changes done to the driver file only renamed to timer-ti-dm.c.
Also removed the config dependencies for OMAP_DM_TIMER.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
---
 arch/arm/plat-omap/Kconfig                                        | 6 ------
 arch/arm/plat-omap/Makefile                                       | 1 -
 drivers/clocksource/Kconfig                                       | 3 +++
 drivers/clocksource/Makefile                                      | 1 +
 arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-ti-dm.c | 0
 5 files changed, 4 insertions(+), 7 deletions(-)
 rename arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-ti-dm.c (100%)

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
index b3b4ed9..5995086 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -21,6 +21,9 @@ config CLKEVT_I8253
 config I8253_LOCK
 	bool
 
+config OMAP_DM_TIMER
+	bool
+
 config CLKBLD_I8253
 	def_bool y if CLKSRC_I8253 || CLKEVT_I8253 || I8253_LOCK
 
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index d6dec44..c8c5109 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
+obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
diff --git a/arch/arm/plat-omap/dmtimer.c b/drivers/clocksource/timer-ti-dm.c
similarity index 100%
rename from arch/arm/plat-omap/dmtimer.c
rename to drivers/clocksource/timer-ti-dm.c
-- 
1.9.1
