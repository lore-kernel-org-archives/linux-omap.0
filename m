From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
 generic
Date: Thu, 21 Jan 2010 11:03:38 -0800
Message-ID: <20100121190337.GN23467@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013515.10065.30649.stgit@baageli.muru.com>
 <20100116093555.GA13596@n2100.arm.linux.org.uk>
 <20100116191820.GI10318@atomide.com>
 <20100116193313.GA23092@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kfjH4zxOES6UT95V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60862 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0AUTDk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 14:03:40 -0500
Content-Disposition: inline
In-Reply-To: <20100116193313.GA23092@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 11:31]:
> On Sat, Jan 16, 2010 at 11:18:20AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 01:33]:
> > > On Fri, Jan 15, 2010 at 05:35:15PM -0800, Tony Lindgren wrote:
> > > > diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > index 23e4724..0174858 100644
> > > > --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > @@ -15,18 +15,71 @@
> > > >  
> > > >  #include <plat/serial.h>
> > > >  
> > > > +omap_uart_phys:	.word	0x0
> > > > +omap_uart_virt:	.word	0x0
> > > 
> > > I assume that you have no plans for XIP kernel support on OMAP, since
> > > these will be placed in the .text section, and is therefore read-only
> > > on XIP kernels.
> > 
> > Did not think of that.. Maybe some addruart_premable solution here would.
> > Or adding \tmp register for addruart and just do the detection for each
> > character.

<snip>
 
> Why not do something like this:
> 
> 		.pushsection .data
> omap_uart_phys:	.word 0
> omap_uart_virt:	.word 0
> 		.popsection
> 
> 		.macro addruart, rx
> ...		
> +               ldreq   \rx, =omap_uart_phys    @ physical base address
> +               ldrne   \rx, =omap_uart_virt    @ virtual base
> 		ldr	\rx, [\rx]
> +               cmp     \rx, #0                 @ is port configured?
> +               bne     99f                     @ already configured
> ...
> 
> ?

Works fine, but it add one issue. Looks like we need to add tmp register
into addruart to initially save the omap_uart_phys and omap_uart_virt:

+		/* Store both phys and virt address for the uart */
+98:		add	\rx, \rx, #0x48000000	@ phys base
+		ldr	\tmp, =omap_uart_phys
+		str	\rx, [\tmp, #0]
+		sub	\rx, \rx, #0x48000000	@ phys base
+		add	\rx, \rx, #0xfa000000	@ virt base
+		ldr	\tmp, =omap_uart_virt
+		str	\rx, [\tmp, #0]

Does the following patch look OK to you, or do you have some other way
in mind for doing it?

Regards,

Tony

--kfjH4zxOES6UT95V
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="arm-addruart-extra-reg.patch"

>From fae696043ad94ce83709ae72564623f42e66488c Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Jan 2010 18:26:32 -0800
Subject: [PATCH] arm: Add \tmp register for addruart and loadsp

Otherwise more complicated uart configuration won't be possible.
We can use r1 for tmp register for both head.S and debug.S.

NOTE: This patch depends on another patch to add the the \tmp register
into all debug-macro.S files. That can be done with:

$ find arch/arm -name debug-macro.S | xargs -n1 -i sed -i \
-e "s/addruart,rx\|addruart, rx/addruart, rx, tmp/" {}

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4fddc50..99b75aa 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -22,13 +22,13 @@
 #if defined(CONFIG_DEBUG_ICEDCC)
 
 #ifdef CONFIG_CPU_V6
-		.macro	loadsp, rb
+		.macro	loadsp, rb, tmp
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
 #elif defined(CONFIG_CPU_V7)
-		.macro	loadsp, rb
+		.macro	loadsp, rb, tmp
 		.endm
 		.macro	writeb, ch, rb
 wait:		mrc	p14, 0, pc, c0, c1, 0
@@ -36,13 +36,13 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
 #elif defined(CONFIG_CPU_XSCALE)
-		.macro	loadsp, rb
+		.macro	loadsp, rb, tmp
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c8, c0, 0
 		.endm
 #else
-		.macro	loadsp, rb
+		.macro	loadsp, rb, tmp
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c1, c0, 0
@@ -58,7 +58,7 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 		.endm
 
 #if defined(CONFIG_ARCH_SA1100)
-		.macro	loadsp, rb
+		.macro	loadsp, rb, tmp
 		mov	\rb, #0x80000000	@ physical base address
 #ifdef CONFIG_DEBUG_LL_SER3
 		add	\rb, \rb, #0x00050000	@ Ser3
@@ -67,13 +67,13 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 #endif
 		.endm
 #elif defined(CONFIG_ARCH_S3C2410)
-		.macro loadsp, rb
+		.macro loadsp, rb, tmp
 		mov	\rb, #0x50000000
 		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
 		.endm
 #else
-		.macro	loadsp,	rb
-		addruart \rb
+		.macro	loadsp,	rb, tmp
+		addruart \rb, \tmp
 		.endm
 #endif
 #endif
@@ -1025,7 +1025,7 @@ phex:		adr	r3, phexbuf
 		strb	r2, [r3, r1]
 		b	1b
 
-puts:		loadsp	r3
+puts:		loadsp	r3, r1
 1:		ldrb	r2, [r0], #1
 		teq	r2, #0
 		moveq	pc, lr
@@ -1042,7 +1042,7 @@ puts:		loadsp	r3
 putc:
 		mov	r2, r0
 		mov	r0, #0
-		loadsp	r3
+		loadsp	r3, r1
 		b	2b
 
 memdump:	mov	r12, r0
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index 5c91add..a38b487 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -24,7 +24,7 @@
 
 #if defined(CONFIG_CPU_V6)
 
-		.macro	addruart, rx
+		.macro	addruart, rx, tmp
 		.endm
 
 		.macro	senduart, rd, rx
@@ -51,7 +51,7 @@
 
 #elif defined(CONFIG_CPU_V7)
 
-		.macro	addruart, rx
+		.macro	addruart, rx, tmp
 		.endm
 
 		.macro	senduart, rd, rx
@@ -71,7 +71,7 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 
 #elif defined(CONFIG_CPU_XSCALE)
 
-		.macro	addruart, rx
+		.macro	addruart, rx, tmp
 		.endm
 
 		.macro	senduart, rd, rx
@@ -98,7 +98,7 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 
 #else
 
-		.macro	addruart, rx
+		.macro	addruart, rx, tmp
 		.endm
 
 		.macro	senduart, rd, rx
@@ -164,7 +164,7 @@ ENDPROC(printhex2)
 		.ltorg
 
 ENTRY(printascii)
-		addruart r3
+		addruart r3, r1
 		b	2f
 1:		waituart r2, r3
 		senduart r1, r3
@@ -180,7 +180,7 @@ ENTRY(printascii)
 ENDPROC(printascii)
 
 ENTRY(printch)
-		addruart r3
+		addruart r3, r1
 		mov	r1, r0
 		mov	r0, #0
 		b	1b

--kfjH4zxOES6UT95V--
