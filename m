From: x0080970@ti.com
Subject: [PATCH v2 2/6] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Tue, 19 Jan 2010 23:05:41 +0530
Message-ID: <1263922541-13782-1-git-send-email-x0080970@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36418 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab0ASRXa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 12:23:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

From: Lesly A M <x0080970@ti.com>

omap3: pm: Using separate clk/volt setup_time for RET and OFF states

Copied the setuptime in each board file, since OMAP3430 & OMAP3630
has different voltage levels for the same states.

Made the changes to program the setup time according to
the target state of CORE power domain.
The voltsetup2 is used only when the device exits sys_off mode
(with PRM_VOLTCTRL[3]SEL_OFF set to 1).

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>

---
 arch/arm/mach-omap2/board-3430sdp.c           |   14 ++++--
 arch/arm/mach-omap2/board-3630sdp.c           |   25 ++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    4 +
 arch/arm/mach-omap2/board-zoom2.c             |   25 ++++++++++
 arch/arm/mach-omap2/board-zoom3.c             |   25 ++++++++++
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 
 arch/arm/mach-omap2/pm.h                      |   11 +++-
 arch/arm/mach-omap2/pm34xx.c                  |   60 +++++++++++++++++++++-----
 8 files changed, 143 insertions(+), 23 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-3430sdp.c	2010-01-19 19:18:55.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/board-3430sdp.c	2010-01-19 19:19:23.000000000 +0530
@@ -75,13 +75,19 @@
 	{1, 10000, 30000, 300000},
 };
 
