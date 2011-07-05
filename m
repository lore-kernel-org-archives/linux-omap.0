From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH] OMAP4460: Hwmod: Add hwmod for thermal sensor
Date: Tue, 5 Jul 2011 20:28:52 +0530
Message-ID: <1309877932-27202-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58264 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab1GEO5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 10:57:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, Vishwnath BS <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

From: Keerthy <j-keerthy@ti.com>

Patch adds hwmod entry for 4460 thermal sensor module. Thermal sensor module
is part of Control module sharing its address space and clocked via Bandgap
Functional Clock. Adding a seperate hwmod entry for thermal sensor will
enable thermal sensor driver to manage its clock cleanly using PM runtime
interfaces.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Vishwnath BS <vishwanath.bs@ti.com>

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
Patch is generated against "[PATCH v2 0/6] OMAP4: Add 4460 base support"
patch series from Rajendra and boot tested on 4430 and 4460.

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   54 ++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5e9df34..a01a9ec
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -755,6 +755,58 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 };
 
 /*
+ * 'thermal_sensor' class
+ * thermal sensor module inside the bandgap / control module
+ */
+
+static struct omap_hwmod_class omap44xx_thermal_sensor_hwmod_class = {
+	.name   = "thermal_sensor",
+};
+
+static struct omap_hwmod_irq_info omap44xx_thermal_sensor_irqs[] = {
+	{ .name = "thermal_alert", .irq = 126 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_thermal_sensor_addrs[] = {
+	{
+		.pa_start       = 0x4a002378,
+		.pa_end         = 0x4a0023ff,
+	},
+};
+
+static struct omap_hwmod omap44xx_thermal_sensor_hwmod;
+/* l4_cfg -> ctrl_module_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__thermal_sensor = {
+	.master         = &omap44xx_l4_cfg_hwmod,
+	.slave          = &omap44xx_thermal_sensor_hwmod,
+	.clk            = "l4_div_ck",
+	.addr           = omap44xx_thermal_sensor_addrs,
+	.addr_cnt       = ARRAY_SIZE(omap44xx_thermal_sensor_addrs),
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ctrl_module_core slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_thermal_sensor_slaves[] = {
+	&omap44xx_l4_cfg__thermal_sensor,
+};
+
+static struct omap_hwmod omap44xx_thermal_sensor_hwmod = {
+	.name           = "thermal_sensor",
+	.class          = &omap44xx_thermal_sensor_hwmod_class,
+	.mpu_irqs       = omap44xx_thermal_sensor_irqs,
+	.mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_thermal_sensor_irqs),
+	.main_clk       = "bandgap_ts_fclk",
+	.slaves		= omap44xx_thermal_sensor_slaves,
+	.slaves_cnt     = ARRAY_SIZE(omap44xx_thermal_sensor_slaves),
+	.prcm           = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+		},
+	},
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP446X),
+};
+
+/*
  * 'bandgap' class
  * bangap reference for ldo regulators
  */
@@ -5205,6 +5257,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_timer10_hwmod,
 	&omap44xx_timer11_hwmod,
 
+	/* thermal sensor hwmod */
+	&omap44xx_thermal_sensor_hwmod,
 	/* uart class */
 	&omap44xx_uart1_hwmod,
 	&omap44xx_uart2_hwmod,
-- 
1.7.0.4

