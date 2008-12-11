From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 05/23] OMAP3 SRAM: clear the SDRC PWRENA bit during SDRC frequency change
Date: Thu, 11 Dec 2008 17:52:24 +0200
Message-ID: <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55851 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbYLKP7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:19 -0500
In-Reply-To: <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Clear the SDRC_POWER.PWRENA bit before putting the SDRAM into self-refresh
mode.  This prevents the SDRC from attempting to power off the SDRAM,
which can cause the system to hang.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/sram34xx.S |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 8d524f3..9a45415 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -77,7 +77,9 @@ lock_dll:
 sdram_in_selfrefresh:
 	ldr	r4, omap3_sdrc_power	@ read the SDRC_POWER register
 	ldr	r5, [r4]		@ read the contents of SDRC_POWER
+	mov	r9, r5			@ keep a copy of SDRC_POWER bits
 	orr 	r5, r5, #0x40		@ enable self refresh on idle req
+	bic 	r5, r5, #0x4		@ clear PWDENA
 	str 	r5, [r4]		@ write back to SDRC_POWER register
 	ldr	r5, [r4]		@ posted-write barrier for SDRC
 	ldr	r4, omap3_cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
@@ -128,10 +130,9 @@ wait_sdrc_idle1:
 	and 	r5, r5, #0x2
 	cmp	r5, #0
 	bne	wait_sdrc_idle1
+restore_sdrc_power_val:
 	ldr	r4, omap3_sdrc_power
-	ldr	r5, [r4]
-	bic 	r5, r5, #0x40
-	str 	r5, [r4]
+	str	r9, [r4]		@ restore SDRC_POWER, no barrier needed
 	bx	lr
 wait_dll_lock:
 	ldr	r4, omap3_sdrc_dlla_status
-- 
1.5.4.3

