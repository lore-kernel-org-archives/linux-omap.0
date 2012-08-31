From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/9] ARM: OMAP2+: Prepare for irqs.h removal
Date: Thu, 30 Aug 2012 17:52:37 -0700
Message-ID: <20120831005237.28732.96766.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17249 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab2HaAwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 20:52:39 -0400
In-Reply-To: <20120831004828.28732.902.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

As the interrupts should only be defined in the platform_data, and
eventually coming from device tree, there's no need to define them
in header files.

Let's remove the hardcoded references to irqs.h and fix up the includes
so we don't rely on headers included in irqs.h. While at it, sort
the includes the standard way.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c                |    7 +++--
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +
 arch/arm/mach-omap2/board-am3517evm.c              |    3 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |    6 ++--
 arch/arm/mach-omap2/board-flash.c                  |    2 +
 arch/arm/mach-omap2/board-igep0020.c               |    7 +++--
 arch/arm/mach-omap2/board-n8x0.c                   |    3 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +
 arch/arm/mach-omap2/board-rm680.c                  |    6 +++-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    2 +
 arch/arm/mach-omap2/board-ti8168evm.c              |    3 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    1 +
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    5 ++--
 arch/arm/mach-omap2/cpuidle34xx.c                  |    1 -
 arch/arm/mach-omap2/devices.c                      |    7 +----
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    1 +
 arch/arm/mach-omap2/gpmc.c                         |   11 +++++---
 arch/arm/mach-omap2/io.c                           |    2 +
 arch/arm/mach-omap2/mailbox.c                      |    3 +-
 arch/arm/mach-omap2/mcbsp.c                        |    1 -
 arch/arm/mach-omap2/omap-iommu.c                   |    1 -
 arch/arm/mach-omap2/omap-wakeupgen.c               |    1 +
 arch/arm/mach-omap2/omap4-common.c                 |    7 ++---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    3 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   12 ++++-----
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   27 ++++++++++----------
 arch/arm/mach-omap2/omap_l3_noc.c                  |    6 +++-
 arch/arm/mach-omap2/omap_phy_internal.c            |    2 +
 arch/arm/mach-omap2/pm24xx.c                       |    2 -
 arch/arm/mach-omap2/prcm.c                         |    1 -
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |    3 +-
 arch/arm/mach-omap2/prm44xx.c                      |    4 +--
 arch/arm/mach-omap2/prm_common.c                   |    1 -
 arch/arm/mach-omap2/serial.c                       |    1 +
 arch/arm/mach-omap2/timer.c                        |   10 ++++---
 arch/arm/mach-omap2/twl-common.c                   |    3 +-
 arch/arm/mach-omap2/twl-common.h                   |    6 +---
 arch/arm/mach-omap2/usb-host.c                     |    1 -
 arch/arm/mach-omap2/usb-musb.c                     |    1 -
 arch/arm/plat-omap/include/plat/omap44xx.h         |    1 +
 drivers/dma/omap-dma.c                             |    2 +
 drivers/mfd/twl-core.c                             |    2 +
 drivers/mtd/onenand/omap2.c                        |    8 ++++--
 drivers/tty/serial/8250/8250.c                     |    4 +--
 drivers/video/omap2/dss/dispc.c                    |    1 +
 drivers/video/omap2/omapfb/omapfb-main.c           |    4 ++-
 sound/soc/omap/mcbsp.c                             |    3 +-
 sound/soc/omap/omap-mcbsp.c                        |    1 +
 sound/soc/omap/omap-pcm.c                          |    1 +
 51 files changed, 105 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index cacc498..3a587d0 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -28,19 +28,20 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
 
+#include <mach/hardware.h>
+
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 
+#include "common.h"
 #include "mux.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
@@ -231,7 +232,7 @@ static int __init omap2430_i2c_init(void)
 	sdp2430_i2c1_boardinfo[0].irq = gpio_to_irq(78);
 	omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
 			ARRAY_SIZE(sdp2430_i2c1_boardinfo));
