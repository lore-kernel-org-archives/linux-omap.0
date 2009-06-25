From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/11] OMAP3: PM: Clear pending PRCM reset flags on init
Date: Thu, 25 Jun 2009 09:41:58 -0700
Message-ID: <1245948124-24111-6-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-3-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-4-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:35146 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018AbZFYQnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:43:01 -0400
Received: by mail-pz0-f189.google.com with SMTP id 27so1461235pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:43:04 -0700 (PDT)
In-Reply-To: <1245948124-24111-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Any pending reset flags can prevent retention.  Ensure they are all
cleared during boot.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index cc83dfc..1422e93 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -613,6 +613,15 @@ static void __init prcm_setup_regs(void)
 	/* Clear any pending PRCM interrupts */
 	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
+	/* Clear any pending 'reset' flags */
+	prm_write_mod_reg(0xffffffff, MPU_MOD, RM_RSTST);
+	prm_write_mod_reg(0xffffffff, CORE_MOD, RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, RM_RSTST);
+
 	/* Clear any pending PRCM interrupts */
 	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-- 
1.6.3.2

