From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 11/23] OMAP3 clock: remove wait for DPLL3 M2 clock to stabilize
Date: Thu, 11 Dec 2008 17:52:30 +0200
Message-ID: <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34960 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbYLKP7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:13 -0500
In-Reply-To: <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

The original CDP kernel that this code comes from waited for 0x800
loops after switching the CORE DPLL M2 divider.  This does not appear
to be necessary.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/sram34xx.S |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index c080c82..84781a6 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -102,9 +102,6 @@ configure_core_dpll:
 	orr	r12, r12, r3, lsl #0x1B	@ r3 contains the M2 val
 	str	r12, [r11]
 	ldr	r12, [r11]		@ posted-write barrier for CM
-	mov 	r12, #0x800		@ wait for the clock to stabilise
-	cmp	r3, #2
-	bne	wait_clk_stable
 	bx	lr
 wait_clk_stable:
 	subs 	r12, r12, #1
-- 
1.5.4.3

