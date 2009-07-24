From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [RFC/RFT 4/4] OMAP3: PM: USBHOST: clear wakeup events on both hosts
Date: Fri, 24 Jul 2009 10:54:28 -0700
Message-ID: <1248458068-21747-5-git-send-email-khilman@deeprootsystems.com>
References: <1248458068-21747-1-git-send-email-khilman@deeprootsystems.com>
 <1248458068-21747-2-git-send-email-khilman@deeprootsystems.com>
 <1248458068-21747-3-git-send-email-khilman@deeprootsystems.com>
 <1248458068-21747-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:61046 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbZGXRyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 13:54:39 -0400
Received: by mail-px0-f184.google.com with SMTP id 14so494297pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2009 10:54:40 -0700 (PDT)
In-Reply-To: <1248458068-21747-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

USBHOST module has 2 fclocks (for HOST1 and HOST2), only one iclock
and only a single bit in the WKST register to indicate a wakeup event.

Because of the single WKST bit, we cannot know whether a wakeup event
was on HOST1 or HOST2, so enable both fclocks before clearing the
wakeup event to ensure both hosts can properly clear the event.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 348a683..9ce651a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -206,7 +206,7 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
  */
 static int prcm_clear_mod_irqs(s16 module, u8 regs)
 {
-	u32 wkst, fclk, iclk;
+	u32 wkst, fclk, iclk, clken;
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
 	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
 	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
@@ -220,8 +220,15 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 		iclk = cm_read_mod_reg(module, iclk_off);
 		fclk = cm_read_mod_reg(module, fclk_off);
 		while (wkst) {
-			cm_set_mod_reg_bits(wkst, module, iclk_off);
-			cm_set_mod_reg_bits(wkst, module, fclk_off);
+			clken = wkst;
+			cm_set_mod_reg_bits(clken, module, iclk_off);
+			/*
+			 * For USBHOST, we don't know whether HOST1 or
+			 * HOST2 woke us up, so enable both f-clocks
+			 */
+			if (module == OMAP3430ES2_USBHOST_MOD)
+				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
+			cm_set_mod_reg_bits(clken, module, fclk_off);
 			prm_write_mod_reg(wkst, module, wkst_off);
 			wkst = prm_read_mod_reg(module, wkst_off);
 			c++;
-- 
1.6.3.3

