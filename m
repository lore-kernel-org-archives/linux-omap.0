From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing frequency
Date: Wed, 21 Jul 2010 11:02:35 -0500
Message-ID: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41252 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253Ab0GUQFr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Jul 2010 12:05:47 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6LG5kFm002500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 21 Jul 2010 11:05:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

When changing the L3 clock frequency, the CPU is executing from internal RAM
and the SDRC clock is disabled. During this time accesses made to external
DDR are stalled. If the ARM subsystem attempts to access the DDR while the
SDRC clock is disabled this will stall the CPU until the access to the SDRC
timeouts. A timeout on the SDRC should never occur. Once a timeout occurs all
the following accesses will be aborted and the DDR is no longer accessible.

Although the code being executed in the internal RAM does not directly access
the DDR, it was found that the branch prediction logic in the CPU may cause
the CPU to prefetch code from a DDR location while the SDRC clock is disabled.
This was causing an SDRC timeout which resulted in a system hang.

This patch fixes this problem by ensuring the branch prediction logic is
disabled while changing the L3 clock frequency. The branch prediction logic
is disabled by clearing the Z-bit in the ARM AUX CTRL register.

Disabling the branch prediction logic does not have any noticable impact
on the execution time of this code section. The hardware observability
signals were used to monitor the sdrc idle time with and without this
patch when operating at different CPU frequencies (150MHz, 500MHz and
600MHz) and the total sdrc idle time when changing frequenct was in
the range of 9-11us. This was measured on an omap3430 SDP running the
omapzoom p-android-omap-2.6.29 branch.

This change has been commited to both TI's android 2.6.29 and 2.6.32 kernels.
The commits can be viewed here:
http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=5679c7b1142f3cc2b9285181d53f6b40c4d0296d
http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=cf16e57823575d98e9d5165aa7a498ffb751c940

This patch has been rebased on the latest linux-omap tree and tested on
Kevin Hilman's pm branch.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/sram34xx.S |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index de99ba2..e87e730 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -129,8 +129,11 @@ ENTRY(omap3_sram_configure_core_dpll)
 	ldr	r4, [sp, #80]
 	str     r4, omap_sdrc_mr_1_val
 skip_cs1_params:
+	mrc p15, 0, r8, c1, c0, 0	@ read aux ctrl register
+	bic r10, r8, #0x800		@ clear Z-bit, disable branch prediction
+	mcr p15, 0, r10, c1, c0, 0	@ write aux ctrl register
 	dsb				@ flush buffered writes to interconnect
-
+	isb				@ prevent speculative exec past here
 	cmp	r3, #1			@ if increasing SDRC clk rate,
 	bleq	configure_sdrc		@ program the SDRC regs early (for RFR)
 	cmp	r1, #SDRC_UNLOCK_DLL	@ set the intended DLL state
@@ -148,6 +151,7 @@ skip_cs1_params:
 	beq	return_to_sdram		@ return to SDRAM code, otherwise,
 	bl	configure_sdrc		@ reprogram SDRC regs now
 return_to_sdram:
+	mcr p15, 0, r8, c1, c0, 0	@ restore aux ctrl register
 	isb				@ prevent speculative exec past here
 	mov 	r0, #0 			@ return value
 	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
-- 
1.7.0.4

