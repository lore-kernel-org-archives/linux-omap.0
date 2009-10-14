From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] omap: headers: Split debug-macro.S for mach-omap1 and
	mach-omap2
Date: Wed, 14 Oct 2009 14:49:04 -0700
Message-ID: <20091014214904.30227.69687.stgit@kaulin.muru.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014213748.30227.71513.stgit@kaulin.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This also creates the include/mach subdirectories under
mach-omap1 and mach-omap2.

REVISIT: Remove "OMAP-730 only" parts in mach-omap2 version

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

 arch/arm/mach-omap1/include/mach/debug-macro.S |   45 +++++++++++++++
 arch/arm/mach-omap2/include/mach/debug-macro.S |   59 ++++++++++++++++++++
 arch/arm/plat-omap/include/mach/debug-macro.S  |   70 ------------------------
 3 files changed, 104 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-omap2/include/mach/debug-macro.S
 delete mode 100644 arch/arm/plat-omap/include/mach/debug-macro.S

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
new file mode 100644
index 0000000..aedb746
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -0,0 +1,45 @@
+/* arch/arm/mach-omap1/include/mach/debug-macro.S
+ *
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+		.macro	addruart,rx
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1			@ MMU enabled?
+		moveq	\rx, #0xff000000	@ physical base address
+		movne	\rx, #0xfe000000	@ virtual base
+		orr	\rx, \rx, #0x00fb0000
+#ifdef CONFIG_OMAP_LL_DEBUG_UART3
+		orr	\rx, \rx, #0x00009000	@ UART 3
+#endif
+#if defined(CONFIG_OMAP_LL_DEBUG_UART2) || defined(CONFIG_OMAP_LL_DEBUG_UART3)
+		orr	\rx, \rx, #0x00000800	@ UART 2 & 3
+#endif
+		.endm
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx]
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:		ldrb	\rd, [\rx, #(0x5 << 2)]	@ OMAP-1510 and friends
+		and	\rd, \rd, #0x60
+		teq	\rd, #0x60
+		beq	1002f
+		ldrb	\rd, [\rx, #(0x5 << 0)]	@ OMAP-730 only
+		and	\rd, \rd, #0x60
+		teq	\rd, #0x60
+		bne	1001b
+1002:
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm
diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
similarity index 76%
rename from arch/arm/plat-omap/include/mach/debug-macro.S
rename to arch/arm/mach-omap2/include/mach/debug-macro.S
index ac24050..271b9d8 100644
--- a/arch/arm/plat-omap/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -1,4 +1,4 @@
-/* arch/arm/plat-omap/include/mach/debug-macro.S
+/* arch/arm/mach-omap2/include/mach/debug-macro.S
  *
  * Debugging macro include header
  *
@@ -14,18 +14,7 @@
 		.macro	addruart,rx
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
-#ifdef CONFIG_ARCH_OMAP1
-		moveq	\rx, #0xff000000	@ physical base address
-		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		orr	\rx, \rx, #0x00009000	@ UART 3
-#endif
-#if defined(CONFIG_OMAP_LL_DEBUG_UART2) || defined(CONFIG_OMAP_LL_DEBUG_UART3)
-		orr	\rx, \rx, #0x00000800	@ UART 2 & 3
-#endif
-
-#elif  CONFIG_ARCH_OMAP2
+#ifdef  CONFIG_ARCH_OMAP2
 		moveq	\rx, #0x48000000	@ physical base address
 		movne	\rx, #0xd8000000	@ virtual base
 		orr	\rx, \rx, #0x0006a000
