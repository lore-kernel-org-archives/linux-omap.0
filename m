From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/7] omap2: add OMAP3430 modules to prcm_common.h
Date: Fri, 25 May 2007 02:31:46 -0600
Message-ID: <20070525083243.149866061@pwsan.com>
References: <20070525083145.236366049@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0001-omap2-add-OMAP3430-modules-to-prcm_common.h.patch
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

Add 3430-specific module offset defines to prcm_common.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm_common.h |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm_common.h b/arch/arm/mach-omap2/prcm_common.h
index 5220b05..d2e1bfc 100644
--- a/arch/arm/mach-omap2/prcm_common.h
+++ b/arch/arm/mach-omap2/prcm_common.h
@@ -2,7 +2,7 @@
 #define __ARCH_ASM_MACH_OMAP2_PRCM_COMMON_H
 
 /*
- * OMAP2 PRCM base and module definitions
+ * OMAP2/3 PRCM base and module definitions
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Copyright (C) 2007 Nokia Corporation
@@ -32,6 +32,16 @@
 
 #define OMAP2430_MDM_MOD				0xc00
 
+/* IVA2 module is < base on 3430 */
+#define OMAP3430_IVA2_MOD				-0x800
+#define OMAP3430_CCR_MOD				PLL_MOD
+#define OMAP3430_DSS_MOD				0x600
+#define OMAP3430_CAM_MOD				0x700
+#define OMAP3430_PER_MOD				0x800
+#define OMAP3430_EMU_MOD				0x900
+#define OMAP3430_GR_MOD					0xa00
+#define OMAP3430_NEON_MOD				0xb00
+
 
 /* 24XX register bits shared between CM & PRM registers */
 
-- 
1.5.1.3

-- 
