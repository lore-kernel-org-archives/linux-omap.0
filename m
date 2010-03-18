From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: Fix build break when used with gcc-4.4.1 (2009-q3)
Date: Thu, 18 Mar 2010 11:16:28 +0530
Message-ID: <1268891188-31562-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57250 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab0CRFqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 01:46:36 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2I5kWLE028746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 00:46:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Richard Woodruff <r-woodruff2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

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
---
The patch is generated against linux-omap  "omap-fixes-for-linus" and 
also applies on master branch. Boot tesetd on omap4430 SDP.

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
-- 
1.6.0.4

