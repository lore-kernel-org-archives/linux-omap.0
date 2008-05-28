From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/14] ARM: OMAP: Fix debug-macro for multi_omap
Date: Tue, 27 May 2008 21:20:05 -0700
Message-ID: <1211948418-16455-2-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64515 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYE1EUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:21 -0400
In-Reply-To: <1211948418-16455-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Use ARM revision register to set debug serial port base.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/asm-arm/arch-omap/debug-macro.S |   40 ++++++++++++++++++++++--------
 1 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/asm-arm/arch-omap/debug-macro.S b/include/asm-arm/arch-omap/debug-macro.S
index 3866e04..a7ca8c8 100644
--- a/include/asm-arm/arch-omap/debug-macro.S
+++ b/include/asm-arm/arch-omap/debug-macro.S
@@ -12,34 +12,51 @@
 */
 
 		.macro	addruart,rx
-		mrc	p15, 0, \rx, c1, c0
+
+		/* Detect omap */
+		mrc	p15, 0, \rx, c0, c0, 0	@ get processor revision
+		and	\rx, \rx, #0x000f0000	@ only check architecture
+		cmp	\rx, #0x00060000	@ is v6?
+		beq	1000f			@ found 925 or 926 (omap1)
+		cmp	\rx, #0x00070000	@ is v7?
+		beq	2000f			@ found arm11 (omap2)
+		cmp	\rx, #0x000f0000	@ is cortex?
+		beq	3000f			@ found cortex (omap3)
+
+1000:		/* Found omap1 */
+		mrc	p15, 0, \rx, c1, c0	@ get control register
 		tst	\rx, #1			@ MMU enabled?
-#ifdef CONFIG_ARCH_OMAP1
 		moveq	\rx, #0xff000000	@ physical base address
 		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		orr	\rx, \rx, #0x00009000	@ UART 3
-#endif
+		orr	\rx, \rx, #0x00fb0000	@ UART 1
 #if defined(CONFIG_OMAP_LL_DEBUG_UART2) || defined(CONFIG_OMAP_LL_DEBUG_UART3)
 		orr	\rx, \rx, #0x00000800	@ UART 2 & 3
 #endif
+#ifdef CONFIG_OMAP_LL_DEBUG_UART3
+		orr	\rx, \rx, #0x00009000	@ UART 3
+#endif
+		b	9999f			@ goto out
 
-#elif  CONFIG_ARCH_OMAP2
+2000:		/* Found omap2 */
+		mrc	p15, 0, \rx, c1, c0	@ get control register
+		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x48000000	@ physical base address
 		movne	\rx, #0xd8000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000
+		orr	\rx, \rx, #0x0006a000	@ UART 1
 #ifdef CONFIG_OMAP_LL_DEBUG_UART2
 		add	\rx, \rx, #0x00002000	@ UART 2
 #endif
 #ifdef CONFIG_OMAP_LL_DEBUG_UART3
 		add	\rx, \rx, #0x00004000	@ UART 3
 #endif
+		b	9999f			@ goto out
 
-#elif	CONFIG_ARCH_OMAP3
+3000:		/* Found omap3 */
+		mrc	p15, 0, \rx, c1, c0	@ get control register
+		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x48000000	@ physical base address
 		movne	\rx, #0xd8000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000
+		orr	\rx, \rx, #0x0006a000	@ UART 1
 #ifdef CONFIG_OMAP_LL_DEBUG_UART2
 		add	\rx, \rx, #0x00002000	@ UART 2
 #endif
@@ -47,7 +64,8 @@
 		add	\rx, \rx, #0x00fb0000	@ UART 3
 		add	\rx, \rx, #0x00006000
 #endif
-#endif
+
+9999:
 		.endm
 
 		.macro	senduart,rd,rx
-- 
1.5.3.6