-	omap_pmic_init(2, 100, "twl4030", INT_24XX_SYS_NIRQ,
+	omap_pmic_init(2, 100, "twl4030", 7,
 			&sdp2430_twldata);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ee82604..31456ea 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -579,7 +579,7 @@ static int __init omap4_i2c_init(void)
 			TWL_COMMON_REGULATOR_V1V8 |
 			TWL_COMMON_REGULATOR_V2V1);
 	omap4_pmic_init("twl6030", &sdp4430_twldata,
-			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
+			&twl6040_data, 119 + OMAP44XX_IRQ_GIC_START);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
 				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index c6d63d7..818f664 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -298,8 +298,7 @@ static struct resource am3517_hecc_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= INT_35XX_HECC0_IRQ,
-		.end	= INT_35XX_HECC0_IRQ,
+		.start	= 24,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 30b7b01..d1c59d3 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -38,13 +38,14 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
 #include <plat/usb.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <plat/gpmc.h>
+#include <plat/serial.h>
 
 #include <mach/am35xx.h>
 
+#include "common.h"
 #include "mux.h"
 #include "control.h"
 #include "common-board-devices.h"
@@ -89,8 +90,7 @@ static struct resource cm_t3517_hecc_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= INT_35XX_HECC0_IRQ,
-		.end	= INT_35XX_HECC0_IRQ,
+		.start	= 24,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index c8d4382..bd67c4c 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -16,8 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
-#include <plat/irqs.h>
 
+#include <plat/cpu.h>
 #include <plat/gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 0b9677b..0dfed5a 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -23,19 +23,20 @@
 #include <linux/regulator/fixed.h>
 #include <linux/i2c/twl.h>
 #include <linux/mmc/host.h>
-
 #include <linux/mtd/nand.h>
+#include <linux/platform_data/mtd-onenand-omap2.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
+#include <plat/serial.h>
+
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
 
+#include "common.h"
 #include "mux.h"
 #include "hsmmc.h"
 #include "sdram-numonyx-m65kxxxxam.h"
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index edf6559..eed16d6 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -27,7 +27,6 @@
 
 #include "common.h"
 #include <plat/menelaus.h>
