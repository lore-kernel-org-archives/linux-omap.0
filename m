From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: PM: Fix freeze when scaling CORE dpll to < 83Mhz
Date: Thu,  9 Jul 2009 15:48:22 +0530
Message-ID: <1247134702-12704-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59885 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbZGIKSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 06:18:31 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n69AIOWl014871
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2009 05:18:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch fixes a bug in the CORE dpll scaling sequence
which was errouneously clearing some bits in the
SDRC DLLA CTRL register and hence causing a freeze.
The issue was observed only on platforms which scale
CORE dpll to < 83Mhz and hence program the DLL in fixed 
delay mode.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/sram34xx.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 481f912..9be09a7 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -113,7 +113,7 @@ return_to_sdram:
 unlock_dll:
 	ldr	r11, omap3_sdrc_dlla_ctrl
 	ldr	r12, [r11]
-	and	r12, r12, #FIXEDDELAY_MASK
+	bic	r12, r12, #FIXEDDELAY_MASK
 	orr	r12, r12, #FIXEDDELAY_DEFAULT
 	orr	r12, r12, #DLLIDLE_MASK
 	str	r12, [r11]		@ (no OCP barrier needed)
-- 
1.5.4.7

