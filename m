From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/10] OMAP: control: move plat-omap/control.h to
	mach-omap2/control.h
Date: Fri, 01 Oct 2010 15:35:36 -0600
Message-ID: <20101001213535.1408.50961.stgit@twilight.localdomain>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49855 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208Ab0JAVl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:41:28 -0400
In-Reply-To: <20101001213119.1408.65395.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Cory Maccarrone <darkstar6262@gmail.com>

Only OMAP2+ platforms have the System Control Module (SCM) IP block.
In the past, we've kept the SCM header file in plat-omap.  This has
led to abuse - device drivers including it; includes being added that
create implicit dependencies on OMAP2+ builds; etc.

In response, move the SCM headers into mach-omap2/.

As part of this, remove the direct SCM access from the OMAP UDC
driver.  It was clearly broken.  The UDC code needs an indepth review for
use on OMAP2+ chips.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-omap2/board-3430sdp.c       |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c       |    3 ++-
 arch/arm/mach-omap2/board-am3517evm.c     |    2 +-
 arch/arm/mach-omap2/board-apollon.c       |    2 +-
 arch/arm/mach-omap2/board-cm-t3517.c      |    2 +-
 arch/arm/mach-omap2/board-h4.c            |    2 +-
 arch/arm/mach-omap2/board-ldp.c           |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c    |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c    |    4 ++--
 arch/arm/mach-omap2/clock2420_data.c      |    2 +-
 arch/arm/mach-omap2/clock2430_data.c      |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c      |    2 +-
 arch/arm/mach-omap2/common.c              |    2 +-
 arch/arm/mach-omap2/control.c             |    3 ++-
 arch/arm/mach-omap2/control.h             |   16 ++++++++--------
 arch/arm/mach-omap2/cpuidle34xx.c         |    2 +-
 arch/arm/mach-omap2/devices.c             |    3 +--
 arch/arm/mach-omap2/hsmmc.c               |    2 +-
 arch/arm/mach-omap2/id.c                  |    3 ++-
 arch/arm/mach-omap2/mcbsp.c               |    4 +++-
 arch/arm/mach-omap2/mux.c                 |    8 +++-----
 arch/arm/mach-omap2/pm24xx.c              |    2 +-
 arch/arm/mach-omap2/pm34xx.c              |    2 +-
 arch/arm/mach-omap2/prcm.c                |    2 +-
 arch/arm/mach-omap2/serial.c              |    2 +-
 arch/arm/mach-omap2/sleep34xx.S           |    2 +-
 arch/arm/mach-omap2/usb-fs.c              |    6 +++---
 arch/arm/plat-omap/mcbsp.c                |    1 -
 drivers/usb/gadget/omap_udc.c             |   18 ++++--------------
 30 files changed, 49 insertions(+), 58 deletions(-)
 rename arch/arm/{plat-omap/include/plat/control.h => mach-omap2/control.h} (97%)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 3eb9839..d3793a3 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -39,7 +39,6 @@
 #include <plat/gpmc.h>
 #include <plat/display.h>
 
-#include <plat/control.h>
 #include <plat/gpmc-smc91x.h>
 
 #include <mach/board-flash.h>
@@ -48,6 +47,7 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
 #include "pm.h"
+#include "control.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9f75dc2..e454737 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -32,11 +32,12 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+
 #include "hsmmc.h"
+#include "control.h"
 
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4d0f585..64e9e22 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -32,11 +32,11 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/control.h>
 #include <plat/usb.h>
 #include <plat/display.h>
 
 #include "mux.h"
+#include "control.h"
 
 #define AM35XX_EVM_PHY_MASK		(0xF)
 #define AM35XX_EVM_MDIO_FREQUENCY	(1000000)
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index c6421a7..102719c 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -39,9 +39,9 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
-#include <plat/control.h>
 
 #include "mux.h"
