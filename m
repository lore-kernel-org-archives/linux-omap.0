From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH RESEND v8 3/7] omap: gpmc: enable irq mode in gpmc
Date: Wed, 19 Jan 2011 18:54:59 +0530
Message-ID: <1295443503-14515-4-git-send-email-s-ghorai@ti.com>
References: <1295443503-14515-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35324 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab1ASNZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 08:25:19 -0500
In-Reply-To: <1295443503-14515-1-git-send-email-s-ghorai@ti.com>
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
 arch/arm/mach-omap2/board-zoom.c           |    2 +
 arch/arm/mach-omap2/gpmc.c                 |   39 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/io.c                   |    3 --
 arch/arm/plat-omap/include/plat/gpmc.h     |    4 +++
 arch/arm/plat-omap/include/plat/irqs.h     |    9 +++++-
 26 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index e066177..527374f 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -146,6 +146,7 @@ static void __init omap_2430sdp_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 8fb5f43..8304d16 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -335,6 +335,7 @@ static void __init omap_3430sdp_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static int sdp3430_batt_table[] = {
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index b4ca7fc..befebde 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -78,6 +78,7 @@ static void __init omap_sdp_init_irq(void)
 	omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
 				  h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 07d1b20..2c125ab 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -35,6 +35,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -249,6 +250,7 @@ static void __init omap_4430sdp_init_irq(void)
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
 	gic_init_irq();
+	gpmc_init();
 }
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 10d60b7..2d87087 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,6 +35,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 #include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
@@ -403,6 +404,7 @@ static void __init am3517_evm_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 9f55b68..09f6322 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -281,6 +281,7 @@ static void __init omap_apollon_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static void __init apollon_led_init(void)
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index dac1416..8aca46f 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -692,6 +692,7 @@ static void __init cm_t35_init_irq(void)
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static struct omap_board_mux board_mux[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 00bb1fc..27ae379 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -458,6 +458,7 @@ static void __init devkit8000_init_irq(void)
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 0e3d81e..d2ba70c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -29,6 +29,7 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/gpmc.h>
 
 static struct omap_board_config_kernel generic_config[] = {
 };
@@ -40,6 +41,7 @@ static void __init omap_generic_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static void __init omap_generic_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 25cc9da..2ca224e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -297,6 +297,7 @@ static void __init omap_h4_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 	h4_init_flash();
 }
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3be85a1..bf92442 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -531,6 +531,7 @@ static void __init igep2_init_irq(void)
 	omap2_init_common_devices(m65kxxxxam_sdrc_params,
 				  m65kxxxxam_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static struct twl4030_codec_audio_data igep2_audio_data = {
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d986d32..66fed88 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -295,6 +295,7 @@ static void __init omap_ldp_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static struct twl4030_usb_data ldp_usb_data = {
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index f396756..f4613c3 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -33,6 +33,7 @@
 #include <plat/onenand.h>
 #include <plat/mmc.h>
 #include <plat/serial.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 
@@ -633,6 +634,7 @@ static void __init n8x0_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 46d814a..e2db779 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -542,6 +542,7 @@ static void __init omap3_beagle_init_irq(void)
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 323c380..47397f3 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -43,6 +43,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 #include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
@@ -632,6 +633,7 @@ static void __init omap3_evm_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 0b34bed..717d33c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -47,6 +47,7 @@
 #include <plat/mcspi.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/gpmc.h>
 #include <plat/nand.h>
 
 #include "mux.h"
@@ -640,6 +641,7 @@ static void __init omap3pandora_init_irq(void)
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static void __init pandora_wl1251_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 2a2dad4..91c4ba6 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -598,6 +598,7 @@ static void __init omap3_stalker_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index db1f74f..19167f5 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -424,6 +424,7 @@ static void __init omap3_touchbook_init_irq(void)
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e001a04..226affb 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -37,6 +37,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/gpmc.h>
 #include "timer-gp.h"
 
 #include "hsmmc.h"
@@ -81,6 +82,7 @@ static void __init omap4_panda_init_irq(void)
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 	gic_init_irq();
+	gpmc_init();
 }
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index cb26e5d..05784ff 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -417,6 +417,7 @@ static void __init overo_init_irq(void)
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 }
 
 static struct platform_device *overo_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index f53fc55..0f37e20 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -109,6 +109,7 @@ static void __init rx51_init_irq(void)
 	sdrc_params = nokia_get_sdram_timings();
 	omap2_init_common_devices(sdrc_params, sdrc_params);
 	omap_init_irq();
+	gpmc_init();
 }
 
 extern void __init rx51_peripherals_init(void);
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 0242611..11ef6f5 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -24,6 +24,7 @@
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/usb.h>
+#include <plat/gpmc.h>
 
 #include <mach/board-zoom.h>
 
@@ -45,6 +46,7 @@ static void __init omap_zoom_init_irq(void)
 					  h8mbx00u0mer0em_sdrc_params);
 
 	omap_init_irq();
+	gpmc_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1b7b3e7..b198598 100644
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
@@ -497,6 +500,10 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
 	u32 regval = 0;
 
 	switch (cmd) {
+	case GPMC_ENABLE_IRQ:
+		gpmc_write_reg(GPMC_IRQENABLE, wval);
+		break;
+
 	case GPMC_SET_IRQ_STATUS:
 		gpmc_write_reg(GPMC_IRQSTATUS, wval);
 		break;
@@ -680,7 +687,8 @@ static void __init gpmc_mem_init(void)
 
 void __init gpmc_init(void)
 {
-	u32 l;
+	u32 l, irq;
+	int cs;
 	char *ck = NULL;
 
 	if (cpu_is_omap24xx()) {
@@ -723,6 +731,33 @@ void __init gpmc_init(void)
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
+		pr_err("gpmc: irq-%d could not claim: err %d\n",
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
index e66687b..0331ab0 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -30,7 +30,6 @@
 
 #include <plat/sram.h>
 #include <plat/sdrc.h>
-#include <plat/gpmc.h>
 #include <plat/serial.h>
 
 #include "clock2xxx.h"
@@ -408,8 +407,6 @@ void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
 	}
-	gpmc_init();
-
 	omap_irq_base_init();
 }
 
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 85ded59..ffd2a24 100644
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
  * Note that all values in this struct are in nanoseconds except sync_clk
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 2910de9..1b91168 100644
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

