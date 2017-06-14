From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] ARM: debug: Use generic 8250 debug_ll for omap3/4/5
Date: Wed, 14 Jun 2017 00:31:13 -0700
Message-ID: <20170614073118.28246-3-tony@atomide.com>
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
 arch/arm/Kconfig.debug             | 18 ++++++++++++------
 arch/arm/include/debug/omap2plus.S | 32 --------------------------------
 2 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -664,7 +664,7 @@ choice
 	config DEBUG_OMAP3UART3
 		bool "Kernel low-level debugging messages via OMAP3 UART3 (most omap3 boards)"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 		help
 		  This covers at least cm_t3x, beagle, crane, devkit8000,
 		  igep00x0, ldp, n900, n9(50), pandora, overo, touchbook,
@@ -673,17 +673,17 @@ choice
 	config DEBUG_OMAP4UART3
 		bool "Kernel low-level debugging messages via OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 
 	config DEBUG_OMAP3UART4
 		bool "Kernel low-level debugging messages via OMAP36XX UART4"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 
 	config DEBUG_OMAP4UART4
 		bool "Kernel low-level debugging messages via OMAP4/5 UART4"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 
 	config DEBUG_OMAP7XXUART1
 		bool "Kernel low-level debugging via OMAP730 UART1"
@@ -1523,11 +1523,14 @@ config DEBUG_UART_PHYS
 	default 0x40090000 if DEBUG_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if DEBUG_GEMINI
+	default 0x48020000 if DEBUG_OMAP4UART3
 	default 0x4806a000 if DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || \
 				DEBUG_OMAP4UART1 || DEBUG_OMAP5UART1
 	default 0x4806c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
 				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
-	default 0x4806e000 if DEBUG_OMAP2UART3
+	default 0x4806e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
+	default 0x49020000 if DEBUG_OMAP3UART3
+	default 0x49042000 if DEBUG_OMAP3UART4
 	default 0x50000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
 				DEBUG_S3C2410_UART0)
 	default 0x50004000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART1 || \
@@ -1646,15 +1649,18 @@ config DEBUG_UART_VIRT
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0xf8ffee00 if DEBUG_AT91_SAM9263_DBGU
 	default 0xf8fff200 if DEBUG_AT91_RM9200_DBGU
+ 	default 0xfa020000 if DEBUG_OMAP4UART3
 	default 0xfa06a000 if DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || \
 				DEBUG_OMAP4UART1 || DEBUG_OMAP5UART1
 	default 0xfa06c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
 				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
-	default 0xfa06e000 if DEBUG_OMAP2UART3
+	default 0xfa06e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
 	default 0xfa71e000 if DEBUG_QCOM_UARTDM
 	default 0xfb002000 if DEBUG_CNS3XXX
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
 	default 0xfb00c000 if DEBUG_AT91_SAMA5D4_USART3
+	default 0xfb020000 if DEBUG_OMAP3UART3
+	default 0xfb042000 if DEBUG_OMAP3UART4
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0xfc705000 if DEBUG_ZTE_ZX
 	default 0xfcfe8600 if DEBUG_BCM63XX_UART
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
--- a/arch/arm/include/debug/omap2plus.S
+++ b/arch/arm/include/debug/omap2plus.S
@@ -13,14 +13,8 @@
 #include <linux/serial_reg.h>
 
 /* OMAP3 serial ports */
-#define OMAP3_UART3_BASE	0x49020000
-#define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
 #define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
 
-/* OMAP4 serial ports */
-#define OMAP4_UART3_BASE	0x48020000
-#define OMAP4_UART4_BASE	0x4806e000
-
 /* TI81XX serial ports */
 #define TI81XX_UART1_BASE	0x48020000
 #define TI81XX_UART2_BASE	0x48022000
@@ -32,12 +26,6 @@
 /* AM33XX serial port */
 #define AM33XX_UART1_BASE	0x44E09000
 
-/* OMAP5 serial ports */
-#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
-#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
-#define OMAP5_UART5_BASE	0x48066000
-#define OMAP5_UART6_BASE	0x48068000
-
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
 #define ZOOM_UART_VIRT		0xfa400000
@@ -68,26 +56,6 @@ omap_uart_lsr:	.word	0
 		bne	100f			@ already configured
 
 		/* Configure the UART offset from the phys/virt base */
-#ifdef CONFIG_DEBUG_OMAP3UART3
-		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
-		add	\rp, \rp, #0x00fb0000
-		add	\rp, \rp, #0x00006000		@ OMAP3_UART3_BASE
-		b	98f
-#endif
-#ifdef CONFIG_DEBUG_OMAP4UART3
-		mov	\rp, #UART_OFFSET(OMAP4_UART3_BASE)
-		b	98f
-#endif
-#ifdef CONFIG_DEBUG_OMAP3UART4
-		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
-		add	\rp, \rp, #0x00fb0000
-		add	\rp, \rp, #0x00028000		@ OMAP3_UART4_BASE
-		b	98f
-#endif
-#ifdef CONFIG_DEBUG_OMAP4UART4
-		mov	\rp, #UART_OFFSET(OMAP4_UART4_BASE)
-		b	98f
-#endif
 #ifdef CONFIG_DEBUG_TI81XXUART1
 		mov	\rp, #UART_OFFSET(TI81XX_UART1_BASE)
 		b	98f
-- 
2.13.0
