From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH] OMAP3: Remove CONFIG_OMAP_SYSOFFMODE flag
Date: Fri, 17 Oct 2008 09:46:08 +0300
Message-ID: <1224225968-20828-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24052 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYJQGpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 02:45:45 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Remove CONFIG_OMAP_SYSOFFMODE flag and do the full initialization of voltage
controller . Enabling automatic sending of OFF command and selecting wether
SYS_OFF_MODE signal is used should be determined dynamically. Hence they are
now not set in the initialization.

The sleep voltage for OFF mode is changed to default 1,2V for VDD1 and
1,15V for VDD2. Using the 0,9V setting causes hangup.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c           |   10 +---------
 arch/arm/mach-omap2/prm-regbits-34xx.h |    4 ++--
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a828db6..457639f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -622,10 +622,7 @@ static void __init configure_vc(void)
 				OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
 	/* Setup voltctrl and other setup times */
-
-#ifdef CONFIG_OMAP_SYSOFFMODE
-	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
-			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
+	prm_write_mod_reg(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTCTRL_OFFSET);
 
 	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
@@ -640,11 +637,6 @@ static void __init configure_vc(void)
 			OMAP3_PRM_VOLTOFFSET_OFFSET);
 	prm_write_mod_reg(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTSETUP2_OFFSET);
-#else
-	prm_set_mod_reg_bits(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTCTRL_OFFSET);
-#endif
-
 }
 
 static int __init omap3_pm_early_init(void)
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index f82b5a7..d73eee8 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -466,13 +466,13 @@
 #define OMAP3430_VC_CMD_VAL0_ON				(0x3 << 4)
 #define OMAP3430_VC_CMD_VAL0_ONLP			(0x3 << 3)
 #define OMAP3430_VC_CMD_VAL0_RET			(0x3 << 3)
-#define OMAP3430_VC_CMD_VAL0_OFF			(0x3 << 3)
+#define OMAP3430_VC_CMD_VAL0_OFF			(0x3 << 4)
 
 /* PRM_VC_CMD_VAL_1 specific bits */
 #define OMAP3430_VC_CMD_VAL1_ON				(0xB << 2)
 #define OMAP3430_VC_CMD_VAL1_ONLP			(0x3 << 3)
 #define OMAP3430_VC_CMD_VAL1_RET			(0x3 << 3)
-#define OMAP3430_VC_CMD_VAL1_OFF			(0x3 << 3)
+#define OMAP3430_VC_CMD_VAL1_OFF			(0xB << 2)
 
 /* PRM_VC_CH_CONF */
 #define OMAP3430_CMD1					(1 << 20)
-- 
1.5.4.3

