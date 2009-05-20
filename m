From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/13] OMAP3: PM: Clear pending PRCM reset flags on init
Date: Wed, 20 May 2009 16:19:35 -0700
Message-ID: <1242861576-13008-13-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-6-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-7-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-8-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-9-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-10-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-11-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-12-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:45716 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160AbZETXUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:20:08 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so340449pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:20:09 -0700 (PDT)
In-Reply-To: <1242861576-13008-12-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 57d33f9..8442286 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -600,6 +600,15 @@ static void __init prcm_setup_regs(void)
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

