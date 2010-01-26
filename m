From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: Add tmp register for addruart and loadsp
Date: Tue, 26 Jan 2010 11:37:41 -0800
Message-ID: <20100126193741.15134.16101.stgit@baageli.muru.com>
References: <20100126193311.15134.24078.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63164 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab0AZThY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 14:37:24 -0500
In-Reply-To: <20100126193311.15134.24078.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise more complicated uart configuration won't be possible.
We can use r1 for tmp register for both head.S and debug.S.

NOTE: This patch depends on another patch to add the the \tmp register
into all debug-macro.S files. That can be done with:

$ sed -i -e "s/addruart,rx\|addruart, rx/addruart, rx, tmp/" \
	arch/arm/*/include/*/debug-macro.S

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/compressed/head.S |   20 ++++++++++----------
 arch/arm/kernel/debug.S         |   12 ++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

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

