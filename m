From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: Add empty inituart macros
Date: Thu, 03 Feb 2011 17:22:09 -0800
Message-ID: <20110204012209.26298.75402.stgit@baageli.muru.com>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13798 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1BDBWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:22:24 -0500
In-Reply-To: <20110204012008.26298.16341.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Add empty inituart macros. These can be used to initialize
the debug serial port based on the machine ID.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-aaec2000/include/mach/debug-macro.S  |    4 ++++
 arch/arm/mach-at91/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |    3 +++
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-davinci/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-dove/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    3 +++
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 ++++
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    3 +++
 .../arm/mach-integrator/include/mach/debug-macro.S |    3 +++
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    3 +++
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-l7200/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-loki/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-mmp/include/mach/debug-macro.S       |    3 +++
 arch/arm/mach-msm/include/mach/debug-macro.S       |    4 ++++
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-mxs/include/mach/debug-macro.S       |    3 +++
 arch/arm/mach-netx/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-omap1/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-pxa/include/mach/debug-macro.S       |    3 +++
 arch/arm/mach-realview/include/mach/debug-macro.S  |    3 +++
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    3 +++
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5p6442/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5pv210/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5pv310/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-shark/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-u300/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-versatile/include/mach/debug-macro.S |    3 +++
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |    3 +++
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    3 +++
 arch/arm/plat-spear/include/plat/debug-macro.S     |    3 +++
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S  |    3 +++
 arch/arm/plat-tcc/include/mach/debug-macro.S       |    3 +++
 51 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-aaec2000/include/mach/debug-macro.S b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
index bc7ad55..1a15ebb 100644
--- a/arch/arm/mach-aaec2000/include/mach/debug-macro.S
+++ b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
@@ -10,6 +10,10 @@
  */
 
 #include "hardware.h"
+
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, 0x00000800
 		orr	\rv, \rp, #io_p2v(0x80000000)	@ virtual
diff --git a/arch/arm/mach-at91/include/mach/debug-macro.S b/arch/arm/mach-at91/include/mach/debug-macro.S
index 0f959fa..d752c57 100644
--- a/arch/arm/mach-at91/include/mach/debug-macro.S
+++ b/arch/arm/mach-at91/include/mach/debug-macro.S
@@ -14,6 +14,9 @@
 #include <mach/hardware.h>
 #include <mach/at91_dbgu.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldr	\rp, =(AT91_BASE_SYS + AT91_DBGU)		@ System peripherals (phys address)
 	ldr	\rv, =(AT91_VA_BASE_SYS	+ AT91_DBGU)		@ System peripherals (virt address)
diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
index 507c687..f029a4e 100644
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
@@ -14,6 +14,9 @@
 #include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 #ifndef CONFIG_DEBUG_CLPS711X_UART2
 		mov	\rp, #0x0000	@ UART1
diff --git a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
index 56d8286..eb01d86 100644
--- a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
@@ -10,6 +10,9 @@
  * published by the Free Software Foundation.
  */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart,rp,rv
 		mov	\rp, #0x00009000
 		orr	\rv, \rp, #0xf0000000	@ virtual base
diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index 9f1befc..00af9bb 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -29,6 +29,9 @@ davinci_uart_phys:	.word	0
 davinci_uart_virt:	.word	0
 		.popsection
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro addruart, rp, rv
 
 		/* Use davinci_uart_phys/virt if already configured */
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
index da8bf2b..3c60a90 100644
--- a/arch/arm/mach-dove/include/mach/debug-macro.S
+++ b/arch/arm/mach-dove/include/mach/debug-macro.S
@@ -8,6 +8,9 @@
 
 #include <mach/bridge-regs.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldr	\rp, =DOVE_SB_REGS_PHYS_BASE
 	ldr	\rv, =DOVE_SB_REGS_VIRT_BASE
diff --git a/arch/arm/mach-ebsa110/include/mach/debug-macro.S b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
index 7ef5690..287178c 100644
--- a/arch/arm/mach-ebsa110/include/mach/debug-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  *
 **/
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0xf0000000
 		orr	\rp, \rp, #0x00000be0
