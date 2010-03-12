From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v3 2/5] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Fri, 12 Mar 2010 21:01:31 +0530
Message-ID: <1268407891-22559-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38231 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934030Ab0CLPLa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 10:11:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Copied the setuptime in each board file, since OMAP3430 & OMAP3630
has different voltage levels for the same states.
Changed vdd0_/vdd1_ to vdd1_/vdd2_ in prcm vc setuptime structure.

Made the changes to program the setup time according to
the target state of CORE power domain.
The voltsetup2 is used only when the device exits sys_off mode
(with PRM_VOLTCTRL[3]SEL_OFF set to 1).

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/board-3430sdp.c           |   27 ++++---
 arch/arm/mach-omap2/board-3630sdp.c           |   25 ++++++-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    8 ++-
 arch/arm/mach-omap2/board-zoom2.c             |   25 ++++++-
 arch/arm/mach-omap2/board-zoom3.c             |   25 ++++++-
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +-
 arch/arm/mach-omap2/pm.h                      |   21 ++++--
 arch/arm/mach-omap2/pm34xx.c                  |   14 +++-
 arch/arm/mach-omap2/voltage.c                 |   94 ++++++++++++++++++-------
 arch/arm/mach-omap2/voltage.h                 |    1 +
 10 files changed, 189 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 6ee9f20..23403f0 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -77,21 +77,26 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
 	{1, 10000, 30000, 300000},
 };
 
-/* FIXME: These are not the optimal setup values to be used on 3430sdp*/
 static struct prm_setup_vc omap3_setuptime_table = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
-	.voltoffset = 0xff,
-	.voltsetup2 = 0xff,
-	.vdd0_on = 0x30,
-	.vdd0_onlp = 0x20,
-	.vdd0_ret = 0x1e,
-	.vdd0_off = 0x00,
-	.vdd1_on = 0x2c,
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0x1,
+	.clksetup_off = 0x14A,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0x005B,
+	.voltsetup_time2_ret = 0x0055,
+	.voltsetup_time1_off = 0x00B3,
+	.voltsetup_time2_off = 0x00A0,
+	.voltoffset = 0x118,
+	.voltsetup2 = 0x32,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd1_on = 0x30,
 	.vdd1_onlp = 0x20,
 	.vdd1_ret = 0x1e,
 	.vdd1_off = 0x00,
