From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: Add tmp register for debug-macro.S files
Date: Tue, 26 Jan 2010 11:37:46 -0800
Message-ID: <20100126193746.15134.28570.stgit@baageli.muru.com>
References: <20100126193311.15134.24078.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50933 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab0AZTh1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 14:37:27 -0500
In-Reply-To: <20100126193311.15134.24078.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Done with:

$ sed -i -e "s/addruart,rx\|addruart, rx/addruart, rx, tmp/" \
        arch/arm/*/include/*/debug-macro.S

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-aaec2000/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-at91/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-davinci/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-dove/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    2 +-
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 ++--
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-h720x/include/mach/debug-macro.S     |    2 +-
 .../arm/mach-integrator/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-ixp2000/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-l7200/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-lh7a40x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-loki/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-mmp/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-msm/include/mach/debug-macro.S       |    4 ++--
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-netx/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-omap1/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-pxa/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-realview/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c6400/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-shark/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-u300/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-versatile/include/mach/debug-macro.S |    2 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    2 +-
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S  |    2 +-
 46 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-aaec2000/include/mach/debug-macro.S b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
index 0b6351d..a9cac36 100644
--- a/arch/arm/mach-aaec2000/include/mach/debug-macro.S
+++ b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
  */
 
 #include "hardware.h"
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x80000000		@ physical
diff --git a/arch/arm/mach-at91/include/mach/debug-macro.S b/arch/arm/mach-at91/include/mach/debug-macro.S
index 29052ba..9e750a1 100644
--- a/arch/arm/mach-at91/include/mach/debug-macro.S
+++ b/arch/arm/mach-at91/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 #include <mach/hardware.h>
 #include <mach/at91_dbgu.h>
 
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1						@ MMU enabled?
 	ldreq	\rx, =(AT91_BASE_SYS + AT91_DBGU)		@ System peripherals (phys address)
diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
index 64baf9f..fedd807 100644
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
@@ -13,7 +13,7 @@
 
 #include <asm/hardware/clps7111.h>
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #CLPS7111_PHYS_BASE
diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index 17ab523..3cd93a8 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -19,7 +19,7 @@
 #include <linux/serial_reg.h>
 #define UART_SHIFT	2
 
-		.macro addruart, rx
+		.macro addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x01000000	@ physical base address
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
index 9b89ec7..1521d13 100644
--- a/arch/arm/mach-dove/include/mach/debug-macro.S
+++ b/arch/arm/mach-dove/include/mach/debug-macro.S
@@ -8,7 +8,7 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =DOVE_SB_REGS_PHYS_BASE
diff --git a/arch/arm/mach-ebsa110/include/mach/debug-macro.S b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
index 1dde822..ebbd89f 100644
--- a/arch/arm/mach-ebsa110/include/mach/debug-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 **/
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mov	\rx, #0xf0000000
 		orr	\rx, \rx, #0x00000be0
 		.endm
diff --git a/arch/arm/mach-ep93xx/include/mach/debug-macro.S b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
index 802858b..5cd2244 100644
--- a/arch/arm/mach-ep93xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  */
 #include <mach/ep93xx-regs.h>
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1				@ MMU enabled?
 		ldreq	\rx, =EP93XX_APB_PHYS_BASE	@ Physical base
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index 4329b81..60dda13 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -15,7 +15,7 @@
 
 #ifndef CONFIG_DEBUG_DC21285_PORT
 	/* For NetWinder debugging */
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x7c000000	@ physical
@@ -32,7 +32,7 @@
 		.equ	dc21285_high, ARMCSR_BASE & 0xff000000
 		.equ	dc21285_low,  ARMCSR_BASE & 0x00ffffff
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x42000000
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
index d04a6ea..ad47704 100644
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ b/arch/arm/mach-gemini/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  */
 #include <mach/hardware.h>
 
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =GEMINI_UART_BASE			@ physical
diff --git a/arch/arm/mach-h720x/include/mach/debug-macro.S b/arch/arm/mach-h720x/include/mach/debug-macro.S
index 6294a13..a9ee8f0 100644
--- a/arch/arm/mach-h720x/include/mach/debug-macro.S
+++ b/arch/arm/mach-h720x/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 		.equ    io_virt, IO_BASE
 		.equ    io_phys, IO_START
 
