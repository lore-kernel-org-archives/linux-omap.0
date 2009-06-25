From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 06/11] OMAP3: PM: prevent module wakeups from waking IVA2
Date: Thu, 25 Jun 2009 09:41:59 -0700
Message-ID: <1245948124-24111-7-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-3-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-4-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-5-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-6-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:49012 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbZFYQnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:43:10 -0400
Received: by mail-px0-f190.google.com with SMTP id 28so1148479pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:43:13 -0700 (PDT)
In-Reply-To: <1245948124-24111-6-git-send-email-khilman@deeprootsystems.com>
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
1.6.3.2