-/* FIXME: These are not the optimal setup values to be used on 3430sdp*/
+/* FIXME: These are not the optimal setup values to be used on 3430sdp */
 static struct prm_setup_vc omap3_setuptime_table = {
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
+	/* VC COMMAND VALUES for VDD1/VDD2 */
 	.vdd0_on = 0x30,
 	.vdd0_onlp = 0x20,
 	.vdd0_ret = 0x1e,
Index: linux-omap-pm/arch/arm/mach-omap2/board-3630sdp.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-3630sdp.c	2010-01-19 19:18:55.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/board-3630sdp.c	2010-01-19 19:19:23.000000000 +0530
@@ -25,6 +25,29 @@
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+
+static struct prm_setup_vc omap3_setuptime_table = {
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0xff,
+	.clksetup_off = 0xff,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0xfff,
+	.voltsetup_time2_ret = 0xfff,
+	.voltsetup_time1_off = 0xfff,
+	.voltsetup_time2_off = 0xfff,
+	.voltoffset = 0xff,
+	.voltsetup2 = 0xff,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd0_on = 0x28, /* 1.1v */
+	.vdd0_onlp = 0x20, /* 1.0v */
+	.vdd0_ret = 0x13, /* 0.83v */
+	.vdd0_off = 0x00, /* 0.6v */
+	.vdd1_on = 0x2B, /* 1.1375v */
+	.vdd1_onlp = 0x20, /* 1.0v */
+	.vdd1_ret = 0x14, /* 0.85v */
+	.vdd1_off = 0x00, /* 0.6v */
+};
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -97,7 +120,7 @@
 static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-	zoom_peripherals_init();
+	zoom_peripherals_init(&omap3_setuptime_table);
 	board_smc91x_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom-peripherals.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom-peripherals.c	2010-01-19 19:18:55.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/board-zoom-peripherals.c	2010-01-19 19:19:23.000000000 +0530
@@ -26,6 +26,7 @@
 
 #include "mux.h"
 #include "mmc-twl4030.h"
+#include "pm.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -271,10 +272,11 @@
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
-void __init zoom_peripherals_init(void)
+void __init zoom_peripherals_init(void *peripheral_data)
 {
 	omap_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
 	enable_board_wakeup_source();
+	omap3_pm_init_vc((struct prm_setup_vc *)peripheral_data);
 }
Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom2.c	2010-01-19 19:18:55.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c	2010-01-19 19:19:23.000000000 +0530
@@ -26,6 +26,29 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "omap3-opp.h"
+#include "pm.h"
+
+static struct prm_setup_vc omap3_setuptime_table = {
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0xff,
+	.clksetup_off = 0xff,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0xfff,
+	.voltsetup_time2_ret = 0xfff,
+	.voltsetup_time1_off = 0xfff,
+	.voltsetup_time2_off = 0xfff,
+	.voltoffset = 0xff,
+	.voltsetup2 = 0xff,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd0_on = 0x30,
+	.vdd0_onlp = 0x20,
+	.vdd0_ret = 0x1e,
+	.vdd0_off = 0x00,
+	.vdd1_on = 0x2c,
+	.vdd1_onlp = 0x20,
+	.vdd1_ret = 0x1e,
+	.vdd1_off = 0x00,
+};
 
 static void __init omap_zoom2_init_irq(void)
 {
@@ -82,7 +105,7 @@
 static void __init omap_zoom2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	zoom_peripherals_init();
+	zoom_peripherals_init(&omap3_setuptime_table);
 	zoom_debugboard_init();
 }
 
Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom3.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom3.c	2010-01-19 19:18:55.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/board-zoom3.c	2010-01-19 19:19:23.000000000 +0530
@@ -24,6 +24,29 @@
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+
+static struct prm_setup_vc omap3_setuptime_table = {
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0xff,
+	.clksetup_off = 0xff,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0xfff,
+	.voltsetup_time2_ret = 0xfff,
+	.voltsetup_time1_off = 0xfff,
+	.voltsetup_time2_off = 0xfff,
+	.voltoffset = 0xff,
+	.voltsetup2 = 0xff,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd0_on = 0x28, /* 1.1v */
+	.vdd0_onlp = 0x20, /* 1.0v */
+	.vdd0_ret = 0x13, /* 0.83v */
+	.vdd0_off = 0x00, /* 0.6v */
+	.vdd1_on = 0x2B, /* 1.1375v */
+	.vdd1_onlp = 0x20, /* 1.0v */
+	.vdd1_ret = 0x14, /* 0.85v */
+	.vdd1_off = 0x00, /* 0.6v */
+};
 
 static void __init omap_zoom_map_io(void)
 {
@@ -66,7 +89,7 @@
 static void __init omap_zoom_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-	zoom_peripherals_init();
+	zoom_peripherals_init(&omap3_setuptime_table);
 	zoom_debugboard_init();
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
Index: linux-omap-pm/arch/arm/mach-omap2/include/mach/board-zoom.h
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/include/mach/board-zoom.h	2010-01-19 19:18:55.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/include/mach/board-zoom.h	2010-01-19 19:19:23.000000000 +0530
@@ -2,4 +2,4 @@
  * Defines for zoom boards
  */
 extern int __init zoom_debugboard_init(void);
-extern void __init zoom_peripherals_init(void);
+extern void __init zoom_peripherals_init(void *);
Index: linux-omap-pm/arch/arm/mach-omap2/pm.h
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm.h	2010-01-19 19:18:55.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/pm.h	2010-01-19 19:19:23.000000000 +0530
@@ -41,9 +41,14 @@
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
Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c	2010-01-19 19:18:55.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c	2010-01-19 19:19:23.000000000 +0530
@@ -96,11 +96,17 @@
 static struct powerdomain *cam_pwrdm;
 
 static struct prm_setup_vc prm_setup = {
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
+	/* VC COMMAND VALUES for VDD1/VDD2 */
 	.vdd0_on = 0x30,	/* 1.2v */
 	.vdd0_onlp = 0x20,	/* 1.0v */
 	.vdd0_ret = 0x1e,	/* 0.975v */
@@ -374,6 +380,10 @@
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
+	u16 clksetup = 0xff;
+	u16 voltsetup_time1 = 0xfff;
+	u16 voltsetup_time2 = 0xfff;
+	u16 voltsetup2_sys_off = 0x0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -438,20 +448,43 @@
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
+			/* VOLT & CLK SETUPTIME for OFF */
+			clksetup = prm_setup.clksetup_off;
+			voltsetup_time1 = prm_setup.voltsetup_time1_off;
+			voltsetup_time2 = prm_setup.voltsetup_time2_off;
+
 			u32 voltctrl = OMAP3430_AUTO_OFF;
 
-			if (voltage_off_while_idle)
+			if (voltage_off_while_idle) {
 				voltctrl |= OMAP3430_SEL_OFF;
+				voltsetup2_sys_off = prm_setup.voltsetup2;
+			}
 			prm_set_mod_reg_bits(voltctrl,
 					     OMAP3430_GR_MOD,
 					     OMAP3_PRM_VOLTCTRL_OFFSET);
 			omap3_core_save_context();
 			omap3_prcm_save_context();
 		} else if (core_next_state == PWRDM_POWER_RET) {
+			/* VOLT & CLK SETUPTIME for RET */
+			clksetup = prm_setup.clksetup_ret;
+			voltsetup_time1 = prm_setup.voltsetup_time1_ret;
+			voltsetup_time2 = prm_setup.voltsetup_time2_ret;
+
 			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
 		}
+		/* Write setup times */
+		prm_write_mod_reg(clksetup, OMAP3430_GR_MOD,
+				OMAP3_PRM_CLKSETUP_OFFSET);
+		prm_write_mod_reg((voltsetup_time2 <<
+				OMAP3430_SETUP_TIME2_SHIFT) |
+				(voltsetup_time1 <<
+				OMAP3430_SETUP_TIME1_SHIFT),
+				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
+		prm_write_mod_reg(voltsetup2_sys_off, OMAP3430_GR_MOD,
+				OMAP3_PRM_VOLTSETUP2_OFFSET);
+
 		/* Enable IO-PAD and IO-CHAIN wakeups */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
@@ -1077,12 +1110,17 @@
 {
 	if (!setup_vc)
 		return;
-
-	prm_setup.clksetup = setup_vc->clksetup;
-	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
-	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
+	/* CLK SETUPTIME for RET & OFF */
+	prm_setup.clksetup_ret = setup_vc->clksetup_ret;
+	prm_setup.clksetup_off = setup_vc->clksetup_off;
+	/* VOLT SETUPTIME for RET & OFF */
+	prm_setup.voltsetup_time1_ret = setup_vc->voltsetup_time1_ret;
+	prm_setup.voltsetup_time2_ret = setup_vc->voltsetup_time2_ret;
+	prm_setup.voltsetup_time1_off = setup_vc->voltsetup_time1_off;
+	prm_setup.voltsetup_time2_off = setup_vc->voltsetup_time2_off;
 	prm_setup.voltoffset = setup_vc->voltoffset;
 	prm_setup.voltsetup2 = setup_vc->voltsetup2;
+	/* VC COMMAND VALUES for VDD1/VDD2 */
 	prm_setup.vdd0_on = setup_vc->vdd0_on;
 	prm_setup.vdd0_onlp = setup_vc->vdd0_onlp;
 	prm_setup.vdd0_ret = setup_vc->vdd0_ret;
@@ -1259,11 +1297,11 @@
 			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
 	/* Write setup times */
-	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
+	prm_write_mod_reg(prm_setup.clksetup_ret, OMAP3430_GR_MOD,
 			OMAP3_PRM_CLKSETUP_OFFSET);
-	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
+	prm_write_mod_reg((prm_setup.voltsetup_time2_ret <<
 			OMAP3430_SETUP_TIME2_SHIFT) |
-			(prm_setup.voltsetup_time1 <<
+			(prm_setup.voltsetup_time1_ret <<
 			OMAP3430_SETUP_TIME1_SHIFT),
 			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
 
