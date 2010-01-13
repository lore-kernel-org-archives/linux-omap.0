From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 14/13] DSS PM_WKEN to refill DMA
Date: Wed, 13 Jan 2010 15:53:50 -0800
Message-ID: <1263426830-22203-1-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:37326 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478Ab0AMXx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 18:53:56 -0500
Received: by fxm25 with SMTP id 25so801959fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 15:53:55 -0800 (PST)
In-Reply-To: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Subramani Venkatesh <x0108988@ti.com>, Subramani Venkatesh <subramani.venkatesh@windriver.com>

From: Subramani Venkatesh <x0108988@ti.com>

Currently, DSS doesnot wakeup when there is a DMA request.
DSS wake up event must be enabled so that the DMA request to refill
the FIFO will wake up the CORE domain.

Signed-off-by: Subramani Venkatesh <subramani.venkatesh@windriver.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
One more PM fix for the 2.6.33-rc series.
This has been added to my pm-fixes branch.

 arch/arm/mach-omap2/pm34xx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 31762ca..46fbced 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -739,6 +739,11 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
+
+	/* Enable PM_WKEN to support DSS LPR */
+	prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS,
+				OMAP3430_DSS_MOD, PM_WKEN);
+
 	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
-- 
1.6.6

