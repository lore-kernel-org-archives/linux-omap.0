From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/5] OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
Date: Fri,  2 Oct 2009 11:14:52 -0700
Message-ID: <1254507295-11381-3-git-send-email-khilman@deeprootsystems.com>
References: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
 <1254507295-11381-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:44292 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729AbZJBSOz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 14:14:55 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so1224757pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 02 Oct 2009 11:15:00 -0700 (PDT)
In-Reply-To: <1254507295-11381-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

PM_WKST register contents should be ANDed with the contents of the
MPUGRPSEL registers.  Otherwise the MPU PRCM interrupt handler could
wind up clearing wakeup events meant for the IVA PRCM interrupt
handler. A future revision to this code should be to read a cached
version of MPUGRPSEL from the powerdomain code, since PRM reads are
relatively slow.

Updated after Jon Hunter's PRCM IRQ change by Kevin Hilman

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1e7aae2..0e7bd8e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -67,8 +67,11 @@ static void prcm_clear_mod_irqs(s16 module, u8 regs)
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
 	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
 	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
+	u16 grpsel_off = (regs == 3) ?
+		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
 
 	wkst = prm_read_mod_reg(module, wkst_off);
+	wkst &= prm_read_mod_reg(module, grpsel_off);
 	if (wkst) {
 		iclk = cm_read_mod_reg(module, iclk_off);
 		fclk = cm_read_mod_reg(module, fclk_off);
-- 
1.6.4.3