-#include <mach/irqs.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <plat/mmc.h>
@@ -599,7 +598,7 @@ static struct menelaus_platform_data n8x0_menelaus_platform_data __initdata = {
 static struct i2c_board_info __initdata n8x0_i2c_board_info_1[] __initdata = {
 	{
 		I2C_BOARD_INFO("menelaus", 0x72),
-		.irq = INT_24XX_SYS_NIRQ,
+		.irq = 7,
 		.platform_data = &n8x0_menelaus_platform_data,
 	},
 };
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e37ee67..cbf6fd5 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -292,7 +292,7 @@ static int __init omap4_panda_i2c_init(void)
 			TWL_COMMON_REGULATOR_V1V8 |
 			TWL_COMMON_REGULATOR_V2V1);
 	omap4_pmic_init("twl6030", &omap4_panda_twldata,
-			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
+			&twl6040_data, 119 + OMAP44XX_IRQ_GIC_START);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	/*
 	 * Bus 3 is attached to the DVI port where devices like the pico DLP
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 4c45109..abdb057 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -25,9 +25,11 @@
 #include <plat/mmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc.h>
-#include "common.h"
+#include <plat/serial.h>
+
 #include <linux/platform_data/mtd-onenand-omap2.h>
 
+#include "common.h"
 #include "mux.h"
 #include "hsmmc.h"
 #include "sdram-nokia.h"
@@ -84,7 +86,7 @@ static struct twl4030_platform_data rm680_twl_data = {
 static void __init rm680_i2c_init(void)
 {
 	omap3_pmic_get_config(&rm680_twl_data, TWL_COMMON_PDATA_USB, 0);
-	omap_pmic_init(1, 2900, "twl5031", INT_34XX_SYS_NIRQ, &rm680_twl_data);
+	omap_pmic_init(1, 2900, "twl5031", 7, &rm680_twl_data);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 }
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 06e44e4..93710b3 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1047,7 +1047,7 @@ static int __init rx51_i2c_init(void)
 	rx51_twldata.vdac->constraints.apply_uV = true;
 	rx51_twldata.vdac->constraints.name = "VDAC";
 
-	omap_pmic_init(1, 2200, "twl5030", INT_34XX_SYS_NIRQ, &rx51_twldata);
+	omap_pmic_init(1, 2200, "twl5030", 7, &rx51_twldata);
 	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
 			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_2));
 #if defined(CONFIG_SENSORS_LIS3_I2C) || defined(CONFIG_SENSORS_LIS3_I2C_MODULE)
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index da4679d..5387cb8 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -20,9 +20,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/irqs.h>
-#include "common.h"
 #include <plat/usb.h>
+#include "common.h"
 
 static struct omap_musb_board_data musb_board_data = {
 	.set_phy_power	= ti81xx_musb_phy_power,
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index f64f441..f1100c2 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -19,6 +19,7 @@
 
 #include <plat/gpmc.h>
 #include <plat/gpmc-smsc911x.h>
+#include <plat/serial.h>
 
 #include <mach/board-zoom.h>
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index ae5d36b..406303d 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -25,11 +25,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
 #include <plat/usb.h>
+#include <plat/serial.h>
 
 #include <mach/board-zoom.h>
 
+#include "common.h"
 #include "mux.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
@@ -279,7 +280,7 @@ static int __init omap_i2c_init(void)
 		codec_data->hs_extmute = 1;
 		codec_data->set_hs_extmute = zoom2_set_hs_extmute;
 	}
-	omap_pmic_init(1, 2400, "twl5030", INT_34XX_SYS_NIRQ, &zoom_twldata);
+	omap_pmic_init(1, 2400, "twl5030", 7, &zoom_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f2a49a4..bc27569 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -28,7 +28,6 @@
 #include <linux/cpu_pm.h>
 
 #include <plat/prcm.h>
-#include <plat/irqs.h>
 #include "powerdomain.h"
 #include "clockdomain.h"
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b80073f..a4f5ce6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -20,17 +20,16 @@
 #include <linux/platform_data/omap4-keypad.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
 
-#include "iomap.h"
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap4-keypad.h>
 
+#include "iomap.h"
 #include "mux.h"
 #include "control.h"
 #include "devices.h"
@@ -435,13 +434,11 @@ static inline void omap_init_mcspi(void) {}
 
 static struct resource omap2_pmu_resource = {
 	.start	= 3,
-	.end	= 3,
 	.flags	= IORESOURCE_IRQ,
 };
 
 static struct resource omap3_pmu_resource = {
-	.start	= INT_34XX_BENCH_MPU_EMUL,
-	.end	= INT_34XX_BENCH_MPU_EMUL,
+	.start	= 3,
 	.flags	= IORESOURCE_IRQ,
 };
 
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index 3f75ff0..e8ff2da 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/smc91x.h>
 
+#include <plat/cpu.h>
 #include <plat/gpmc.h>
 #include <plat/gpmc-smc91x.h>
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 39c30d9..bea55a2 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -26,10 +26,13 @@
 #include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
-#include <plat/gpmc.h>
 
+#include <plat/cpu.h>
+#include <plat/gpmc.h>
 #include <plat/sdrc.h>
 
+#include <mach/hardware.h>
+
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
@@ -846,16 +849,16 @@ static int __init gpmc_init(void)
 			l = OMAP2420_GPMC_BASE;
 		else
 			l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = INT_34XX_GPMC_IRQ;
+		gpmc_irq = 20;
 	} else if (cpu_is_omap34xx()) {
 		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = INT_34XX_GPMC_IRQ;
+		gpmc_irq = 20;
 	} else if (cpu_is_omap44xx() || soc_is_omap54xx()) {
 		/* Base address and irq number are same for OMAP4/5 */
 		ck = "gpmc_ck";
 		l = OMAP44XX_GPMC_BASE;
-		gpmc_irq = OMAP44XX_IRQ_GPMC;
+		gpmc_irq = 20 + OMAP44XX_IRQ_GIC_START;
 	}
 
 	if (WARN_ON(!ck))
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4d2d981..ff6fc5b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -33,6 +33,8 @@
 #include <plat/multi.h>
 #include <plat/dma.h>
 
+#include <mach/hardware.h>
+
 #include "iomap.h"
 #include "voltage.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 6875be8..e032a73 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -16,8 +16,9 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
+
+#include <plat/cpu.h>
 #include <plat/mailbox.h>
