From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/3] omap4: Add smc API to read AuxCoreBoot0 register
Date: Tue,  6 Jul 2010 20:28:23 +0530
Message-ID: <1278428303-8673-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46593 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab0GFO6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jul 2010 10:58:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds a secure API to read AuxCoreBoot0 register to
check the cpu boot status. It also moves the other smc APIs
to common omap44xx-smc.S. This APIs should not be marked as
__INIT because we need these to be present for CPU hotplug

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S    |   16 ----------------
 arch/arm/mach-omap2/omap44xx-smc.S    |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/smp.h |    1 +
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index ef0e7a0..6ae937a 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -47,19 +47,3 @@ hold:	ldr	r12,=0x103
 	b	secondary_startup
 END(omap_secondary_startup)
 
-
-ENTRY(omap_modify_auxcoreboot0)
-	stmfd   sp!, {r1-r12, lr}
-	ldr	r12, =0x104
-	dsb
-	smc	#0
-	ldmfd   sp!, {r1-r12, pc}
-END(omap_modify_auxcoreboot0)
-
-ENTRY(omap_auxcoreboot_addr)
-	stmfd   sp!, {r2-r12, lr}
-	ldr	r12, =0x105
-	dsb
-	smc	#0
-	ldmfd   sp!, {r2-r12, pc}
-END(omap_auxcoreboot_addr)
diff --git a/arch/arm/mach-omap2/omap44xx-smc.S b/arch/arm/mach-omap2/omap44xx-smc.S
index f61c777..1980dc3 100644
--- a/arch/arm/mach-omap2/omap44xx-smc.S
+++ b/arch/arm/mach-omap2/omap44xx-smc.S
@@ -30,3 +30,28 @@ ENTRY(omap_smc1)
 	smc	#0
 	ldmfd   sp!, {r2-r12, pc}
 END(omap_smc1)
+
+ENTRY(omap_modify_auxcoreboot0)
+	stmfd   sp!, {r1-r12, lr}
+	ldr	r12, =0x104
+	dsb
+	smc	#0
+	ldmfd   sp!, {r1-r12, pc}
+END(omap_modify_auxcoreboot0)
+
+ENTRY(omap_auxcoreboot_addr)
+	stmfd   sp!, {r2-r12, lr}
+	ldr	r12, =0x105
+	dsb
+	smc	#0
+	ldmfd   sp!, {r2-r12, pc}
+END(omap_auxcoreboot_addr)
+
+ENTRY(omap_read_auxcoreboot0)
+	stmfd   sp!, {r2-r12, lr}
+	ldr	r12, =0x103
+	dsb
+	smc	#0
+	mov	r0, r0, lsr #9
+	ldmfd   sp!, {r2-r12, pc}
+END(omap_read_auxcoreboot0)
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
index 8983d54..6a3ff65 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -30,6 +30,7 @@
 extern void omap_secondary_startup(void);
 extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
+extern u32 omap_read_auxcoreboot0(void);
 
 /*
  * We use Soft IRQ1 as the IPI
-- 
1.6.0.4

