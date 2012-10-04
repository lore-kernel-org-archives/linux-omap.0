From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/16] ARM: OMAP: Split plat/serial.h for omap1 and omap2+
Date: Thu, 04 Oct 2012 15:05:06 -0700
Message-ID: <20121004220505.26676.15846.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28366 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751692Ab2JDWFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:05:07 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

For omap1, we'll keep mach/serial.h around for 8250.c hardware
workarounds. For omap2+, we no longer need mach/serial.h and
can make it local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S     |    2 -
 arch/arm/mach-omap1/include/mach/hardware.h        |    2 -
 arch/arm/mach-omap1/include/mach/serial.h          |   53 ++++++++++++++++++++
 arch/arm/mach-omap1/include/mach/uncompress.h      |    2 -
 arch/arm/mach-omap2/board-rm680.c                  |    1 
 arch/arm/mach-omap2/common.h                       |    2 -
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    2 -
 arch/arm/mach-omap2/include/mach/uncompress.h      |    2 -
 arch/arm/mach-omap2/io.c                           |    2 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |    1 
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    1 
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    2 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    1 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 -
 arch/arm/mach-omap2/serial.c                       |    2 -
 arch/arm/mach-omap2/serial.h                       |   11 ----
 18 files changed, 63 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/serial.h
 rename arch/arm/{plat-omap/include/plat/serial.h => mach-omap2/serial.h} (91%)

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 2b36a28..5c1a26c 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -13,7 +13,7 @@
 
 #include <linux/serial_reg.h>
 
-#include <plat/serial.h>
+#include "serial.h"
 
 		.pushsection .data
 omap_uart_phys:	.word	0x0
diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
index 2e60265..2a4eb19 100644
--- a/arch/arm/mach-omap1/include/mach/hardware.h
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -72,7 +72,7 @@ static inline u32 omap_cs3_phys(void)
 
 #endif	/* ifndef __ASSEMBLER__ */
 
-#include <plat/serial.h>
+#include <mach/serial.h>
 
 /*
  * ---------------------------------------------------------------------------
diff --git a/arch/arm/mach-omap1/include/mach/serial.h b/arch/arm/mach-omap1/include/mach/serial.h
new file mode 100644
index 0000000..2ce6a2d
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/serial.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support- Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_ARCH_SERIAL_H
+#define __ASM_ARCH_SERIAL_H
+
+#include <linux/init.h>
+
+/*
+ * Memory entry used for the DEBUG_LL UART configuration, relative to
+ * start of RAM. See also uncompress.h and debug-macro.S.
+ *
+ * Note that using a memory location for storing the UART configuration
+ * has at least two limitations:
+ *
+ * 1. Kernel uncompress code cannot overlap OMAP_UART_INFO as the
+ *    uncompress code could then partially overwrite itself
+ * 2. We assume printascii is called at least once before paging_init,
+ *    and addruart has a chance to read OMAP_UART_INFO
+ */
+#define OMAP_UART_INFO_OFS	0x3ffc
+
+/* OMAP1 serial ports */
+#define OMAP1_UART1_BASE	0xfffb0000
+#define OMAP1_UART2_BASE	0xfffb0800
+#define OMAP1_UART3_BASE	0xfffb9800
+
+#define OMAP_PORT_SHIFT		2
+#define OMAP7XX_PORT_SHIFT	0
+
+#define OMAP1510_BASE_BAUD	(12000000/16)
+#define OMAP16XX_BASE_BAUD	(48000000/16)
+
+/*
+ * DEBUG_LL port encoding stored into the UART1 scratchpad register by
+ * decomp_setup in uncompress.h
+ */
+#define OMAP1UART1		11
+#define OMAP1UART2		12
+#define OMAP1UART3		13
+
+#ifndef __ASSEMBLER__
+extern void omap_serial_init(void);
+#endif
+
+#endif
diff --git a/arch/arm/mach-omap1/include/mach/uncompress.h b/arch/arm/mach-omap1/include/mach/uncompress.h
index e9eb834..ad6fbe7 100644
--- a/arch/arm/mach-omap1/include/mach/uncompress.h
+++ b/arch/arm/mach-omap1/include/mach/uncompress.h
@@ -23,7 +23,7 @@
 #include <asm/memory.h>
 #include <asm/mach-types.h>
 
-#include <plat/serial.h>
+#include "serial.h"
 
 #define MDR1_MODE_MASK			0x07
 
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 4250229..533a851 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -26,7 +26,6 @@
 #include <plat/usb.h>
 #include <plat/gpmc.h>
 #include "common.h"
-#include <plat/serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index d3cd625..3301252 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -35,10 +35,10 @@
 #include <asm/proc-fns.h>
 
 #include <plat/cpu.h>
-#include <plat/serial.h>
 #include "../plat-omap/common.h"
 
 #include "i2c.h"
+#include "serial.h"
 
 #define OMAP_INTC_START		NR_IRQS
 
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 93d10de..4b5cbdf 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -13,7 +13,7 @@
 
 #include <linux/serial_reg.h>
 
