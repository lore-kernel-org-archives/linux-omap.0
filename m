From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/17] ARM: OMAP2+: Prepare for irqs.h removal
Date: Mon, 10 Sep 2012 22:31:09 -0700
Message-ID: <20120911053108.29637.8738.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48090 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754605Ab2IKFbL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:31:11 -0400
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

As the interrupts should only be defined in the platform_data, and
eventually coming from device tree, there's no need to define them
in header files.

Let's remove the hardcoded references to irqs.h and fix up the includes
so we don't rely on headers included in irqs.h. Note that we're
defining OMAP_INTC_START as 0 to the interrupts. This will be needed
when we enable SPARSE_IRQ. For some drivers we need to add
#include <plat/cpu.h> for now until these drivers are fixed to
remove cpu_is_omapxxxx() usage.

While at it, sort som of the includes the standard way, and add
the trailing commas where they are missing in the related data
structures.

Note that for drivers/staging/tidspbridge we just define things
locally.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c                |    2 
 arch/arm/mach-omap2/board-4430sdp.c                |    2 
 arch/arm/mach-omap2/board-am3517evm.c              |    3 
 arch/arm/mach-omap2/board-cm-t3517.c               |    4 -
 arch/arm/mach-omap2/board-flash.c                  |    2 
 arch/arm/mach-omap2/board-igep0020.c               |    2 
 arch/arm/mach-omap2/board-n8x0.c                   |    3 
 arch/arm/mach-omap2/board-omap4panda.c             |    2 
 arch/arm/mach-omap2/board-rm680.c                  |    3 
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    2 
 arch/arm/mach-omap2/board-ti8168evm.c              |    1 
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    1 
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    3 
 arch/arm/mach-omap2/common-board-devices.c         |    1 
 arch/arm/mach-omap2/common.h                       |    2 
 arch/arm/mach-omap2/cpuidle34xx.c                  |    1 
 arch/arm/mach-omap2/devices.c                      |   17 +-
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    1 
 arch/arm/mach-omap2/gpmc.c                         |   11 +
 arch/arm/mach-omap2/io.c                           |    2 
 arch/arm/mach-omap2/mailbox.c                      |    3 
 arch/arm/mach-omap2/mcbsp.c                        |    1 
 arch/arm/mach-omap2/omap-iommu.c                   |   12 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |    1 
 arch/arm/mach-omap2/omap4-common.c                 |    7 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   23 +--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   71 +++++-----
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  108 +++++++-------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    6 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  149 ++++++++++----------
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 
 arch/arm/mach-omap2/omap_l3_noc.c                  |    6 +
 arch/arm/mach-omap2/omap_phy_internal.c            |    2 
 arch/arm/mach-omap2/pm24xx.c                       |    2 
 arch/arm/mach-omap2/prcm.c                         |    1 
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |    3 
 arch/arm/mach-omap2/prm44xx.c                      |    4 -
 arch/arm/mach-omap2/prm_common.c                   |    1 
 arch/arm/mach-omap2/serial.c                       |    1 
 arch/arm/mach-omap2/soc.h                          |    1 
 arch/arm/mach-omap2/timer.c                        |   10 +
 arch/arm/mach-omap2/twl-common.c                   |    3 
 arch/arm/mach-omap2/twl-common.h                   |    6 -
 arch/arm/mach-omap2/usb-host.c                     |    1 
 arch/arm/mach-omap2/usb-musb.c                     |    1 
 arch/arm/plat-omap/include/plat/omap44xx.h         |    1 
 drivers/dma/omap-dma.c                             |    2 
 drivers/mfd/twl-core.c                             |    2 
 drivers/mtd/onenand/omap2.c                        |    1 
 drivers/video/omap2/dss/dispc.c                    |    1 
 drivers/video/omap2/omapfb/omapfb-main.c           |    1 
 sound/soc/omap/mcbsp.c                             |    2 
 sound/soc/omap/omap-mcbsp.c                        |    1 
 sound/soc/omap/omap-pcm.c                          |    1 
 54 files changed, 263 insertions(+), 238 deletions(-)
 create mode 100644 arch/arm/mach-omap2/soc.h

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index cacc498..0900eac 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -231,7 +231,7 @@ static int __init omap2430_i2c_init(void)
 	sdp2430_i2c1_boardinfo[0].irq = gpio_to_irq(78);
 	omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
 			ARRAY_SIZE(sdp2430_i2c1_boardinfo));
