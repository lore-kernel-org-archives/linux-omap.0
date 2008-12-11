From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 04/23] OMAP3 clock: add interconnect barriers to CORE DPLL M2 change
Date: Thu, 11 Dec 2008 17:52:23 +0200
Message-ID: <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55849 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204AbYLKP7R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:17 -0500
In-Reply-To: <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Where necessary, add interconnect barriers to force posted writes to
complete before continuing.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/sram34xx.S |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index f4a356d..8d524f3 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -66,22 +66,23 @@ unlock_dll:
 	ldr	r4, omap3_sdrc_dlla_ctrl
 	ldr	r5, [r4]
 	orr	r5, r5, #0x4
-	str	r5, [r4]
+	str	r5, [r4]		@ (no OCP barrier needed)
 	bx	lr
 lock_dll:
 	ldr	r4, omap3_sdrc_dlla_ctrl
 	ldr	r5, [r4]
 	bic	r5, r5, #0x4
-	str	r5, [r4]
+	str	r5, [r4]		@ (no OCP barrier needed)
 	bx	lr
 sdram_in_selfrefresh:
 	ldr	r4, omap3_sdrc_power	@ read the SDRC_POWER register
 	ldr	r5, [r4]		@ read the contents of SDRC_POWER
 	orr 	r5, r5, #0x40		@ enable self refresh on idle req
 	str 	r5, [r4]		@ write back to SDRC_POWER register
+	ldr	r5, [r4]		@ posted-write barrier for SDRC
 	ldr	r4, omap3_cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
 	ldr	r5, [r4]
-	bic	r5, r5, #0x2		@ disable iclk bit for SRDC
+	bic	r5, r5, #0x2		@ disable iclk bit for SDRC
 	str 	r5, [r4]
 wait_sdrc_idle:
 	ldr 	r4, omap3_cm_idlest1_core
@@ -97,6 +98,7 @@ configure_core_dpll:
 	and	r5, r5, r6
 	orr	r5, r5, r3, lsl #0x1B	@ r3 contains the M2 val
 	str	r5, [r4]
+	ldr	r5, [r4]		@ posted-write barrier for CM
 	mov 	r5, #0x800		@ wait for the clock to stabilise
 	cmp	r3, #2
 	bne	wait_clk_stable
@@ -152,6 +154,7 @@ configure_sdrc:
 	str	r1, [r4]
 	ldr	r4, omap3_sdrc_actim_ctrlb
 	str	r2, [r4]
+	ldr	r2, [r4]		@ posted-write barrier for SDRC
 	bx	lr
 
 omap3_sdrc_power:
-- 
1.5.4.3

