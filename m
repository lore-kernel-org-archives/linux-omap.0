From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v6 3/7] omap: gpmc: enable irq mode in gpmc
Date: Fri, 26 Nov 2010 21:04:33 +0530
Message-ID: <1290785677-16005-4-git-send-email-s-ghorai@ti.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46035 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203Ab0KZPey (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Nov 2010 10:34:54 -0500
In-Reply-To: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

add support the irq mode in GPMC.
gpmc_init() function move after omap_init_irq() as it has dependecy on irq.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c        |    1 +
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +
 arch/arm/mach-omap2/board-apollon.c        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c         |    1 +
 arch/arm/mach-omap2/board-devkit8000.c     |    1 +
 arch/arm/mach-omap2/board-generic.c        |    2 +
 arch/arm/mach-omap2/board-h4.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c       |    1 +
 arch/arm/mach-omap2/board-ldp.c            |    1 +
 arch/arm/mach-omap2/board-n8x0.c           |    2 +
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +
 arch/arm/mach-omap2/board-overo.c          |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-zoom2.c          |    2 +
 arch/arm/mach-omap2/board-zoom3.c          |    2 +
 arch/arm/mach-omap2/gpmc.c                 |   39 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/io.c                   |    2 -
 arch/arm/plat-omap/include/plat/gpmc.h     |    4 +++
 arch/arm/plat-omap/include/plat/irqs.h     |    9 +++++-
 27 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index b527f8d..11c89dc 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -145,6 +145,7 @@ static void __init omap_2430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4e3742c..a040165 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -328,6 +328,7 @@ static void __init omap_3430sdp_init_irq(void)
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index bbcf580..17983ed 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -76,6 +76,7 @@ static void __init omap_sdp_init_irq(void)
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index df5a425..8d15604 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -34,6 +34,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/gpmc.h>
 
 #include "hsmmc.h"
 #include "timer-gp.h"
@@ -222,6 +223,7 @@ static void __init omap_4430sdp_init_irq(void)
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
 	gic_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 0739950..460e3d1 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,6 +35,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 #include "control.h"
@@ -392,6 +393,7 @@ static void __init am3517_evm_init_irq(void)
 
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 2c6db1a..8264e7a 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -280,6 +280,7 @@ static void __init omap_apollon_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 	apollon_init_smc91x();
 }
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 63f764e..7c9a834 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -686,6 +686,7 @@ static void __init cm_t35_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 53ac762..f82d3b7 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -447,6 +447,7 @@ static void __init devkit8000_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index b1c2c9a..0b0d2cb 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -29,6 +29,7 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/gpmc.h>
 
 static struct omap_board_config_kernel generic_config[] = {
 };
@@ -39,6 +40,7 @@ static void __init omap_generic_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(generic_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static void __init omap_generic_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 929993b..41b04c4 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -293,6 +293,7 @@ static void __init omap_h4_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 	h4_init_flash();
 }
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..c4de273 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -497,6 +497,7 @@ static void __init igep2_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(igep2_config);
 	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 001fd97..0f66645 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -294,6 +294,7 @@ static void __init omap_ldp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 	ldp_init_smsc911x();
 }
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e823c70..4f7c714 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -33,6 +33,7 @@
 #include <plat/onenand.h>
 #include <plat/mmc.h>
 #include <plat/serial.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 
@@ -641,6 +642,7 @@ static void __init n8x0_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..a83c3f3 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -487,6 +487,7 @@ static void __init omap3_beagle_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b04365c..21cc9e5 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -43,6 +43,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -625,6 +626,7 @@ static void __init omap3_evm_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 89ed1be..e095f1d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -47,6 +47,7 @@
 #include <plat/mcspi.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 #include <plat/nand.h>
 
 #include "mux.h"
@@ -639,6 +640,7 @@ static void __init omap3pandora_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f252721..c07ba77 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -586,6 +586,7 @@ static void __init omap3_stalker_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 41104bb..d549763 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -425,6 +425,7 @@ static void __init omap3_touchbook_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1ecd0a6..a03a021 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -36,6 +36,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/gpmc.h>
 #include "timer-gp.h"
 
 #include "hsmmc.h"
@@ -78,6 +79,7 @@ static void __init omap4_panda_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
 	gic_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 7053bc0..c5fe2b0 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -416,6 +416,7 @@ static void __init overo_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 36f2cf4..3be8729 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -107,6 +107,7 @@ static void __init rx51_init_irq(void)
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	sdrc_params = rx51_get_sdram_timings();
 	omap2_init_common_hw(sdrc_params, sdrc_params);
+	gpmc_init();
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 2992a9f..ab0a05d 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -21,6 +21,7 @@
 
 #include <plat/common.h>
 #include <plat/board.h>
+#include <plat/gpmc.h>
 
 #include <mach/board-zoom.h>
 
