From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v2 6/6] TI816X: Add low level debug support
Date: Wed, 11 Aug 2010 22:41:27 +0530
Message-ID: <1281546687-11593-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52378 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab0HKRLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 13:11:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch adds support for low level debugging on TI816X boards. Currently the
support for UART3 console on TI816X EVM is added.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/include/mach/debug-macro.S |   12 ++++++++++++
 arch/arm/plat-omap/include/plat/serial.h       |    3 +++
 arch/arm/plat-omap/include/plat/uncompress.h   |    7 +++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 09331bb..992411f 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -66,6 +66,12 @@ omap_uart_lsr:	.word	0
 		beq	34f			@ configure OMAP3UART4
 		cmp	\rx, #OMAP4UART4	@ only on 44xx
 		beq	44f			@ configure OMAP4UART4
+		cmp	\rx, #TI816XUART1	@ ti816x UART offsets different
+		beq	81f			@ configure UART1
+		cmp	\rx, #TI816XUART2	@ ti816x UART offsets different
+		beq	82f			@ configure UART2
+		cmp	\rx, #TI816XUART3	@ ti816x UART offsets different
+		beq	83f			@ configure UART3
 		cmp	\rx, #ZOOM_UART		@ only on zoom2/3
 		beq	95f			@ configure ZOOM_UART
 
@@ -88,6 +94,12 @@ omap_uart_lsr:	.word	0
 		b	98f
 44:		mov	\rx, #UART_OFFSET(OMAP4_UART4_BASE)
 		b	98f
+81:		mov	\rx, #UART_OFFSET(TI816X_UART1_BASE)
+		b	98f
+82:		mov	\rx, #UART_OFFSET(TI816X_UART2_BASE)
+		b	98f
+83:		mov	\rx, #UART_OFFSET(TI816X_UART3_BASE)
+		b	98f
 95:		ldr	\rx, =ZOOM_UART_BASE
 		mrc	p15, 0, \tmp, c1, c0
 		tst	\tmp, #1		@ MMU enabled?
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index ad8d0d8..ef8a57a 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -86,6 +86,9 @@
 #define OMAP4UART2		OMAP2UART2
 #define OMAP4UART3		43
 #define OMAP4UART4		44
+#define TI816XUART1		81
+#define TI816XUART2		82
+#define TI816XUART3		83
 #define ZOOM_UART		95		/* Only on zoom2/3 */
 
 /* This is only used by 8250.c for omap1510 */
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index ddf723b..48a0d8c 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -93,6 +93,10 @@ static inline void flush(void)
 #define DEBUG_LL_ZOOM(mach)						\
 	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
 
+#define DEBUG_LL_TI816X(p, mach)					\
+	_DEBUG_LL_ENTRY(mach, TI816X_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		TI816XUART##p)
+
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {
 	int port = 0;
@@ -158,6 +162,9 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_ZOOM(omap_zoom2);
 		DEBUG_LL_ZOOM(omap_zoom3);
 
+		/* TI8168 base boards using UART3 */
+		DEBUG_LL_TI816X(3, ti8168evm);
+
 	} while (0);
 }
 
-- 
1.6.2.4

