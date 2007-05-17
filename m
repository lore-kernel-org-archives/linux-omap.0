From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/7] omap2: add OMAP3430 Clock Management register defines
	to cm.h
Date: Wed, 16 May 2007 18:56:41 -0600
Message-ID: <20070517011702.978830429@pwsan.com>
References: <20070517005638.997832459@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=0003-omap2-add-OMAP3430-Clock-Management-register-define.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add symbolic constants to cm.h for Clock Management registers for the
OMAP3430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm.h |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 48999ce..4c30fae 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -2,7 +2,7 @@
 #define __ARCH_ASM_MACH_OMAP2_CM_H
 
 /*
- * OMAP2 Clock Management (CM) register definitions
+ * OMAP2/3 Clock Management (CM) register definitions
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Copyright (C) 2007 Nokia Corporation
@@ -26,7 +26,10 @@
  * Use cm_{read,write}_reg() with these registers.
  */
 
-/* None currently */
+#define OMAP3430_CM_REVISION		OMAP_CM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP3430_CM_SYSCONFIG		OMAP_CM_REGADDR(OCP_MOD, 0x0010)
+#define OMAP3430_CM_POLCTRL		OMAP_CM_REGADDR(OCP_MOD, 0x009c)
+
 
 /* Clock management global register get/set */
 
@@ -104,6 +107,18 @@ static u32 __attribute__((unused)) cm_read_mod_reg(s16 module, s16 idx)
 /* CM_IDLEST_GFX */
 #define OMAP_ST_GFX					(1 << 0)
 
+#define OMAP3430_CM_CLKEN_PLL				0x0004
+#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
+#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
+#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
+#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
+#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
+#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
+#define OMAP3430_CM_CLKSEL3				CM_CLKSTCTRL
+#define OMAP3430_CM_CLKSTST				0x004c
+#define OMAP3430_CM_CLKSEL2_EMU				0x0050
+#define OMAP3430_CM_CLKSEL3_EMU				0x0054
+
 
 
 #endif
-- 
1.5.1.3

-- 
