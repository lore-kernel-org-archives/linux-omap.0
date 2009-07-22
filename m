From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFT 2/3] OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
Date: Wed, 22 Jul 2009 11:48:21 -0700
Message-ID: <1248288502-3496-3-git-send-email-khilman@deeprootsystems.com>
References: <1248288502-3496-1-git-send-email-khilman@deeprootsystems.com>
 <1248288502-3496-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:19773 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbZGVSsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 14:48:30 -0400
Received: by rv-out-0506.google.com with SMTP id f6so118285rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2009 11:48:31 -0700 (PDT)
In-Reply-To: <1248288502-3496-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

PM_WKST register contents should be ANDed with the contents of the
MPUGRPSEL registers.  Otherwise the MPU PRCM interrupt handler could
wind up clearing wakeup events meant for the IVA PRCM interrupt
handler.  For a production version of this patch, we should not read
MPUGRPSEL from the PRM, since those reads are very slow; rather, we
should use a cached version from struct powerdomain (not yet
implemented)
---
 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f6cc71a..25372b7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -210,8 +210,11 @@ static void prcm_clear_mod_irqs(s16 module, u8 regs)
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
1.6.3.3