-	omap_pmic_init(2, 100, "twl4030", INT_24XX_SYS_NIRQ,
+	omap_pmic_init(2, 100, "twl4030", 7 + OMAP_INTC_START,
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
index 029ebdf..f8bc860 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -296,8 +296,7 @@ static struct resource am3517_hecc_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= INT_35XX_HECC0_IRQ,
-		.end	= INT_35XX_HECC0_IRQ,
+		.start	= 24 + OMAP_INTC_START,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 57204f8..20fe233 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -42,6 +42,7 @@
 #include <plat/usb.h>
 #include <plat/nand.h>
 #include <plat/gpmc.h>
+#include <plat/serial.h>
 
 #include <mach/am35xx.h>
 
@@ -89,8 +90,7 @@ static struct resource cm_t3517_hecc_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= INT_35XX_HECC0_IRQ,
-		.end	= INT_35XX_HECC0_IRQ,
+		.start	= 24 + OMAP_INTC_START,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 9ceec38..901fa1f 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -16,8 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
-#include <plat/irqs.h>
 
+#include <plat/cpu.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/onenand.h>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5775549..bacb917 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -32,6 +32,8 @@
 #include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
+#include <plat/serial.h>
+
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
 #include <plat/onenand.h>
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 5397209..6e6b175 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -27,7 +27,6 @@
 
 #include "common.h"
 #include <plat/menelaus.h>
-#include <mach/irqs.h>
 #include <plat/mcspi.h>
 #include <plat/onenand.h>
 #include <plat/mmc.h>
@@ -599,7 +598,7 @@ static struct menelaus_platform_data n8x0_menelaus_platform_data __initdata = {
 static struct i2c_board_info __initdata n8x0_i2c_board_info_1[] __initdata = {
 	{
 		I2C_BOARD_INFO("menelaus", 0x72),
-		.irq = INT_24XX_SYS_NIRQ,
+		.irq = 7 + OMAP_INTC_START,
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
index 12411b9..00773a3 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -27,6 +27,7 @@
 #include <plat/gpmc.h>
 #include "common.h"
 #include <plat/onenand.h>
+#include <plat/serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -84,7 +85,7 @@ static struct twl4030_platform_data rm680_twl_data = {
 static void __init rm680_i2c_init(void)
 {
 	omap3_pmic_get_config(&rm680_twl_data, TWL_COMMON_PDATA_USB, 0);
-	omap_pmic_init(1, 2900, "twl5031", INT_34XX_SYS_NIRQ, &rm680_twl_data);
+	omap_pmic_init(1, 2900, "twl5031", 7 + OMAP_INTC_START, &rm680_twl_data);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 }
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e8b6dda..4560490 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1047,7 +1047,7 @@ static int __init rx51_i2c_init(void)
 	rx51_twldata.vdac->constraints.apply_uV = true;
 	rx51_twldata.vdac->constraints.name = "VDAC";
 
-	omap_pmic_init(1, 2200, "twl5030", INT_34XX_SYS_NIRQ, &rx51_twldata);
+	omap_pmic_init(1, 2200, "twl5030", 7 + OMAP_INTC_START, &rx51_twldata);
 	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
 			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_2));
 #if defined(CONFIG_SENSORS_LIS3_I2C) || defined(CONFIG_SENSORS_LIS3_I2C_MODULE)
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index da4679d..4ca16e3 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -20,7 +20,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/irqs.h>
 #include "common.h"
 #include <plat/usb.h>
 
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
index ae5d36b..089024c 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -27,6 +27,7 @@
 
 #include "common.h"
 #include <plat/usb.h>
+#include <plat/serial.h>
 
 #include <mach/board-zoom.h>
 
@@ -279,7 +280,7 @@ static int __init omap_i2c_init(void)
 		codec_data->hs_extmute = 1;
 		codec_data->set_hs_extmute = zoom2_set_hs_extmute;
 	}
-	omap_pmic_init(1, 2400, "twl5030", INT_34XX_SYS_NIRQ, &zoom_twldata);
+	omap_pmic_init(1, 2400, "twl5030", 7 + OMAP_INTC_START, &zoom_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index c187586..013fedc 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -27,6 +27,7 @@
 #include <plat/mcspi.h>
 #include <plat/nand.h>
 
+#include "common.h"
 #include "common-board-devices.h"
 
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 1f65b18..7e60a69 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -31,6 +31,8 @@
 #include <plat/common.h>
 #include <asm/proc-fns.h>
 
+#define OMAP_INTC_START		0
+
 #ifdef CONFIG_SOC_OMAP2420
 extern void omap242x_map_common_io(void);
 #else
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
index 56dfa2d..626e98e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -20,7 +20,6 @@
 #include <linux/platform_data/omap4-keypad.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
@@ -31,6 +30,8 @@
 #include <plat/omap_device.h>
 #include <plat/omap4-keypad.h>
 
+#include "soc.h"
+#include "common.h"
 #include "mux.h"
 #include "control.h"
 #include "devices.h"
@@ -111,7 +112,7 @@ static struct resource omap2cam_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= INT_24XX_CAM_IRQ,
+		.start		= 24 + OMAP_INTC_START,
 		.flags		= IORESOURCE_IRQ,
 	}
 };
@@ -200,7 +201,7 @@ static struct resource omap3isp_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= INT_34XX_CAM_IRQ,
+		.start		= 24 + OMAP_INTC_START,
 		.flags		= IORESOURCE_IRQ,
 	}
 };
@@ -434,14 +435,12 @@ static inline void omap_init_mcspi(void) {}
 #endif
 
 static struct resource omap2_pmu_resource = {
-	.start	= 3,
-	.end	= 3,
+	.start	= 3 + OMAP_INTC_START,
 	.flags	= IORESOURCE_IRQ,
 };
 
 static struct resource omap3_pmu_resource = {
-	.start	= INT_34XX_BENCH_MPU_EMUL,
-	.end	= INT_34XX_BENCH_MPU_EMUL,
+	.start	= 3 + OMAP_INTC_START,
 	.flags	= IORESOURCE_IRQ,
 };
 
