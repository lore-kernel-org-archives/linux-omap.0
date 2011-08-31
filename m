From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/6 V4] OMAP4: Hwmod: OMAP temperature sensor
Date: Wed, 31 Aug 2011 22:55:08 +0530
Message-ID: <1314811510-15595-5-git-send-email-j-keerthy@ti.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40350 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756915Ab1HaRZ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 13:25:28 -0400
In-Reply-To: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Keerthy <j-keerthy@ti.com>, tony@atomide.com

From: Benoit Cousson <b-cousson@ti.com>

OMAP4460 temperature sensor hwmod cannot be auto generated
since it is part of ctrl module. Hence populating the
necessary hwmod info manually.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com
Cc: b-cousson@ti.com
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   61 ++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..28bf6d3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -29,6 +29,7 @@
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
 #include <plat/i2c.h>
+#include <plat/temperature_sensor.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -832,6 +833,63 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 };
 
 /*
+ * 'temperature_sensor' class
+ * temperature sensor module inside the bandgap / control module
+ */
+
+static struct omap_hwmod_class omap44xx_temperature_sensor_hwmod_class = {
+	.name   = "temperature_sensor",
+};
+
+static struct omap_hwmod_irq_info omap44xx_temperature_sensor_irqs[] = {
+	{ .name = "thermal_alert", .irq = 126 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_temperature_sensor_addrs[] = {
+	{
+		.pa_start       = 0x4a00232c,
+		.pa_end         = 0x4a00238b,
+	},
+};
+
+static struct omap_hwmod omap44xx_temperature_sensor_hwmod;
+/* l4_cfg -> ctrl_module_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__temperature_sensor = {
+	.master         = &omap44xx_l4_cfg_hwmod,
+	.slave          = &omap44xx_temperature_sensor_hwmod,
+	.clk            = "l4_div_ck",
+	.addr           = omap44xx_temperature_sensor_addrs,
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ctrl_module_core slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_temperature_sensor_slaves[] = {
+	&omap44xx_l4_cfg__temperature_sensor,
+};
+
+/* temperature sensor dev_attr */
+static struct omap_temp_sensor_dev_attr temp_sensor_dev_attr = {
+	.name	= "mpu",
+};
+
+static struct omap_hwmod omap44xx_temperature_sensor_hwmod = {
+	.name           = "temperature_sensor_mpu",
+	.class          = &omap44xx_temperature_sensor_hwmod_class,
+	.mpu_irqs       = omap44xx_temperature_sensor_irqs,
+	.main_clk       = "bandgap_ts_fclk",
+	.slaves		= omap44xx_temperature_sensor_slaves,
+	.slaves_cnt     = ARRAY_SIZE(omap44xx_temperature_sensor_slaves),
+	.clkdm_name     = "l4_wkup_clkdm",
+	.prcm           = {
+		.omap4 = {
+		.clkctrl_offs = OMAP4_CM_WKUP_BANDGAP_CLKCTRL_OFFSET,
+		},
+	},
+	.dev_attr	= &temp_sensor_dev_attr,
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'bandgap' class
  * bangap reference for ldo regulators
  */
@@ -5469,6 +5527,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_timer10_hwmod,
 	&omap44xx_timer11_hwmod,
 
+	/* temperature sensor hwmod */
+	&omap44xx_temperature_sensor_hwmod,
+
 	/* uart class */
 	&omap44xx_uart1_hwmod,
 	&omap44xx_uart2_hwmod,
-- 
1.7.0.4

