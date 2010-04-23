From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/28] omap4: Fix build break when used with gcc-4.4.1
	(2009-q3)
Date: Fri, 23 Apr 2010 16:11:15 -0700
Message-ID: <20100423231115.31953.46396.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61393 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab0DWXLP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:15 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

From: Richard Woodruff <r-woodruff2@ti.com>

This patch adds  argument to smc calls as gcc-4.4.1 requires it
otherwise the build breaks with 2009-q3 toolchanin.

arch/arm/mach-omap2/omap-headsmp.S: Assembler messages:
arch/arm/mach-omap2/omap-headsmp.S:36: Error: missing expression -- `smc'
arch/arm/mach-omap2/omap-headsmp.S:55: Error: missing expression -- `smc'
arch/arm/mach-omap2/omap-headsmp.S:63: Error: missing expression -- `smc'
make[1]: *** [arch/arm/mach-omap2/omap-headsmp.o] Error 1

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-headsmp.S |    6 +++---
 arch/arm/mach-omap2/omap44xx-smc.S |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index aa3f65c..ef0e7a0 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -33,7 +33,7 @@
 ENTRY(omap_secondary_startup)
 hold:	ldr	r12,=0x103
 	dsb
-	smc				@ read from AuxCoreBoot0
+	smc	#0			@ read from AuxCoreBoot0
 	mov	r0, r0, lsr #9
 	mrc	p15, 0, r4, c0, c0, 5
 	and	r4, r4, #0x0f
@@ -52,7 +52,7 @@ ENTRY(omap_modify_auxcoreboot0)
 	stmfd   sp!, {r1-r12, lr}
 	ldr	r12, =0x104
 	dsb
-	smc
+	smc	#0
 	ldmfd   sp!, {r1-r12, pc}
 END(omap_modify_auxcoreboot0)
 
@@ -60,6 +60,6 @@ ENTRY(omap_auxcoreboot_addr)
 	stmfd   sp!, {r2-r12, lr}
 	ldr	r12, =0x105
 	dsb
-	smc
+	smc	#0
 	ldmfd   sp!, {r2-r12, pc}
 END(omap_auxcoreboot_addr)
diff --git a/arch/arm/mach-omap2/omap44xx-smc.S b/arch/arm/mach-omap2/omap44xx-smc.S
index 89bb2b1..f61c777 100644
--- a/arch/arm/mach-omap2/omap44xx-smc.S
+++ b/arch/arm/mach-omap2/omap44xx-smc.S
@@ -27,6 +27,6 @@ ENTRY(omap_smc1)
 	mov	r12, r0
 	mov 	r0, r1
 	dsb
-	smc
+	smc	#0
 	ldmfd   sp!, {r2-r12, pc}
 END(omap_smc1)

