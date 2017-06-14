From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] ARM: debug: Use generic 8250 debug_ll for omap zoom
Date: Wed, 14 Jun 2017 00:31:16 -0700
Message-ID: <20170614073118.28246-6-tony@atomide.com>
References: <20170614073118.28246-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170614073118.28246-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Hoeun Ryu <hoeun.ryu@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We want to use generic 8250 debug_ll code to get DEBUG_UNCOMPRESS
working and to simplify the code. The old debug_ll code is no longer
needed and the machine ID based detection is no longer used.

With zoom debug port being the last user, we can now drop
arch/arm/include/debug/omap2plus.S. And I also folded in an
earlier patch from Hoeun Ryu <hoeun.ryu@gmail.com> removing
DEBUG_OMAP2PLUS_UART dependency to DEBUG_UNCOMPRESS as we now
have no users for DEBUG_OMAP2PLUS_UART.

Note that for most part there's no need to keep DEBUG_LL enabled.
We now have CONFIG_SERIAL_EARLYCON working very early as long as
the kernel cmdline has "earlycon" in it and the board specific dts
file has chosen configured with with the port using stdout-path.

Cc: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig.debug             | 12 +++---
 arch/arm/include/debug/omap2plus.S | 82 --------------------------------------
 2 files changed, 5 insertions(+), 89 deletions(-)
 delete mode 100644 arch/arm/include/debug/omap2plus.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -732,7 +732,7 @@ choice
 	config DEBUG_ZOOM_UART
 		bool "Kernel low-level debugging messages via Zoom2/3 UART"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 
 	config DEBUG_PICOXCELL_UART
 		depends on ARCH_PICOXCELL
@@ -1369,10 +1369,6 @@ config DEBUG_S3C64XX_UART
 config DEBUG_S5PV210_UART
 	bool
 
-config DEBUG_OMAP2PLUS_UART
-	bool
-	depends on ARCH_OMAP2PLUS
-
 config DEBUG_IMX_UART_PORT
 	int "i.MX Debug UART Port Selection" if DEBUG_IMX1_UART || \
 						DEBUG_IMX25_UART || \
@@ -1444,7 +1440,6 @@ config DEBUG_LL_INCLUDE
 	default "debug/ks8695.S" if DEBUG_KS8695_UART
 	default "debug/msm.S" if DEBUG_QCOM_UARTDM
 	default "debug/netx.S" if DEBUG_NETX_UART
-	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/renesas-scif.S" if DEBUG_R7S72100_SCIF2
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF0
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF2
@@ -1492,6 +1487,7 @@ config DEBUG_UART_PHYS
 	default 0x03010fe0 if ARCH_RPC
 	default 0x07000000 if DEBUG_SUN9I_UART0
 	default 0x09405000 if DEBUG_ZTE_ZX
+	default 0x10000000 if DEBUG_ZOOM_UART
 	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || \
 				DEBUG_VEXPRESS_UART0_CA9
 	default 0x1010c000 if DEBUG_REALVIEW_PB1176_PORT
@@ -1661,6 +1657,7 @@ config DEBUG_UART_VIRT
 	default 0xfa06c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
 				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
 	default 0xfa06e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
+	default 0xfa400000 if DEBUG_ZOOM_UART
 	default 0xfa71e000 if DEBUG_QCOM_UARTDM
 	default 0xfb002000 if DEBUG_CNS3XXX
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
@@ -1728,6 +1725,7 @@ config DEBUG_UART_8250_SHIFT
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default 0 if DEBUG_FOOTBRIDGE_COM1 || ARCH_IOP32X || DEBUG_BCM_5301X || \
 		DEBUG_OMAP7XXUART1 || DEBUG_OMAP7XXUART2 || DEBUG_OMAP7XXUART3
+	default 1 if DEBUG_ZOOM_UART
 	default 2
 
 config DEBUG_UART_8250_WORD
@@ -1758,7 +1756,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 config DEBUG_UNCOMPRESS
 	bool
 	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
-	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
+	default y if DEBUG_LL && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
 		     !DEBUG_BRCMSTB_UART
 	help
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
deleted file mode 100644
--- a/arch/arm/include/debug/omap2plus.S
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-
-#include <linux/serial_reg.h>
-
-/* External port on Zoom2/3 */
-#define ZOOM_UART_BASE		0x10000000
-#define ZOOM_UART_VIRT		0xfa400000
-
-#define OMAP_PORT_SHIFT		2
-#define ZOOM_PORT_SHIFT		1
-
-#define UART_OFFSET(addr)	((addr) & 0x00ffffff)
-
-		.pushsection .data
-omap_uart_phys:	.word	0
-omap_uart_virt:	.word	0
-omap_uart_lsr:	.word	0
-		.popsection
-
-		.macro	addruart, rp, rv, tmp
-
-		/* Use omap_uart_phys/virt if already configured */
-10:		adr	\rp, 99f		@ get effective addr of 99f
-		ldr	\rv, [\rp]		@ get absolute addr of 99f
-		sub	\rv, \rv, \rp		@ offset between the two
-		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
-		sub	\tmp, \rp, \rv		@ make it effective
-		ldr	\rp, [\tmp, #0]		@ omap_uart_phys
-		ldr	\rv, [\tmp, #4]		@ omap_uart_virt
-		cmp	\rp, #0			@ is port configured?
-		cmpne	\rv, #0
-		bne	100f			@ already configured
-
-		/* Configure the UART offset from the phys/virt base */
-#ifdef CONFIG_DEBUG_ZOOM_UART
-		ldr	\rp, =ZOOM_UART_BASE
-		str	\rp, [\tmp, #0]		@ omap_uart_phys
-		ldr	\rp, =ZOOM_UART_VIRT
-		str	\rp, [\tmp, #4]		@ omap_uart_virt
-		mov	\rp, #(UART_LSR << ZOOM_PORT_SHIFT)
-		str	\rp, [\tmp, #8]		@ omap_uart_lsr
-#endif
-		b	10b
-
-		.align
-99:		.word	.
-		.word	omap_uart_phys
-		.ltorg
-
-100:		/* Pass the UART_LSR reg address */
-		ldr	\tmp, [\tmp, #8]	@ omap_uart_lsr
-		add	\rp, \rp, \tmp
-		add	\rv, \rv, \tmp
-		.endm
-
-		.macro	senduart,rd,rx
-		orr	\rd, \rd, \rx, lsl #24	@ preserve LSR reg offset
-		bic	\rx, \rx, #0xff		@ get base (THR) reg address
-		strb	\rd, [\rx]		@ send lower byte of rd
-		orr	\rx, \rx, \rd, lsr #24	@ restore original rx (LSR)
-		bic	\rd, \rd, #(0xff << 24)	@ restore original rd
-		.endm
-
-		.macro	busyuart,rd,rx
-1001:		ldrb	\rd, [\rx]		@ rx contains UART_LSR address
-		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		bne	1001b
-		.endm
-
-		.macro	waituart,rd,rx
-		.endm
-- 
2.13.0
