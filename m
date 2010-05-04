From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] OMAP3: PM: fix AM35x musb issue with AUTOIDLE bit in CONTROL_SYSCONFIG
Date: Tue,  4 May 2010 15:03:05 +0530
Message-ID: <1272965585-21836-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54178 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab0EDJdL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 05:33:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

MUSB interface on AM35x stops working when we set AUTOIDLE bit (D0) in
CONTROL_SYSCONFIG(0x48002010) register.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ea0000b..cc9d566 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -849,7 +849,12 @@ static void __init prcm_setup_regs(void)
 			CM_AUTOIDLE);
 	}
 
-	omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
+	/*
+	 * MUSB interface on AM35x stops working when we enable AUTOIDLE,
+	 * so avoid this for AM3517 and AM3505 device.
+	 */
+	if (!cpu_is_omap3517() && !cpu_is_omap3505())
+		omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
 
 	/*
 	 * Set all plls to autoidle. This is needed until autoidle is
-- 
1.6.2.4

