From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [pm-core][PATCH v3 19/21] OMAP4: Remove un-used do_wfi() macro.
Date: Mon, 28 Mar 2011 14:52:35 +0530
Message-ID: <1301304157-2466-20-git-send-email-santosh.shilimkar@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40592 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab1C1JXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 05:23:03 -0400
In-Reply-To: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

With OMAP4 suspend, idle and hotplug series, we no longer need
do_wfi() macro.

Remove the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index a4b3beb..33fa3d3 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -16,16 +16,6 @@
 #include <asm/proc-fns.h>
 
 #ifndef __ASSEMBLER__
-/*
- * wfi used in low power code. Directly opcode is used instead
- * of instruction to avoid mulit-omap build break
- */
-#ifdef CONFIG_THUMB2_KERNEL
-#define do_wfi() __asm__ __volatile__ ("wfi" : : : "memory")
-#else
-#define do_wfi()			\
-		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
-#endif
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *omap4_get_l2cache_base(void);
-- 
1.6.0.4

