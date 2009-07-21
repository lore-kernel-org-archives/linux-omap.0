From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 03/14] OMAP3: PM: Ensure PRCM interrupts are cleared at boot
Date: Tue, 21 Jul 2009 15:08:29 -0700
Message-ID: <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:42991 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835AbZGUWIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:08:49 -0400
Received: by mail-pz0-f204.google.com with SMTP id 42so701151pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:08:49 -0700 (PDT)
In-Reply-To: <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Any pending PRCM interrupts can prevent retention.  Ensure
they are cleared during boot.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 765cdc0..cc83dfc 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -613,6 +613,9 @@ static void __init prcm_setup_regs(void)
 	/* Clear any pending PRCM interrupts */
 	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
+	/* Clear any pending PRCM interrupts */
+	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+
 	omap3_iva_idle();
 	omap3_d2d_idle();
 }
-- 
1.6.3.3

