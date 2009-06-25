From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 04/11] OMAP3: PM: Ensure PRCM interrupts are cleared at boot
Date: Thu, 25 Jun 2009 09:41:57 -0700
Message-ID: <1245948124-24111-5-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-3-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:49012 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbZFYQmw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:42:52 -0400
Received: by mail-px0-f190.google.com with SMTP id 28so1148479pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:42:56 -0700 (PDT)
In-Reply-To: <1245948124-24111-4-git-send-email-khilman@deeprootsystems.com>
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
1.6.3.2

