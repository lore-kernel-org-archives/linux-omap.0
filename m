From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 11/18] ARM: OMAP5: PM: Add L2 memory power down support
Date: Mon, 25 Mar 2013 15:35:03 +0530
Message-ID: <1364205910-32392-12-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35772 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab3CYKEH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:04:07 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

When the entire MPUSS cluster is powered down in device off state, L2 cache
memory looses it's content and hence while targetting such a state,
l2 cache needs to be flushed to main memory.

Add the necessary low power code support for the same.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-secure.h     |    1 +
 arch/arm/mach-omap2/sleep_omap4plus.S |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 1739468..a171a5a 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -47,6 +47,7 @@
 #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
 #define OMAP5_MON_CACHES_CLEAN_INDEX	0x103
 #define OMAP5_MON_AUX_CTRL_INDEX	0x107
+#define OMAP5_MON_L2AUX_CTRL_INDEX	0x104
 
 #define OMAP5_MON_AMBA_IF_INDEX		0x108
 
diff --git a/arch/arm/mach-omap2/sleep_omap4plus.S b/arch/arm/mach-omap2/sleep_omap4plus.S
index 4a5e2e4..288f62f 100644
--- a/arch/arm/mach-omap2/sleep_omap4plus.S
+++ b/arch/arm/mach-omap2/sleep_omap4plus.S
@@ -337,6 +337,7 @@ ENDPROC(omap4_cpu_resume)
  *	0 - Nothing lost and no need to save: MPUSS INA/CSWR
  *	1 - CPUx L1 and logic lost: CPU OFF, MPUSS INA/CSWR
  *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
+ *	3 - CPUx L1 and logic lost + GIC,L2 lost: MPU OSWR & L2 lost(debug only)
  */
 ENTRY(omap5_finish_suspend)
 	stmfd	sp!, {r4-r12, lr}
@@ -391,6 +392,26 @@ skip_secure_l1_clean_op:
 	isb
 	dsb
 
+	bl	omap4_get_sar_ram_base
+	mov	r8, r0
+	mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
+	ands	r5, r5, #0x0f
+	ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]	@ Retrieve L2 state
+	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]
+	cmp	r0, #3
+	bne	do_wfi
+	bl	omap4_get_sar_ram_base
+	ldr	r9, [r0, #OMAP_TYPE_OFFSET]
+	cmp	r9, #0x1			@ Check for HS device
+	bne	skip_secure_l2_clean_op
+	mov	r0, #1				@ Clean secure L2
+	stmfd   r13!, {r4-r12, r14}
+	ldr	r12, =OMAP5_MON_CACHES_CLEAN_INDEX
+	DO_SMC
+	ldmfd   r13!, {r4-r12, r14}
+skip_secure_l2_clean_op:
+	bl	v7_flush_dcache_all
+
 do_wfi:
 	bl	omap_do_wfi
 
-- 
1.7.9.5

