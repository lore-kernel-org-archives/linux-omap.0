From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 01/20] DSS HWMOD database generation for OMAP3
Date: Mon, 23 Aug 2010 21:27:50 +0530
Message-ID: <1282579089-10487-2-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38246 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754244Ab0HWP6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

OMAP3 HWMOD database for DSS is added and is applicable for 34xx and 36xx.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  346 ++++++++++++++++++++++++++++
 1 files changed, 346 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5d8eb58..e736bb7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,6 +21,7 @@
 #include "omap_hwmod_common_data.h"
 
 #include "prm-regbits-34xx.h"
+#include "cm-regbits-34xx.h"
 
 /*
  * OMAP3xxx hardware module integration data
@@ -31,6 +32,11 @@
  * elsewhere.
  */
 
+static struct omap_hwmod omap3xxx_dss_hwmod;
+static struct omap_hwmod omap3xxx_dss_dispc_hwmod;
+static struct omap_hwmod omap3xxx_dss_dsi1_hwmod;
+static struct omap_hwmod omap3xxx_dss_rfbi_hwmod;
+static struct omap_hwmod omap3xxx_dss_venc_hwmod;
 static struct omap_hwmod omap3xxx_mpu_hwmod;
 static struct omap_hwmod omap3xxx_iva_hwmod;
 static struct omap_hwmod omap3xxx_l3_main_hwmod;
@@ -58,6 +64,14 @@ static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
 	.user	= OCP_USER_MPU,
 };
 
