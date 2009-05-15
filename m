From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/11] OMAP3: PM: Ensure PRCM interrupts are cleared at boot
Date: Fri, 15 May 2009 11:40:49 -0700
Message-ID: <1242412851-16606-10-git-send-email-khilman@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-3-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-4-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-5-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-6-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-7-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-8-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:38335 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbZEOSl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:41:27 -0400
Received: by wa-out-1112.google.com with SMTP id j5so746788wah.21
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 11:41:29 -0700 (PDT)
In-Reply-To: <1242412851-16606-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a7734c7..9b29414 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -601,6 +601,9 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
+	/* Clear any pending PRCM interrupts */
+	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+
 	omap3_iva_idle();
 	omap3_d2d_idle();
 }
-- 
1.6.2.2