diff --git a/arch/arm/mach-ep93xx/include/mach/debug-macro.S b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
index b25bc907..e840a96 100644
--- a/arch/arm/mach-ep93xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  */
 #include <mach/ep93xx-regs.h>
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		ldr	\rp, =EP93XX_APB_PHYS_BASE	@ Physical base
 		ldr	\rv, =EP93XX_APB_VIRT_BASE	@ virtual base
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index 30b971d..30d6244 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -15,6 +15,10 @@
 
 #ifndef CONFIG_DEBUG_DC21285_PORT
 	/* For NetWinder debugging */
+
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x000003f8
 		orr	\rv, \rp, #0xff000000	@ virtual
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
index f40e006..0fe48bc 100644
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ b/arch/arm/mach-gemini/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  */
 #include <mach/hardware.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldr	\rp, =GEMINI_UART_BASE			@ physical
 	ldr	\rv, =IO_ADDRESS(GEMINI_UART_BASE)	@ virtual
diff --git a/arch/arm/mach-integrator/include/mach/debug-macro.S b/arch/arm/mach-integrator/include/mach/debug-macro.S
index a1f598f..06681fe 100644
--- a/arch/arm/mach-integrator/include/mach/debug-macro.S
+++ b/arch/arm/mach-integrator/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  *
 */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x16000000	@ physical base address
 		mov	\rv, #0xf0000000	@ virtual base
diff --git a/arch/arm/mach-iop13xx/include/mach/debug-macro.S b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
index e664466..685cb18 100644
--- a/arch/arm/mach-iop13xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  * published by the Free Software Foundation.
  */
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	mov	\rp, #0x00002300
 	orr	\rp, \rp, #0x00000040
diff --git a/arch/arm/mach-iop32x/include/mach/debug-macro.S b/arch/arm/mach-iop32x/include/mach/debug-macro.S
index ff9e76c..7e6328a 100644
--- a/arch/arm/mach-iop32x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  * published by the Free Software Foundation.
  */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0xfe000000	@ physical as well as virtual
 		orr	\rp, \rp, #0x00800000	@ location of the UART
diff --git a/arch/arm/mach-iop33x/include/mach/debug-macro.S b/arch/arm/mach-iop33x/include/mach/debug-macro.S
index 40c500d..601d688 100644
--- a/arch/arm/mach-iop33x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  * published by the Free Software Foundation.
  */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x00ff0000
 		orr	\rp, \rp, #0x0000f700
diff --git a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
index f7c6eef..813ff68 100644
--- a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
@@ -12,6 +12,9 @@
  */
 #include <mach/ixp23xx.h>
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		ldr	\rp, =IXP23XX_PERIPHERAL_PHYS 	@ physical
 		ldr	\rv, =IXP23XX_PERIPHERAL_VIRT	@ virtual
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
index db06ae4..4a7a9e6 100644
--- a/arch/arm/mach-kirkwood/include/mach/debug-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
@@ -8,6 +8,9 @@
 
 #include <mach/bridge-regs.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldr	\rp, =KIRKWOOD_REGS_PHYS_BASE
 	ldr	\rv, =KIRKWOOD_REGS_VIRT_BASE
diff --git a/arch/arm/mach-ks8695/include/mach/debug-macro.S b/arch/arm/mach-ks8695/include/mach/debug-macro.S
index bf516ad..07f346b 100644
--- a/arch/arm/mach-ks8695/include/mach/debug-macro.S
+++ b/arch/arm/mach-ks8695/include/mach/debug-macro.S
@@ -14,6 +14,9 @@
 #include <mach/hardware.h>
 #include <mach/regs-uart.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 		ldr	\rp, =KS8695_UART_PA		@ physical base address
 		ldr	\rv, =KS8695_UART_VA		@ virtual base address
diff --git a/arch/arm/mach-l7200/include/mach/debug-macro.S b/arch/arm/mach-l7200/include/mach/debug-macro.S
index b0a2db7..a637598 100644
--- a/arch/arm/mach-l7200/include/mach/debug-macro.S
+++ b/arch/arm/mach-l7200/include/mach/debug-macro.S
@@ -14,6 +14,9 @@
 		.equ	io_virt, IO_BASE
 		.equ	io_phys, IO_START
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x00044000	@ UART1
 @		mov	\rp, #0x00045000	@ UART2