-#include <mach/irqs.h>
 
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_MESSAGE(m)		(0x040 + 4 * (m))
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 4ee08c6..4576708 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <mach/irqs.h>
 #include <plat/dma.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/dsp-mcbsp.h>
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 1be8bcb..a8d957a 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -14,7 +14,6 @@
 #include <linux/platform_device.h>
 
 #include <plat/iommu.h>
-#include <plat/irqs.h>
 
 struct iommu_device {
 	resource_size_t base;
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 05fdebf..95ee7dd 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -27,6 +27,7 @@
 
 #include <asm/hardware/gic.h>
 
+#include <mach/hardware.h>
 #include <mach/omap-wakeupgen.h>
 #include <mach/omap-secure.h>
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index c29dee9..c886325 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -16,15 +16,15 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/memblock.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/export.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 
-#include <plat/irqs.h>
 #include <plat/sram.h>
 #include <plat/omap-secure.h>
 #include <plat/mmc.h>
@@ -35,7 +35,6 @@
 #include "common.h"
 #include "hsmmc.h"
 #include "omap4-sar-layout.h"
-#include <linux/export.h>
 
 #ifdef CONFIG_CACHE_L2X0
 static void __iomem *l2cache_base;
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b305d7f..8fdc676 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -13,7 +13,6 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 #include <plat/omap_hwmod.h>
-#include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 79ac236..4a6bbfd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -16,7 +16,6 @@
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <plat/omap_hwmod.h>
-#include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
@@ -25,6 +24,8 @@
 #include <plat/mmc.h>
 #include <plat/l3_2xxx.h>
 
+#include <plat/hardware.h>
+
 #include "omap_hwmod_common_data.h"
 
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 102d76e..f19540a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -15,8 +15,6 @@
 #include <plat/common.h>
 #include <plat/hdq1w.h>
 
-#include <mach/irqs.h>
-
 #include "omap_hwmod_common_data.h"
 
 /* UART */
@@ -237,17 +235,17 @@ struct omap_hwmod_irq_info omap2_timer11_mpu_irqs[] = {
 };
 
 struct omap_hwmod_irq_info omap2_uart1_mpu_irqs[] = {
-	{ .irq = INT_24XX_UART1_IRQ, },
+	{ .irq = 72, },
 	{ .irq = -1 }
 };
 
 struct omap_hwmod_irq_info omap2_uart2_mpu_irqs[] = {
-	{ .irq = INT_24XX_UART2_IRQ, },
+	{ .irq = 73, },
 	{ .irq = -1 }
 };
 
 struct omap_hwmod_irq_info omap2_uart3_mpu_irqs[] = {
-	{ .irq = INT_24XX_UART3_IRQ, },
+	{ .irq = 74, },
 	{ .irq = -1 }
 };
 
@@ -257,12 +255,12 @@ struct omap_hwmod_irq_info omap2_dispc_irqs[] = {
 };
 
 struct omap_hwmod_irq_info omap2_i2c1_mpu_irqs[] = {
-	{ .irq = INT_24XX_I2C1_IRQ, },
+	{ .irq = 56, },
 	{ .irq = -1 }
 };
 
 struct omap_hwmod_irq_info omap2_i2c2_mpu_irqs[] = {
-	{ .irq = INT_24XX_I2C2_IRQ, },
+	{ .irq = 57, },
 	{ .irq = -1 }
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 44e4764..85c1259 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -15,8 +15,6 @@
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
-#include <mach/irqs.h>
-
 #include "omap_hwmod_common_data.h"
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 15f617e..b9525d2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -20,7 +20,6 @@
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <plat/omap_hwmod.h>
-#include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
@@ -30,11 +29,13 @@
 #include <plat/mmc.h>
 #include <plat/dmtimer.h>
 
+#include <mach/hardware.h>
+#include <mach/am35xx.h>
+
 #include "omap_hwmod_common_data.h"
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
 #include "wd_timer.h"
-#include <mach/am35xx.h>
 
 /*
  * OMAP3xxx hardware module integration data
@@ -51,8 +52,8 @@
 
 /* L3 */
 static struct omap_hwmod_irq_info omap3xxx_l3_main_irqs[] = {
-	{ .irq = INT_34XX_L3_DBG_IRQ },
-	{ .irq = INT_34XX_L3_APP_IRQ },
+	{ .irq = 9 },
+	{ .irq = 10 },
 	{ .irq = -1 }
 };
 
@@ -490,7 +491,7 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 
 /* UART4 */
 static struct omap_hwmod_irq_info uart4_mpu_irqs[] = {
-	{ .irq = INT_36XX_UART4_IRQ, },
+	{ .irq = 80, },
 	{ .irq = -1 }
 };
 
@@ -518,7 +519,7 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 };
 
 static struct omap_hwmod_irq_info am35xx_uart4_mpu_irqs[] = {
-	{ .irq = INT_35XX_UART4_IRQ, },
+	{ .irq = 84, },
 	{ .irq = -1 }
 };
 
@@ -804,7 +805,7 @@ static struct omap_i2c_dev_attr i2c3_dev_attr = {
 };
 
 static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
-	{ .irq = INT_34XX_I2C3_IRQ, },
+	{ .irq = 61, },
 	{ .irq = -1 }
 };
 
