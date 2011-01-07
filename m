From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Fri, 7 Jan 2011 16:12:30 +0000
Message-ID: <20110107161230.GR1198@n2100.arm.linux.org.uk>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com> <20110106203238.GH1198@n2100.arm.linux.org.uk> <20110106204053.GA7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49720 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab1AGQMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 11:12:38 -0500
Content-Disposition: inline
In-Reply-To: <20110106204053.GA7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jan 06, 2011 at 12:40:54PM -0800, Tony Lindgren wrote:
> Anyways, I can debug the DEBUG_LL booting issue further if the patch
> I posted does not help.

This is what I ended up with earlier today to make the debug code work
both in the decompressor and in the kernel - once I had it working I
haven't bothered putting any more effort into it.

diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 6a4d413..47df8a6 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -13,6 +13,7 @@
 
 #include <linux/serial_reg.h>
 
+#if 0
 #include <asm/memory.h>
 
 #include <plat/serial.h>
@@ -139,6 +140,24 @@ omap_uart_lsr:	.word	0
 		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		bne	1001b
 		.endm
+#else
+		.macro	addruart, rp, rv
+		mov	\rp, #0x00020000
+		orr	\rv, \rp, #0xfa000000
+		orr	\rp, \rp, #0x48000000
+		.endm
+
+		.macro	senduart, ch, rb
+		strb	\ch, [\rb]
+		.endm
+
+		.macro	busyuart, rb, tmp
+1001:		ldrb	\tmp, [\rb, #UART_LSR << 2]
+		and	\tmp, \tmp, #UART_LSR_TEMT | UART_LSR_THRE
+		teq	\tmp, #UART_LSR_TEMT | UART_LSR_THRE
+		bne	1001b
+		.endm
+#endif
 
 		.macro	waituart,rd,rx
 		.endm

