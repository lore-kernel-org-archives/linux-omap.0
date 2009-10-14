From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 11/17] OMAP7XX: Update core omap1 files to use omap7xx.h
Date: Wed, 14 Oct 2009 20:51:26 +0100
Message-ID: <3d374d00910141251i26517cb7ve4256847710b7e9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch is part of a series which removes references to omap730 in code
which is shared with omap850, replacing them with references to omap7xx.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/board-fsample.c        |   12 ++++++------
 arch/arm/mach-omap1/board-perseus2.c       |   12 ++++++------
 arch/arm/mach-omap1/clock.c                |    2 +-
 arch/arm/mach-omap1/io.c                   |   12 ++++++------
 arch/arm/plat-omap/include/mach/hardware.h |    2 +-
 arch/arm/plat-omap/include/mach/mux.h      |   14 +++++++-------
 arch/arm/plat-omap/io.c                    |   12 ++++++------
 7 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c
b/arch/arm/mach-omap1/board-fsample.c
index a7ead1b..e53f774 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -309,7 +309,7 @@ static void __init omap_fsample_map_io(void)
 	/*
 	 * Hold GSM Reset until needed
 	 */
-	omap_writew(omap_readw(OMAP730_DSP_M_CTL) & ~1, OMAP730_DSP_M_CTL);
+	omap_writew(omap_readw(OMAP7XX_DSP_M_CTL) & ~1, OMAP7XX_DSP_M_CTL);

 	/*
 	 * UARTs -> done automagically by 8250 driver
@@ -320,21 +320,21 @@ static void __init omap_fsample_map_io(void)
 	 */

 	/* Flash: CS0 timings setup */
-	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_0);
-	omap_writel(0x00000088, OMAP730_FLASH_ACFG_0);
+	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_0);
+	omap_writel(0x00000088, OMAP7XX_FLASH_ACFG_0);

 	/*
 	 * Ethernet support through the debug board
 	 * CS1 timings setup
 	 */
-	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_1);
-	omap_writel(0x00000000, OMAP730_FLASH_ACFG_1);
+	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_1);
+	omap_writel(0x00000000, OMAP7XX_FLASH_ACFG_1);

 	/*
 	 * Configure MPU_EXT_NIRQ IO in IO_CONF9 register,
 	 * It is used as the Ethernet controller interrupt
 	 */
-	omap_writel(omap_readl(OMAP730_IO_CONF_9) & 0x1FFFFFFF, OMAP730_IO_CONF_9);
+	omap_writel(omap_readl(OMAP7XX_IO_CONF_9) & 0x1FFFFFFF, OMAP7XX_IO_CONF_9);
 }

 MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
diff --git a/arch/arm/mach-omap1/board-perseus2.c
b/arch/arm/mach-omap1/board-perseus2.c
index 8340669..ec22838 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -270,7 +270,7 @@ static void __init omap_perseus2_map_io(void)
 	/*
 	 * Hold GSM Reset until needed
 	 */
-	omap_writew(omap_readw(OMAP730_DSP_M_CTL) & ~1, OMAP730_DSP_M_CTL);
+	omap_writew(omap_readw(OMAP7XX_DSP_M_CTL) & ~1, OMAP7XX_DSP_M_CTL);

 	/*
 	 * UARTs -> done automagically by 8250 driver
@@ -281,21 +281,21 @@ static void __init omap_perseus2_map_io(void)
 	 */

 	/* Flash: CS0 timings setup */
-	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_0);
-	omap_writel(0x00000088, OMAP730_FLASH_ACFG_0);
+	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_0);
+	omap_writel(0x00000088, OMAP7XX_FLASH_ACFG_0);

 	/*
 	 * Ethernet support through the debug board
 	 * CS1 timings setup
 	 */
-	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_1);
-	omap_writel(0x00000000, OMAP730_FLASH_ACFG_1);
+	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_1);
+	omap_writel(0x00000000, OMAP7XX_FLASH_ACFG_1);

 	/*
 	 * Configure MPU_EXT_NIRQ IO in IO_CONF9 register,
 	 * It is used as the Ethernet controller interrupt
 	 */
-	omap_writel(omap_readl(OMAP730_IO_CONF_9) & 0x1FFFFFFF, OMAP730_IO_CONF_9);
+	omap_writel(omap_readl(OMAP7XX_IO_CONF_9) & 0x1FFFFFFF, OMAP7XX_IO_CONF_9);
 }

 MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index fcbea61..c24cc28 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -862,7 +862,7 @@ int __init omap1_clk_init(void)

 #if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
 	/* Select slicer output as OMAP input clock */