-		.macro  addruart,rx
+		.macro  addruart, rx, tmp
 		mrc     p15, 0, \rx, c1, c0
 		tst     \rx, #1  	       @ MMU enabled?
 		moveq   \rx, #io_phys	       @ physical base address
diff --git a/arch/arm/mach-integrator/include/mach/debug-macro.S b/arch/arm/mach-integrator/include/mach/debug-macro.S
index d347d65..87a6888 100644
--- a/arch/arm/mach-integrator/include/mach/debug-macro.S
+++ b/arch/arm/mach-integrator/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x16000000	@ physical base address
diff --git a/arch/arm/mach-iop13xx/include/mach/debug-macro.S b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
index 9037d2e..c9d6ba4 100644
--- a/arch/arm/mach-iop13xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  */
 
-	.macro	addruart, rx
+	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1			@ mmu enabled?
 	moveq	\rx, #0xff000000	@ physical
diff --git a/arch/arm/mach-iop32x/include/mach/debug-macro.S b/arch/arm/mach-iop32x/include/mach/debug-macro.S
index 58b0166..736afe1 100644
--- a/arch/arm/mach-iop32x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  */
 
-		.macro	addruart, rx
+		.macro	addruart, rx, tmp
 		mov	\rx, #0xfe000000	@ physical as well as virtual
 		orr	\rx, \rx, #0x00800000	@ location of the UART
 		.endm
diff --git a/arch/arm/mach-iop33x/include/mach/debug-macro.S b/arch/arm/mach-iop33x/include/mach/debug-macro.S
index a60c9ef..addb2da 100644
--- a/arch/arm/mach-iop33x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  */
 
-		.macro	addruart, rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ mmu enabled?
 		moveq	\rx, #0xff000000	@ physical
diff --git a/arch/arm/mach-ixp2000/include/mach/debug-macro.S b/arch/arm/mach-ixp2000/include/mach/debug-macro.S
index 904ff56..6a82768 100644
--- a/arch/arm/mach-ixp2000/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp2000/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro  addruart,rx
+		.macro  addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0xc0000000	@ Physical base
diff --git a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
index 905db31..a82e375 100644
--- a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
@@ -12,7 +12,7 @@
  */
 #include <mach/ixp23xx.h>
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1				@ mmu enabled?
 		ldreq	\rx, =IXP23XX_PERIPHERAL_PHYS 	@ physical
diff --git a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
index 7c6a691..893873e 100644
--- a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
  * published by the Free Software Foundation.
 */
 
-                .macro  addruart,rx
+                .macro  addruart, rx, tmp
                 mrc     p15, 0, \rx, c1, c0
                 tst     \rx, #1                 @ MMU enabled?
                 moveq   \rx, #0xc8000000
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
index a4a55c1..d060677 100644
--- a/arch/arm/mach-kirkwood/include/mach/debug-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
@@ -8,7 +8,7 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =KIRKWOOD_REGS_PHYS_BASE
diff --git a/arch/arm/mach-ks8695/include/mach/debug-macro.S b/arch/arm/mach-ks8695/include/mach/debug-macro.S
index 3782c35..cf2095d 100644
--- a/arch/arm/mach-ks8695/include/mach/debug-macro.S
+++ b/arch/arm/mach-ks8695/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-uart.h>
 
-	.macro	addruart, rx
+	.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1				@ MMU enabled?
 		ldreq	\rx, =KS8695_UART_PA		@ physical base address
diff --git a/arch/arm/mach-l7200/include/mach/debug-macro.S b/arch/arm/mach-l7200/include/mach/debug-macro.S
index 34eed2a..b69ed34 100644
--- a/arch/arm/mach-l7200/include/mach/debug-macro.S
+++ b/arch/arm/mach-l7200/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 		.equ	io_virt, IO_BASE
 		.equ	io_phys, IO_START
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #io_phys		@ physical base address
diff --git a/arch/arm/mach-lh7a40x/include/mach/debug-macro.S b/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
index 85141ed..c0dcbbb 100644
--- a/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
+++ b/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 	@ It is not known if this will be appropriate for every 40x
 	@ board.
 
