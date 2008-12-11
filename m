From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 03/23] OMAP3 SRAM: add ARM barriers to omap3_sram_configure_core_dpll
Date: Thu, 11 Dec 2008 17:52:22 +0200
Message-ID: <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55795 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104AbYLKP6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:58:50 -0500
In-Reply-To: <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Add more barriers in the SRAM CORE DPLL M2 divider change code.

- Add a DSB SY after the function's entry point to flush all cached
  and buffered writes and wait for the interconnect to claim that they
  have completed[1].  The idea here is to force all delayed write
  traffic going to the SDRAM to at least post to the L3 interconnect
  before continuing.  If these writes are allowed to occur after the
  SDRC is idled, the writes will not be acknowledged and the ARM will
  stall.

  Note that in this case, it does not matter if the writes actually
  complete to the SDRAM - it is only necessary for the writes to leave
  the ARM itself.  If the writes are posted by the interconnect when
  the SDRC goes into idle, the writes will be delayed until the SDRC
  returns from idle[2].  If the SDRC is in the middle of a write when
  it is requested to enter idle, the SDRC will not acknowledge the
  idle request until the writes complete to the SDRAM.[3]

  The old-style DMB in sdram_in_selfrefresh is now superfluous, so,
  remove it.

- Add an ISB before the function's exit point to prevent the ARM from
  speculatively executing into SDRAM before the SDRAM is enabled[4].

...

1. ARMv7 ARM (DDI 0406A) A3-47, A3-48.

2. Private communication with Richard Woodruff <r-woodruff2@ti.com>.

3. Private communication with Richard Woodruff <r-woodruff2@ti.com>.

4. ARMv7 ARM (DDI 0406A) A3-48.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/sram34xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 2c71461..f4a356d 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -43,6 +43,7 @@
  */
 ENTRY(omap3_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
+	dsb				@ flush buffered writes to interconnect
 	cmp	r3, #0x2
 	blne	configure_sdrc
 	cmp	r3, #0x2
@@ -58,6 +59,7 @@ ENTRY(omap3_sram_configure_core_dpll)
 	blne	wait_dll_lock
 	cmp	r3, #0x1
 	blne	configure_sdrc
+	isb				@ prevent speculative exec past here
 	mov 	r0, #0 			@ return value
 	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
 unlock_dll:
@@ -73,8 +75,6 @@ lock_dll:
 	str	r5, [r4]
 	bx	lr
 sdram_in_selfrefresh:
-	mov	r5, #0x0		@ Move 0 to R5
-	mcr	p15, 0, r5, c7, c10, 5	@ memory barrier
 	ldr	r4, omap3_sdrc_power	@ read the SDRC_POWER register
 	ldr	r5, [r4]		@ read the contents of SDRC_POWER
 	orr 	r5, r5, #0x40		@ enable self refresh on idle req
-- 
1.5.4.3