-	omap_writew(omap_readw(OMAP730_PCC_UPLD_CTRL) & ~0x1, OMAP730_PCC_UPLD_CTRL);
+	omap_writew(omap_readw(OMAP7XX_PCC_UPLD_CTRL) & ~0x1, OMAP7XX_PCC_UPLD_CTRL);
 #endif

 	/* Amstrad Delta wants BCLK high when inactive */
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 19de57f..157d508 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -39,14 +39,14 @@ static struct map_desc omap_io_desc[] __initdata = {
 #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
 static struct map_desc omap730_io_desc[] __initdata = {
 	{
-		.virtual	= OMAP730_DSP_BASE,
-		.pfn		= __phys_to_pfn(OMAP730_DSP_START),
-		.length		= OMAP730_DSP_SIZE,
+		.virtual	= OMAP7XX_DSP_BASE,
+		.pfn		= __phys_to_pfn(OMAP7XX_DSP_START),
+		.length		= OMAP7XX_DSP_SIZE,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= OMAP730_DSPREG_BASE,
-		.pfn		= __phys_to_pfn(OMAP730_DSPREG_START),
-		.length		= OMAP730_DSPREG_SIZE,
+		.virtual	= OMAP7XX_DSPREG_BASE,
+		.pfn		= __phys_to_pfn(OMAP7XX_DSPREG_START),
+		.length		= OMAP7XX_DSPREG_SIZE,
 		.type		= MT_DEVICE
 	}
 };
diff --git a/arch/arm/plat-omap/include/mach/hardware.h
b/arch/arm/plat-omap/include/mach/hardware.h
index 26c1fbf..99c4241 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -280,7 +280,7 @@
  * ---------------------------------------------------------------------------
  */

-#include "omap730.h"
+#include "omap7xx.h"
 #include "omap1510.h"
 #include "omap16xx.h"
 #include "omap24xx.h"
diff --git a/arch/arm/plat-omap/include/mach/mux.h
b/arch/arm/plat-omap/include/mach/mux.h
index 587fb63..66ae302 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -51,13 +51,13 @@
 					.pu_pd_reg = PU_PD_SEL_##reg, \
 					.pu_pd_val = status,

-#define MUX_REG_730(reg, mode_offset, mode) .mux_reg_name =
"OMAP730_IO_CONF_"#reg, \
-					.mux_reg = OMAP730_IO_CONF_##reg, \
+#define MUX_REG_730(reg, mode_offset, mode) .mux_reg_name =
"OMAP7XX_IO_CONF_"#reg, \
+					.mux_reg = OMAP7XX_IO_CONF_##reg, \
 					.mask_offset = mode_offset, \
 					.mask = mode,

-#define PULL_REG_730(reg, bit, status)	.pull_name = "OMAP730_IO_CONF_"#reg, \
-					.pull_reg = OMAP730_IO_CONF_##reg, \
+#define PULL_REG_730(reg, bit, status)	.pull_name = "OMAP7XX_IO_CONF_"#reg, \
+					.pull_reg = OMAP7XX_IO_CONF_##reg, \
 					.pull_bit = bit, \
 					.pull_val = status,

@@ -75,11 +75,11 @@
 					.pu_pd_val = status,

 #define MUX_REG_730(reg, mode_offset, mode) \
-					.mux_reg = OMAP730_IO_CONF_##reg, \
+					.mux_reg = OMAP7XX_IO_CONF_##reg, \
 					.mask_offset = mode_offset, \
 					.mask = mode,

-#define PULL_REG_730(reg, bit, status)	.pull_reg = OMAP730_IO_CONF_##reg, \
+#define PULL_REG_730(reg, bit, status)	.pull_reg = OMAP7XX_IO_CONF_##reg, \
 					.pull_bit = bit, \
 					.pull_val = status,

@@ -99,7 +99,7 @@

 /*
  * OMAP730/850 has a slightly different config for the pin mux.
- * - config regs are the OMAP730_IO_CONF_x regs (see omap730.h) regs and
+ * - config regs are the OMAP7XX_IO_CONF_x regs (see omap730.h) regs and
  *   not the FUNC_MUX_CTRL_x regs from hardware.h
  * - for pull-up/down, only has one enable bit which is is in the same register
  *   as mux config
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index 388fd94..23a205f 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>

-#include <mach/omap730.h>
+#include <mach/omap7xx.h>
 #include <mach/omap1510.h>
 #include <mach/omap16xx.h>
 #include <mach/omap24xx.h>
@@ -34,12 +34,12 @@ void __iomem *omap_ioremap(unsigned long p, size_t
size, unsigned int type)
 			return XLATE(p, OMAP1_IO_PHYS, OMAP1_IO_VIRT);
 	}
 	if (cpu_is_omap7xx()) {
-		if (BETWEEN(p, OMAP730_DSP_BASE, OMAP730_DSP_SIZE))
-			return XLATE(p, OMAP730_DSP_BASE, OMAP730_DSP_START);
+		if (BETWEEN(p, OMAP7XX_DSP_BASE, OMAP7XX_DSP_SIZE))
+			return XLATE(p, OMAP7XX_DSP_BASE, OMAP7XX_DSP_START);

-		if (BETWEEN(p, OMAP730_DSPREG_BASE, OMAP730_DSPREG_SIZE))
-			return XLATE(p, OMAP730_DSPREG_BASE,
-					OMAP730_DSPREG_START);
+		if (BETWEEN(p, OMAP7XX_DSPREG_BASE, OMAP7XX_DSPREG_SIZE))
+			return XLATE(p, OMAP7XX_DSPREG_BASE,
+					OMAP7XX_DSPREG_START);
 	}
 	if (cpu_is_omap15xx()) {
 		if (BETWEEN(p, OMAP1510_DSP_BASE, OMAP1510_DSP_SIZE))
-- 
1.6.5
