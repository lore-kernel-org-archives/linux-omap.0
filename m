From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/16] ARM: OMAP1: Move plat/tc.h to mach/tc.h for omap1
Date: Thu, 04 Oct 2012 15:04:45 -0700
Message-ID: <20121004220445.26676.27900.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11144 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751889Ab2JDWEr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:04:47 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-pcmcia@lists.infradead.org, Felipe Balbi <balbi@ti.com>

We cannot keep this in plat as it causes problems
with the ARM single zImage support.

Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-pcmcia@lists.infradead.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-fsample.c         |    2 +-
 arch/arm/mach-omap1/board-h2.c              |    2 +-
 arch/arm/mach-omap1/board-h3.c              |    2 +-
 arch/arm/mach-omap1/board-innovator.c       |    2 +-
 arch/arm/mach-omap1/board-osk.c             |    2 +-
 arch/arm/mach-omap1/board-palmte.c          |    2 +-
 arch/arm/mach-omap1/board-palmtt.c          |    2 +-
 arch/arm/mach-omap1/board-palmz71.c         |    2 +-
 arch/arm/mach-omap1/board-perseus2.c        |    2 +-
 arch/arm/mach-omap1/board-sx1.c             |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c       |    2 +-
 arch/arm/mach-omap1/devices.c               |    2 +-
 arch/arm/mach-omap1/dma.c                   |    2 +-
 arch/arm/mach-omap1/flash.c                 |    2 +-
 arch/arm/mach-omap1/include/mach/hardware.h |    2 +-
 arch/arm/mach-omap1/include/mach/tc.h       |    0 
 arch/arm/mach-omap1/io.c                    |    2 +-
 arch/arm/mach-omap1/pm.c                    |    2 +-
 arch/arm/mach-omap2/board-flash.c           |    1 -
 arch/arm/plat-omap/dma.c                    |   24 ++++++++++++++----------
 drivers/pcmcia/omap_cf.c                    |    2 +-
 21 files changed, 32 insertions(+), 29 deletions(-)
 rename arch/arm/{plat-omap/include/plat/tc.h => mach-omap1/include/mach/tc.h} (100%)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 6f496df..27cf02d 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -27,7 +27,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/mux.h>
 #include <mach/flash.h>
 #include <../plat-omap/fpga.h>
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 376f7f2..7aa1627 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -40,7 +40,7 @@
 
 #include <mach/mux.h>
 #include <plat/dma.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <mach/flash.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index ededdb7..8f0cc6d 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -41,7 +41,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/mux.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <plat/dma.h>
 #include <mach/flash.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 5804da7..06eb4e6 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -34,7 +34,7 @@
 #include <mach/mux.h>
 #include <mach/flash.h>
 #include <../plat-omap/fpga.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <plat/mmc.h>
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 5973945..6dc53da 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -48,7 +48,7 @@
 
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 1c578d5..04edf60 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -36,7 +36,7 @@
 
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <plat/dma.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 9715809..dece125 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -37,7 +37,7 @@
 #include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e311032..5326f0b 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -39,7 +39,7 @@
 #include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
 
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index a1cdeeb..8fe95cf 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -28,7 +28,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/mux.h>
 #include <../plat-omap/fpga.h>
 #include <mach/flash.h>
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 13bf2cc..7e1e929 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -38,7 +38,7 @@
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <mach/irda.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/board-sx1.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index ad75e34..6e5dce1 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -34,7 +34,7 @@
 #include <mach/board-voiceblue.h>
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 726c02c..6faae7f 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -19,7 +19,7 @@
 
 #include <asm/mach/map.h>
 
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 29007fe..5f816db 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -26,7 +26,7 @@
 #include <linux/io.h>
 
 #include <plat/dma.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
index 73ae616..b3fb531 100644
--- a/arch/arm/mach-omap1/flash.c
+++ b/arch/arm/mach-omap1/flash.c
@@ -10,7 +10,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/flash.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
index 84248d2..2e60265 100644
--- a/arch/arm/mach-omap1/include/mach/hardware.h
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -51,7 +51,7 @@ extern void omap_writeb(u8 v, u32 pa);
 extern void omap_writew(u16 v, u32 pa);
 extern void omap_writel(u32 v, u32 pa);
 
-#include <plat/tc.h>
+#include <mach/tc.h>
 
 /* Almost all documentation for chip and board memory maps assumes
  * BM is clear.  Most devel boards have a switch to control booting
diff --git a/arch/arm/plat-omap/include/plat/tc.h b/arch/arm/mach-omap1/include/mach/tc.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/tc.h
rename to arch/arm/mach-omap1/include/mach/tc.h
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 6a5baab..9a10c40 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -17,7 +17,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/mux.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <plat/dma.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 47ec161..a60b7c3 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -52,7 +52,7 @@
 #include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 0cabe61..42c4b4e 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -21,7 +21,6 @@
 #include <plat/gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
-#include <plat/tc.h>
 
 #include "common.h"
 #include "board-flash.h"
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c76ed8b..b0cb83f 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -38,7 +38,6 @@
 
 #include <plat/cpu.h>
 #include <plat/dma.h>
-#include <plat/tc.h>
 
 /*
  * MAX_LOGICAL_DMA_CH_COUNT: the maximum number of logical DMA
@@ -175,6 +174,7 @@ static inline void set_gdma_dev(int req, int dev)
 #define omap_writel(val, reg)	do {} while (0)
 #endif
 
+#ifdef CONFIG_ARCH_OMAP1
 void omap_set_dma_priority(int lch, int dst_port, int priority)
 {
 	unsigned long reg;
@@ -203,18 +203,22 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 		l |= (priority & 0xf) << 8;
 		omap_writel(l, reg);
 	}
+}
+#endif
 
-	if (cpu_class_is_omap2()) {
-		u32 ccr;
+#ifdef CONFIG_ARCH_OMAP2PLUS
+void omap_set_dma_priority(int lch, int dst_port, int priority)
+{
+	u32 ccr;
 
-		ccr = p->dma_read(CCR, lch);
-		if (priority)
-			ccr |= (1 << 6);
-		else
-			ccr &= ~(1 << 6);
-		p->dma_write(ccr, CCR, lch);
-	}
+	ccr = p->dma_read(CCR, lch);
+	if (priority)
+		ccr |= (1 << 6);
+	else
+		ccr &= ~(1 << 6);
+	p->dma_write(ccr, CCR, lch);
 }
+#endif
 EXPORT_SYMBOL(omap_set_dma_priority);
 
 void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index fa74efe..25c4b19 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -25,7 +25,7 @@
 #include <asm/sizes.h>
 
 #include <mach/mux.h>
-#include <plat/tc.h>
+#include <mach/tc.h>
 
 
 /* NOTE:  don't expect this to support many I/O cards.  The 16xx chips have