diff --git a/arch/arm/mach-loki/include/mach/debug-macro.S b/arch/arm/mach-loki/include/mach/debug-macro.S
index cc90d99..580d939 100644
--- a/arch/arm/mach-loki/include/mach/debug-macro.S
+++ b/arch/arm/mach-loki/include/mach/debug-macro.S
@@ -8,6 +8,9 @@
 
 #include <mach/loki.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldr	\rp, =LOKI_REGS_PHYS_BASE
 	ldr	\rv, =LOKI_REGS_VIRT_BASE
diff --git a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
index 629e744..9b51e20 100644
--- a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
@@ -20,6 +20,9 @@
  * Debug output is hardcoded to standard UART 5
 */
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldreq	\rp, =0x40090000
 	ldrne	\rv, =0xF4090000
diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
index 7e2ebd3..c7c579a 100644
--- a/arch/arm/mach-mmp/include/mach/debug-macro.S
+++ b/arch/arm/mach-mmp/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
 
 #include <mach/addr-map.h>
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		ldr	\rp, =APB_PHYS_BASE		@ physical
 		ldr	\rv, =APB_VIRT_BASE		@ virtual
diff --git a/arch/arm/mach-msm/include/mach/debug-macro.S b/arch/arm/mach-msm/include/mach/debug-macro.S
index 646b99e..8d574ec 100644
--- a/arch/arm/mach-msm/include/mach/debug-macro.S
+++ b/arch/arm/mach-msm/include/mach/debug-macro.S
@@ -20,6 +20,10 @@
 #include <mach/msm_iomap.h>
 
 #if defined(CONFIG_HAS_MSM_DEBUG_UART_PHYS) && !defined(CONFIG_MSM_DEBUG_UART_NONE)
+
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldr	\rp, =MSM_DEBUG_UART_PHYS
 	ldr	\rv, =MSM_DEBUG_UART_BASE
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
index 0489142..31dd8d0 100644
--- a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
@@ -8,6 +8,9 @@
 
 #include <mach/mv78xx0.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldr	\rp, =MV78XX0_REGS_PHYS_BASE
 	ldr	\rv, =MV78XX0_REGS_VIRT_BASE
diff --git a/arch/arm/mach-mxs/include/mach/debug-macro.S b/arch/arm/mach-mxs/include/mach/debug-macro.S
index 79650a1..f2ca06b 100644
--- a/arch/arm/mach-mxs/include/mach/debug-macro.S
+++ b/arch/arm/mach-mxs/include/mach/debug-macro.S
@@ -30,6 +30,9 @@
 
 #define UART_VADDR	MXS_IO_ADDRESS(UART_PADDR)
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		ldr	\rp, =UART_PADDR	@ physical
 		ldr	\rv, =UART_VADDR	@ virtual
diff --git a/arch/arm/mach-netx/include/mach/debug-macro.S b/arch/arm/mach-netx/include/mach/debug-macro.S
index 56a9152..6edba149 100644
--- a/arch/arm/mach-netx/include/mach/debug-macro.S
+++ b/arch/arm/mach-netx/include/mach/debug-macro.S
@@ -13,6 +13,9 @@
 
 #include "hardware.h"
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x00000a00
 		orr	\rv, \rp, #io_p2v(0x00100000)	@ virtual
diff --git a/arch/arm/mach-nomadik/include/mach/debug-macro.S b/arch/arm/mach-nomadik/include/mach/debug-macro.S
index e7151b4..ea3baf0 100644
--- a/arch/arm/mach-nomadik/include/mach/debug-macro.S
+++ b/arch/arm/mach-nomadik/include/mach/debug-macro.S
@@ -10,6 +10,9 @@
  *
 */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x00100000
 		add	\rp, \rp, #0x000fb000
diff --git a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
index 5a2acbd..d5c0d4b 100644
--- a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
@@ -12,6 +12,9 @@
 
 #include <mach/regs-board-a9m9750dev.h>
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		ldr	\rp, =NS9XXX_CSxSTAT_PHYS(0)
 		ldr	\rv, =io_p2v(NS9XXX_CSxSTAT_PHYS(0))
diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 6285604..bf0cc57 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -25,6 +25,9 @@ omap_uart_phys:	.word	0x0
 omap_uart_virt:	.word	0x0
 		.popsection
 
