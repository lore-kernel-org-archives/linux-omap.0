From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: Ensure PRCM interrupts are cleared at boot
Date: Mon, 27 Apr 2009 08:15:42 -0700
Message-ID: <1240845342-3469-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:62250 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294AbZD0PPp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 11:15:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1846258rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 08:15:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Pending bits in IRQSTATUS can prevent the system from hitting
retention.  The PRCM interrupt handler takes care of clearing the
IRQSTATUS bits, but any pending bits before first suspend or idle may
prevent the system from hitting retention.  Ensure they are cleared
during PRCM setup.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to current PM branch.

 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7a561db..d7b6596 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -854,6 +854,9 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
 
+	/* Clear any pending PRCM interrupts */
+	prm_write_mod_reg(0, OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
+
 	omap3_iva_idle();
 }
 
-- 
1.6.2.2

