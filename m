From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/6] OMAP4: Hwmod: system control module hwmod
Date: Thu, 22 Sep 2011 20:59:19 +0530
Message-ID: <1316705361-12175-5-git-send-email-j-keerthy@ti.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49376 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab1IVP32 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 11:29:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MFTOYU022864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 10:29:26 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MFTNZK025732
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 20:59:23 +0530 (IST)
In-Reply-To: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com

From: Benoit Cousson <b-cousson@ti.com>

Adding the system control module hwmod.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   71 ++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 393afac..af77ec6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -30,6 +30,7 @@
 #include <plat/mmc.h>
 #include <plat/i2c.h>
 #include <plat/dmtimer.h>
+#include <plat/scm.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -821,6 +822,73 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 };
 
 /*
+ * 'ctrl_module' class
+ * attila core control module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_ctrl_module_sysc = {
+	.rev_offs       = 0x0000,
+	.sysc_offs      = 0x0010,
+	.sysc_flags     = SYSC_HAS_SIDLEMODE,
+	.idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				SIDLE_SMART_WKUP),
+	.sysc_fields    = &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_ctrl_module_hwmod_class = {
+	.name   = "ctrl_module",
+	.sysc   = &omap44xx_ctrl_module_sysc,
+};
+
+/* ctrl_module_core */
+static struct omap_hwmod omap44xx_ctrl_module_core_hwmod;
+static struct omap_hwmod_irq_info omap44xx_ctrl_module_core_irqs[] = {
+	{ .name = "sec_evts", .irq = 8 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "thermal_alert", .irq = 126 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_core_addrs[] = {
+	{
+		.pa_start       = 0x4a002000,
+		.pa_end         = 0x4a0027ff,
+		.flags          = ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> ctrl_module_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_core = {
+	.master         = &omap44xx_l4_cfg_hwmod,
+	.slave          = &omap44xx_ctrl_module_core_hwmod,
+	.clk            = "l4_div_ck",
+	.addr           = omap44xx_ctrl_module_core_addrs,
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ctrl_module_core slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_ctrl_module_core_slaves[] = {
+	&omap44xx_l4_cfg__ctrl_module_core,
+};
+
+/* scm dev_attr */
+static struct omap4460plus_scm_dev_attr scm_dev_attr = {
+	.cnt		= 1,
+	.list[0]	= &omap_mpu_temp_sensor_registers,
+	.name[0]	= "mpu",
+	.t_shut		= 1,
+};
+
+static struct omap_hwmod omap44xx_ctrl_module_core_hwmod = {
+	.name           = "ctrl_module_core",
+	.class          = &omap44xx_ctrl_module_hwmod_class,
+	.mpu_irqs       = omap44xx_ctrl_module_core_irqs,
+	.main_clk       = "l4_div_ck",
+	.slaves         = omap44xx_ctrl_module_core_slaves,
+	.slaves_cnt     = ARRAY_SIZE(omap44xx_ctrl_module_core_slaves),
+	.dev_attr	= &scm_dev_attr,
+	.clkdm_name     = "l4_wkup_clkdm",
+};
+
+/*
  * 'bandgap' class
  * bangap reference for ldo regulators
  */
@@ -5409,6 +5477,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_timer10_hwmod,
 	&omap44xx_timer11_hwmod,
 
+	/* scm hwmod */
+	&omap44xx_ctrl_module_core_hwmod,
+
 	/* uart class */
 	&omap44xx_uart1_hwmod,
 	&omap44xx_uart2_hwmod,
-- 
1.7.0.4