@@ -474,7 +473,7 @@ static struct resource omap2_sham_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= INT_24XX_SHA1MD5,
+		.start	= 51 + OMAP_INTC_START,
 		.flags	= IORESOURCE_IRQ,
 	}
 };
@@ -492,7 +491,7 @@ static struct resource omap3_sham_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= INT_34XX_SHA1MD52_IRQ,
+		.start	= 49 + OMAP_INTC_START,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
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
index 39c30d9..68eead8 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -28,8 +28,13 @@
 #include <asm/mach-types.h>
 #include <plat/gpmc.h>
 
+#include <plat/cpu.h>
 #include <plat/sdrc.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
@@ -846,16 +851,16 @@ static int __init gpmc_init(void)
 			l = OMAP2420_GPMC_BASE;
 		else
 			l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = INT_34XX_GPMC_IRQ;
+		gpmc_irq = 20 + OMAP_INTC_START;
 	} else if (cpu_is_omap34xx()) {
 		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = INT_34XX_GPMC_IRQ;
+		gpmc_irq = 20 + OMAP_INTC_START;
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
index 577cb77..219a6e8 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <mach/irqs.h>
 #include <plat/dma.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 1be8bcb..df298d4 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -14,7 +14,9 @@
 #include <linux/platform_device.h>
 
 #include <plat/iommu.h>
-#include <plat/irqs.h>
+
+#include "soc.h"
+#include "common.h"
 
 struct iommu_device {
 	resource_size_t base;
@@ -29,7 +31,7 @@ static int num_iommu_devices;
 static struct iommu_device omap3_devices[] = {
 	{
 		.base = 0x480bd400,
-		.irq = 24,
+		.irq = 24 + OMAP_INTC_START,
 		.pdata = {
 			.name = "isp",
 			.nr_tlb_entries = 8,
@@ -41,7 +43,7 @@ static struct iommu_device omap3_devices[] = {
 #if defined(CONFIG_OMAP_IOMMU_IVA2)
 	{
 		.base = 0x5d000000,
-		.irq = 28,
+		.irq = 28 + OMAP_INTC_START,
 		.pdata = {
 			.name = "iva2",
 			.nr_tlb_entries = 32,
@@ -64,7 +66,7 @@ static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
 static struct iommu_device omap4_devices[] = {
 	{
 		.base = OMAP4_MMU1_BASE,
-		.irq = OMAP44XX_IRQ_DUCATI_MMU,
+		.irq = 100 + OMAP44XX_IRQ_GIC_START,
 		.pdata = {
 			.name = "ducati",
 			.nr_tlb_entries = 32,
@@ -75,7 +77,7 @@ static struct iommu_device omap4_devices[] = {
 	},
 	{
 		.base = OMAP4_MMU2_BASE,
-		.irq = OMAP44XX_IRQ_TESLA_MMU,
+		.irq = 28 + OMAP44XX_IRQ_GIC_START,
 		.pdata = {
 			.name = "tesla",
 			.nr_tlb_entries = 32,
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
index 5b49ebf..1645d3f 100644
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
@@ -161,9 +160,9 @@ static struct omap_hwmod omap2420_dma_system_hwmod = {
 
 /* mailbox */
 static struct omap_hwmod_irq_info omap2420_mailbox_irqs[] = {
-	{ .name = "dsp", .irq = 26 },
-	{ .name = "iva", .irq = 34 },
-	{ .irq = -1 }
+	{ .name = "dsp", .irq = 26 + OMAP_INTC_START, },
+	{ .name = "iva", .irq = 34 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2420_mailbox_hwmod = {
@@ -198,9 +197,9 @@ static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
 
 /* mcbsp1 */
 static struct omap_hwmod_irq_info omap2420_mcbsp1_irqs[] = {
-	{ .name = "tx", .irq = 59 },
-	{ .name = "rx", .irq = 60 },
-	{ .irq = -1 }
+	{ .name = "tx", .irq = 59 + OMAP_INTC_START, },
+	{ .name = "rx", .irq = 60 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2420_mcbsp1_hwmod = {
@@ -224,9 +223,9 @@ static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 
 /* mcbsp2 */
 static struct omap_hwmod_irq_info omap2420_mcbsp2_irqs[] = {
-	{ .name = "tx", .irq = 62 },
-	{ .name = "rx", .irq = 63 },
-	{ .irq = -1 }
+	{ .name = "tx", .irq = 62 + OMAP_INTC_START, },
+	{ .name = "rx", .irq = 63 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2420_mcbsp2_hwmod = {
@@ -264,8 +263,8 @@ static struct omap_hwmod_class omap2420_msdi_hwmod_class = {
 
 /* msdi1 */
 static struct omap_hwmod_irq_info omap2420_msdi1_irqs[] = {
-	{ .irq = 83 },
-	{ .irq = -1 }
+	{ .irq = 83 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap2420_msdi1_sdma_reqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 1fd66f0..23582fc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -13,7 +13,6 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 #include <plat/omap_hwmod.h>
-#include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
@@ -24,6 +23,8 @@
 #include <plat/mmc.h>
 #include <plat/l3_2xxx.h>
 
+#include <plat/hardware.h>
+
 #include "omap_hwmod_common_data.h"
 
 #include "prm-regbits-24xx.h"
@@ -132,8 +133,8 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 
 /* gpio5 */
 static struct omap_hwmod_irq_info omap243x_gpio5_irqs[] = {
-	{ .irq = 33 }, /* INT_24XX_GPIO_BANK5 */
-	{ .irq = -1 }
+	{ .irq = 33 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK5 */
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2430_gpio5_hwmod = {
@@ -172,8 +173,8 @@ static struct omap_hwmod omap2430_dma_system_hwmod = {
 
 /* mailbox */
 static struct omap_hwmod_irq_info omap2430_mailbox_irqs[] = {
-	{ .irq = 26 },
-	{ .irq = -1 }
+	{ .irq = 26 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2430_mailbox_hwmod = {
@@ -194,8 +195,8 @@ static struct omap_hwmod omap2430_mailbox_hwmod = {
 
 /* mcspi3 */
 static struct omap_hwmod_irq_info omap2430_mcspi3_mpu_irqs[] = {
-	{ .irq = 91 },
-	{ .irq = -1 }
+	{ .irq = 91 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap2430_mcspi3_sdma_reqs[] = {
@@ -249,9 +250,9 @@ static struct omap_hwmod_class usbotg_class = {
 /* usb_otg_hs */
 static struct omap_hwmod_irq_info omap2430_usbhsotg_mpu_irqs[] = {
 
-	{ .name = "mc", .irq = 92 },
-	{ .name = "dma", .irq = 93 },
-	{ .irq = -1 }
+	{ .name = "mc", .irq = 92 + OMAP_INTC_START, },
+	{ .name = "dma", .irq = 93 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2430_usbhsotg_hwmod = {
@@ -302,11 +303,11 @@ static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
 
 /* mcbsp1 */
 static struct omap_hwmod_irq_info omap2430_mcbsp1_irqs[] = {
-	{ .name = "tx",		.irq = 59 },
-	{ .name = "rx",		.irq = 60 },
-	{ .name = "ovr",	.irq = 61 },
-	{ .name = "common",	.irq = 64 },
-	{ .irq = -1 }
+	{ .name = "tx",		.irq = 59 + OMAP_INTC_START, },
+	{ .name = "rx",		.irq = 60 + OMAP_INTC_START, },
+	{ .name = "ovr",	.irq = 61 + OMAP_INTC_START, },
+	{ .name = "common",	.irq = 64 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2430_mcbsp1_hwmod = {
@@ -330,10 +331,10 @@ static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 
 /* mcbsp2 */
 static struct omap_hwmod_irq_info omap2430_mcbsp2_irqs[] = {
-	{ .name = "tx",		.irq = 62 },
-	{ .name = "rx",		.irq = 63 },
-	{ .name = "common",	.irq = 16 },
-	{ .irq = -1 }
+	{ .name = "tx",		.irq = 62 + OMAP_INTC_START, },
+	{ .name = "rx",		.irq = 63 + OMAP_INTC_START, },
+	{ .name = "common",	.irq = 16 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2430_mcbsp2_hwmod = {
@@ -357,10 +358,10 @@ static struct omap_hwmod omap2430_mcbsp2_hwmod = {
 
 /* mcbsp3 */
 static struct omap_hwmod_irq_info omap2430_mcbsp3_irqs[] = {
-	{ .name = "tx",		.irq = 89 },
-	{ .name = "rx",		.irq = 90 },
-	{ .name = "common",	.irq = 17 },
-	{ .irq = -1 }
+	{ .name = "tx",		.irq = 89 + OMAP_INTC_START, },
+	{ .name = "rx",		.irq = 90 + OMAP_INTC_START, },
+	{ .name = "common",	.irq = 17 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap2430_mcbsp3_hwmod = {
@@ -384,10 +385,10 @@ static struct omap_hwmod omap2430_mcbsp3_hwmod = {
 
 /* mcbsp4 */
 static struct omap_hwmod_irq_info omap2430_mcbsp4_irqs[] = {
-	{ .name = "tx",		.irq = 54 },
-	{ .name = "rx",		.irq = 55 },
-	{ .name = "common",	.irq = 18 },
-	{ .irq = -1 }
+	{ .name = "tx",		.irq = 54 + OMAP_INTC_START, },
+	{ .name = "rx",		.irq = 55 + OMAP_INTC_START, },
+	{ .name = "common",	.irq = 18 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap2430_mcbsp4_sdma_chs[] = {
@@ -417,10 +418,10 @@ static struct omap_hwmod omap2430_mcbsp4_hwmod = {
 
 /* mcbsp5 */
 static struct omap_hwmod_irq_info omap2430_mcbsp5_irqs[] = {
-	{ .name = "tx",		.irq = 81 },
-	{ .name = "rx",		.irq = 82 },
-	{ .name = "common",	.irq = 19 },
-	{ .irq = -1 }
+	{ .name = "tx",		.irq = 81 + OMAP_INTC_START, },
+	{ .name = "rx",		.irq = 82 + OMAP_INTC_START, },
+	{ .name = "common",	.irq = 19 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap2430_mcbsp5_sdma_chs[] = {
@@ -467,8 +468,8 @@ static struct omap_hwmod_class omap2430_mmc_class = {
 
 /* MMC/SD/SDIO1 */
 static struct omap_hwmod_irq_info omap2430_mmc1_mpu_irqs[] = {
-	{ .irq = 83 },
-	{ .irq = -1 }
+	{ .irq = 83 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap2430_mmc1_sdma_reqs[] = {
@@ -508,8 +509,8 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 
 /* MMC/SD/SDIO2 */
 static struct omap_hwmod_irq_info omap2430_mmc2_mpu_irqs[] = {
-	{ .irq = 86 },
-	{ .irq = -1 }
+	{ .irq = 86 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap2430_mmc2_sdma_reqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 102d76e..bea700e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -15,8 +15,6 @@
 #include <plat/common.h>
 #include <plat/hdq1w.h>
 
-#include <mach/irqs.h>
-
 #include "omap_hwmod_common_data.h"
 
 /* UART */
@@ -182,126 +180,126 @@ struct omap_hwmod_class iva_hwmod_class = {
 /* Common MPU IRQ line data */
 
 struct omap_hwmod_irq_info omap2_timer1_mpu_irqs[] = {
-	{ .irq = 37, },
-	{ .irq = -1 }
+	{ .irq = 37 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer2_mpu_irqs[] = {
-	{ .irq = 38, },
-	{ .irq = -1 }
+	{ .irq = 38 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer3_mpu_irqs[] = {
-	{ .irq = 39, },
-	{ .irq = -1 }
+	{ .irq = 39 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer4_mpu_irqs[] = {
-	{ .irq = 40, },
-	{ .irq = -1 }
+	{ .irq = 40 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer5_mpu_irqs[] = {
-	{ .irq = 41, },
-	{ .irq = -1 }
+	{ .irq = 41 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer6_mpu_irqs[] = {
-	{ .irq = 42, },
-	{ .irq = -1 }
+	{ .irq = 42 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer7_mpu_irqs[] = {
-	{ .irq = 43, },
-	{ .irq = -1 }
+	{ .irq = 43 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer8_mpu_irqs[] = {
-	{ .irq = 44, },
-	{ .irq = -1 }
+	{ .irq = 44 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer9_mpu_irqs[] = {
-	{ .irq = 45, },
-	{ .irq = -1 }
+	{ .irq = 45 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer10_mpu_irqs[] = {
-	{ .irq = 46, },
-	{ .irq = -1 }
+	{ .irq = 46 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_timer11_mpu_irqs[] = {
-	{ .irq = 47, },
-	{ .irq = -1 }
+	{ .irq = 47 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_uart1_mpu_irqs[] = {
-	{ .irq = INT_24XX_UART1_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 72 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_uart2_mpu_irqs[] = {
-	{ .irq = INT_24XX_UART2_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 73 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_uart3_mpu_irqs[] = {
-	{ .irq = INT_24XX_UART3_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 74 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_dispc_irqs[] = {
-	{ .irq = 25 },
-	{ .irq = -1 }
+	{ .irq = 25 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_i2c1_mpu_irqs[] = {
-	{ .irq = INT_24XX_I2C1_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 56 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_i2c2_mpu_irqs[] = {
-	{ .irq = INT_24XX_I2C2_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 57 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_gpio1_irqs[] = {
-	{ .irq = 29 }, /* INT_24XX_GPIO_BANK1 */
-	{ .irq = -1 }
+	{ .irq = 29 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK1 */
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_gpio2_irqs[] = {
-	{ .irq = 30 }, /* INT_24XX_GPIO_BANK2 */
-	{ .irq = -1 }
+	{ .irq = 30 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK2 */
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_gpio3_irqs[] = {
-	{ .irq = 31 }, /* INT_24XX_GPIO_BANK3 */
-	{ .irq = -1 }
+	{ .irq = 31 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK3 */
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_gpio4_irqs[] = {
-	{ .irq = 32 }, /* INT_24XX_GPIO_BANK4 */
-	{ .irq = -1 }
+	{ .irq = 32 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK4 */
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 }, /* INT_24XX_SDMA_IRQ0 */
-	{ .name = "1", .irq = 13 }, /* INT_24XX_SDMA_IRQ1 */
-	{ .name = "2", .irq = 14 }, /* INT_24XX_SDMA_IRQ2 */
-	{ .name = "3", .irq = 15 }, /* INT_24XX_SDMA_IRQ3 */
-	{ .irq = -1 }
+	{ .name = "0", .irq = 12 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ0 */
+	{ .name = "1", .irq = 13 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ1 */
+	{ .name = "2", .irq = 14 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ2 */
+	{ .name = "3", .irq = 15 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ3 */
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_mcspi1_mpu_irqs[] = {
-	{ .irq = 65 },
-	{ .irq = -1 }
+	{ .irq = 65 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_irq_info omap2_mcspi2_mpu_irqs[] = {
-	{ .irq = 66 },
-	{ .irq = -1 }
+	{ .irq = 66 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_class_sysconfig omap2_hdq1w_sysc = {
@@ -320,7 +318,7 @@ struct omap_hwmod_class omap2_hdq1w_class = {
 };
 
 struct omap_hwmod_irq_info omap2_hdq1w_mpu_irqs[] = {
-	{ .irq = 58, },
-	{ .irq = -1 }
+	{ .irq = 58 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index c6416c9..ceb3052 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -15,16 +15,14 @@
 #include <plat/dmtimer.h>
 #include <plat/mcspi.h>
 
-#include <mach/irqs.h>
-
 #include "omap_hwmod_common_data.h"
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
 #include "wd_timer.h"
 
 struct omap_hwmod_irq_info omap2xxx_timer12_mpu_irqs[] = {
-	{ .irq = 48, },
-	{ .irq = -1 }
+	{ .irq = 48 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5820c73..9605e5f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -18,7 +18,6 @@
 #include <linux/platform_data/gpio-omap.h>
 
 #include <plat/omap_hwmod.h>
-#include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
@@ -30,11 +29,13 @@
 #include <plat/mcspi.h>
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
@@ -51,9 +52,9 @@
 
 /* L3 */
 static struct omap_hwmod_irq_info omap3xxx_l3_main_irqs[] = {
-	{ .irq = INT_34XX_L3_DBG_IRQ },
-	{ .irq = INT_34XX_L3_APP_IRQ },
-	{ .irq = -1 }
+	{ .irq = 9 + OMAP_INTC_START, },
+	{ .irq = 10 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_l3_main_hwmod = {
@@ -355,8 +356,8 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 
 /* timer12 */
 static struct omap_hwmod_irq_info omap3xxx_timer12_mpu_irqs[] = {
-	{ .irq = 95, },
-	{ .irq = -1 }
+	{ .irq = 95 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_timer12_hwmod = {
@@ -490,8 +491,8 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 
 /* UART4 */
 static struct omap_hwmod_irq_info uart4_mpu_irqs[] = {
-	{ .irq = INT_36XX_UART4_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 80 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info uart4_sdma_reqs[] = {
@@ -518,8 +519,8 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 };
 
 static struct omap_hwmod_irq_info am35xx_uart4_mpu_irqs[] = {
-	{ .irq = INT_35XX_UART4_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 84 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info am35xx_uart4_sdma_reqs[] = {
@@ -674,8 +675,8 @@ static struct omap_hwmod_class omap3xxx_dsi_hwmod_class = {
 };
 
 static struct omap_hwmod_irq_info omap3xxx_dsi1_irqs[] = {
-	{ .irq = 25 },
-	{ .irq = -1 }
+	{ .irq = 25 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 /* dss_dsi1 */
@@ -804,8 +805,8 @@ static struct omap_i2c_dev_attr i2c3_dev_attr = {
 };
 
 static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
-	{ .irq = INT_34XX_I2C3_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 61 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info i2c3_sdma_reqs[] = {
@@ -963,8 +964,8 @@ static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 
 /* gpio5 */
 static struct omap_hwmod_irq_info omap3xxx_gpio5_irqs[] = {
-	{ .irq = 33 }, /* INT_34XX_GPIO_BANK5 */
-	{ .irq = -1 }
+	{ .irq = 33 + OMAP_INTC_START, }, /* INT_34XX_GPIO_BANK5 */
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
@@ -993,8 +994,8 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 
 /* gpio6 */
 static struct omap_hwmod_irq_info omap3xxx_gpio6_irqs[] = {
-	{ .irq = 34 }, /* INT_34XX_GPIO_BANK6 */
-	{ .irq = -1 }
+	{ .irq = 34 + OMAP_INTC_START, }, /* INT_34XX_GPIO_BANK6 */
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
@@ -1098,10 +1099,10 @@ static struct omap_hwmod_opt_clk mcbsp234_opt_clks[] = {
 
 /* mcbsp1 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp1_irqs[] = {
-	{ .name = "common", .irq = 16 },
-	{ .name = "tx", .irq = 59 },
-	{ .name = "rx", .irq = 60 },
-	{ .irq = -1 }
+	{ .name = "common", .irq = 16 + OMAP_INTC_START, },
+	{ .name = "tx", .irq = 59 + OMAP_INTC_START, },
+	{ .name = "rx", .irq = 60 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
@@ -1125,10 +1126,10 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 
 /* mcbsp2 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp2_irqs[] = {
-	{ .name = "common", .irq = 17 },
-	{ .name = "tx", .irq = 62 },
-	{ .name = "rx", .irq = 63 },
-	{ .irq = -1 }
+	{ .name = "common", .irq = 17 + OMAP_INTC_START, },
+	{ .name = "tx", .irq = 62 + OMAP_INTC_START, },
+	{ .name = "rx", .irq = 63 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
@@ -1157,10 +1158,10 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 
 /* mcbsp3 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp3_irqs[] = {
-	{ .name = "common", .irq = 22 },
-	{ .name = "tx", .irq = 89 },
-	{ .name = "rx", .irq = 90 },
-	{ .irq = -1 }
+	{ .name = "common", .irq = 22 + OMAP_INTC_START, },
+	{ .name = "tx", .irq = 89 + OMAP_INTC_START, },
+	{ .name = "rx", .irq = 90 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
@@ -1189,10 +1190,10 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 
 /* mcbsp4 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp4_irqs[] = {
-	{ .name = "common", .irq = 23 },
-	{ .name = "tx", .irq = 54 },
-	{ .name = "rx", .irq = 55 },
-	{ .irq = -1 }
+	{ .name = "common", .irq = 23 + OMAP_INTC_START, },
+	{ .name = "tx", .irq = 54 + OMAP_INTC_START, },
+	{ .name = "rx", .irq = 55 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap3xxx_mcbsp4_sdma_chs[] = {
@@ -1222,10 +1223,10 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 
 /* mcbsp5 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp5_irqs[] = {
-	{ .name = "common", .irq = 27 },
-	{ .name = "tx", .irq = 81 },
-	{ .name = "rx", .irq = 82 },
-	{ .irq = -1 }
+	{ .name = "common", .irq = 27 + OMAP_INTC_START, },
+	{ .name = "tx", .irq = 81 + OMAP_INTC_START, },
+	{ .name = "rx", .irq = 82 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap3xxx_mcbsp5_sdma_chs[] = {
@@ -1267,8 +1268,8 @@ static struct omap_hwmod_class omap3xxx_mcbsp_sidetone_hwmod_class = {
 
 /* mcbsp2_sidetone */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp2_sidetone_irqs[] = {
-	{ .name = "irq", .irq = 4 },
-	{ .irq = -1 }
+	{ .name = "irq", .irq = 4 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
@@ -1289,8 +1290,8 @@ static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
 
 /* mcbsp3_sidetone */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp3_sidetone_irqs[] = {
-	{ .name = "irq", .irq = 5 },
-	{ .irq = -1 }
+	{ .name = "irq", .irq = 5 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
@@ -1352,8 +1353,8 @@ static struct omap_smartreflex_dev_attr sr1_dev_attr = {
 };
 
 static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
-	{ .irq = 18 },
-	{ .irq = -1 }
+	{ .irq = 18 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap34xx_sr1_hwmod = {
@@ -1397,8 +1398,8 @@ static struct omap_smartreflex_dev_attr sr2_dev_attr = {
 };
 
 static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
-	{ .irq = 19 },
-	{ .irq = -1 }
+	{ .irq = 19 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap34xx_sr2_hwmod = {
@@ -1458,8 +1459,8 @@ static struct omap_hwmod_class omap3xxx_mailbox_hwmod_class = {
 };
 
 static struct omap_hwmod_irq_info omap3xxx_mailbox_irqs[] = {
-	{ .irq = 26 },
-	{ .irq = -1 }
+	{ .irq = 26 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_mailbox_hwmod = {
@@ -1549,8 +1550,8 @@ static struct omap_hwmod omap34xx_mcspi2 = {
 
 /* mcspi3 */
 static struct omap_hwmod_irq_info omap34xx_mcspi3_mpu_irqs[] = {
-	{ .name = "irq", .irq = 91 }, /* 91 */
-	{ .irq = -1 }
+	{ .name = "irq", .irq = 91 + OMAP_INTC_START, }, /* 91 */
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap34xx_mcspi3_sdma_reqs[] = {
@@ -1585,8 +1586,8 @@ static struct omap_hwmod omap34xx_mcspi3 = {
 
 /* mcspi4 */
 static struct omap_hwmod_irq_info omap34xx_mcspi4_mpu_irqs[] = {
-	{ .name = "irq", .irq = INT_34XX_SPI4_IRQ }, /* 48 */
-	{ .irq = -1 }
+	{ .name = "irq", .irq = 48 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap34xx_mcspi4_sdma_reqs[] = {
@@ -1638,9 +1639,9 @@ static struct omap_hwmod_class usbotg_class = {
 /* usb_otg_hs */
 static struct omap_hwmod_irq_info omap3xxx_usbhsotg_mpu_irqs[] = {
 
-	{ .name = "mc", .irq = 92 },
-	{ .name = "dma", .irq = 93 },
-	{ .irq = -1 }
+	{ .name = "mc", .irq = 92 + OMAP_INTC_START, },
+	{ .name = "dma", .irq = 93 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
@@ -1670,8 +1671,8 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 
 /* usb_otg_hs */
 static struct omap_hwmod_irq_info am35xx_usbhsotg_mpu_irqs[] = {
-	{ .name = "mc", .irq = 71 },
-	{ .irq = -1 }
+	{ .name = "mc", .irq = 71 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_class am35xx_usbotg_class = {
@@ -1706,8 +1707,8 @@ static struct omap_hwmod_class omap34xx_mmc_class = {
 /* MMC/SD/SDIO1 */
 
 static struct omap_hwmod_irq_info omap34xx_mmc1_mpu_irqs[] = {
-	{ .irq = 83, },
-	{ .irq = -1 }
+	{ .irq = 83 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap34xx_mmc1_sdma_reqs[] = {
@@ -1773,8 +1774,8 @@ static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod = {
 /* MMC/SD/SDIO2 */
 
 static struct omap_hwmod_irq_info omap34xx_mmc2_mpu_irqs[] = {
-	{ .irq = INT_24XX_MMC2_IRQ, },
-	{ .irq = -1 }
+	{ .irq = 86 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap34xx_mmc2_sdma_reqs[] = {
@@ -1834,8 +1835,8 @@ static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod = {
 /* MMC/SD/SDIO3 */
 
 static struct omap_hwmod_irq_info omap34xx_mmc3_mpu_irqs[] = {
-	{ .irq = 94, },
-	{ .irq = -1 }
+	{ .irq = 94 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_dma_info omap34xx_mmc3_sdma_reqs[] = {
@@ -1893,9 +1894,9 @@ static struct omap_hwmod_opt_clk omap3xxx_usb_host_hs_opt_clks[] = {
 };
 
 static struct omap_hwmod_irq_info omap3xxx_usb_host_hs_irqs[] = {
-	{ .name = "ohci-irq", .irq = 76 },
-	{ .name = "ehci-irq", .irq = 77 },
-	{ .irq = -1 }
+	{ .name = "ohci-irq", .irq = 76 + OMAP_INTC_START, },
+	{ .name = "ehci-irq", .irq = 77 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_usb_host_hs_hwmod = {
@@ -1987,8 +1988,8 @@ static struct omap_hwmod_class omap3xxx_usb_tll_hs_hwmod_class = {
 };
 
 static struct omap_hwmod_irq_info omap3xxx_usb_tll_hs_irqs[] = {
-	{ .name = "tll-irq", .irq = 78 },
-	{ .irq = -1 }
+	{ .name = "tll-irq", .irq = 78 + OMAP_INTC_START, },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
@@ -3214,11 +3215,11 @@ static struct omap_hwmod_ocp_if am35xx_l4_core__mdio = {
 };
 
 static struct omap_hwmod_irq_info am35xx_emac_mpu_irqs[] = {
-	{ .name = "rxthresh",	.irq = INT_35XX_EMAC_C0_RXTHRESH_IRQ },
-	{ .name = "rx_pulse",	.irq = INT_35XX_EMAC_C0_RX_PULSE_IRQ },
-	{ .name = "tx_pulse",	.irq = INT_35XX_EMAC_C0_TX_PULSE_IRQ },
-	{ .name = "misc_pulse",	.irq = INT_35XX_EMAC_C0_MISC_PULSE_IRQ },
-	{ .irq = -1 }
+	{ .name = "rxthresh",	.irq = 67 + OMAP_INTC_START, },
+	{ .name = "rx_pulse",	.irq = 68 + OMAP_INTC_START, },
+	{ .name = "tx_pulse",	.irq = 69 + OMAP_INTC_START },
+	{ .name = "misc_pulse",	.irq = 70 + OMAP_INTC_START },
+	{ .irq = -1 },
 };
 
 static struct omap_hwmod_class am35xx_emac_class = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index e7e8eea..dddb677 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -16,6 +16,7 @@
 
 #include <plat/omap_hwmod.h>
 
+#include "common.h"
 #include "display.h"
 
 /* Common address space across OMAP2xxx */
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
index a0309de..3601763 100644
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
+	.irq			= 11 + OMAP_INTC_START,
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
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
new file mode 100644
index 0000000..40195f1
--- /dev/null
+++ b/arch/arm/mach-omap2/soc.h
@@ -0,0 +1 @@
+#include <plat/cpu.h>
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2ff6d41..3bdaf98 100644
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
+			      OMAP44XX_LOCAL_TWD_BASE, 29 + OMAP_INTC_START);
 #endif
 
 static void __init omap4_timer_init(void)
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index db5ff66..b0384ce 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -26,6 +26,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
+#include <plat/hardware.h>
 #include <plat/i2c.h>
 #include <plat/usb.h>
 
@@ -84,7 +85,7 @@ void __init omap4_pmic_init(const char *pmic_type,
 	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
 	strncpy(omap4_i2c1_board_info[0].type, pmic_type,
 		sizeof(omap4_i2c1_board_info[0].type));
-	omap4_i2c1_board_info[0].irq = OMAP44XX_IRQ_SYS_1N;
+	omap4_i2c1_board_info[0].irq = 7 + OMAP44XX_IRQ_GIC_START;
 	omap4_i2c1_board_info[0].platform_data = pmic_data;
 
 	/* TWL6040 audio IC part */
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 8fe71cf..d109c09 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -1,7 +1,7 @@
 #ifndef __OMAP_PMIC_COMMON__
 #define __OMAP_PMIC_COMMON__
 
-#include <plat/irqs.h>
+#include "common.h"
 
 #define TWL_COMMON_PDATA_USB		(1 << 0)
 #define TWL_COMMON_PDATA_BCI		(1 << 1)
@@ -40,13 +40,13 @@ void omap_pmic_late_init(void);
 static inline void omap2_pmic_init(const char *pmic_type,
 				   struct twl4030_platform_data *pmic_data)
 {
-	omap_pmic_init(2, 2600, pmic_type, INT_24XX_SYS_NIRQ, pmic_data);
+	omap_pmic_init(2, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
 }
 
 static inline void omap3_pmic_init(const char *pmic_type,
 				   struct twl4030_platform_data *pmic_data)
 {
-	omap_pmic_init(1, 2600, pmic_type, INT_34XX_SYS_NIRQ, pmic_data);
+	omap_pmic_init(1, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
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
index 108ab1a..9d49b1f 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -43,6 +43,7 @@
 #include <asm/gpio.h>
 
 #include <plat/dma.h>
+#include <plat/cpu.h>
 
 #define DRIVER_NAME "omap2-onenand"
 
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
index fc671d3..3c39aa8 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -31,6 +31,7 @@
 #include <linux/omapfb.h>
 
 #include <video/omapdss.h>
+#include <plat/cpu.h>
 #include <plat/vram.h>
 #include <plat/vrfb.h>
 
diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index d33c48b..f18e488 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -27,6 +27,8 @@
 
 #include <plat/mcbsp.h>
 
+#include <plat/cpu.h>
+
 #include "mcbsp.h"
 
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index acdd3ef..d0ee71d 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -32,6 +32,7 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+#include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
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
 