@@ -1585,7 +1586,7 @@ static struct omap_hwmod omap34xx_mcspi3 = {
 
 /* mcspi4 */
 static struct omap_hwmod_irq_info omap34xx_mcspi4_mpu_irqs[] = {
-	{ .name = "irq", .irq = INT_34XX_SPI4_IRQ }, /* 48 */
+	{ .name = "irq", .irq = 48 },
 	{ .irq = -1 }
 };
 
@@ -1773,7 +1774,7 @@ static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod = {
 /* MMC/SD/SDIO2 */
 
 static struct omap_hwmod_irq_info omap34xx_mmc2_mpu_irqs[] = {
-	{ .irq = INT_24XX_MMC2_IRQ, },
+	{ .irq = 86, },
 	{ .irq = -1 }
 };
 
@@ -3214,10 +3215,10 @@ static struct omap_hwmod_ocp_if am35xx_l4_core__mdio = {
 };
 
 static struct omap_hwmod_irq_info am35xx_emac_mpu_irqs[] = {
-	{ .name = "rxthresh",	.irq = INT_35XX_EMAC_C0_RXTHRESH_IRQ },
-	{ .name = "rx_pulse",	.irq = INT_35XX_EMAC_C0_RX_PULSE_IRQ },
-	{ .name = "tx_pulse",	.irq = INT_35XX_EMAC_C0_TX_PULSE_IRQ },
-	{ .name = "misc_pulse",	.irq = INT_35XX_EMAC_C0_MISC_PULSE_IRQ },
+	{ .name = "rxthresh",	.irq = 67 },
+	{ .name = "rx_pulse",	.irq = 68 },
+	{ .name = "tx_pulse",	.irq = 69 },
+	{ .name = "misc_pulse",	.irq = 70 },
 	{ .irq = -1 }
 };
 
diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index d15225f..f0992fd 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -28,6 +28,8 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
+#include <plat/hardware.h>
+
 #include "omap_l3_noc.h"
 
 /*
@@ -190,7 +192,7 @@ static int __devinit omap4_l3_probe(struct platform_device *pdev)
 			IRQF_DISABLED, "l3-dbg-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
-						OMAP44XX_IRQ_L3_DBG);
+						9 + OMAP44XX_IRQ_GIC_START);
 		goto err3;
 	}
 
@@ -200,7 +202,7 @@ static int __devinit omap4_l3_probe(struct platform_device *pdev)
 			IRQF_DISABLED, "l3-app-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
-						OMAP44XX_IRQ_L3_APP);
+						10 + OMAP44XX_IRQ_GIC_START);
 		goto err4;
 	}
 
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index d52651a..d0b4dc7 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -28,7 +28,9 @@
 #include <linux/err.h>
 #include <linux/usb.h>
 
+#include <plat/hardware.h>
 #include <plat/usb.h>
+
 #include "control.h"
 
 /* OMAP control module register for UTMI PHY */
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2708a8b..8af6cd6 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -40,8 +40,6 @@
 #include <plat/sram.h>
 #include <plat/dma.h>
 
-#include <mach/irqs.h>
-
 #include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 053e24e..9c9d23c 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -27,7 +27,6 @@
 
 #include "common.h"
 #include <plat/prcm.h>
-#include <plat/irqs.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index a0309de..9052383 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -20,7 +20,6 @@
 #include "common.h"
 #include <plat/cpu.h>
 #include <plat/prcm.h>
-#include <plat/irqs.h>
 
 #include "vp.h"
 
@@ -40,7 +39,7 @@ static struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
 	.nr_regs		= 1,
 	.irqs			= omap3_prcm_irqs,
 	.nr_irqs		= ARRAY_SIZE(omap3_prcm_irqs),
-	.irq			= INT_34XX_PRCM_MPU_IRQ,
+	.irq			= 11,
 	.read_pending_irqs	= &omap3xxx_prm_read_pending_irqs,
 	.ocp_barrier		= &omap3xxx_prm_ocp_barrier,
 	.save_and_clear_irqen	= &omap3xxx_prm_save_and_clear_irqen,
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index bb727c2..df2cfe1 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -18,8 +18,8 @@
 #include <linux/io.h>
 
 #include <plat/cpu.h>
-#include <plat/irqs.h>
 #include <plat/prcm.h>
+#include <plat/hardware.h>
 
 #include "iomap.h"
 #include "common.h"
@@ -40,7 +40,7 @@ static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
 	.nr_regs		= 2,
 	.irqs			= omap4_prcm_irqs,
 	.nr_irqs		= ARRAY_SIZE(omap4_prcm_irqs),
-	.irq			= OMAP44XX_IRQ_PRCM,
+	.irq			= 11 + OMAP44XX_IRQ_GIC_START,
 	.read_pending_irqs	= &omap44xx_prm_read_pending_irqs,
 	.ocp_barrier		= &omap44xx_prm_ocp_barrier,
 	.save_and_clear_irqen	= &omap44xx_prm_save_and_clear_irqen,
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 03b126d..6b4d332 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -26,7 +26,6 @@
 
 #include <plat/common.h>
 #include <plat/prcm.h>
-#include <plat/irqs.h>
 
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 10f7f02..7345267 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -33,6 +33,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
+#include <plat/serial.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2ff6d41..e1f1d09 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -38,14 +38,17 @@
 #include <linux/slab.h>
 
 #include <asm/mach/time.h>
-#include <plat/dmtimer.h>
 #include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
-#include "common.h"
+
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/dmtimer.h>
 #include <plat/omap-pm.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
 #include "powerdomain.h"
 
 /* Parent clocks, eventually these will come from the clock framework */
@@ -373,8 +376,7 @@ OMAP_SYS_TIMER(3_am33xx)
 #ifdef CONFIG_ARCH_OMAP4
 #ifdef CONFIG_LOCAL_TIMERS
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
-			      OMAP44XX_LOCAL_TWD_BASE,
-			      OMAP44XX_IRQ_LOCALTIMER);
+			      OMAP44XX_LOCAL_TWD_BASE, 29);
 #endif
 
 static void __init omap4_timer_init(void)
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index de47f17..81f9956 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -26,6 +26,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
+#include <plat/hardware.h>
 #include <plat/i2c.h>
 #include <plat/usb.h>
 
