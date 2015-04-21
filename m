From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/1] ARM: OMAP2+: Fix omap3 off idle power consumption creeping up
Date: Tue, 21 Apr 2015 09:10:19 -0700
Message-ID: <1429632619-23474-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from si-002-i66.relay.mailchannels.net ([184.154.112.240]:27091 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755302AbbDUQNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2015 12:13:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>

If we use a combination of VMODE and I2C4 for retention modes,
eventually the off idle power consumption will creep up by about
23mW, even during off mode with I2C4 always staying enabled.

Looks like the only way to fix the extra power consumption is to
disable I2C4 usage by setting SEL_VMODE for both off idle and
retention idle. Let's also update the comments accordingly.

Fixes: 3b8c4ebb7630 ("ARM: OMAP3: Fix idle mode signaling for sys_clkreq and sys_off_mode")
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/vc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index be9ef83..f8a2539 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -284,6 +284,9 @@ void omap3_vc_set_pmic_signaling(int core_next_state)
 					OMAP3430_PRM_POLCTRL_CLKREQ_POL)
 #define PRM_POLCTRL_TWL_VAL	OMAP3430_PRM_POLCTRL_CLKREQ_POL
 
+#define OMAP3_VOLTCTRL_CFG	(OMAP3430_PRM_VOLTCTRL_SEL_VMODE | \
+					OMAP3430_PRM_VOLTCTRL_SEL_OFF)
+
 /*
  * Configure signal polarity for sys_clkreq and sys_off_mode pins
  * as the default values are wrong and can cause the system to hang
@@ -309,18 +312,19 @@ static void __init omap3_vc_init_pmic_signaling(struct voltagedomain *voltdm)
 	}
 
 	/*
-	 * By default let's use I2C4 signaling for retention idle
-	 * and sys_off_mode pin signaling for off idle. This way we
-	 * have sys_clk_req pin go down for retention and both
-	 * sys_clk_req and sys_off_mode pins will go down for off
-	 * idle. And we can also scale voltages to zero for off-idle.
-	 * Note that no actual voltage scaling during off-idle will
-	 * happen unless the board specific twl4030 PMIC scripts are
-	 * loaded.
+	 * By default let's use pin based (VMODE) signaling for retention
+	 * idle and off idle. Trying to use both VMODE and I2C4 will cause
+	 * the I2C4 to eventually stay always on consuming extra 23mW even in
+	 * off idle. With VMODE based configuration, we have sys_clk_req pin
+	 * go down for retention and both sys_clk_req and sys_off_mode pins
+	 * will go down for off idle. And we can also scale voltages to zero
+	 * for off-idle, while I2C4 configuration can only scale down to 0.6V.
+	 * Note that no actual voltage scaling during off-idle will happen
+	 * unless the board specific twl4030 PMIC scripts are loaded.
 	 */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
-	if (!(val & OMAP3430_PRM_VOLTCTRL_SEL_OFF)) {
-		val |= OMAP3430_PRM_VOLTCTRL_SEL_OFF;
+	if (!(val & OMAP3_VOLTCTRL_CFG)) {
+		val |= OMAP3_VOLTCTRL_CFG;
 		pr_debug("PM: setting voltctrl sys_off_mode signaling to 0x%x\n",
 			 val);
 		voltdm->write(val, OMAP3_PRM_VOLTCTRL_OFFSET);
-- 
2.1.4

