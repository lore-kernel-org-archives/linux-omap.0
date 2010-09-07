From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/6] ARM: l2x0: Fix coding-style in the cache-l2x0.h
Date: Tue,  7 Sep 2010 13:27:21 +0530
Message-ID: <1283846243-11600-5-git-send-email-santosh.shilimkar@ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51107 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0IGH5w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Sep 2010 03:57:52 -0400
In-Reply-To: <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Replace tab with space after #define to be consisten with other
define in the file. Also move the bit mask below the register offsets.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 6bcba48..d833355 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -21,9 +21,6 @@
 #define __ASM_ARM_HARDWARE_L2X0_H
 
 #define L2X0_CACHE_ID			0x000
-#define   L2X0_CACHE_ID_PART_MASK	(0xf << 6)
-#define   L2X0_CACHE_ID_PART_L210	(1 << 6)
-#define   L2X0_CACHE_ID_PART_L310	(3 << 6)
 #define L2X0_CACHE_TYPE			0x004
 #define L2X0_CTRL			0x100
 #define L2X0_AUX_CTRL			0x104
@@ -54,6 +51,11 @@
 #define L2X0_LINE_TAG			0xF30
 #define L2X0_DEBUG_CTRL			0xF40
 
+/* Registers shifts and masks */
+#define L2X0_CACHE_ID_PART_MASK		(0xf << 6)
+#define L2X0_CACHE_ID_PART_L210		(1 << 6)
+#define L2X0_CACHE_ID_PART_L310		(3 << 6)
+
 #ifndef __ASSEMBLY__
 extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
 #endif
-- 
1.6.0.4

