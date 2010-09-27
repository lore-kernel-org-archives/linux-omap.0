From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH RESEND v5 1/5] omap gpmc: enable irq mode in gpmc
Date: Mon, 27 Sep 2010 19:41:46 +0530
Message-ID: <1285596710-25658-2-git-send-email-s-ghorai@ti.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43031 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759221Ab0I0OMJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 10:12:09 -0400
In-Reply-To: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
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
 arch/arm/mach-omap2/gpmc.c                 |   37 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/io.c                   |    2 -
 arch/arm/plat-omap/include/plat/gpmc.h     |    4 +++
 arch/arm/plat-omap/include/plat/irqs.h     |    9 ++++++-
 27 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 8538e41..a047a35 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -144,6 +144,7 @@ static void __init omap_2430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 67b95b5..549cd62 100644
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
index b359c3f..19cb423 100644
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
index 9447644..5fc66eb 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -35,6 +35,7 @@
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/gpmc.h>
 #include "hsmmc.h"
 
 #define ETH_KS8851_IRQ			34
@@ -181,6 +182,7 @@ static void __init omap_4430sdp_init_irq(void)
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
 	gic_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4d0f585..3a12571 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,6 +35,7 @@
 #include <plat/control.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 
@@ -372,6 +373,7 @@ static void __init am3517_evm_init_irq(void)
 
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index c6421a7..10fe693 100644
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
index e10bc10..8c32e34 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -687,6 +687,7 @@ static void __init cm_t35_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index a07086d..8963561 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -449,6 +449,7 @@ static void __init devkit8000_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 3482b99..8dca149 100644
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
index e09bd68..a6790ba 100644
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
index 175f043..6c3e7e0 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -406,6 +406,7 @@ static void __init igep2_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(igep2_config);
 	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 00d9b13..b31d8e1 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -292,6 +292,7 @@ static void __init omap_ldp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 	ldp_init_smsc911x();
 }
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index a3e2b49..c3d842b 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -32,6 +32,7 @@
 #include <plat/onenand.h>
 #include <plat/mmc.h>
 #include <plat/serial.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 
@@ -648,6 +649,7 @@ static void __init n8x0_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 87969c7..3a8bd5c 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -390,6 +390,7 @@ static void __init omap3_beagle_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f76d9c0..f916fbd 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -42,6 +42,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -624,6 +625,7 @@ static void __init omap3_evm_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index dd3af2b..d6d6590 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -45,6 +45,7 @@
 #include <plat/mcspi.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 #include <plat/nand.h>
 
 #include "mux.h"
@@ -604,6 +605,7 @@ static void __init omap3pandora_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index bcd01d2..85b30a2 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -585,6 +585,7 @@ static void __init omap3_stalker_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 663c62d..28e3bf6 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -424,6 +424,7 @@ static void __init omap3_touchbook_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c03d1d5..f4eea61 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -37,6 +37,7 @@
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/gpmc.h>
 #include "hsmmc.h"
 
 
@@ -44,6 +45,7 @@ static void __init omap4_panda_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
 	gic_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4c48436..05d51de 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -415,6 +415,7 @@ static void __init overo_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index a58e8cb..fe71a34 100644
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
index 3ad9ecf..9c7293c 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -20,6 +20,7 @@
 
 #include <plat/common.h>
 #include <plat/board.h>
+#include <plat/gpmc.h>
 
 #include <mach/board-zoom.h>
 
@@ -31,6 +32,7 @@ static void __init omap_zoom2_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 				 mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 6ca0b83..67c88ca 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -21,6 +21,7 @@
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/usb.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
@@ -76,6 +77,7 @@ static void __init omap_zoom_init_irq(void)
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f46933b..9ecb2a7 100644
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
@@ -713,6 +721,31 @@ void __init gpmc_init(void)
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
+	if (request_irq(20, gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base))
+		printk(KERN_ERR "gpmc: irq-%d could not claim: err %d\n",
+							INT_34XX_GPMC_IRQ, irq);
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
+	generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
+
+	return IRQ_HANDLED;
 }
 
 #ifdef CONFIG_ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b9ea70b..da2815f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -30,7 +30,6 @@
 
 #include <plat/sram.h>
 #include <plat/sdrc.h>
-#include <plat/gpmc.h>
 #include <plat/serial.h>
 
 #include "clock2xxx.h"
@@ -349,5 +348,4 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
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
index c01d9f0..ea2a979 100644
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
@@ -409,7 +410,13 @@
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

