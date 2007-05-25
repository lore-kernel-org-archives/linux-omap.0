From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/18] omap2: add OMAP24XX and OMAP2/3 modules to
	prcm_common.h
Date: Fri, 25 May 2007 02:23:23 -0600
Message-ID: <20070525082501.235223363@pwsan.com>
References: <20070525082322.168056647@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0001-omap2-add-OMAP24XX-and-OMAP2-3-modules-to-prcm_comm.patch
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

Add 24XX-specific module offset defines to prcm_common.h.  Also add
module offsets that are shared between OMAP2/3.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm_common.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prcm_common.h

diff --git a/arch/arm/mach-omap2/prcm_common.h b/arch/arm/mach-omap2/prcm_common.h
new file mode 100644
index 0000000..6275cae
--- /dev/null
+++ b/arch/arm/mach-omap2/prcm_common.h
@@ -0,0 +1,37 @@
+#ifndef __ARCH_ASM_MACH_OMAP2_PRCM_COMMON_H
+#define __ARCH_ASM_MACH_OMAP2_PRCM_COMMON_H
+
+/*
+ * OMAP2 PRCM base and module definitions
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+/* Module offsets from both CM_BASE & PRM_BASE */
+
+/* Offsets that are the same on 24xx and 34xx */
+/* Technically OCP_MOD is 34xx only, and PLL_MOD is CCR_MOD on 3430 */
+#define OCP_MOD						0x000
+#define MPU_MOD						0x100
+#define CORE_MOD					0x200
+#define GFX_MOD						0x300
+#define WKUP_MOD					0x400
+#define PLL_MOD						0x500
+
+
+/* Chip-specific module offsets */
+#define OMAP24XX_DSP_MOD				0x800
+
+#define OMAP2430_MDM_MOD				0xc00
+
+
+#endif
+
-- 
1.5.1.3

-- 
