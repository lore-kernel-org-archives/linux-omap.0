From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/12] omap3: Prevent SDRC deadlock when L3 is changing
	frequency
Date: Fri, 24 Sep 2010 01:08:32 -0600
Message-ID: <20100924070826.14014.40979.stgit@twilight.localdomain>
References: <20100924070643.14014.11359.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33675 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab0IXHJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 03:09:06 -0400
In-Reply-To: <20100924070643.14014.11359.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Richard Woodruff <r-woodruff2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>

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
is disabled by clearing the Z-bit in the ARM CTRL register.

Disabling the branch prediction logic does not have any noticable impact
on the execution time of this code section. The hardware observability
signals were used to monitor the sdrc idle time with and without this
patch when operating at different CPU frequencies (150MHz, 500MHz and
600MHz) and the total sdrc idle time when changing frequenct was in
the range of 9-11us. This was measured on an omap3430 SDP running the
omapzoom p-android-omap-2.6.29 branch.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sram34xx.S |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index de99ba2..3637274 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -129,8 +129,11 @@ ENTRY(omap3_sram_configure_core_dpll)
 	ldr	r4, [sp, #80]
 	str     r4, omap_sdrc_mr_1_val
 skip_cs1_params:
+	mrc	p15, 0, r8, c1, c0, 0	@ read ctrl register
+	bic	r10, r8, #0x800		@ clear Z-bit, disable branch prediction
+	mcr	p15, 0, r10, c1, c0, 0	@ write ctrl register
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
+	mcr	p15, 0, r8, c1, c0, 0	@ restore ctrl register
 	isb				@ prevent speculative exec past here
 	mov 	r0, #0 			@ return value
 	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return