+		.macro	inituart, id, a, v
+		.endm
+
 		/*
 		 * Note that this code won't work if the bootloader passes
 		 * a wrong machine ID number in r1. To debug, just hardcode
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 6049f46..6bbe2dd 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -28,6 +28,9 @@ omap_uart_virt:	.word	0
 omap_uart_lsr:	.word	0
 		.popsection
 
+		.macro	inituart, id, a, v
+		.endm
+
 		/*
 		 * Note that this code won't work if the bootloader passes
 		 * a wrong machine ID number in r1. To debug, just hardcode
diff --git a/arch/arm/mach-pnx4008/include/mach/debug-macro.S b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
index 931afeb..a1f4dc8 100644
--- a/arch/arm/mach-pnx4008/include/mach/debug-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  *
 */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x00090000
 		add	\rv, \rp, #0xf4000000	@ virtual
diff --git a/arch/arm/mach-pxa/include/mach/debug-macro.S b/arch/arm/mach-pxa/include/mach/debug-macro.S
index 7d5c751..bc9a505 100644
--- a/arch/arm/mach-pxa/include/mach/debug-macro.S
+++ b/arch/arm/mach-pxa/include/mach/debug-macro.S
@@ -13,6 +13,9 @@
 
 #include "hardware.h"
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x00100000
 		orr	\rv, \rp, #io_p2v(0x40000000)	@ virtual
diff --git a/arch/arm/mach-realview/include/mach/debug-macro.S b/arch/arm/mach-realview/include/mach/debug-macro.S
index 90b687c..89b106c 100644
--- a/arch/arm/mach-realview/include/mach/debug-macro.S
+++ b/arch/arm/mach-realview/include/mach/debug-macro.S
@@ -33,6 +33,9 @@
 #error "Unknown RealView platform"
 #endif
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #DEBUG_LL_UART_OFFSET
 		orr	\rv, \rp, #0xfb000000	@ virtual base
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
index 85effff..f65806d 100644
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ b/arch/arm/mach-rpc/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  *
 */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0x00010000
 		orr	\rp, \rp, #0x00000fe0
diff --git a/arch/arm/mach-s3c2410/include/mach/debug-macro.S b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
index 5882dea..d6d8b91 100644
--- a/arch/arm/mach-s3c2410/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
@@ -19,6 +19,9 @@
 #define S3C2410_UART1_OFF (0x4000)
 #define SHIFT_2440TXF (14-9)
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro addruart, rp, rv
 		ldr	\rp, = S3C24XX_PA_UART
 		ldr	\rv, = S3C24XX_VA_UART
diff --git a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
index 0c5a738..3f0d15d 100644
--- a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
@@ -10,6 +10,9 @@
 #include <mach/map.h>
 #include <plat/regs-serial.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro addruart, rp, rv
 		ldr	\rp, = S3C24XX_PA_UART
 		ldr	\rv, = S3C24XX_VA_UART
diff --git a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
index a29e705..8510711 100644
--- a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
@@ -21,6 +21,9 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro addruart, rp, rv
 		ldr	\rp, = S3C_PA_UART
 		ldr	\rv, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
diff --git a/arch/arm/mach-s5p6442/include/mach/debug-macro.S b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
index e221320..822e075 100644
--- a/arch/arm/mach-s5p6442/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
@@ -15,6 +15,9 @@
 #include <mach/map.h>
 #include <plat/regs-serial.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro addruart, rp, rv
 		ldr	\rp, = S3C_PA_UART
 		ldr	\rv, = S3C_VA_UART
diff --git a/arch/arm/mach-s5p64x0/include/mach/debug-macro.S b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
index 79b04e6..814f0c9 100644
--- a/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
@@ -15,6 +15,9 @@
 
 #include <plat/regs-serial.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro addruart, rp, rv
 		mov	\rp, #0xE0000000
 		orr	\rp, \rp, #0x00100000
diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
index b2ba95d..8371e60 100644
--- a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
@@ -22,6 +22,9 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro addruart, rp, rv
 		ldr	\rp, = S3C_PA_UART
 		ldr	\rv, = S3C_VA_UART
diff --git a/arch/arm/mach-s5pv210/include/mach/debug-macro.S b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
index 169fe65..e5a3269 100644
--- a/arch/arm/mach-s5pv210/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
@@ -21,6 +21,9 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro addruart, rp, rv
 		ldr	\rp, = S3C_PA_UART
 		ldr	\rv, = S3C_VA_UART
