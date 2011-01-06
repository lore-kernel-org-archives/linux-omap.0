From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 11:52:25 -0800
Message-ID: <20110106195225.GX7771@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15448 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab1AFTwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 14:52:39 -0500
Content-Disposition: inline
In-Reply-To: <20110106182023.GV7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110106 10:20]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 10:00]:
> > On Thu, Jan 06, 2011 at 05:08:05PM +0000, Russell King - ARM Linux wrote:
> > 
> > And another thing: turning on DEBUG in the decompressor breaks the build
> > on OMAP:
> > 
> > `.data' referenced in section `.text' of arch/arm/boot/compressed/head.o: defined in discarded section `.data' of arch/arm/boot/compressed/head.o
> > `.data' referenced in section `.text' of arch/arm/boot/compressed/head.o: defined in discarded section `.data' of arch/arm/boot/compressed/head.o
> > 
> > Is there a reason why this:
> > 
> >                 .pushsection .data
> > omap_uart_phys: .word   0
> > omap_uart_virt: .word   0
> > omap_uart_lsr:  .word   0
> >                 .popsection
> > 
> > can't be in the BSS section?
> 
> BSS works too, got a patch for that?

Actually BSS won't work here, that's not initialized early enough..

But it seems that the only patch that's needed is the following.
Care to give it a try?

Here's what I'm getting with this patch and DEBUG enabled for the uncompress
code on my omap4 panda:

Uncompressing Linux... done, booting the kernel.

00AC3990:00000AE7:00C5187F
802C9EBC-80849D3C>80008000
80849D9C
80008000: E321F0D3 EE109F10 EB0F216F E1B0A005  0A0F217E EB0000D8 E1B08005 0A000094
80008020: EB0000E5 EB0F214B EB000004 E59FD008  E28FE000 E28AF010 EA0F213B C00083F4
80008040: E59F4204 E1A00004 E3A03000 E2806901  E4803004 E4803004 E4803004 E4803004
80008060: E1300006 1AFFFFF9 E59A7008 E28F0F7D  E8900068 E0400003 E0855000 E0866000
80008080: E1A05A25 E1A06A26 E1873A05 E7843105  E1350006 12855001 1AFFFFFA E1A0300F
800080A0: E1A03A23 E1873A03 E2840A03 E5A03000  E59F6198 E2800004 E0846926 E1500006
800080C0: E2833601 94803004 9AFFFFFB E2840A03  E3876102 E5806000 EE117F10 E3170001
800080E0: 059F716C 159F716C E2873004 E5977000  E5933000 E3570000 13530000 1A000043
[    0.000000] Linux version 2.6.37-00001-g98859f0-dirty (tmlind@baageli) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #468 SMP Thu Jan 6 11:46:09 PST 2011
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP4 Panda board
[    0.000000] bootconsole [earlycon0] enabled
...

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 6 Jan 2011 11:29:39 -0800
Subject: [PATCH] ARM: Fix low-level decompress debug code for omap

If DEBUG is enabled for decompress code, the system will hang
as the debug UART is not specified. Fix this by adding the
necessary code for omap2plus.

Note that this won't work properly with multi-omap support
compiled in. Also the debug UART used needs to be patched
in if not omap UART3.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -71,6 +71,23 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 		mov	\rb, #0x50000000
 		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
 		.endm
+#elif defined(CONFIG_ARCH_OMAP2PLUS)
+#include <plat/multi.h>
+#ifdef MULTI_OMAP2)
+#error Low-level uncompress debug code won't work with multi-omap
+#elif defined(CONFIG_ARCH_OMAP2)
+		.macro loadsp, rb, tmp
+		ldr	\rb, =OMAP2_UART3_BASE	/* patch accordingly */
+		.endm
+#elif defined(CONFIG_ARCH_OMAP3)
+		.macro loadsp, rb, tmp
+		ldr	\rb, =OMAP3_UART3_BASE	/* patch accordingly */
+		.endm
+#elif defined(CONFIG_ARCH_OMAP4)
+		.macro loadsp, rb, tmp
+		ldr	\rb, =OMAP4_UART3_BASE	/* patch accordingly */
+		.endm
+#endif
 #else
 		.macro	loadsp,	rb, tmp
 		addruart \rb, \tmp
