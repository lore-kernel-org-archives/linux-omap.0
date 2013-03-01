From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 11/15] ARM: OMAP5: PM: Add L2 memory power down support
Date: Fri, 1 Mar 2013 17:41:00 +0530
Message-ID: <1362139864-9233-12-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33028 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab3CAMKS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 07:10:18 -0500
In-Reply-To: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

When the entire MPUSS cluster is powered down in device off state, L2 cache
memory looses it's content and hence while targetting such a state,
l2 cache needs to be flushed to main memory.

Add the necessary low power code support for the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-secure.h     |    1 +
 arch/arm/mach-omap2/sleep_omap4plus.S |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

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
index f4874e5..ea318be 100644
--- a/arch/arm/mach-omap2/sleep_omap4plus.S
+++ b/arch/arm/mach-omap2/sleep_omap4plus.S
@@ -386,6 +386,27 @@ skip_secure_l1_clean_op:
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
+	mov	r0, #2				@ Flush L2
+	bl	v7_flush_dcache_all
+
 do_wfi:
 	bl	omap_do_wfi
 
@@ -427,6 +448,15 @@ ENTRY(omap5_cpu_resume)
 	dsb
 1:
 #endif
+	mrc	p15, 1, r0, c15, c0, 0		@ Read L2 ACTLR
+	cmp	r0, #0x118			@ Check if it is already set
+	beq	skip_sec_l2
+	ldr	r0, =0x118			@ Setup L2 ACTLR = 0x118
+	ldr	r12, =OMAP5_MON_L2AUX_CTRL_INDEX
+	dsb
+	smc     #0
+	dsb
+skip_sec_l2:
 	b	cpu_resume			@ Jump to generic resume
 ENDPROC(omap5_cpu_resume)
 #endif
-- 
1.7.9.5