-		.macro  addruart,rx
+		.macro  addruart, rx, tmp
 		mrc     p15, 0, \rx, c1, c0
 		tst     \rx, #1                 @ MMU enabled?
 		mov     \rx, #0x00000700        @ offset from base
diff --git a/arch/arm/mach-loki/include/mach/debug-macro.S b/arch/arm/mach-loki/include/mach/debug-macro.S
index a8c20bd..3136c91 100644
--- a/arch/arm/mach-loki/include/mach/debug-macro.S
+++ b/arch/arm/mach-loki/include/mach/debug-macro.S
@@ -8,7 +8,7 @@
 
 #include <mach/loki.h>
 
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =LOKI_REGS_PHYS_BASE
diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
index a850f87..76deff2 100644
--- a/arch/arm/mach-mmp/include/mach/debug-macro.S
+++ b/arch/arm/mach-mmp/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
 
 #include <mach/addr-map.h>
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1				@ MMU enabled?
 		ldreq	\rx, =APB_PHYS_BASE		@ physical
diff --git a/arch/arm/mach-msm/include/mach/debug-macro.S b/arch/arm/mach-msm/include/mach/debug-macro.S
index d48747e..528750f 100644
--- a/arch/arm/mach-msm/include/mach/debug-macro.S
+++ b/arch/arm/mach-msm/include/mach/debug-macro.S
@@ -20,7 +20,7 @@
 #include <mach/msm_iomap.h>
 
 #ifdef CONFIG_MSM_DEBUG_UART
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	@ see if the MMU is enabled and select appropriate base address
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1
@@ -40,7 +40,7 @@
 	beq	1001b
 	.endm
 #else
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	.endm
 
 	.macro	senduart,rd,rx
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
index a06442f..cd81689 100644
--- a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
@@ -8,7 +8,7 @@
 
 #include <mach/mv78xx0.h>
 
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =MV78XX0_REGS_PHYS_BASE
diff --git a/arch/arm/mach-netx/include/mach/debug-macro.S b/arch/arm/mach-netx/include/mach/debug-macro.S
index 11b9d5b..e96339e 100644
--- a/arch/arm/mach-netx/include/mach/debug-macro.S
+++ b/arch/arm/mach-netx/include/mach/debug-macro.S
@@ -13,7 +13,7 @@
 
 #include "hardware.h"
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x00100000		@ physical
diff --git a/arch/arm/mach-nomadik/include/mach/debug-macro.S b/arch/arm/mach-nomadik/include/mach/debug-macro.S
index e876990..4f92acf 100644
--- a/arch/arm/mach-nomadik/include/mach/debug-macro.S
+++ b/arch/arm/mach-nomadik/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
  *
 */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x10000000	@ physical base address
diff --git a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
index c9530fb..0859336 100644
--- a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
 
 #include <mach/regs-board-a9m9750dev.h>
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, =NS9XXX_CSxSTAT_PHYS(0)
diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index aedb746..8c74cab 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0xff000000	@ physical base address
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index e9f255d..86979d7 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 #ifdef  CONFIG_ARCH_OMAP2
diff --git a/arch/arm/mach-orion5x/include/mach/debug-macro.S b/arch/arm/mach-orion5x/include/mach/debug-macro.S
index c7f808b..91e0e39 100644
--- a/arch/arm/mach-orion5x/include/mach/debug-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
 
 #include <mach/orion5x.h>
 