+/* DSS -> l3 */
+static struct omap_hwmod_ocp_if omap3xxx_dss__l3 = {
+	.master		= &omap3xxx_dss_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+
 /* Slave interfaces on the L3 interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l3_main_slaves[] = {
 	&omap3xxx_mpu__l3_main,
@@ -197,6 +211,333 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/*
+ * 'dss' class
+ * display sub-system
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_dss_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_dss_hwmod_class = {
+	.name = "dss",
+	.sysc = &omap3xxx_dss_sysc,
+};
+
+
+/* dss */
+static struct omap_hwmod_irq_info omap3xxx_dss_irqs[] = {
+	{ .irq = 25 },
+};
+
+static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
+	{ .name = "dispc", .dma_req = 5 },
+	{ .name = "dsi1", .dma_req = 74 },
+};
+
+/* dss */
+/* dss master ports */
+static struct omap_hwmod_ocp_if *omap3xxx_dss_masters[] = {
+	&omap3xxx_dss__l3,
+};
+
+static struct omap_hwmod_addr_space omap3xxx_dss_addrs[] = {
+	{
+		.pa_start	= 0x48050000,
+		.pa_end		= 0x480503FF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_dss_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap3xxx_dss_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+
+/* dss slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
+	&omap3xxx_l4_core__dss,
+};
+
+static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_tv_fck" },
+	{ .role = "dssclk", .clk = "dss_96m_fck" },
+	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+};
+
+static struct omap_hwmod omap3xxx_dss_hwmod = {
+	.name		= "dss",
+	.class		= &omap3xxx_dss_hwmod_class,
+	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
+	.mpu_irqs	= omap3xxx_dss_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dss_irqs),
+	.sdma_reqs	= omap3xxx_dss_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_dss_sdma_chs),
+
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_DSS1_SHIFT,
+			.module_offs = OMAP3430_DSS_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
+		},
+	},
+	.opt_clks	= dss_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
+	.slaves		= omap3xxx_dss_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_slaves),
+	.masters	= omap3xxx_dss_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_dss_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/*
+ * 'dispc' class
+ * display controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_dispc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_MIDLEMODE | SYSC_HAS_ENAWAKEUP |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_dispc_hwmod_class = {
+	.name = "dispc",
+	.sysc = &omap3xxx_dispc_sysc,
+};
+
+
+static struct omap_hwmod_addr_space omap3xxx_dss_dispc_addrs[] = {
+	{
+		.pa_start	= 0x48050400,
+		.pa_end		= 0x480507FF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss_dispc */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dispc = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_dss_dispc_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap3xxx_dss_dispc_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_dispc_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* dss_dispc slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_dss_dispc_slaves[] = {
+	&omap3xxx_l4_core__dss_dispc,
+};
+
+static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
+	.name		= "dss_dispc",
+	.class		= &omap3xxx_dispc_hwmod_class,
+	.main_clk	= "dss1_alwon_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_DSS1_SHIFT,
+			.module_offs = OMAP3430_DSS_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_dss_dispc_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dispc_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/*
+ * 'dsi' class
+ * display serial interface controller
+ */
+
+static struct omap_hwmod_class omap3xxx_dsi_hwmod_class = {
+	.name = "dsi",
+};
+
+/* dss_dsi1 */
+
+static struct omap_hwmod_addr_space omap3xxx_dss_dsi1_addrs[] = {
+	{
+		.pa_start	= 0x4804FBFF ,
+		.pa_end		= 0x4804FFFF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss_dsi1 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dsi1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_dss_dsi1_hwmod,
+	.addr		= omap3xxx_dss_dsi1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+
+/* dss_dsi1 slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
+	&omap3xxx_l4_core__dss_dsi1,
+};
+
+static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
+	.name		= "dss_dsi1",
+	.class		= &omap3xxx_dsi_hwmod_class,
+	.main_clk	= "dss1_alwon_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_DSS1_SHIFT,
+			.module_offs = OMAP3430_DSS_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_dss_dsi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+/*
+ * 'rfbi' class
+ * remote frame buffer interface
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_rfbi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_rfbi_hwmod_class = {
+	.name = "rfbi",
+	.sysc = &omap3xxx_rfbi_sysc,
+};
+
+
+static struct omap_hwmod_addr_space omap3xxx_dss_rfbi_addrs[] = {
+	{
+		.pa_start	= 0x48050800,
+		.pa_end		= 0x48050BFF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss_rfbi */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_rfbi = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_dss_rfbi_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap3xxx_dss_rfbi_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+
+/* dss_rfbi slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_dss_rfbi_slaves[] = {
+	&omap3xxx_l4_core__dss_rfbi,
+};
+
+static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
+	.name		= "dss_rfbi",
+	.class		= &omap3xxx_rfbi_hwmod_class,
+	.main_clk	= "dss1_alwon_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_DSS1_SHIFT,
+			.module_offs = OMAP3430_DSS_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_dss_rfbi_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/*
+ * 'venc' class
+ * video encoder
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_venc_sysc = {
+	.sysc_flags	= SYSS_MISSING,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+};
+
+static struct omap_hwmod_class omap3xxx_venc_hwmod_class = {
+	.name = "venc",
+	.sysc = &omap3xxx_venc_sysc,
+};
+
+/* dss_venc */
+static struct omap_hwmod_addr_space omap3xxx_dss_venc_addrs[] = {
+	{
+		.pa_start	= 0x48050C00,
+		.pa_end		= 0x48050FFF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss_venc */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_dss_venc_hwmod,
+	.clk		= "dss_tv_fck",
+	.addr		= omap3xxx_dss_venc_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+
+/* dss_venc slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_dss_venc_slaves[] = {
+	&omap3xxx_l4_core__dss_venc,
+};
+
+static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
+	.name		= "dss_venc",
+	.class		= &omap3xxx_venc_hwmod_class,
+	.main_clk	= "dss1_alwon_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_DSS1_SHIFT,
+			.module_offs = OMAP3430_DSS_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_dss_venc_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -204,6 +545,11 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_dss_hwmod,
+	&omap3xxx_dss_dispc_hwmod,
+	&omap3xxx_dss_dsi1_hwmod,
+	&omap3xxx_dss_rfbi_hwmod,
+	&omap3xxx_dss_venc_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3

