From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/11] OMAP3: PM: Clear pending PRCM reset flags on init
Date: Fri, 15 May 2009 11:40:50 -0700
Message-ID: <1242412851-16606-11-git-send-email-khilman@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-3-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-4-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-5-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-6-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-7-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-8-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-9-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-10-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:64443 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbZEOSl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:41:29 -0400
Received: by mail-pz0-f115.google.com with SMTP id 13so1205834pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 11:41:30 -0700 (PDT)
In-Reply-To: <1242412851-16606-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9b29414..7ed01e5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -601,6 +601,15 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
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
1.6.2.2

