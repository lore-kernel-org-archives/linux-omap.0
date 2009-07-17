From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] OMAP3: USBHOST: Fix prcm interrupt handler
Date: Fri, 17 Jul 2009 17:24:08 -0500
Message-ID: <1247869448-26114-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757810AbZGQW0e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jul 2009 18:26:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

For clearing the PM_WKST of USBHOST domain, two fclocks need
to be enabled: HOST1 and HOST2

Current code just enables HOST1 fclock and thus not clearing the
Wake status of usbhost domain correctly

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e80d59f..4cbeff1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -264,8 +264,10 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 					       CM_FCLKEN);
 			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
 					    CM_ICLKEN);
-			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
-					    CM_FCLKEN);
+			cm_set_mod_reg_bits((1<<OMAP3430ES2_EN_USBHOST2_SHIFT)|
+					(1<<OMAP3430ES2_EN_USBHOST1_SHIFT),
+					OMAP3430ES2_USBHOST_MOD,
+					CM_FCLKEN);
 			prm_write_mod_reg(wkst, OMAP3430ES2_USBHOST_MOD,
 					  PM_WKST);
 			while (prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-- 
1.6.3.3.334.g916e1

