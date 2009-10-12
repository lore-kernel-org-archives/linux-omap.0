From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/3] OMAP3: PM: Configure PRM setup times from board files
Date: Mon, 12 Oct 2009 19:12:39 +0530
Message-ID: <1255354960-7873-2-git-send-email-rnayak@ti.com>
References: <1255354960-7873-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbZJLNnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 09:43:23 -0400
In-Reply-To: <1255354960-7873-1-git-send-email-rnayak@ti.com>
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

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c     |   19 ++++++++++++++++++-
 arch/arm/mach-omap2/board-apollon.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c     |    2 +-
 arch/arm/mach-omap2/board-h4.c          |    2 +-
 arch/arm/mach-omap2/board-ldp.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c    |    2 +-
 arch/arm/mach-omap2/board-overo.c       |    2 +-
 arch/arm/mach-omap2/board-rx51.c        |    2 +-
 arch/arm/mach-omap2/board-zoom2.c       |    2 +-
 arch/arm/mach-omap2/pm.h                |    3 ++-
 arch/arm/mach-omap2/pm34xx.c            |    7 ++++++-
 12 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 425f5ac..0f4ffb2 100644
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
@@ -186,7 +203,7 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				 omap3_l3_rate_table);
+				 omap3_l3_rate_table, &omap3_setuptime_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 6a5c338..c6014d7 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -267,7 +267,7 @@ static void __init omap_apollon_init_irq(void)
 {
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap3_pm_early_init(NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL, NULL);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 55e1f11..20f6dfe 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -38,7 +38,7 @@ static void __init omap_generic_init_irq(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap3_pm_early_init(NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL, NULL);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 }
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index e8b5f6a..2757b16 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -313,7 +313,7 @@ static void __init omap_h4_init_irq(void)
 {
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
-	omap3_pm_early_init(NULL, NULL, NULL)
+	omap3_pm_early_init(NULL, NULL, NULL, NULL)
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 009fe39..21fae1a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -289,7 +289,7 @@ static void __init omap_ldp_init_irq(void)
 {
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
-	omap3_pm_early_init(NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL, NULL);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 097810b..056c086 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -352,7 +352,7 @@ static void __init omap3_beagle_init_irq(void)
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				omap3_l3_rate_table);
+				omap3_l3_rate_table, NULL);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3d05923..d1328dd 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -291,7 +291,7 @@ static void __init omap3_evm_init_irq(void)
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				omap3_l3_rate_table);
+				omap3_l3_rate_table, NULL);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d487942..68bb994 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -375,7 +375,7 @@ static void __init overo_init_irq(void)
 {
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
-	omap3_pm_early_init(NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL, NULL);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 26313ee..ea51c21 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -87,7 +87,7 @@ static void __init rx51_init_irq(void)
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				omap3_l3_rate_table);
+				omap3_l3_rate_table, NULL);
 	omap2_init_common_hw(rx51_get_sdram_timings(),
 			     rx51_get_sdram_timings());
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 607f144..270f788 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -216,7 +216,7 @@ static void __init omap_zoom2_init_irq(void)
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				omap3_l3_rate_table);
+				omap3_l3_rate_table, NULL);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index f535a14..3330d7b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -86,5 +86,6 @@ extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
 void omap3_pm_early_init(struct omap_opp *mpu_opps,
 			 struct omap_opp *dsp_opps,
-			 struct omap_opp *l3_opps);
+			 struct omap_opp *l3_opps,
+			 struct prm_setup_vc *setup_times);
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2242d23..6f2fb51 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1084,6 +1084,9 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 
 void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc)
 {
+	if (!setup_vc)
+		return;
+
 	prm_setup.clksetup = setup_vc->clksetup;
 	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
 	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
@@ -1285,13 +1288,15 @@ static void __init configure_vc(void)
 
 void omap3_pm_early_init(struct omap_opp *mpu_opps,
 			 struct omap_opp *dsp_opps,
-			 struct omap_opp *l3_opps)
+			 struct omap_opp *l3_opps,
+			 struct prm_setup_vc *setup_times)
 {
 	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
 				OMAP3_PRM_POLCTRL_OFFSET);
 
 	configure_vc();
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
+	omap3_set_prm_setup_vc(setup_times);
 
 	return;
 }
-- 
1.5.4.7

