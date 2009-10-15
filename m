From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/2] OMAP3: PM: Configure PRM setup times from board files
Date: Thu, 15 Oct 2009 20:18:49 +0530
Message-ID: <1255618130-14005-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43863 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762191AbZJOOte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 10:49:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

The setup times to be programmed in the PRM module on OMAP
(for clksetup, voltsetup etc) are board specific.
They depend heavily on the PMIC used and even on different boards
with the same PMIC, they vary based on the sleep/wake
sequence used, system clock speed et al.

This patch makes it possible for these setup values to be
configured from different board files.
omap3_pm_init_vc() can now be optionally called from board files
to initialise the setup times. If board files do not use
this function to pass the setup times, default/conservative
values are used which are safe but would cause higher wakeup
latencies from sleep states.

This patch only updates the 3430sdp board file to use
omap3_pm_init_vc() to update the setup times.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/pm.h            |    2 +-
 arch/arm/mach-omap2/pm34xx.c        |    5 ++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 14868b5..0f1975c 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -56,6 +56,23 @@
 
 #define TWL4030_MSECURE_GPIO 22
 
+/* FIXME: These are not the optimal setup values to be used on 3430sdp*/
+static struct prm_setup_vc omap3_setuptime_table = {
+	.clksetup = 0xff,
+	.voltsetup_time1 = 0xfff,
+	.voltsetup_time2 = 0xfff,
+	.voltoffset = 0xff,
+	.voltsetup2 = 0xff,
+	.vdd0_on = 0x30,
+	.vdd0_onlp = 0x20,
+	.vdd0_ret = 0x1e,
+	.vdd0_off = 0x00,
+	.vdd1_on = 0x2c,
+	.vdd1_onlp = 0x20,
+	.vdd1_ret = 0x1e,
+	.vdd1_off = 0x00,
+};
+
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -185,6 +202,7 @@ static void __init omap_3430sdp_init_irq(void)
 {
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
+	omap3_pm_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index f8d11a2..ca673c5 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -41,7 +41,7 @@ struct prm_setup_vc {
 	u16 vdd1_ret;
 	u16 vdd1_off;
 };
-extern void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc);
+extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
 
 extern int resource_set_opp_level(int res, u32 target_level, int flags);
 extern int resource_access_opp_lock(int res, int delta);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 01260ec..3d7ae2f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1027,8 +1027,11 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 	return -EINVAL;
 }
 
-void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc)
+void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
 {
+	if (!setup_vc)
+		return;
+
 	prm_setup.clksetup = setup_vc->clksetup;
 	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
 	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
-- 
1.5.4.7

