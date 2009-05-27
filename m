From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: Re-program also chipselect 1 when changing SDRAM timing
Date: Wed, 27 May 2009 15:13:39 +0300
Message-ID: <1243426419-32652-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36928 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760432AbZE0MmR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 08:42:17 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4RCfpeb013027
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2009 15:42:02 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa01.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4RCftdw002471
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2009 15:41:55 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Previously only chipselect 0 was controlled, which would result in the
chipselect 1 running on too low rate during low core OPPs.

Applies on top of PM branch.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/sram34xx.S |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index f41f8d9..bcfe9eb 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -187,15 +187,24 @@ wait_dll_unlock:
 	bne	wait_dll_unlock
 	bx	lr
 configure_sdrc:
-	ldr	r11, omap3_sdrc_rfr_ctrl
+	ldr	r11, omap3_sdrc_rfr_ctrl_0
 	str	r0, [r11]
-	ldr	r11, omap3_sdrc_actim_ctrla
+	ldr	r11, omap3_sdrc_rfr_ctrl_1
+	str	r0, [r11]
+	ldr	r11, omap3_sdrc_actim_ctrla_0
+	str	r1, [r11]
+	ldr	r11, omap3_sdrc_actim_ctrla_1
 	str	r1, [r11]
-	ldr	r11, omap3_sdrc_actim_ctrlb
+	ldr	r11, omap3_sdrc_actim_ctrlb_0
+	str	r2, [r11]
+	ldr	r11, omap3_sdrc_actim_ctrlb_1
 	str	r2, [r11]
 	ldr	r11, omap3_sdrc_mr_0
 	str	r6, [r11]
 	ldr	r6, [r11]		@ posted-write barrier for SDRC
+	ldr	r11, omap3_sdrc_mr_1
+	str	r6, [r11]
+	ldr	r6, [r11]		@ posted-write barrier for SDRC
 	bx	lr
 
 omap3_sdrc_power:
@@ -206,14 +215,22 @@ omap3_cm_idlest1_core:
 	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
 omap3_cm_iclken1_core:
 	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
-omap3_sdrc_rfr_ctrl:
+omap3_sdrc_rfr_ctrl_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
-omap3_sdrc_actim_ctrla:
+omap3_sdrc_rfr_ctrl_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
+omap3_sdrc_actim_ctrla_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
-omap3_sdrc_actim_ctrlb:
+omap3_sdrc_actim_ctrla_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
+omap3_sdrc_actim_ctrlb_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
+omap3_sdrc_actim_ctrlb_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
 omap3_sdrc_mr_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
+omap3_sdrc_mr_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_1)
 omap3_sdrc_dlla_status:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 omap3_sdrc_dlla_ctrl:
-- 
1.5.4.3