-#include <plat/serial.h>
+#include <../mach-omap2/serial.h>
 
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
 
diff --git a/arch/arm/mach-omap2/include/mach/uncompress.h b/arch/arm/mach-omap2/include/mach/uncompress.h
index 226c757..28d1ec0 100644
--- a/arch/arm/mach-omap2/include/mach/uncompress.h
+++ b/arch/arm/mach-omap2/include/mach/uncompress.h
@@ -23,7 +23,7 @@
 #include <asm/memory.h>
 #include <asm/mach-types.h>
 
-#include <plat/serial.h>
+#include <../mach-omap2/serial.h>
 
 #define MDR1_MODE_MASK			0x07
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 614af76..1e0ba6f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -26,7 +26,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/sdrc.h>
-#include <plat/serial.h>
 #include <plat/omap-pm.h>
 #include "omap_hwmod.h"
 #include <plat/dma.h>
@@ -43,6 +42,7 @@
 #include "clock2xxx.h"
 #include "clock3xxx.h"
 #include "clock44xx.h"
+#include "serial.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 3ed44b2..2310dc7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -18,7 +18,6 @@
 
 #include "omap_hwmod.h"
 #include <plat/dma.h>
-#include <plat/serial.h>
 #include <plat/dmtimer.h>
 #include "l3_2xxx.h"
 #include "l4_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 6d997c0..cbd992c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -19,7 +19,6 @@
 
 #include "omap_hwmod.h"
 #include <plat/dma.h>
-#include <plat/serial.h>
 #include <plat/dmtimer.h>
 #include "mmc.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
index b490087..0413dab 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
@@ -14,7 +14,6 @@
 #include <asm/sizes.h>
 
 #include "omap_hwmod.h"
-#include <plat/serial.h>
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index c0390c4..84e084d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
  */
 #include "omap_hwmod.h"
-#include <plat/serial.h>
 #include <plat/dma.h>
 #include "../plat-omap/common.h"
 #include "hdq1w.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index f54714a..47901a5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -14,9 +14,9 @@
 #include <asm/sizes.h>
 
 #include "omap_hwmod.h"
-#include <plat/serial.h>
 #include "l3_2xxx.h"
 #include "l4_2xxx.h"
+#include "serial.h"
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 7e1bc57..0370acf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -9,7 +9,6 @@
  * published by the Free Software Foundation.
  */
 #include "omap_hwmod.h"
-#include <plat/serial.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ac0290d..88e0364 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,7 +21,6 @@
 
 #include "omap_hwmod.h"
 #include <plat/dma.h>
-#include <plat/serial.h>
 #include "l3_3xxx.h"
 #include "l4_3xxx.h"
 #include "mmc.h"
@@ -38,6 +37,7 @@
 #include "cm-regbits-34xx.h"
 #include "i2c.h"
 #include "wd_timer.h"
+#include "serial.h"
 
 /*
  * OMAP3xxx hardware module integration data
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e07772a..777d504 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -33,7 +33,6 @@
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/omap-pm.h>
-#include <plat/serial.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -41,6 +40,7 @@
 #include "prm-regbits-34xx.h"
 #include "control.h"
 #include "mux.h"
+#include "serial.h"
 
 /*
  * NOTE: By default the serial auto_suspend timeout is disabled as it causes
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/mach-omap2/serial.h
similarity index 91%
rename from arch/arm/plat-omap/include/plat/serial.h
rename to arch/arm/mach-omap2/serial.h
index b780470..6a68062 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/mach-omap2/serial.h
@@ -29,11 +29,6 @@
  */
 #define OMAP_UART_INFO_OFS	0x3ffc
 
-/* OMAP1 serial ports */
-#define OMAP1_UART1_BASE	0xfffb0000
-#define OMAP1_UART2_BASE	0xfffb0800
-#define OMAP1_UART3_BASE	0xfffb9800
-
 /* OMAP2 serial ports */
 #define OMAP2_UART1_BASE	0x4806a000
 #define OMAP2_UART2_BASE	0x4806c000
@@ -76,20 +71,14 @@
 #define ZOOM_UART_VIRT		0xfa400000
 
 #define OMAP_PORT_SHIFT		2
-#define OMAP7XX_PORT_SHIFT	0
 #define ZOOM_PORT_SHIFT		1
 
-#define OMAP1510_BASE_BAUD	(12000000/16)
-#define OMAP16XX_BASE_BAUD	(48000000/16)
 #define OMAP24XX_BASE_BAUD	(48000000/16)
 
 /*
  * DEBUG_LL port encoding stored into the UART1 scratchpad register by
  * decomp_setup in uncompress.h
  */
-#define OMAP1UART1		11
-#define OMAP1UART2		12
-#define OMAP1UART3		13
 #define OMAP2UART1		21
 #define OMAP2UART2		22
 #define OMAP2UART3		23

