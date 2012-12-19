From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/8] ARM: OMAP2+: Add multiplatform debug_ll support
Date: Wed, 19 Dec 2012 11:26:25 -0800
Message-ID: <20121219192625.22098.3474.stgit@muffinssi.local>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62750 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753699Ab2LST01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 14:26:27 -0500
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Add multiplatform debug_ll support by stripping away
the custom hacks to detect the port from debug-macro.S.

Note that this now requires the specific debug_ll port to
be selected in the .config.

The old debug-macro.S will be removed a bit later
once we are sure things work properly with multiplatform
enabled.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig.debug             |   56 +++++++++++
 arch/arm/include/debug/omap2plus.S |  190 ++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+)
 create mode 100644 arch/arm/include/debug/omap2plus.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 661030d..8cccce3 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -291,6 +291,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on MVEBU based platforms.
 
+	config DEBUG_OMAP2PLUS_UART
+		bool "Kernel low-level debugging messages via OMAP2PLUS UART"
+		depends on ARCH_OMAP2PLUS
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on OMAP2PLUS based platforms.
+
 	config DEBUG_PICOXCELL_UART
 		depends on ARCH_PICOXCELL
 		bool "Use PicoXcell UART for low-level debug"
@@ -461,6 +468,54 @@ config DEBUG_IMX6Q_UART_PORT
 
 choice
 	prompt "Low-level debug console UART"
+	depends on DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_OMAP2UART1
+		bool "OMAP2/3/4 UART1 (omap2/3 sdp boards and some omap3 boards)"
+		help
+		  This covers at least h4, 2430sdp, 3430sdp, 3630sdp,
+		  omap3 torpedo and 3530 lv som.
+
+	config DEBUG_OMAP2UART2
+		bool "OMAP2/3/4 UART2"
+
+	config DEBUG_OMAP2UART3
+		bool "OMAP2 UART3 (n8x0)"
+
+	config DEBUG_OMAP3UART3
+		bool "OMAP3 UART3 (most omap3 boards)"
+		help
+		  This covers at least cm_t3x, beagle, crane, devkit8000,
+		  igep00x0, ldp, n900, n9(50), pandora, overo, touchbook,
+		  and 3517evm.
+
+	config DEBUG_OMAP4UART3
+		bool "OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
+
+	config DEBUG_OMAP3UART4
+		bool "OMAP36XX UART4"
+
+	config DEBUG_OMAP4UART4
+		bool "OMAP4/5 UART4"
+
+	config DEBUG_TI81XXUART1
+		bool "TI81XX UART1 (ti8148evm)"
+
+	config DEBUG_TI81XXUART2
+		bool "TI81XX UART2"
+
+	config DEBUG_TI81XXUART3
+		bool "TI81XX UART3 (ti8168evm)"
+
+	config DEBUG_AM33XXUART1
+		bool "AM33XX UART1"
+
+	config DEBUG_ZOOM_UART
+		bool "Zoom2/3 UART"
+endchoice
+
+choice
+	prompt "Low-level debug console UART"
 	depends on DEBUG_LL && DEBUG_TEGRA_UART
 
 	config TEGRA_DEBUG_UART_AUTO_ODMDATA
