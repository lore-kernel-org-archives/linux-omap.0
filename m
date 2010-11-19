From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/5] ARM: l2x0: Add aux control register bitfields
Date: Fri, 19 Nov 2010 23:01:02 +0530
Message-ID: <1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46885 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755658Ab0KSRbd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 12:31:33 -0500
In-Reply-To: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, mans@mansr.com, tony@atomide.com, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Catalin Marinas <catalin.marinas@arm.com>

This patch adds the PL310 Auxiliary Control Register bitfields
so that SOC's can use these bit fields to construct the AUXCTRL
value to be passed/programmed instead of hardcoding it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index cc42d5f..5aeec1e 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -59,7 +59,17 @@
 #define L2X0_CACHE_ID_PART_MASK		(0xf << 6)
 #define L2X0_CACHE_ID_PART_L210		(1 << 6)
 #define L2X0_CACHE_ID_PART_L310		(3 << 6)
-#define L2X0_AUX_CTRL_WAY_SIZE_MASK	(0x3 << 17)
+
+#define L2X0_AUX_CTRL_MASK			0xc0000fff
+#define L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT	16
+#define L2X0_AUX_CTRL_WAY_SIZE_SHIFT		17
+#define L2X0_AUX_CTRL_WAY_SIZE_MASK		(0x3 << 17)
+#define L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT	22
+#define L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT		26
+#define L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT		27
+#define L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT	28
+#define L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT	29
+#define L2X0_AUX_CTRL_EARLY_BRESP_SHIFT		30
 
 #ifndef __ASSEMBLY__
 extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
-- 
1.6.0.4