diff --git a/arch/arm/mach-s5pv310/include/mach/debug-macro.S b/arch/arm/mach-s5pv310/include/mach/debug-macro.S
index b0d920c..9e85890 100644
--- a/arch/arm/mach-s5pv310/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pv310/include/mach/debug-macro.S
@@ -20,6 +20,9 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro addruart, rp, rv
 		ldreq	\rp, = S3C_PA_UART
 		ldrne	\rv, = S3C_VA_UART
diff --git a/arch/arm/mach-sa1100/include/mach/debug-macro.S b/arch/arm/mach-sa1100/include/mach/debug-macro.S
index 0cd0fc9..5ae99eb 100644
--- a/arch/arm/mach-sa1100/include/mach/debug-macro.S
+++ b/arch/arm/mach-sa1100/include/mach/debug-macro.S
@@ -12,6 +12,9 @@
 */
 #include <mach/hardware.h>
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
index a473f55..804fcee 100644
--- a/arch/arm/mach-shark/include/mach/debug-macro.S
+++ b/arch/arm/mach-shark/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  *
 */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #0xe0000000
 		orr	\rp, \rp, #0x000003f8
diff --git a/arch/arm/mach-u300/include/mach/debug-macro.S b/arch/arm/mach-u300/include/mach/debug-macro.S
index df71570..d478038 100644
--- a/arch/arm/mach-u300/include/mach/debug-macro.S
+++ b/arch/arm/mach-u300/include/mach/debug-macro.S
@@ -10,6 +10,9 @@
  */
 #include <mach/hardware.h>
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	/* If we move the address using MMU, use this. */
 	ldr	\rp,	  = U300_SLOW_PER_PHYS_BASE @ MMU off, physical address
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index 700fb05..fe49836 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -35,6 +35,9 @@
 #define UX500_UART(n)	__UX500_UART(n)
 #define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
 
+	.macro	inituart, id, a, v
+	.endm
+
 	.macro	addruart, rp, rv
 	ldr	\rp, =UART_BASE				@ no, physical address
 	ldr	\rv, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
diff --git a/arch/arm/mach-versatile/include/mach/debug-macro.S b/arch/arm/mach-versatile/include/mach/debug-macro.S
index eb2cf7d..09e6d37 100644
--- a/arch/arm/mach-versatile/include/mach/debug-macro.S
+++ b/arch/arm/mach-versatile/include/mach/debug-macro.S
@@ -11,6 +11,9 @@
  *
 */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp,      #0x001F0000
 		orr	\rp, \rp, #0x00001000
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index 050d65e..e4f982e 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -12,6 +12,9 @@
 
 #define DEBUG_LL_UART_OFFSET	0x00009000
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart,rp,rv
 		mov	\rp, #DEBUG_LL_UART_OFFSET
 		orr	\rv, \rp, #0xf8000000	@ virtual base
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 3b3a37c..8c7d0c6 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -53,6 +53,9 @@
 
 #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		ldr	\rp, =UART_PADDR	@ physical
 		ldr	\rv, =UART_VADDR	@ virtual
diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
index e91270e..5594e29 100644
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -14,6 +14,9 @@
 #include <linux/amba/serial.h>
 #include <mach/spear.h>
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
 		mov	\rv, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
diff --git a/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S b/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
index d3a0985..2e0652e 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
+++ b/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
@@ -16,6 +16,9 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		mov	\rp,      #0x00070000
 		add	\rv, \rp, #0xf0000000	@ virtual base
diff --git a/arch/arm/plat-tcc/include/mach/debug-macro.S b/arch/arm/plat-tcc/include/mach/debug-macro.S
index 7662f73..629901c 100644
--- a/arch/arm/plat-tcc/include/mach/debug-macro.S
+++ b/arch/arm/plat-tcc/include/mach/debug-macro.S
@@ -9,6 +9,9 @@
  *
  */
 
+		.macro	inituart, id, a, v
+		.endm
+
 		.macro	addruart, rp, rv
 		moveq	\rp, #0x90000000	@ physical base address
 		movne	\rv, #0xF1000000	@ virtual base

