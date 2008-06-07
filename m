From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/21] ARM: OMAP: Add OMAP3430 base defines
Date: Fri,  6 Jun 2008 18:30:35 -0700
Message-ID: <1212802253-17797-4-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55244 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933774AbYFGBbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:00 -0400
In-Reply-To: <1212802253-17797-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Add symbolic constants for OMAP3430 base addresses; include that file
in hardware.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/include/asm-arm/arch-omap/hardware.h b/include/asm-arm/arch-omap/hardware.h
index 91d85b3..45fdfcc 100644
--- a/include/asm-arm/arch-omap/hardware.h
+++ b/include/asm-arm/arch-omap/hardware.h
@@ -284,6 +284,7 @@
 #include "omap1510.h"
 #include "omap24xx.h"
 #include "omap16xx.h"
+#include "omap34xx.h"
 
 #ifndef __ASSEMBLER__
 
diff --git a/include/asm-arm/arch-omap/omap34xx.h b/include/asm-arm/arch-omap/omap34xx.h
new file mode 100644
index 0000000..6a0459a
--- /dev/null
+++ b/include/asm-arm/arch-omap/omap34xx.h
@@ -0,0 +1,73 @@
+/*
+ * include/asm-arm/arch-omap/omap34xx.h
+ *
+ * This file contains the processor specific definitions of the TI OMAP34XX.
+ *
+ * Copyright (C) 2007 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_OMAP34XX_H
+#define __ASM_ARCH_OMAP34XX_H
+
+/*
+ * Please place only base defines here and put the rest in device
+ * specific headers.
+ */
+
+#define L4_34XX_BASE		0x48000000
+#define L4_WK_34XX_BASE		0x48300000
+#define L4_WK_OMAP_BASE		L4_WK_34XX_BASE
+#define L4_PER_34XX_BASE	0x49000000
+#define L4_PER_OMAP_BASE	L4_PER_34XX_BASE
+#define L4_EMU_34XX_BASE	0x54000000
+#define L4_EMU_BASE		L4_EMU_34XX_BASE
+#define L3_34XX_BASE		0x68000000
+#define L3_OMAP_BASE		L3_34XX_BASE
+
+#define OMAP3430_32KSYNCT_BASE	0x48320000
+#define OMAP3430_CM_BASE	0x48004800
+#define OMAP3430_PRM_BASE	0x48306800
+#define OMAP343X_SMS_BASE	0x6C000000
+#define OMAP343X_SDRC_BASE	0x6D000000
+#define OMAP34XX_GPMC_BASE	0x6E000000
+#define OMAP343X_SCM_BASE	0x48002000
+#define OMAP343X_CTRL_BASE	OMAP343X_SCM_BASE
+
+#define OMAP34XX_IC_BASE	0x48200000
+#define OMAP34XX_IVA_INTC_BASE	0x40000000
+#define OMAP34XX_HSUSB_OTG_BASE	(L4_34XX_BASE + 0xAB000)
+#define OMAP34XX_HSUSB_HOST_BASE	(L4_34XX_BASE + 0x64000)
+#define OMAP34XX_USBTLL_BASE	(L4_34XX_BASE + 0x62000)
+#define IRQ_SIR_IRQ		0x0040
+
+
+#if defined(CONFIG_ARCH_OMAP3430)
+
+#define OMAP2_32KSYNCT_BASE		OMAP3430_32KSYNCT_BASE
+#define OMAP2_CM_BASE			OMAP3430_CM_BASE
+#define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
+#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
+
+#endif
+
+#define OMAP34XX_DSP_BASE	0x58000000
+#define OMAP34XX_DSP_MEM_BASE	(OMAP34XX_DSP_BASE + 0x0)
+#define OMAP34XX_DSP_IPI_BASE	(OMAP34XX_DSP_BASE + 0x1000000)
+#define OMAP34XX_DSP_MMU_BASE	(OMAP34XX_DSP_BASE + 0x2000000)
+#endif /* __ASM_ARCH_OMAP34XX_H */
+