+	.vdd2_on = 0x2c,
+	.vdd2_onlp = 0x20,
+	.vdd2_ret = 0x1e,
+	.vdd2_off = 0x00,
 };
 
 static int board_keymap[] = {
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 3937a47..2f41c51 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -25,6 +25,29 @@
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+
+static struct prm_setup_vc omap3_setuptime_table = {
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0x1,
+	.clksetup_off = 0x14A,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0x005B,
+	.voltsetup_time2_ret = 0x0055,
+	.voltsetup_time1_off = 0x00B3,
+	.voltsetup_time2_off = 0x00A0,
+	.voltoffset = 0x118,
+	.voltsetup2 = 0x32,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd1_on = 0x28,	/* 1.1v */
+	.vdd1_onlp = 0x20,	/* 1.0v */
+	.vdd1_ret = 0x13,	/* 0.83v */
+	.vdd1_off = 0x00,	/* 0.6v */
+	.vdd2_on = 0x2B,	/* 1.1375v */
+	.vdd2_onlp = 0x20,	/* 1.0v */
+	.vdd2_ret = 0x14,	/* 0.85v */
+	.vdd2_off = 0x00,	/* 0.6v */
+};
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -97,7 +120,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-	zoom_peripherals_init();
+	zoom_peripherals_init(&omap3_setuptime_table);
 	board_smc91x_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index ca95d8d..66f9fd0 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -26,6 +26,8 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "pm.h"
+#include "voltage.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -277,8 +279,12 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
-void __init zoom_peripherals_init(void)
+void __init zoom_peripherals_init(void *peripheral_data)
 {
+	struct prm_setup_vc *omap3_setuptime =
+				(struct prm_setup_vc *)peripheral_data;
+
+	omap_voltage_init_vc(omap3_setuptime);
 	omap_i2c_init();
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index a2cdfdd..29ee689 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -26,6 +26,29 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "omap3-opp.h"
+#include "pm.h"
+
+static struct prm_setup_vc omap3_setuptime_table = {
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0x1,
+	.clksetup_off = 0x14A,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0x005B,
+	.voltsetup_time2_ret = 0x0055,
+	.voltsetup_time1_off = 0x00B3,
+	.voltsetup_time2_off = 0x00A0,
+	.voltoffset = 0x118,
+	.voltsetup2 = 0x32,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd1_on = 0x30,
+	.vdd1_onlp = 0x20,
+	.vdd1_ret = 0x1e,
+	.vdd1_off = 0x00,
+	.vdd2_on = 0x2c,
+	.vdd2_onlp = 0x20,
+	.vdd2_ret = 0x1e,
+	.vdd2_off = 0x00,
+};
 
 static void __init omap_zoom2_init_irq(void)
 {
@@ -82,7 +105,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init omap_zoom2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	zoom_peripherals_init();
+	zoom_peripherals_init(&omap3_setuptime_table);
 	zoom_debugboard_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 9a4b2aa..3edb580 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -24,6 +24,29 @@
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+
+static struct prm_setup_vc omap3_setuptime_table = {
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0x1,
+	.clksetup_off = 0x14A,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0x005B,
+	.voltsetup_time2_ret = 0x0055,
+	.voltsetup_time1_off = 0x00B3,
+	.voltsetup_time2_off = 0x00A0,
+	.voltoffset = 0x118,
+	.voltsetup2 = 0x32,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd1_on = 0x28,	/* 1.1v */
+	.vdd1_onlp = 0x20,	/* 1.0v */
+	.vdd1_ret = 0x13,	/* 0.83v */
+	.vdd1_off = 0x00,	/* 0.6v */
+	.vdd2_on = 0x2B,	/* 1.1375v */
+	.vdd2_onlp = 0x20,	/* 1.0v */
+	.vdd2_ret = 0x14,	/* 0.85v */
+	.vdd2_off = 0x00,	/* 0.6v */
+};
 
 static void __init omap_zoom_map_io(void)
 {
@@ -66,7 +89,7 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static void __init omap_zoom_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-	zoom_peripherals_init();
+	zoom_peripherals_init(&omap3_setuptime_table);
 	zoom_debugboard_init();
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/include/mach/board-zoom.h
index c93b29e..ed20b26 100644
--- a/arch/arm/mach-omap2/include/mach/board-zoom.h
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -2,4 +2,4 @@
  * Defines for zoom boards
  */
 extern int __init zoom_debugboard_init(void);
-extern void __init zoom_peripherals_init(void);
+extern void __init zoom_peripherals_init(void *);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 26dc5c8..be2db7f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -41,21 +41,26 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 #endif
 
 struct prm_setup_vc {
-	u16 clksetup;
-	u16 voltsetup_time1;
-	u16 voltsetup_time2;
+/* CLK SETUPTIME for RET & OFF */
+	u16 clksetup_ret;
+	u16 clksetup_off;
+/* VOLT SETUPTIME for RET & OFF */
+	u16 voltsetup_time1_ret;
+	u16 voltsetup_time2_ret;
+	u16 voltsetup_time1_off;
+	u16 voltsetup_time2_off;
 	u16 voltoffset;
 	u16 voltsetup2;
 /* PRM_VC_CMD_VAL_0 specific bits */
-	u16 vdd0_on;
-	u16 vdd0_onlp;
-	u16 vdd0_ret;
-	u16 vdd0_off;
-/* PRM_VC_CMD_VAL_1 specific bits */
 	u16 vdd1_on;
 	u16 vdd1_onlp;
 	u16 vdd1_ret;
 	u16 vdd1_off;
+/* PRM_VC_CMD_VAL_1 specific bits */
+	u16 vdd2_on;
+	u16 vdd2_onlp;
+	u16 vdd2_ret;
+	u16 vdd2_off;
 };
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 81f78d3..a62a505 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -359,6 +359,7 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
+	u32 voltctrl = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -423,20 +424,25 @@ void omap_sram_idle(void)
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
-			u32 voltctrl = OMAP3430_AUTO_OFF;
+			voltctrl = OMAP3430_AUTO_OFF;
 
 			if (voltage_off_while_idle)
 				voltctrl |= OMAP3430_SEL_OFF;
 			prm_set_mod_reg_bits(voltctrl,
 					     OMAP3430_GR_MOD,
 					     OMAP3_PRM_VOLTCTRL_OFFSET);
-			omap3_core_save_context();
-			omap3_prcm_save_context();
 		} else if (core_next_state == PWRDM_POWER_RET) {
 			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
 		}
+		/* Update the voltsetup time for RET/OFF */
+		update_voltsetup_time(core_next_state);
+
+		if (core_next_state == PWRDM_POWER_OFF) {
+			omap3_core_save_context();
+			omap3_prcm_save_context();
+		}
 		/* Enable IO-PAD and IO-CHAIN wakeups */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
@@ -496,7 +502,7 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
-			u32 voltctrl = OMAP3430_AUTO_OFF;
+			voltctrl = OMAP3430_AUTO_OFF;
 
 			if (voltage_off_while_idle)
 				voltctrl |= OMAP3430_SEL_OFF;
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 89a1ab1..4b1dcdb 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -73,19 +73,25 @@ struct vc_reg_info {
  * Default voltage controller settings for OMAP3
  */
 static struct prm_setup_vc vc_config = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0xff,
+	.clksetup_off = 0xff,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0xfff,
+	.voltsetup_time2_ret = 0xfff,
+	.voltsetup_time1_off = 0xfff,
+	.voltsetup_time2_off = 0xfff,
 	.voltoffset = 0xff,
 	.voltsetup2 = 0xff,
-	.vdd0_on = 0x30,        /* 1.2v */
-	.vdd0_onlp = 0x20,      /* 1.0v */
-	.vdd0_ret = 0x1e,       /* 0.975v */
-	.vdd0_off = 0x00,       /* 0.6v */
-	.vdd1_on = 0x2c,        /* 1.15v */
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd1_on = 0x30,        /* 1.2v */
 	.vdd1_onlp = 0x20,      /* 1.0v */
-	.vdd1_ret = 0x1e,       /* .975v */
+	.vdd1_ret = 0x1e,       /* 0.975v */
 	.vdd1_off = 0x00,       /* 0.6v */
+	.vdd2_on = 0x2c,        /* 1.15v */
+	.vdd2_onlp = 0x20,      /* 1.0v */
+	.vdd2_ret = 0x1e,       /* .975v */
+	.vdd2_off = 0x00,       /* 0.6v */
 };
 
 static inline u32 voltage_read_reg(void __iomem *offset)
@@ -149,26 +155,26 @@ static void __init init_voltagecontroller(void)
 			VC_VOLRA0_SHIFT));
 
 	voltage_write_reg(vc_reg.vc_cmdval0_reg,
-			(vc_config.vdd0_on << VC_CMD_ON_SHIFT) |
-			(vc_config.vdd0_onlp << VC_CMD_ONLP_SHIFT) |
-			(vc_config.vdd0_ret << VC_CMD_RET_SHIFT) |
-			(vc_config.vdd0_off << VC_CMD_OFF_SHIFT));
-
-	voltage_write_reg(vc_reg.vc_cmdval1_reg,
 			(vc_config.vdd1_on << VC_CMD_ON_SHIFT) |
 			(vc_config.vdd1_onlp << VC_CMD_ONLP_SHIFT) |
 			(vc_config.vdd1_ret << VC_CMD_RET_SHIFT) |
 			(vc_config.vdd1_off << VC_CMD_OFF_SHIFT));
 
+	voltage_write_reg(vc_reg.vc_cmdval1_reg,
+			(vc_config.vdd2_on << VC_CMD_ON_SHIFT) |
+			(vc_config.vdd2_onlp << VC_CMD_ONLP_SHIFT) |
+			(vc_config.vdd2_ret << VC_CMD_RET_SHIFT) |
+			(vc_config.vdd2_off << VC_CMD_OFF_SHIFT));
+
 	voltage_write_reg(vc_ch_conf_reg, VC_CMD1 | VC_RAV1);
 
 	voltage_write_reg(vc_i2c_cfg_reg, VC_MCODE_SHIFT | VC_HSEN);
 
 	/* Write setup times */
-	voltage_write_reg(prm_clksetup_reg, vc_config.clksetup);
+	voltage_write_reg(prm_clksetup_reg, vc_config.clksetup_ret);
 	voltage_write_reg(prm_voltsetup1_reg,
-			(vc_config.voltsetup_time2 << VC_SETUP_TIME2_SHIFT) |
-			(vc_config.voltsetup_time1 << VC_SETUP_TIME1_SHIFT));
+		(vc_config.voltsetup_time2_ret << VC_SETUP_TIME2_SHIFT) |
+		(vc_config.voltsetup_time1_ret << VC_SETUP_TIME1_SHIFT));
 	voltage_write_reg(prm_voltoffset_reg, vc_config.voltoffset);
 	voltage_write_reg(prm_voltsetup2_reg, vc_config.voltsetup2);
 
