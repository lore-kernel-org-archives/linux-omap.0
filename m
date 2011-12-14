From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV2 REPOST 7/7] ARM: OMAP3 PM: Enable IO Daisychain for supported chips
Date: Wed, 14 Dec 2011 21:31:17 +0530
Message-ID: <1323878477-21122-8-git-send-email-vishwanath.bs@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52839 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757017Ab1LNQLD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 11:11:03 -0500
In-Reply-To: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

IO Daisychain has to be enabled only if the corresponding omap has
io chain wake up capability.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 688e74c..712ce02 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -238,18 +238,20 @@ void omap3_trigger_wuclk_ctrl(void)
 {
 	int i = 0;
 
-	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-			     PM_WKEN);
-	/* Do a readback to assure write has been done */
-	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
-
-	omap_test_timeout(
-	(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
-		 OMAP3430_ST_IO_CHAIN_MASK) == 1)),
-	MAX_IOPAD_LATCH_TIME, i);
-
-	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-			     PM_WKEN);
+	if (omap3_has_io_chain_ctrl()) {
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
+		/* Do a readback to assure write has been done */
+		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+
+		omap_test_timeout(
+		(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
+			 OMAP3430_ST_IO_CHAIN_MASK) == 1)),
+		MAX_IOPAD_LATCH_TIME, i);
+
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
+	}
 }
 
 static int __init omap3xxx_prcm_init(void)
-- 
1.7.0.4

