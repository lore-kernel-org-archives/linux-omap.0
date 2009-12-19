From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] arm: Fix DCC console for v7
Date: Fri, 18 Dec 2009 19:45:54 -0800
Message-ID: <20091219034554.26198.60138.stgit@localhost>
References: <20091219034151.26198.26570.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58244 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbZLSDp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 22:45:56 -0500
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Without this patch arch/arm/compressed/head.S defaults to generic
DCC code that does not work for v7.

For more information on the v7 DCC, see Cortex-A8 TRM
"12.11.1 Debug communications channel".

To use it with post 2.6.33-rc1 or later, you need to have:

CONFIG_DEBUG_LL=y
ONFIG_DEBUG_ICEDCC=y
CONFIG_EARLY_PRINTK=y

Earlier kernels need commit 93fd03a8c6728b58879f8af20ffd55d9c32a778b
backported.

Tested on omap3430.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/compressed/head.S |    8 ++++++++
 arch/arm/boot/compressed/misc.c |   12 ++++++++++++
 arch/arm/kernel/debug.S         |   20 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index d356af7..4fddc50 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -27,6 +27,14 @@
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
+#elif defined(CONFIG_CPU_V7)
+		.macro	loadsp, rb
+		.endm
+		.macro	writeb, ch, rb
+wait:		mrc	p14, 0, pc, c0, c1, 0
+		bcs	wait
+		mcr	p14, 0, \ch, c0, c5, 0
+		.endm
 #elif defined(CONFIG_CPU_XSCALE)
 		.macro	loadsp, rb
 		.endm
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 17153b5..2d1e819 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -48,6 +48,18 @@ static void icedcc_putc(int ch)
 
 	asm("mcr p14, 0, %0, c0, c5, 0" : : "r" (ch));
 }
+
+#elif defined(CONFIG_CPU_V7)
+
+static void icedcc_putc(int ch)
+{
+	asm(
+	"wait:	mrc	p14, 0, pc, c0, c1, 0			\n\
+		bcs	wait					\n\
+		mcr     p14, 0, %0, c0, c5, 0			"
+	: : "r" (ch));
+}
+
 #elif defined(CONFIG_CPU_XSCALE)
 
 static void icedcc_putc(int ch)
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index b121b60..5c91add 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -49,6 +49,26 @@
 1002:
 		.endm
 
+#elif defined(CONFIG_CPU_V7)
+
+		.macro	addruart, rx
+		.endm
+
+		.macro	senduart, rd, rx
+		mcr	p14, 0, \rd, c0, c5, 0
+		.endm
+
+		.macro	busyuart, rd, rx
+busy:		mrc	p14, 0, pc, c0, c1, 0
+		bcs	busy
+		.endm
+
+		.macro	waituart, rd, rx
+wait:		mrc	p14, 0, pc, c0, c1, 0
+		bcs	wait
+
+		.endm
+
 #elif defined(CONFIG_CPU_XSCALE)
 
 		.macro	addruart, rx