+#include "control.h"
 
 /* LED & Switch macros */
 #define LED0_GPIO13		13
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 1115b8a..c49319f 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -40,7 +40,6 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/control.h>
 #include <plat/usb.h>
 #include <plat/nand.h>
 #include <plat/gpmc.h>
@@ -48,6 +47,7 @@
 #include <mach/am35xx.h>
 
 #include "mux.h"
+#include "control.h"
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 static struct gpio_led cm_t3517_leds[] = {
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index e09bd68..08492a3 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -31,7 +31,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/control.h>
 #include <mach/gpio.h>
 #include <plat/usb.h>
 #include <plat/board.h>
@@ -42,6 +41,7 @@
 #include <plat/gpmc.h>
 
 #include "mux.h"
+#include "control.h"
 
 #define H4_FLASH_CS	0
 #define H4_SMC91X_CS	1
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 58698e3..da56324 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -42,11 +42,11 @@
 #include <mach/board-zoom.h>
 
 #include <asm/delay.h>
-#include <plat/control.h>
 #include <plat/usb.h>
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "control.h"
 
 #define LDP_SMSC911X_CS		1
 #define LDP_SMSC911X_GPIO	152
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 4c045cf..da8943c 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -35,6 +35,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "control.h"
 
 #include <plat/mux.h>
 #include <plat/board.h>
@@ -43,7 +44,6 @@
 #include <plat/gpmc.h>
 #include <plat/timer-gp.h>
 #include <plat/sdrc.h>
-#include <plat/control.h>
 
 #define OMAP3LOGIC_SMSC911X_CS			1
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index aa8296e..c8df890 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -34,12 +34,12 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
-#include "hsmmc.h"
 
+#include "hsmmc.h"
+#include "control.h"
 
 static struct gpio_led gpio_leds[] = {
 	{
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 7086fe4..21f8562 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -18,7 +18,6 @@
 #include <linux/list.h>
 
 #include <plat/clkdev_omap.h>
-#include <plat/control.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
@@ -28,6 +27,7 @@
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
+#include "control.h"
 
 #define OMAP_CM_REGADDR                 OMAP2420_CM_REGADDR
 
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 4548319..e32afcb 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -18,7 +18,6 @@
 #include <linux/list.h>
 
 #include <plat/clkdev_omap.h>
-#include <plat/control.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
@@ -28,6 +27,7 @@
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
+#include "control.h"
 
 #define OMAP_CM_REGADDR			OMAP2430_CM_REGADDR
 
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index accbcf3..9b8aadf 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -20,7 +20,6 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
-#include <plat/control.h>
 #include <plat/clkdev_omap.h>
 
 #include "clock.h"
@@ -33,6 +32,7 @@
 #include "cm-regbits-34xx.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
+#include "control.h"
 
 /*
  * clocks
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 67fac44..1599836 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -26,7 +26,6 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
-#include <plat/control.h>
 #include <plat/clkdev_omap.h>
 
 #include "clock.h"
@@ -35,6 +34,7 @@
 #include "cm-regbits-44xx.h"
 #include "prm.h"
 #include "prm-regbits-44xx.h"
+#include "control.h"
 
 /* Root clocks */
 
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 4e0469d..caa42b9 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -20,12 +20,12 @@
 
 #include <plat/common.h>
 #include <plat/board.h>
-#include <plat/control.h>
 #include <plat/mux.h>
 
 #include <plat/clock.h>
 
 #include "sdrc.h"
+#include "control.h"
 
 /* Global address base setup code */
 
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 8b3c469..495cd05 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -16,13 +16,14 @@
 #include <linux/io.h>
 
 #include <plat/common.h>
-#include <plat/control.h>
 #include <plat/sdrc.h>
+
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
 #include "cm.h"
 #include "prm.h"
 #include "sdrc.h"
+#include "control.h"
 
 static void __iomem *omap2_ctrl_base;
 static void __iomem *omap4_ctrl_pad_base;
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/mach-omap2/control.h
similarity index 97%
rename from arch/arm/plat-omap/include/plat/control.h
rename to arch/arm/mach-omap2/control.h
index 54b0c35..b6c6b7c 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -1,10 +1,10 @@
 /*
- * arch/arm/plat-omap/include/mach/control.h
+ * arch/arm/mach-omap2/control.h
  *
  * OMAP2/3/4 System Control Module definitions
  *
- * Copyright (C) 2007-2009 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2010 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -13,8 +13,8 @@
  * the Free Software Foundation.
  */
 
-#ifndef __ASM_ARCH_CONTROL_H
-#define __ASM_ARCH_CONTROL_H
+#ifndef __ARCH_ARM_MACH_OMAP2_CONTROL_H
+#define __ARCH_ARM_MACH_OMAP2_CONTROL_H
 
 #include <mach/io.h>
 #include <mach/ctrl_module_core_44xx.h>
@@ -321,12 +321,12 @@
 #define		FEAT_L2CACHE_256KB	3
 
 #define OMAP3_ISP_SHIFT			5
-#define OMAP3_ISP_MASK			(1<< OMAP3_ISP_SHIFT)
+#define OMAP3_ISP_MASK			(1 << OMAP3_ISP_SHIFT)
 #define		FEAT_ISP		0
 #define		FEAT_ISP_NONE		1
 
 #define OMAP3_NEON_SHIFT		4
-#define OMAP3_NEON_MASK			(1<< OMAP3_NEON_SHIFT)
+#define OMAP3_NEON_MASK			(1 << OMAP3_NEON_SHIFT)
 #define		FEAT_NEON		0
 #define		FEAT_NEON_NONE		1
 
@@ -364,5 +364,5 @@ extern void omap3_control_restore_context(void);
 #endif
 #endif	/* __ASSEMBLY__ */
 
-#endif /* __ASM_ARCH_CONTROL_H */
+#endif /* __ARCH_ARM_MACH_OMAP2_CONTROL_H */
 
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 8ea012e..61a3523 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -29,10 +29,10 @@
 #include <plat/irqs.h>
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
-#include <plat/control.h>
 #include <plat/serial.h>
 
 #include "pm.h"
+#include "control.h"
 
 #ifdef CONFIG_CPU_IDLE
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9bd4b34..4872bce 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -9,7 +9,6 @@
  * (at your option) any later version.
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -22,7 +21,6 @@
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
 
-#include <plat/control.h>
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <mach/gpio.h>
@@ -30,6 +28,7 @@
 #include <plat/dma.h>
 
 #include "mux.h"
+#include "control.h"
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 5c5cd5e..47644b9 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -14,11 +14,11 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <mach/hardware.h>
-#include <plat/control.h>
 #include <plat/mmc.h>
 #include <plat/omap-pm.h>
 
 #include "hsmmc.h"
+#include "control.h"
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 04a2fa2..5f9086c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -22,11 +22,12 @@
 #include <asm/cputype.h>
 
 #include <plat/common.h>
-#include <plat/control.h>
 #include <plat/cpu.h>
 
 #include <mach/id.h>
 
+#include "control.h"
+
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 51abced..eba9fa1 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -22,7 +22,9 @@
 #include <plat/dma.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
-#include <plat/control.h>
+
+#include "control.h"
+
 
 /* McBSP internal signal muxing functions */
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index e33740c..074536a 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -23,12 +23,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  */
-#include <linux/module.h>
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -36,8 +35,7 @@
 
 #include <asm/system.h>
 
-#include <plat/control.h>
-
+#include "control.h"
 #include "mux.h"
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 6aeedea..c1bceec 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -38,7 +38,6 @@
 #include <mach/irqs.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
-#include <plat/control.h>
 #include <plat/dma.h>
 #include <plat/board.h>
 
@@ -48,6 +47,7 @@
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 #include "pm.h"
+#include "control.h"
 
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d2b940c..7b71813 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -32,7 +32,6 @@
 #include <plat/sram.h>
 #include <plat/clockdomain.h>
 #include <plat/powerdomain.h>
-#include <plat/control.h>
 #include <plat/serial.h>
 #include <plat/sdrc.h>
 #include <plat/prcm.h>
@@ -48,6 +47,7 @@
 #include "prm.h"
 #include "pm.h"
 #include "sdrc.h"
+#include "control.h"
 
 /* Scratchpad offsets */
 #define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index d4388d3..16235c6 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -26,7 +26,6 @@
 #include <plat/common.h>
 #include <plat/prcm.h>
 #include <plat/irqs.h>
-#include <plat/control.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
@@ -34,6 +33,7 @@
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-44xx.h"
+#include "control.h"
 
 static void __iomem *prm_base;
 static void __iomem *cm_base;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 566e991..4ec9c6a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -28,11 +28,11 @@
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/clock.h>
-#include <plat/control.h>
 
 #include "prm.h"
 #include "pm.h"
 #include "prm-regbits-34xx.h"
+#include "control.h"
 
 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index ba53191..2fb205a 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -27,11 +27,11 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <mach/io.h>
-#include <plat/control.h>
 
 #include "cm.h"
 #include "prm.h"
 #include "sdrc.h"
+#include "control.h"
 
 #define SDRC_SCRATCHPAD_SEM_V	0xfa00291c
 
diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.c
index a216d88..1481078 100644
--- a/arch/arm/mach-omap2/usb-fs.c
+++ b/arch/arm/mach-omap2/usb-fs.c
@@ -29,18 +29,18 @@
 
 #include <asm/irq.h>
 
-#include <plat/control.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 
+#include "control.h"
+#include "mux.h"
+
 #define INT_USB_IRQ_GEN		INT_24XX_USB_IRQ_GEN
 #define INT_USB_IRQ_NISO	INT_24XX_USB_IRQ_NISO
 #define INT_USB_IRQ_ISO		INT_24XX_USB_IRQ_ISO
 #define INT_USB_IRQ_HGEN	INT_24XX_USB_IRQ_HGEN
 #define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
 
-#include "mux.h"
-
 #if defined(CONFIG_ARCH_OMAP2)
 
 #ifdef	CONFIG_USB_GADGET_OMAP
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 49bebbf..be59325 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -27,7 +27,6 @@
 
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
-#include <plat/control.h>
 
 #include "../mach-omap2/cm-regbits-34xx.h"
 
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index f81e4f0..7f472a5 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -54,7 +54,6 @@
 
 #include <plat/dma.h>
 #include <plat/usb.h>
-#include <plat/control.h>
 
 #include "omap_udc.h"
 
@@ -2309,21 +2308,12 @@ static char *trx_mode(unsigned m, int enabled)
 static int proc_otg_show(struct seq_file *s)
 {
 	u32		tmp;
-	u32		trans;
-	char		*ctrl_name;
+	u32		trans = 0;
+	char		*ctrl_name = "(UNKNOWN)";
 
+	/* XXX This needs major revision for OMAP2+ */
 	tmp = omap_readl(OTG_REV);
-	if (cpu_is_omap24xx()) {
-		/*
-		 * REVISIT: Not clear how this works on OMAP2.  trans
-		 * is ANDed to produce bits 7 and 8, which might make
-		 * sense for USB_TRANSCEIVER_CTRL on OMAP1,
-		 * but with CONTROL_DEVCONF, these bits have something to
-		 * do with the frame adjustment counter and McBSP2.
-		 */
-		ctrl_name = "control_devconf";
-		trans = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-	} else {
+	if (cpu_class_is_omap1()) {
 		ctrl_name = "tranceiver_ctrl";
 		trans = omap_readw(USB_TRANSCEIVER_CTRL);
 	}


