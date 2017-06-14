From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] ARM: debug: Use generic 8250 debug_ll for am3517 and
 am335x
Date: Wed, 14 Jun 2017 00:31:15 -0700
Message-ID: <20170614073118.28246-5-tony@atomide.com>
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
 arch/arm/Kconfig.debug             |  4 +++-
 arch/arm/include/debug/omap2plus.S | 25 -------------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -727,7 +727,7 @@ choice
 	config DEBUG_AM33XXUART1
 		bool "Kernel low-level debugging messages via AM33XX UART1"
 		depends on ARCH_OMAP2PLUS
-		select DEBUG_OMAP2PLUS_UART
+		select DEBUG_UART_8250
 
 	config DEBUG_ZOOM_UART
 		bool "Kernel low-level debugging messages via Zoom2/3 UART"
@@ -1523,6 +1523,7 @@ config DEBUG_UART_PHYS
 	default 0x40090000 if DEBUG_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if DEBUG_GEMINI
+	default 0x44e09000 if DEBUG_AM33XXUART1
 	default 0x48020000 if DEBUG_OMAP4UART3 || DEBUG_TI81XXUART1
 	default 0x48022000 if DEBUG_TI81XXUART2
 	default 0x48024000 if DEBUG_TI81XXUART3
@@ -1651,6 +1652,7 @@ config DEBUG_UART_VIRT
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0xf8ffee00 if DEBUG_AT91_SAM9263_DBGU
 	default 0xf8fff200 if DEBUG_AT91_RM9200_DBGU
+	default 0xf9e09000 if DEBUG_AM33XXUART1
  	default 0xfa020000 if DEBUG_OMAP4UART3 || DEBUG_TI81XXUART1
 	default 0xfa022000 if DEBUG_TI81XXUART2
 	default 0xfa024000 if DEBUG_TI81XXUART3
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
--- a/arch/arm/include/debug/omap2plus.S
+++ b/arch/arm/include/debug/omap2plus.S
@@ -12,15 +12,6 @@
 
 #include <linux/serial_reg.h>
 
-/* OMAP3 serial ports */
-#define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
-
-/* AM3505/3517 UART4 */
-#define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
-
-/* AM33XX serial port */
-#define AM33XX_UART1_BASE	0x44E09000
-
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
 #define ZOOM_UART_VIRT		0xfa400000
@@ -51,11 +42,6 @@ omap_uart_lsr:	.word	0
 		bne	100f			@ already configured
 
 		/* Configure the UART offset from the phys/virt base */
-#ifdef CONFIG_DEBUG_AM33XXUART1
-		ldr	\rp, =AM33XX_UART1_BASE
-		and	\rp, \rp, #0x00ffffff
-		b	97f
-#endif
 #ifdef CONFIG_DEBUG_ZOOM_UART
 		ldr	\rp, =ZOOM_UART_BASE
 		str	\rp, [\tmp, #0]		@ omap_uart_phys
@@ -66,17 +52,6 @@ omap_uart_lsr:	.word	0
 #endif
 		b	10b
 
-		/* AM33XX: Store both phys and virt address for the uart */
-97:		add	\rp, \rp, #0x44000000	@ phys base
-		str	\rp, [\tmp, #0]		@ omap_uart_phys
-		sub	\rp, \rp, #0x44000000	@ phys base
-		add	\rp, \rp, #0xf9000000	@ virt base
-		str	\rp, [\tmp, #4]		@ omap_uart_virt
-		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
-		str	\rp, [\tmp, #8]		@ omap_uart_lsr
-
-		b	10b
-
 		.align
 99:		.word	.
 		.word	omap_uart_phys
-- 
2.13.0
