From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] ARM: debug: Use generic 8250 debug_ll for omap2 and
 omap3/4/5 common uarts
Date: Wed, 14 Jun 2017 00:31:12 -0700
Message-ID: <20170614073118.28246-2-tony@atomide.com>
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

Note that for most part there's no need to keep DEBUG_LL enabled.
We now have CONFIG_SERIAL_EARLYCON working very early as long as
the kernel cmdline has "earlycon" in it and the board specific dts
file has chosen configured with with the port using stdout-path.

Cc: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig.debug             | 16 +++++++++++++---
 arch/arm/include/debug/omap2plus.S | 23 -----------------------
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -646,7 +646,7 @@ choice
 	config DEBUG_OMAP2UART1
 		bool "OMAP2/3/4 UART1 (omap2/3 sdp boards and some omap3 boards)"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 		help
 		  This covers at least h4, 2430sdp, 3430sdp, 3630sdp,
 		  omap3 torpedo and 3530 lv som.
@@ -654,12 +654,12 @@ choice
 	config DEBUG_OMAP2UART2
 		bool "Kernel low-level debugging messages via OMAP2/3/4 UART2"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 
 	config DEBUG_OMAP2UART3
 		bool "Kernel low-level debugging messages via OMAP2 UART3 (n8x0)"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 
 	config DEBUG_OMAP3UART3
 		bool "Kernel low-level debugging messages via OMAP3 UART3 (most omap3 boards)"
@@ -1523,6 +1523,11 @@ config DEBUG_UART_PHYS
 	default 0x40090000 if DEBUG_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if DEBUG_GEMINI
+	default 0x4806a000 if DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || \
+				DEBUG_OMAP4UART1 || DEBUG_OMAP5UART1
+	default 0x4806c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
+				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
+	default 0x4806e000 if DEBUG_OMAP2UART3
 	default 0x50000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
 				DEBUG_S3C2410_UART0)
 	default 0x50004000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART1 || \
@@ -1641,6 +1646,11 @@ config DEBUG_UART_VIRT
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0xf8ffee00 if DEBUG_AT91_SAM9263_DBGU
 	default 0xf8fff200 if DEBUG_AT91_RM9200_DBGU
+	default 0xfa06a000 if DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || \
+				DEBUG_OMAP4UART1 || DEBUG_OMAP5UART1
+	default 0xfa06c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
+				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
+	default 0xfa06e000 if DEBUG_OMAP2UART3
 	default 0xfa71e000 if DEBUG_QCOM_UARTDM
 	default 0xfb002000 if DEBUG_CNS3XXX
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
--- a/arch/arm/include/debug/omap2plus.S
+++ b/arch/arm/include/debug/omap2plus.S
@@ -12,21 +12,12 @@
 
 #include <linux/serial_reg.h>
 
-/* OMAP2 serial ports */
-#define OMAP2_UART1_BASE	0x4806a000
-#define OMAP2_UART2_BASE	0x4806c000
-#define OMAP2_UART3_BASE	0x4806e000
-
 /* OMAP3 serial ports */
-#define OMAP3_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP3_UART2_BASE	OMAP2_UART2_BASE
 #define OMAP3_UART3_BASE	0x49020000
 #define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
 #define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
 
 /* OMAP4 serial ports */
-#define OMAP4_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP4_UART2_BASE	OMAP2_UART2_BASE
 #define OMAP4_UART3_BASE	0x48020000
 #define OMAP4_UART4_BASE	0x4806e000
 
@@ -42,8 +33,6 @@
 #define AM33XX_UART1_BASE	0x44E09000
 
 /* OMAP5 serial ports */
-#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
 #define OMAP5_UART3_BASE	OMAP4_UART3_BASE
 #define OMAP5_UART4_BASE	OMAP4_UART4_BASE
 #define OMAP5_UART5_BASE	0x48066000
@@ -79,18 +68,6 @@ omap_uart_lsr:	.word	0
 		bne	100f			@ already configured
 
 		/* Configure the UART offset from the phys/virt base */
-#ifdef CONFIG_DEBUG_OMAP2UART1
-		mov	\rp, #UART_OFFSET(OMAP2_UART1_BASE)	@ omap2/3/4
-		b	98f
-#endif
-#ifdef CONFIG_DEBUG_OMAP2UART2
-		mov	\rp, #UART_OFFSET(OMAP2_UART2_BASE)	@ omap2/3/4
-		b	98f
-#endif
-#ifdef CONFIG_DEBUG_OMAP2UART3
-		mov	\rp, #UART_OFFSET(OMAP2_UART3_BASE)
-		b	98f
-#endif
 #ifdef CONFIG_DEBUG_OMAP3UART3
 		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
 		add	\rp, \rp, #0x00fb0000
-- 
2.13.0
