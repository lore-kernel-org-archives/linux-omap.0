From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 11/13] OMAP3: PM: Ensure PRCM interrupts are cleared at boot
Date: Wed, 20 May 2009 16:19:34 -0700
Message-ID: <1242861576-13008-12-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:43119 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425AbZETXUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:20:06 -0400
Received: by mail-px0-f171.google.com with SMTP id 1so365239pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:20:08 -0700 (PDT)
In-Reply-To: <1242861576-13008-11-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d41e2c5..57d33f9 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -600,6 +600,9 @@ static void __init prcm_setup_regs(void)
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

