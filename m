From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [RFC][PATCH 3/3] OMAP PM: Add Board specific parameters for OMAP Volatge layer
Date: Tue, 15 Mar 2011 20:03:42 +0530
Message-ID: <1300199622-32500-4-git-send-email-vishwanath.bs@ti.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44173 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757849Ab1COOaA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 10:30:00 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2FETutq023039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 09:29:59 -0500
In-Reply-To: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

This patch adds board specific parameters for ZOOM3 and OMAP4430 SDP Boards.
The same needs to be done for other OMAP3 and OMAP4 boards once the approach
is accepted.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   52 +++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom.c    |   79 +++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 670cbd5..6dda89c 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -41,6 +41,7 @@
 #include "hsmmc.h"
 #include "timer-gp.h"
 #include "control.h"
+#include "voltage.h"
 
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
@@ -248,6 +249,46 @@ static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
 	},
 };
 
+/* TODO: replace these dummy values with characterized latencies */
+static union omap_volt_board_data omap4430sdp_mpu_volt_data = {
+	.omap4_board_data = {
+		.vdd_setup_ret = {
+			.voltsetup_ramp_up	= 0xff,
+			.voltsetup_ramp_down = 0xff,
+		},
+		.vdd_setup_off = {
+			.voltsetup_ramp_up	= 0xff,
+			.voltsetup_ramp_down = 0xff,
+		},
+	}
+};
+
+static union omap_volt_board_data omap4430sdp_iva_volt_data = {
+	.omap4_board_data = {
+		.vdd_setup_ret = {
+			.voltsetup_ramp_up	= 0xff,
+			.voltsetup_ramp_down = 0xff,
+		},
+		.vdd_setup_off = {
+			.voltsetup_ramp_up	= 0xff,
+			.voltsetup_ramp_down = 0xff,
+		},
+	}
+};
+
+static union omap_volt_board_data omap4430sdp_core_volt_data = {
+	.omap4_board_data = {
+		.vdd_setup_ret = {
+			.voltsetup_ramp_up	= 0xff,
+			.voltsetup_ramp_down = 0xff,
+		},
+		.vdd_setup_off = {
+			.voltsetup_ramp_up	= 0xff,
+			.voltsetup_ramp_down = 0xff,
+		},
+	}
+};
+
 static int omap_ethernet_init(void)
 {
 	int status;
@@ -700,6 +741,7 @@ static void __init omap_4430sdp_init(void)
 {
 	int status;
 	int package = OMAP_PACKAGE_CBS;
+	struct voltagedomain *voltdm;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		package = OMAP_PACKAGE_CBL;
@@ -728,6 +770,15 @@ static void __init omap_4430sdp_init(void)
 	status = omap4_keyboard_init(&sdp4430_keypad_data);
 	if (status)
 		pr_err("Keypad initialization failed: %d\n", status);
+
+	voltdm = omap_voltage_domain_lookup("mpu");
+	omap_voltage_register_board_params(voltdm, &omap4430sdp_mpu_volt_data);
+
+	voltdm = omap_voltage_domain_lookup("iva");
+	omap_voltage_register_board_params(voltdm, &omap4430sdp_iva_volt_data);
+
+	voltdm = omap_voltage_domain_lookup("core");
+	omap_voltage_register_board_params(voltdm, &omap4430sdp_core_volt_data);
 }
 
 static void __init omap_4430sdp_map_io(void)
@@ -746,3 +797,4 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.init_machine	= omap_4430sdp_init,
 	.timer		= &omap_timer,
 MACHINE_END
+
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 7e895ff..d921a2e 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -27,12 +27,45 @@
 
 #include <mach/board-zoom.h>
 
+#include "voltage.h"
 #include "board-flash.h"
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 
 #define ZOOM3_EHCI_RESET_GPIO		64
+/*
+ * VOLTSETUP1 for RET & OFF
+ * Setup time (in us) of the VDD1 and VDD2 regulators.
+ * Number of sys_clk cycles required for VDD regulator to stabilize is
+ * devided by 8 and programmed in the register field for VDD1/VDD2.
+ */
+#define OMAP3_VOLTSETUP_VDD1_RET		28
+#define OMAP3_VOLTSETUP_VDD2_RET		26
+
+#define OMAP3_VOLTSETUP_VDD1_OFF		55
+#define OMAP3_VOLTSETUP_VDD2_OFF		49
+
+/*
+ * VOLTOFFSET for RET & OFF
+ * Offset-time to de-assert sys_offmode signal while exiting the OFF mode
+ * and when the OFF sequence is supervised by the Power IC.
+ */
+#define OMAP3_VOLTOFFSET_OFF	516
+
+#define OMAP3_SYSREQ_CKEN_TIME	31
+#define OMAP3_S2A_TIME			10041
+#define OMAP3_VDD_RAMP_TIME		1250
+
+#define OMAP3_VOLTSETUP2	(OMAP3_SYSREQ_CKEN_TIME + OMAP3_S2A_TIME + OMAP3_VDD_RAMP_TIME - OMAP3_VOLTOFFSET_OFF)
+
+/*
+ * OMAP3 CLKSETUP TIME for RET & OFF
+ * Setup time of the oscillator (sys_clk), based on number of
+ * 32 kHz clock cycles.
+ */
+#define OMAP3_CLKSETUP_RET		31
+#define OMAP3_CLKSETUP_OFF		(OMAP3_VOLTOFFSET_OFF + OMAP3_VOLTSETUP2)
 
 static void __init omap_zoom_init_early(void)
 {
@@ -115,8 +148,46 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]	= -EINVAL,
 };
 
