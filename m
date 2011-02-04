From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for DEBUG_LL
Date: Thu, 03 Feb 2011 17:27:09 -0800
Message-ID: <20110204012709.26410.78100.stgit@baageli.muru.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20859 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab1BDB1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:27:24 -0500
In-Reply-To: <20110204012317.26410.55157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This way we can have the debug-macro.S be common for omap1 and omap2+
and get sensible error messages booting the wrong zImage with
CONFIG_AUTO_ZRELADDR selected. Note that this does not seem to work
with u-boot and uImage.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |   36 ++++++++++++++++++++----
 arch/arm/mach-omap2/include/mach/debug-macro.S |   27 +++++++++++++++++-
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 80dcf18..bae924e 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -27,7 +27,15 @@
 		.macro	inituart, id, a, v
 		mrc	p15, 0, \a, c1, c0
 		tst	\a, #1			@ MMU enabled?
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\a, =omap_uart_phys
+		biceq	\a, \a, #0xf8000000	@ clear top bits of virt addr
+		moveq	\v, pc			@ copy pc
+		andeq	\v, \v, #0xf8000000	@ clear lower bits
+		orreq	\a, \v			@ combile to get phys addr
+#else
 		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
+#endif
 		ldrne	\a, =omap_uart_phys
 		mov	\v, #(UART_LSR << OMAP_PORT_SHIFT)
 		str	\v, [\a, #8]		@ save lsr, different for 7xx
@@ -101,7 +109,15 @@
 		/* Use omap_uart_phys/virt if already configured */
 		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\rp, =omap_uart_phys	@ MMU disabled
+		biceq	\rp, \rp, #0xf8000000	@ clear top bits of virt addr
+		moveq	\rv, pc			@ copy pc
+		andeq	\rv, \rv, #0xf8000000	@ clear lower bits
+		orreq	\rp, \rv		@ combine to get phys addr
+#else
 		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
+#endif
 		ldrne	\rp, =omap_uart_phys	@ MMU enabled
 		add	\rv, \rp, #4		@ omap_uart_virt
 		ldr	\rp, [\rp, #0]
@@ -113,15 +129,23 @@
 		.endm
 
 		.macro	busyuart,rd,rx
-1001:		ldrb	\rd, [\rx, #(UART_LSR << OMAP_PORT_SHIFT)]
-		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		beq	1002f
-		ldrb	\rd, [\rx, #(UART_LSR << OMAP7XX_PORT_SHIFT)]
+1001:		mrc	p15, 0, \rd, c1, c0
+		tst	\rd, #1			@ MMU enabled?
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\rd, =omap_uart_lsr	@ MMU disabled
+		biceq	\rd, \rd, #0xf8000000	@ clear top bits of virt addr
+		roreq	\rd, \rd, #27		@ rotate bits
+		orreq	\rd, pc, lsr #27	@ orr with top bits of pc
+		roreq	\rd, \rd, #5		@ rotate bits back
+#else
+		ldreq	\rd, =omap_uart_v2p(omap_uart_lsr)	@ MMU disabled
+#endif
+		ldrne	\rd, =omap_uart_lsr	@ MMU enabled
+		ldr	\rd, [\rd, #0]
+		ldrb	\rd, [\rx, \rd]
 		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		bne	1001b
-1002:
 		.endm
 
 		.macro	waituart,rd,rx
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 45c29e3..80e0bdc 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -27,8 +27,17 @@
 		.macro	inituart, id, a, v
 		mrc	p15, 0, \a, c1, c0
 		tst	\a, #1			@ MMU enabled?
+		ldreq	\a, =omap_uart_phys
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\a, =omap_uart_phys
+		biceq	\a, \a, #0xf8000000	@ clear top bits of virt addr
+		moveq	\v, pc			@ copy pc
+		andeq	\v, \v, #0xf8000000	@ clear lower bits
+		orreq	\a, \v			@ combile to get phys addr
+#else
 		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
-		ldrne	\a, =omap_uart_phys
+#endif
+		ldrne	\a, =omap_uart_phys	@ MMU enabled
 		mov	\v, #(UART_LSR << OMAP_PORT_SHIFT)
 		str	\v, [\a, #8]		@ save lsr, different for zoom
 
@@ -151,7 +160,15 @@
 		/* Use omap_uart_phys/virt if already configured */
 		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\rp, =omap_uart_phys	@ MMU disabled
+		biceq	\rp, \rp, #0xf8000000	@ clear top bits of virt addr
+		moveq	\rv, pc			@ copy pc
+		andeq	\rv, \rv, #0xf8000000	@ clear lower bits
+		orreq	\rp, \rv		@ combine to get phys addr
+#else
 		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
+#endif
 		ldrne	\rp, =omap_uart_phys	@ MMU enabled
 		add	\rv, \rp, #4		@ omap_uart_virt
 		ldr	\rp, [\rp, #0]
@@ -165,7 +182,15 @@
 		.macro	busyuart,rd,rx
 1001:		mrc	p15, 0, \rd, c1, c0
 		tst	\rd, #1			@ MMU enabled?
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\rd, =omap_uart_lsr	@ MMU disabled
+		biceq	\rd, \rd, #0xf8000000	@ clear top bits of virt addr
+		roreq	\rd, \rd, #27		@ rotate bits
+		orreq	\rd, pc, lsr #27	@ orr with top bits of pc
+		roreq	\rd, \rd, #5		@ rotate bits back
+#else
 		ldreq	\rd, =omap_uart_v2p(omap_uart_lsr)	@ MMU disabled
+#endif
 		ldrne	\rd, =omap_uart_lsr	@ MMU enabled
 		ldr	\rd, [\rd, #0]
 		ldrb	\rd, [\rx, \rd]

