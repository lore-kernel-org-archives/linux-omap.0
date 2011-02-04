From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix DEBUG_LL code for p2v changes (Re: Fwd: [RFC
 4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys runtime patching)
Date: Thu, 3 Feb 2011 17:15:39 -0800
Message-ID: <20110204011538.GN3322@atomide.com>
References: <20110118183252.GJ16980@n2100.arm.linux.org.uk>
 <20110118203706.GR4957@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60221 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab1BDBQB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:16:01 -0500
Content-Disposition: inline
In-Reply-To: <20110118203706.GR4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [110118 12:36]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110118 10:32]:
> > A warning for OMAP.
> > 
> > Your use of the __virt_to_phys() in assembly code for the debug stuff
> > will break with this patch... please ensure that it is resolved by the
> > next merge window.
> 
> Sure thanks. I'm aware of this series, will take care of it.

Here's a minimal fix for your p2v branch. Will send more DEBUG_LL
related patches in a separate series.

Regards,

Tony

--ZGiS0Q5IWpPtfppv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="inituart-omap-p2v.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 3 Feb 2011 15:17:44 -0800
Subject: [PATCH] omap: Fix DEBUG_LL code for p2v changes

These are needed for CONFIG_ARM_PATCH_PHYS_VIRT to work.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -17,6 +17,9 @@
 
 #include <plat/serial.h>
 
+#define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
+#define omap_uart_p2v(x)	((x) - PLAT_PHYS_OFFSET + PAGE_OFFSET)
+
 		.pushsection .data
 omap_uart_phys:	.word	0x0
 omap_uart_virt:	.word	0x0
@@ -33,7 +36,7 @@ omap_uart_virt:	.word	0x0
 		/* Use omap_uart_phys/virt if already configured */
 9:		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
 		ldrne	\rp, =omap_uart_phys	@ MMU enabled
 		add	\rv, \rp, #4		@ omap_uart_virt
 		ldr	\rp, [\rp, #0]
@@ -46,7 +49,7 @@ omap_uart_virt:	.word	0x0
 		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
 		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
-		ldrne	\rp, =__phys_to_virt(OMAP_UART_INFO)	@ MMU enabled
+		ldrne	\rp, =omap_uart_p2v(OMAP_UART_INFO)	@ MMU enabled
 		ldr	\rp, [\rp, #0]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
@@ -73,7 +76,7 @@ omap_uart_virt:	.word	0x0
 98:		add	\rp, \rp, #0xff000000	@ phys base
 		mrc	p15, 0, \rv, c1, c0
 		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
 		ldrne	\rv, =omap_uart_phys	@ MMU enabled
 		str	\rp, [\rv, #0]
 		sub	\rp, \rp, #0xff000000	@ phys base
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -19,6 +19,9 @@
 
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
 
+#define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
+#define omap_uart_p2v(x)	((x) - PLAT_PHYS_OFFSET + PAGE_OFFSET)
+
 		.pushsection .data
 omap_uart_phys:	.word	0
 omap_uart_virt:	.word	0
@@ -36,7 +39,7 @@ omap_uart_lsr:	.word	0
 		/* Use omap_uart_phys/virt if already configured */
 10:		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
 		ldrne	\rp, =omap_uart_phys	@ MMU enabled
 		add	\rv, \rp, #4		@ omap_uart_virt
 		ldr	\rp, [\rp, #0]
@@ -49,7 +52,7 @@ omap_uart_lsr:	.word	0
 		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
 		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
-		ldrne	\rp, =__phys_to_virt(OMAP_UART_INFO)	@ MMU enabled
+		ldrne	\rp, =omap_uart_p2v(OMAP_UART_INFO)	@ MMU enabled
 		ldr	\rp, [\rp, #0]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
@@ -94,7 +97,7 @@ omap_uart_lsr:	.word	0
 95:		ldr	\rp, =ZOOM_UART_BASE
 		mrc	p15, 0, \rv, c1, c0
 		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
 		ldrne	\rv, =omap_uart_phys	@ MMU enabled
 		str	\rp, [\rv, #0]
 		ldr	\rp, =ZOOM_UART_VIRT
@@ -109,7 +112,7 @@ omap_uart_lsr:	.word	0
 98:		add	\rp, \rp, #0x48000000	@ phys base
 		mrc	p15, 0, \rv, c1, c0
 		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
 		ldrne	\rv, =omap_uart_phys	@ MMU enabled
 		str	\rp, [\rv, #0]
 		sub	\rp, \rp, #0x48000000	@ phys base
@@ -131,7 +134,7 @@ omap_uart_lsr:	.word	0
 		.macro	busyuart,rd,rx
 1001:		mrc	p15, 0, \rd, c1, c0
 		tst	\rd, #1			@ MMU enabled?
-		ldreq	\rd, =__virt_to_phys(omap_uart_lsr)	@ MMU not enabled
+		ldreq	\rd, =omap_uart_v2p(omap_uart_lsr)	@ MMU disabled
 		ldrne	\rd, =omap_uart_lsr	@ MMU enabled
 		ldr	\rd, [\rd, #0]
 		ldrb	\rd, [\rx, \rd]

--ZGiS0Q5IWpPtfppv--