@@ -83,7 +84,7 @@ void __init omap4_pmic_init(const char *pmic_type,
 	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
 	strncpy(omap4_i2c1_board_info[0].type, pmic_type,
 		sizeof(omap4_i2c1_board_info[0].type));
-	omap4_i2c1_board_info[0].irq = OMAP44XX_IRQ_SYS_1N;
+	omap4_i2c1_board_info[0].irq = 7 + OMAP44XX_IRQ_GIC_START;
 	omap4_i2c1_board_info[0].platform_data = pmic_data;
 
 	/* TWL6040 audio IC part */
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 8fe71cf..1ddea9f 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -1,8 +1,6 @@
 #ifndef __OMAP_PMIC_COMMON__
 #define __OMAP_PMIC_COMMON__
 
-#include <plat/irqs.h>
-
 #define TWL_COMMON_PDATA_USB		(1 << 0)
 #define TWL_COMMON_PDATA_BCI		(1 << 1)
 #define TWL_COMMON_PDATA_MADC		(1 << 2)
@@ -40,13 +38,13 @@ void omap_pmic_late_init(void);
 static inline void omap2_pmic_init(const char *pmic_type,
 				   struct twl4030_platform_data *pmic_data)
 {
-	omap_pmic_init(2, 2600, pmic_type, INT_24XX_SYS_NIRQ, pmic_data);
+	omap_pmic_init(2, 2600, pmic_type, 7, pmic_data);
 }
 
 static inline void omap3_pmic_init(const char *pmic_type,
 				   struct twl4030_platform_data *pmic_data)
 {
-	omap_pmic_init(1, 2600, pmic_type, INT_34XX_SYS_NIRQ, pmic_data);
+	omap_pmic_init(1, 2600, pmic_type, 7, pmic_data);
 }
 
 void omap4_pmic_init(const char *pmic_type,
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index dde8a11..14368c3 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -26,7 +26,6 @@
 #include <asm/io.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <plat/usb.h>
 #include <plat/omap_device.h>
 
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index c4a5768..3f35e6c 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -27,7 +27,6 @@
 #include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <mach/am35xx.h>
 #include <plat/usb.h>
 #include <plat/omap_device.h>
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index c0d478e..5da9735 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -39,6 +39,7 @@
 #define IRQ_SIR_IRQ			0x0040
 #define OMAP44XX_GIC_DIST_BASE		0x48241000
 #define OMAP44XX_GIC_CPU_BASE		0x48240100
+#define OMAP44XX_IRQ_GIC_START		32
 #define OMAP44XX_SCU_BASE		0x48240000
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
 #define OMAP44XX_L2CACHE_BASE		0x48242000
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ae05618..2e16627 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -18,6 +18,8 @@
 #include <linux/spinlock.h>
 
 #include "virt-dma.h"
+
+#include <plat/cpu.h>
 #include <plat/dma.h>
 
 struct omap_dmadev {
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 1c32afe..f462ff2 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -46,6 +46,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 
+#include <plat/cpu.h>
+
 #include "twl-core.h"
 
 /*
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 1b4725b..06134c9 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -37,13 +37,15 @@
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
 
-#include <asm/mach/flash.h>
-#include <plat/gpmc.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
 #include <asm/gpio.h>
+#include <asm/mach/flash.h>
 
+#include <plat/cpu.h>
+#include <plat/gpmc.h>
 #include <plat/dma.h>
 
+#include <linux/platform_data/mtd-onenand-omap2.h>
+
 #define DRIVER_NAME "omap2-onenand"
 
 #define ONENAND_BUFRAM_SIZE	(1024 * 5)
diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 8123f78..5b3f2fe 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -2336,7 +2336,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 			serial_port_out(port, UART_EFR, efr);
 	}
 
-#ifdef CONFIG_ARCH_OMAP
+#ifdef CONFIG_ARCH_OMAP1
 	/* Workaround to enable 115200 baud on OMAP1510 internal ports */
 	if (cpu_is_omap1510() && is_omap_port(up)) {
 		if (baud == 115200) {
@@ -2426,7 +2426,7 @@ static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
 	if (pt->port.iotype == UPIO_AU)
 		return 0x1000;
-#ifdef CONFIG_ARCH_OMAP
+#ifdef CONFIG_ARCH_OMAP1
 	if (is_omap_port(pt))
 		return 0x16 << pt->port.regshift;
 #endif
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5b289c5..ee9e296 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -37,6 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+#include <plat/cpu.h>
 #include <plat/clock.h>
 
 #include <video/omapdss.h>
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 08ec1a7..9e6ee5c 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -30,10 +30,12 @@
 #include <linux/platform_device.h>
 #include <linux/omapfb.h>
 
-#include <video/omapdss.h>
+#include <plat/cpu.h>
 #include <plat/vram.h>
 #include <plat/vrfb.h>
 
+#include <video/omapdss.h>
+
 #include "omapfb.h"
 
 #define MODULE_NAME     "omapfb"
diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 4bc029d..bfdf7e0 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -24,9 +24,10 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-
 #include <linux/platform_data/dsp-mcbsp.h>
 
+#include <plat/cpu.h>
+
 #include "mcbsp.h"
 
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index deeda47..ecee212b 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -32,6 +32,7 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+#include <plat/cpu.h>
 #include <plat/dma.h>
 #include <linux/platform_data/dsp-mcbsp.h>
 #include "mcbsp.h"
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index f0feb06..b309941 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -30,6 +30,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
+#include <plat/cpu.h>
 #include <plat/dma.h>
 #include "omap-pcm.h"
 