-	.macro  addruart,rx
+	.macro  addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =ORION5X_REGS_PHYS_BASE
diff --git a/arch/arm/mach-pnx4008/include/mach/debug-macro.S b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
index 6d1407f..6ca8bd3 100644
--- a/arch/arm/mach-pnx4008/include/mach/debug-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		mov	\rx, #0x00090000
diff --git a/arch/arm/mach-pxa/include/mach/debug-macro.S b/arch/arm/mach-pxa/include/mach/debug-macro.S
index 55d6a17..01cf813 100644
--- a/arch/arm/mach-pxa/include/mach/debug-macro.S
+++ b/arch/arm/mach-pxa/include/mach/debug-macro.S
@@ -13,7 +13,7 @@
 
 #include "hardware.h"
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x40000000		@ physical
diff --git a/arch/arm/mach-realview/include/mach/debug-macro.S b/arch/arm/mach-realview/include/mach/debug-macro.S
index 932d8af..8662228 100644
--- a/arch/arm/mach-realview/include/mach/debug-macro.S
+++ b/arch/arm/mach-realview/include/mach/debug-macro.S
@@ -33,7 +33,7 @@
 #error "Unknown RealView platform"
 #endif
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx,      #0x10000000
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
index b2a939f..6fc8d66 100644
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ b/arch/arm/mach-rpc/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x03000000
diff --git a/arch/arm/mach-s3c2410/include/mach/debug-macro.S b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
index 4c29a89..0eef78b 100644
--- a/arch/arm/mach-s3c2410/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
@@ -19,7 +19,7 @@
 #define S3C2410_UART1_OFF (0x4000)
 #define SHIFT_2440TXF (14-9)
 
-	.macro addruart, rx
+	.macro addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C24XX_PA_UART
diff --git a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
index f0ef0ab..239476b 100644
--- a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
 #include <mach/map.h>
 #include <plat/regs-serial.h>
 
-	.macro addruart, rx
+	.macro addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C24XX_PA_UART
diff --git a/arch/arm/mach-s3c6400/include/mach/debug-macro.S b/arch/arm/mach-s3c6400/include/mach/debug-macro.S
index b18ac52..5c88875 100644
--- a/arch/arm/mach-s3c6400/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c6400/include/mach/debug-macro.S
@@ -21,7 +21,7 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rx
+	.macro addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C_PA_UART
diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
index 9d142cc..e181f57 100644
--- a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
@@ -22,7 +22,7 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rx
+	.macro addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C_PA_UART
diff --git a/arch/arm/mach-sa1100/include/mach/debug-macro.S b/arch/arm/mach-sa1100/include/mach/debug-macro.S
index 1f0634d..336adcc 100644
--- a/arch/arm/mach-sa1100/include/mach/debug-macro.S
+++ b/arch/arm/mach-sa1100/include/mach/debug-macro.S
@@ -12,7 +12,7 @@
 */
 #include <mach/hardware.h>
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x80000000	@ physical base address
diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
index f97a762..50f071c 100644
--- a/arch/arm/mach-shark/include/mach/debug-macro.S
+++ b/arch/arm/mach-shark/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mov	\rx, #0xe0000000
 		orr	\rx, \rx, #0x000003f8
 		.endm
diff --git a/arch/arm/mach-u300/include/mach/debug-macro.S b/arch/arm/mach-u300/include/mach/debug-macro.S
index f3a1cbb..ca4a028 100644
--- a/arch/arm/mach-u300/include/mach/debug-macro.S
+++ b/arch/arm/mach-u300/include/mach/debug-macro.S
@@ -10,7 +10,7 @@
  */
 #include <mach/hardware.h>
 
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	/* If we move the adress using MMU, use this. */
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1			@ MMU enabled?
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index 8f21b6a..494408b 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  */
-	.macro	addruart,rx
+	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1			@MMU enabled?
 	moveq	\rx, #0x80000000	@MMU off, Physical address
diff --git a/arch/arm/mach-versatile/include/mach/debug-macro.S b/arch/arm/mach-versatile/include/mach/debug-macro.S
index b4ac00e..6fea719 100644
--- a/arch/arm/mach-versatile/include/mach/debug-macro.S
+++ b/arch/arm/mach-versatile/include/mach/debug-macro.S
@@ -11,7 +11,7 @@
  *
 */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx,      #0x10000000
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 15b2b14..5a6ae1b 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -52,7 +52,7 @@
 #define UART_PADDR	MXC91231_UART2_BASE_ADDR
 #define UART_VADDR	MXC91231_AIPS1_IO_ADDRESS(MXC91231_UART2_BASE_ADDR)
 #endif
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		ldreq	\rx, =UART_PADDR	@ physical
diff --git a/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S b/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
index fb3b969..1b9348b 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
+++ b/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
@@ -16,7 +16,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-		.macro	addruart,rx
+		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x80000000	@ physical base address

