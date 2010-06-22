From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH] OMAP3 PM: fix the error messages printed when the system suspend
Date: Tue, 22 Jun 2010 16:31:24 +0800
Message-ID: <1277195484-5501-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:46217 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab0FVIS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 04:18:56 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o5M8ItEn004801
	for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 01:18:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

omap3505/omap3517 don't have the bit OMAP3430_EN_IO and the bit
OMAP3430_EN_IO_CHAIN in the register PM_WKEN_WKUP. When the system
suspend, the following messages will be printed:

"Wake up daisy chain activation failed."

Now fix it by adding "if (!cpu_is_omap3505() && !cpu_is_omap3517())".

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 62529ff..d16648a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -385,8 +385,9 @@ void omap_sram_idle(void)
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	if (per_next_state < PWRDM_POWER_ON ||
-			core_next_state < PWRDM_POWER_ON) {
+	if (!cpu_is_omap3505() && !cpu_is_omap3517() && \
+			(per_next_state < PWRDM_POWER_ON || \
+			  core_next_state < PWRDM_POWER_ON)) {
 		prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
@@ -479,7 +480,8 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (core_next_state < PWRDM_POWER_ON) {
+	if ((core_next_state < PWRDM_POWER_ON) && \
+			!cpu_is_omap3505() && !cpu_is_omap3517()) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
-- 
1.5.4.3