@@ -497,19 +503,57 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
 	if (!setup_vc)
 		return;
 
-	vc_config.clksetup = setup_vc->clksetup;
-	vc_config.voltsetup_time1 = setup_vc->voltsetup_time1;
-	vc_config.voltsetup_time2 = setup_vc->voltsetup_time2;
+	/* CLK SETUPTIME for RET & OFF */
+	vc_config.clksetup_ret = setup_vc->clksetup_ret;
+	vc_config.clksetup_off = setup_vc->clksetup_off;
+	/* VOLT SETUPTIME for RET & OFF */
+	vc_config.voltsetup_time1_ret = setup_vc->voltsetup_time1_ret;
+	vc_config.voltsetup_time2_ret = setup_vc->voltsetup_time2_ret;
+	vc_config.voltsetup_time1_off = setup_vc->voltsetup_time1_off;
+	vc_config.voltsetup_time2_off = setup_vc->voltsetup_time2_off;
 	vc_config.voltoffset = setup_vc->voltoffset;
 	vc_config.voltsetup2 = setup_vc->voltsetup2;
-	vc_config.vdd0_on = setup_vc->vdd0_on;
-	vc_config.vdd0_onlp = setup_vc->vdd0_onlp;
-	vc_config.vdd0_ret = setup_vc->vdd0_ret;
-	vc_config.vdd0_off = setup_vc->vdd0_off;
+
+	/* VC COMMAND VALUES for VDD1/VDD2 */
 	vc_config.vdd1_on = setup_vc->vdd1_on;
 	vc_config.vdd1_onlp = setup_vc->vdd1_onlp;
 	vc_config.vdd1_ret = setup_vc->vdd1_ret;
 	vc_config.vdd1_off = setup_vc->vdd1_off;