@@ -501,6 +556,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6Q_UART
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
+	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/sunxi.S" if DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
new file mode 100644
index 0000000..6d867ae
--- /dev/null
+++ b/arch/arm/include/debug/omap2plus.S
@@ -0,0 +1,190 @@
+/*
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
+#include <linux/serial_reg.h>
+
+/* OMAP2 serial ports */
+#define OMAP2_UART1_BASE	0x4806a000
+#define OMAP2_UART2_BASE	0x4806c000
+#define OMAP2_UART3_BASE	0x4806e000
+
+/* OMAP3 serial ports */
+#define OMAP3_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP3_UART2_BASE	OMAP2_UART2_BASE
+#define OMAP3_UART3_BASE	0x49020000
+#define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
+#define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
+
+/* OMAP4 serial ports */
+#define OMAP4_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP4_UART2_BASE	OMAP2_UART2_BASE
+#define OMAP4_UART3_BASE	0x48020000
+#define OMAP4_UART4_BASE	0x4806e000
+
+/* TI81XX serial ports */
+#define TI81XX_UART1_BASE	0x48020000
+#define TI81XX_UART2_BASE	0x48022000
+#define TI81XX_UART3_BASE	0x48024000
+
+/* AM3505/3517 UART4 */
+#define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
+
+/* AM33XX serial port */
+#define AM33XX_UART1_BASE	0x44E09000
+
+/* OMAP5 serial ports */
+#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
+#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
+#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
+#define OMAP5_UART5_BASE	0x48066000
+#define OMAP5_UART6_BASE	0x48068000
+
+/* External port on Zoom2/3 */
+#define ZOOM_UART_BASE		0x10000000
+#define ZOOM_UART_VIRT		0xfa400000
+
+#define OMAP_PORT_SHIFT		2
+#define ZOOM_PORT_SHIFT		1
+
+#define UART_OFFSET(addr)	((addr) & 0x00ffffff)
+
+		.pushsection .data
+omap_uart_phys:	.word	0
+omap_uart_virt:	.word	0
+omap_uart_lsr:	.word	0
+		.popsection
+
+		.macro	addruart, rp, rv, tmp
+
+		/* Use omap_uart_phys/virt if already configured */
+10:		adr	\rp, 99f		@ get effective addr of 99f
+		ldr	\rv, [\rp]		@ get absolute addr of 99f
+		sub	\rv, \rv, \rp		@ offset between the two
+		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
+		sub	\tmp, \rp, \rv		@ make it effective
+		ldr	\rp, [\tmp, #0]		@ omap_uart_phys
+		ldr	\rv, [\tmp, #4]		@ omap_uart_virt
+		cmp	\rp, #0			@ is port configured?
+		cmpne	\rv, #0
+		bne	100f			@ already configured
+
+		/* Configure the UART offset from the phys/virt base */
+#ifdef CONFIG_DEBUG_OMAP2UART1
+		mov	\rp, #UART_OFFSET(OMAP2_UART1_BASE)	@ omap2/3/4
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_OMAP2UART2
+		mov	\rp, #UART_OFFSET(OMAP2_UART2_BASE)	@ omap2/3/4
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_OMAP2UART3
+		mov	\rp, #UART_OFFSET(OMAP2_UART3_BASE)
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_OMAP3UART3
+		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
+		add	\rp, \rp, #0x00fb0000
+		add	\rp, \rp, #0x00006000		@ OMAP3_UART3_BASE
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_OMAP4UART3
+		mov	\rp, #UART_OFFSET(OMAP4_UART3_BASE)
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_OMAP3UART4
+		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
+		add	\rp, \rp, #0x00fb0000
+		add	\rp, \rp, #0x00028000		@ OMAP3_UART4_BASE
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_OMAP4UART4
+		mov	\rp, #UART_OFFSET(OMAP4_UART4_BASE)
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_TI81XXUART1
+		mov	\rp, #UART_OFFSET(TI81XX_UART1_BASE)
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_TI81XXUART2
+		mov	\rp, #UART_OFFSET(TI81XX_UART2_BASE)
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_TI81XXUART3
+		mov	\rp, #UART_OFFSET(TI81XX_UART3_BASE)
+		b	98f
+#endif
+#ifdef CONFIG_DEBUG_AM33XXUART1
+		ldr	\rp, =AM33XX_UART1_BASE
+		and	\rp, \rp, #0x00ffffff
+		b	97f
+#endif
+#ifdef CONFIG_DEBUG_ZOOM_UART
+		ldr	\rp, =ZOOM_UART_BASE
+		str	\rp, [\tmp, #0]		@ omap_uart_phys
+		ldr	\rp, =ZOOM_UART_VIRT
+		str	\rp, [\tmp, #4]		@ omap_uart_virt
+		mov	\rp, #(UART_LSR << ZOOM_PORT_SHIFT)
+		str	\rp, [\tmp, #8]		@ omap_uart_lsr
+#endif
+		b	10b
+
+		/* AM33XX: Store both phys and virt address for the uart */
+97:		add	\rp, \rp, #0x44000000	@ phys base
+		str	\rp, [\tmp, #0]		@ omap_uart_phys
+		sub	\rp, \rp, #0x44000000	@ phys base
+		add	\rp, \rp, #0xf9000000	@ virt base
+		str	\rp, [\tmp, #4]		@ omap_uart_virt
+		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
+		str	\rp, [\tmp, #8]		@ omap_uart_lsr
+
+		b	10b
+
+		/* Store both phys and virt address for the uart */
+98:		add	\rp, \rp, #0x48000000	@ phys base
+		str	\rp, [\tmp, #0]		@ omap_uart_phys
+		sub	\rp, \rp, #0x48000000	@ phys base
+		add	\rp, \rp, #0xfa000000	@ virt base
+		str	\rp, [\tmp, #4]		@ omap_uart_virt
+		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
+		str	\rp, [\tmp, #8]		@ omap_uart_lsr
+
+		b	10b
+
+		.align
+99:		.word	.
+		.word	omap_uart_phys
+		.ltorg
+
+100:		/* Pass the UART_LSR reg address */
+		ldr	\tmp, [\tmp, #8]	@ omap_uart_lsr
+		add	\rp, \rp, \tmp
+		add	\rv, \rv, \tmp
+		.endm
+
+		.macro	senduart,rd,rx
+		orr	\rd, \rd, \rx, lsl #24	@ preserve LSR reg offset
+		bic	\rx, \rx, #0xff		@ get base (THR) reg address
+		strb	\rd, [\rx]		@ send lower byte of rd
+		orr	\rx, \rx, \rd, lsr #24	@ restore original rx (LSR)
+		bic	\rd, \rd, #(0xff << 24)	@ restore original rd
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:		ldrb	\rd, [\rx]		@ rx contains UART_LSR address
+		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
+		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
+		bne	1001b
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm

