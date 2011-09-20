From: <hvaibhav@ti.com>
Subject: [PATCH-V3 4/4] arm:omap:am33xx: Add low level debugging support
Date: Tue, 20 Sep 2011 20:02:22 +0530
Message-ID: <1316529142-27564-5-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41429 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab1ITOcx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 10:32:53 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

Add support for low level debugging on AM335X EVM (AM33XX family).
Currently only support for UART1 console, which is used on AM335X EVM
is added.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/include/mach/debug-macro.S |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/serial.h       |    4 ++++
 arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 48adfe9..f649973 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -78,6 +78,8 @@ omap_uart_lsr:	.word	0
 		beq	82f			@ configure UART2
 		cmp	\rp, #TI816XUART3	@ ti816x UART offsets different
 		beq	83f			@ configure UART3
+		cmp	\rp, #AM33XXUART1	@ AM33XX UART offsets different
+		beq	84f			@ configure UART1
 		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
 		beq	95f			@ configure ZOOM_UART

@@ -106,6 +108,9 @@ omap_uart_lsr:	.word	0
 		b	98f
 83:		mov	\rp, #UART_OFFSET(TI816X_UART3_BASE)
 		b	98f
+84:		ldr	\rp, =AM33XX_UART1_BASE
+		and	\rp, \rp, #0x00ffffff
+		b	97f
 95:		ldr	\rp, =ZOOM_UART_BASE
 		mrc	p15, 0, \rv, c1, c0
 		tst	\rv, #1			@ MMU enabled?
@@ -121,6 +126,23 @@ omap_uart_lsr:	.word	0
 		b	10b

 		/* Store both phys and virt address for the uart */
+97:		add	\rp, \rp, #0x44000000	@ phys base
+		mrc	p15, 0, \rv, c1, c0
+		tst	\rv, #1			@ MMU enabled?
+		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
+		ldrne	\rv, =omap_uart_phys	@ MMU enabled
+		str	\rp, [\rv, #0]
+		sub	\rp, \rp, #0x44000000	@ phys base
+		add	\rp, \rp, #0xf9000000	@ virt base
+		add	\rv, \rv, #4		@ omap_uart_virt
+		str	\rp, [\rv, #0]
+		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
+		add	\rv, \rv, #4		@ omap_uart_lsr
+		str	\rp, [\rv, #0]
+
+		b	10b
+
+		/* Store both phys and virt address for the uart */
 98:		add	\rp, \rp, #0x48000000	@ phys base
 		mrc	p15, 0, \rv, c1, c0
 		tst	\rv, #1			@ MMU enabled?
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index de3b10c..ad19377 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -59,6 +59,9 @@
 /* AM3505/3517 UART4 */
 #define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */

+/* AM33XX serial port */
+#define AM33XX_UART1_BASE	0x44E09000
+
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
 #define ZOOM_UART_VIRT		0xfa400000
@@ -92,6 +95,7 @@
 #define TI816XUART1		81
 #define TI816XUART2		82
 #define TI816XUART3		83
+#define AM33XXUART1		84
 #define ZOOM_UART		95		/* Only on zoom2/3 */

 /* This is only used by 8250.c for omap1510 */
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index a067484..bd1e051 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -97,6 +97,10 @@ static inline void flush(void)
 	_DEBUG_LL_ENTRY(mach, TI816X_UART##p##_BASE, OMAP_PORT_SHIFT,	\
 		TI816XUART##p)

+#define DEBUG_LL_AM33XX(p, mach)					\
+	_DEBUG_LL_ENTRY(mach, AM33XX_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		AM33XXUART##p)
+
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {
 	int port = 0;
@@ -173,6 +177,8 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		/* TI8168 base boards using UART3 */
 		DEBUG_LL_TI816X(3, ti8168evm);

+		/* AM33XX base boards using UART1 */
+		DEBUG_LL_AM33XX(1, am335xevm);
 	} while (0);
 }

--
1.7.0.4