+	vc_config.vdd2_on = setup_vc->vdd2_on;
+	vc_config.vdd2_onlp = setup_vc->vdd2_onlp;
+	vc_config.vdd2_ret = setup_vc->vdd2_ret;
+	vc_config.vdd2_off = setup_vc->vdd2_off;
+}
+
+void update_voltsetup_time(int core_next_state)
+{
+	/* update voltsetup time */
+	if (core_next_state == PWRDM_POWER_OFF) {
+		prm_write_mod_reg(vc_config.clksetup_off, OMAP3430_GR_MOD,
+				OMAP3_PRM_CLKSETUP_OFFSET);
+		prm_write_mod_reg((vc_config.voltsetup_time2_off <<
+				OMAP3430_SETUP_TIME2_SHIFT) |
+				(vc_config.voltsetup_time1_off <<
+				OMAP3430_SETUP_TIME1_SHIFT),
+				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
+
+		if (voltage_off_while_idle)
+			prm_write_mod_reg(vc_config.voltsetup2, OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTSETUP2_OFFSET);
+
+	} else if (core_next_state == PWRDM_POWER_RET) {
+		prm_write_mod_reg(vc_config.clksetup_ret, OMAP3430_GR_MOD,
+				OMAP3_PRM_CLKSETUP_OFFSET);
+		prm_write_mod_reg((vc_config.voltsetup_time2_ret <<
+				OMAP3430_SETUP_TIME2_SHIFT) |
+				(vc_config.voltsetup_time1_ret <<
+				OMAP3430_SETUP_TIME1_SHIFT),
+				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
+
+		/* clear voltsetup2_reg if sys_off not enabled */
+		prm_write_mod_reg(0x0, OMAP3430_GR_MOD,
+				OMAP3_PRM_VOLTSETUP2_OFFSET);
+	}
 }
 
 /**
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index be67dbe..7bc4948 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -73,6 +73,7 @@ extern int get_vdd2_opp(void);
 void omap_voltageprocessor_enable(int vp_id);
 void omap_voltageprocessor_disable(int vp_id);
 void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
+void update_voltsetup_time(int core_next_state);
 void omap_voltage_init(void);
 int omap_voltage_scale(int vdd, u8 target_vsel, u8 current_vsel);
 void omap_reset_voltage(int vdd);
-- 
1.6.0.4

