From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/6 v2] OMAP4: Re-arrange the low level debug code
Date: Sat, 12 Dec 2009 13:05:34 +0530
Message-ID: <1260603334-22158-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36473 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZLLHfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Dec 2009 02:35:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4430 the UART3 base address is different than that on OMAP3.
Because of this existing code needs additional #ifdef'ry to accommodate
that code. Hence this patch separates it. Also UART3 base address is
fixed for OMAP4430 in this patch.

Incorporated comment from Sergei Shtylyov [sshtylyov@ru.mvista.com]

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/include/mach/debug-macro.S |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index e9f255d..791bd73 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -25,7 +25,7 @@
 		add	\rx, \rx, #0x00004000	@ UART 3
 #endif
 
-#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#elif defined(CONFIG_ARCH_OMAP3)
 		moveq	\rx, #0x48000000	@ physical base address
 		movne	\rx, #0xfa000000	@ virtual base
 		orr	\rx, \rx, #0x0006a000
@@ -36,6 +36,17 @@
 		add	\rx, \rx, #0x00fb0000	@ UART 3
 		add	\rx, \rx, #0x00006000
 #endif
+#elif defined(CONFIG_ARCH_OMAP4)
+		moveq	\rx, #0x48000000	@ physical base address
+		movne	\rx, #0xfa000000	@ virtua base
+		orr	\rx, \rx, #0x0006a000	@ UART 1
+#ifdef CONFIG_OMAP_LL_DEBUG_UART2
+		add	\rx, \rx, #0x00002000	@ UART 2
+#endif
+#ifdef CONFIG_OMAP_LL_DEBUG_UART3
+		and 	\rx, \rx, #0xff000000
+		add	\rx, \rx, #0x00020000	@ UART 3
+#endif
 #endif
 		.endm
 
-- 
1.6.0.4

