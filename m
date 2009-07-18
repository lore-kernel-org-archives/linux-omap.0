From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2] OMAP3: PM: USBHOST: clear wakeup events on both hosts
Date: Fri, 17 Jul 2009 19:33:09 -0500
Message-ID: <1247877189-5754-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50613 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbZGRAff (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jul 2009 20:35:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

USBHOST module has 2 fclocks (for HOST1 and HOST2), only one iclock
and only a single bit in the WKST register to indicate a wakeup event.

Because of the single WKST bit, we cannot know whether a wakeup event
was on HOST1 or HOST2, so enable both fclocks before clearing the
wakeup event to ensure both hosts can properly clear the event.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e80d59f..2430bed 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -264,8 +264,13 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 					       CM_FCLKEN);
 			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
 					    CM_ICLKEN);
-			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
-					    CM_FCLKEN);
+			/* We don't know whether HOST1 or HOST2 woke us up,
+			 * so enable both clocks
+			 */
+			cm_set_mod_reg_bits(wkst |
+					(1<<OMAP3430ES2_EN_USBHOST2_SHIFT),
+					OMAP3430ES2_USBHOST_MOD,
+					CM_FCLKEN);
 			prm_write_mod_reg(wkst, OMAP3430ES2_USBHOST_MOD,
 					  PM_WKST);
 			while (prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-- 
1.6.3.3.334.g916e1

