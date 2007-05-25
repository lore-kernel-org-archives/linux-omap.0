From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/7] omap2: add OMAP3430 base defines
Date: Fri, 25 May 2007 02:31:52 -0600
Message-ID: <20070525083243.819445302@pwsan.com>
References: <20070525083145.236366049@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0007-omap2-add-OMAP3430-base-defines.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add symbolic constants for OMAP3430 base addresses; include that file
in hardware.h.  Remove #error in omap24xx.h on unknown architecture
type.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 include/asm-arm/arch-omap/hardware.h |    1 
 include/asm-arm/arch-omap/omap24xx.h |    3 --
 include/asm-arm/arch-omap/omap34xx.h |   44 +++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 include/asm-arm/arch-omap/omap34xx.h

Index: linux-omap/include/asm-arm/arch-omap/hardware.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/hardware.h
+++ linux-omap/include/asm-arm/arch-omap/hardware.h
@@ -285,6 +285,7 @@
 #include "omap1510.h"
 #include "omap24xx.h"
 #include "omap16xx.h"
+#include "omap34xx.h"
 
 #ifndef __ASSEMBLER__
 
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h
@@ -51,7 +51,6 @@
 /* Mailbox */
 #define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)
 
-
 #if defined(CONFIG_ARCH_OMAP2420)
 
 #define OMAP2_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE
@@ -76,8 +75,6 @@
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
 
-#else
-#error "Unknown architecture"
 #endif
 
 #endif /* __ASM_ARCH_OMAP24XX_H */
Index: linux-omap/include/asm-arm/arch-omap/omap34xx.h
===================================================================
--- /dev/null
+++ linux-omap/include/asm-arm/arch-omap/omap34xx.h
@@ -0,0 +1,44 @@
+#ifndef __ASM_ARCH_OMAP34XX_H
+#define __ASM_ARCH_OMAP34XX_H
+
+/*
+ * Please place only base defines here and put the rest in device
+ * specific headers.
+ */
+
+#define OMAP3430_32KSYNCT_BASE	0x48320000
+#define OMAP3430_CM_BASE	0x48004800
+#define OMAP3430_PRM_BASE	0x48306800
+#define OMAP343X_SMS_BASE	0x6C000000
+#define OMAP343X_SDRC_BASE	0x6D000000
+#define OMAP34XX_GPMC_BASE	0x6E000000
+#define OMAP3430_SCM_BASE	0x48002000
+#define OMAP3430_CTRL_BASE	OMAP3430_SCM_BASE
+
+#define OMAP34XX_IC_BASE	0x48200000
+#define OMAP34XX_IVA_INTC_BASE	0x40000000
+#define IRQ_SIR_IRQ		0x0040
+
+
+#if defined(CONFIG_ARCH_OMAP3430)
+
+#define OMAP2_32KSYNCT_BASE	OMAP3430_32KSYNCT_BASE
+#define OMAP2_CM_BASE		OMAP3430_CM_BASE
+#define OMAP2_PRM_BASE		OMAP3430_PRM_BASE
+#define OMAP2_SDRC_BASE		OMAP343X_SDRC_BASE
+#define OMAP2_SMS_BASE		OMAP343X_SMS_BASE
+#define OMAP2_L4_BASE		L4_34XX_BASE
+#define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP34XX_IC_BASE)
+#define OMAP2_CTRL_BASE		OMAP3430_CTRL_BASE
+
+#endif
+
+
+#define OMAP34XX_DSP_BASE	0x58000000
+#define OMAP34XX_DSP_MEM_BASE	(OMAP34XX_DSP_BASE + 0x0)
+#define OMAP34XX_DSP_IPI_BASE	(OMAP34XX_DSP_BASE + 0x1000000)
+#define OMAP34XX_DSP_MMU_BASE	(OMAP34XX_DSP_BASE + 0x2000000)
+
+
+#endif /* __ASM_ARCH_OMAP34XX_H */
+

-- 
