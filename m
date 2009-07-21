From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/14] OMAP3: PM: prevent module wakeups from waking IVA2
Date: Tue, 21 Jul 2009 15:08:31 -0700
Message-ID: <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:7329 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbZGUWIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:08:54 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1009646wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:08:54 -0700 (PDT)
In-Reply-To: <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

By default, prevent functional wakeups from inside a module from
waking up the IVA2.  Let DSP Bridge code handle this when loaded.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1422e93..c813a08 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -613,6 +613,12 @@ static void __init prcm_setup_regs(void)
 	/* Clear any pending PRCM interrupts */
 	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
+	/* Don't attach IVA interrupts */
+	prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+	prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
+	prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+	prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
+
 	/* Clear any pending 'reset' flags */
 	prm_write_mod_reg(0xffffffff, MPU_MOD, RM_RSTST);
 	prm_write_mod_reg(0xffffffff, CORE_MOD, RM_RSTST);
-- 
1.6.3.3

