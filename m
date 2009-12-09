From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/4] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
Date: Thu, 10 Dec 2009 00:13:52 +0530
Message-ID: <1260384233-2278-3-git-send-email-santosh.shilimkar@ti.com>
References: <1260384233-2278-1-git-send-email-santosh.shilimkar@ti.com>
 <1260384233-2278-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50162 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756930AbZLISoL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 13:44:11 -0500
In-Reply-To: <1260384233-2278-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch implements the work-around for the errata 588369. The secure API
is used to alter L2 debug regsiter because of trust-zone.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Kconfig         |   13 +++++++++++++
 arch/arm/mm/cache-l2x0.c |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf8a99f..388d1e3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -916,6 +916,19 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR register
 	  may not be available in non-secure mode.
 
+config PL310_ERRATA_588369
+	bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
+	depends on CACHE_L2X0
+	default n
+	help
+	   The PL310 L2 cache controller implements three types of Clean &
+	   Invalidate maintenance operations: by Physical Address
+	   (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
+	   They are architecturally defined to behave as the execution of a
+	   clean operation followed immediately by an invalidate operation,
+	   both performing to the same memory location. This functionality
+	   is not correctly implemented in PL310 as clean lines are not
+	   invalidated as a result of these operations
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 747f9a9..c3905a9 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -88,8 +88,40 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	unsigned long addr;
 
 	start &= ~(CACHE_LINE_SIZE - 1);
+#ifdef CONFIG_PL310_ERRATA_588369
+	/*
+	 * Disable Write-Back and Cache Linefill (set bits [1:0] of the Debug
+	 * Control Register)
+	 */
+	__asm__ __volatile__(
+	"stmfd r13!, {r0-r12, r14}\n"
+	"mov r0, #3\n"
+	"ldr r12, =0x100\n"
+	"dsb\n"
+	"smc\n"
+	"ldmfd r13!, {r0-r12, r14}");
+
+	/* Clean by PA followed by Invalidate by PA */
+	for (addr = start; addr < end; addr += CACHE_LINE_SIZE) {
+		sync_writel(addr, L2X0_CLEAN_LINE_PA, 1);
+		sync_writel(addr, L2X0_INV_LINE_PA, 1);
+	}
+
+	/*
+	 * Enable Write-Back and Cache Linefill (set bits [1:0] of the Debug
+	 * Control Register)
+	 */
+	__asm__ __volatile__(
+	"stmfd r13!, {r0-r12, r14}\n"
+	"mov r0, #0\n"
+	"ldr r12, =0x100\n"
+	"dsb\n"
+	"smc\n"
+	"ldmfd r13!, {r0-r12, r14}");
+#else
 	for (addr = start; addr < end; addr += CACHE_LINE_SIZE)
 		sync_writel(addr, L2X0_CLEAN_INV_LINE_PA, 1);
+#endif
 	cache_sync();
 }
 
-- 
1.6.0.4