+union omap_volt_board_data zoom_mpu_volt_data = {
+	.omap3_board_data = {
+		.vdd_setup_ret = {
+			.voltsetup	= OMAP3_VOLTSETUP_VDD1_RET,
+			.clksetup	= OMAP3_CLKSETUP_RET,
+			.voltsetup2		= 0,
+			},
+
+		.vdd_setup_off = {
+			.voltsetup	= OMAP3_VOLTSETUP_VDD1_OFF,
+			.clksetup	= OMAP3_CLKSETUP_OFF,
+			.voltsetup2	= OMAP3_VOLTSETUP2,
+		},
+		.voltoffset		= OMAP3_VOLTOFFSET_OFF
+	}
+};
+
+union omap_volt_board_data zoom_core_volt_data = {
+	.omap3_board_data = {
+		.vdd_setup_ret = {
+			.voltsetup	= OMAP3_VOLTSETUP_VDD2_RET,
+			.clksetup	= OMAP3_CLKSETUP_RET,
+			.voltsetup2		= 0,
+		},
+
+		.vdd_setup_off = {
+			.voltsetup	= OMAP3_VOLTSETUP_VDD2_OFF,
+			.clksetup	= OMAP3_CLKSETUP_OFF,
+			.voltsetup2	= OMAP3_VOLTSETUP2,
+		},
+
+		.voltoffset		= OMAP3_VOLTOFFSET_OFF
+	}
+};
+
+
 static void __init omap_zoom_init(void)
 {
+	struct voltagedomain *voltdm;
+
 	if (machine_is_omap_zoom2()) {
 		omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	} else if (machine_is_omap_zoom3()) {
@@ -130,6 +201,13 @@ static void __init omap_zoom_init(void)
 	zoom_debugboard_init();
 	zoom_peripherals_init();
 	zoom_display_init();
+
+	voltdm = omap_voltage_domain_lookup("mpu");
+	omap_voltage_register_board_params(voltdm, &zoom_mpu_volt_data);
+
+	voltdm = omap_voltage_domain_lookup("core");
+	omap_voltage_register_board_params(voltdm, &zoom_core_volt_data);
+
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
@@ -151,3 +229,4 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap_timer,
 MACHINE_END
+
-- 
1.7.0.4