@@ -33,6 +34,7 @@ static void __init omap_zoom2_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 				 mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 5adde12..d637d98 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -21,6 +21,7 @@
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/usb.h>
+#include <plat/gpmc.h>
 
 #include "board-flash.h"
 #include "mux.h"
@@ -77,6 +78,7 @@ static void __init omap_zoom_init_irq(void)
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f46933b..cfaf357 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -14,6 +14,7 @@
  */
 #undef DEBUG
 
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -22,12 +23,12 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
 #include <plat/gpmc.h>
 
 #include <plat/sdrc.h>
-
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
@@ -100,6 +101,8 @@ static void __iomem *gpmc_base;
 
 static struct clk *gpmc_l3_clk;
 
+static irqreturn_t gpmc_handle_irq(int irq, void *dev);
+
 static void gpmc_write_reg(int idx, u32 val)
 {
 	__raw_writel(val, gpmc_base + idx);
@@ -487,6 +490,10 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
 	u32 regval = 0;
 
 	switch (cmd) {
+	case GPMC_ENABLE_IRQ:
+		gpmc_write_reg(GPMC_IRQENABLE, wval);
+		break;
+
 	case GPMC_SET_IRQ_STATUS:
 		gpmc_write_reg(GPMC_IRQSTATUS, wval);
 		break;
@@ -670,7 +677,8 @@ static void __init gpmc_mem_init(void)
 
 void __init gpmc_init(void)
 {
-	u32 l;
+	u32 l, irq;
+	int cs;
 	char *ck = NULL;
 
 	if (cpu_is_omap24xx()) {
@@ -713,6 +721,33 @@ void __init gpmc_init(void)
 	l |= (0x02 << 3) | (1 << 0);
 	gpmc_write_reg(GPMC_SYSCONFIG, l);
 	gpmc_mem_init();
+
+	/* initalize the irq_chained */
+	irq = OMAP_GPMC_IRQ_BASE;
+	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
+		set_irq_handler(irq, handle_simple_irq);
+		set_irq_flags(irq, IRQF_VALID);
+		irq++;
+	}
+
+	if (request_irq(INT_34XX_GPMC_IRQ,
+			gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base))
+		printk(KERN_ERR "gpmc: irq-%d could not claim: err %d\n",
+						INT_34XX_GPMC_IRQ, irq);
+}
+
+static irqreturn_t gpmc_handle_irq(int irq, void *dev)
+{
+	u8 cs;
+
+	if (irq != INT_34XX_GPMC_IRQ)
+		return IRQ_HANDLED;
+	/* check cs to invoke the irq */
+	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
+	if (OMAP_GPMC_IRQ_BASE+cs <= OMAP_GPMC_IRQ_END)
+		generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
+
+	return IRQ_HANDLED;
 }
 
 #ifdef CONFIG_ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 40562dd..4d11621 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -30,7 +30,6 @@
 
 #include <plat/sram.h>
 #include <plat/sdrc.h>
-#include <plat/gpmc.h>
 #include <plat/serial.h>
 
 #include "clock2xxx.h"
@@ -351,5 +350,4 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
 	}
-	gpmc_init();
 }
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 9fd99b9..054e704 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -41,6 +41,8 @@
 #define GPMC_NAND_ADDRESS	0x0000000b
 #define GPMC_NAND_DATA		0x0000000c
 
+#define GPMC_ENABLE_IRQ		0x0000000d
+
 /* ECC commands */
 #define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
 #define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
@@ -78,6 +80,8 @@
 #define WR_RD_PIN_MONITORING		0x00600000
 #define GPMC_PREFETCH_STATUS_FIFO_CNT(val)	((val >> 24) & 0x7F)
 #define GPMC_PREFETCH_STATUS_COUNT(val)	(val & 0x00003fff)
+#define GPMC_IRQ_FIFOEVENTENABLE	0x01
+#define GPMC_IRQ_COUNT_EVENT		0x02
 
 /*
  * Note that all values in this struct are in nanoseconds, while
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 65e20a6..b90b9ef 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -318,6 +318,7 @@
 #define INT_34XX_PRCM_MPU_IRQ	11
 #define INT_34XX_MCBSP1_IRQ	16
 #define INT_34XX_MCBSP2_IRQ	17
+#define INT_34XX_GPMC_IRQ	20
 #define INT_34XX_MCBSP3_IRQ	22
 #define INT_34XX_MCBSP4_IRQ	23
 #define INT_34XX_CAM_IRQ	24
@@ -411,7 +412,13 @@
 #define TWL_IRQ_END		TWL6030_IRQ_END
 #endif
 
-#define NR_IRQS			TWL_IRQ_END
+/* GPMC related */
+#define OMAP_GPMC_IRQ_BASE	(TWL_IRQ_END)
+#define OMAP_GPMC_NR_IRQS	7
+#define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
+
+
+#define NR_IRQS			OMAP_GPMC_IRQ_END
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
-- 
1.7.0.4

