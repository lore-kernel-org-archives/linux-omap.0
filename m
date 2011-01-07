From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v5 02/17] OMAP2430: hwmod data: add DSS DISPC RFBI VENC
Date: Fri,  7 Jan 2011 16:55:36 +0530
Message-ID: <1294399551-10457-3-git-send-email-sumit.semwal@ti.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56387 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab1AGL0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 06:26:36 -0500
In-Reply-To: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Hwmod needs database of all IPs in a system. This patch generates the hwmod
database for OMAP2430 Display Sub System. Since DSS is also considered as an
IP as DISPC, RFBI, name it as dss_dss.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  282 ++++++++++++++++++++++++++++
 1 files changed, 282 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8ecfbcd..b06eeea 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -38,6 +38,10 @@ static struct omap_hwmod omap2430_mpu_hwmod;
 static struct omap_hwmod omap2430_iva_hwmod;
 static struct omap_hwmod omap2430_l3_main_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
+static struct omap_hwmod omap2430_dss_dss_hwmod;
+static struct omap_hwmod omap2430_dss_dispc_hwmod;
+static struct omap_hwmod omap2430_dss_rfbi_hwmod;
+static struct omap_hwmod omap2430_dss_venc_hwmod;
 static struct omap_hwmod omap2430_wd_timer2_hwmod;
 static struct omap_hwmod omap2430_gpio1_hwmod;
 static struct omap_hwmod omap2430_gpio2_hwmod;
@@ -65,6 +69,13 @@ static struct omap_hwmod_ocp_if *omap2430_l3_main_slaves[] = {
 	&omap2430_mpu__l3_main,
 };
 
+/* DSS -> l3 */
+static struct omap_hwmod_ocp_if omap2430_dss__l3 = {
+	.master		= &omap2430_dss_dss_hwmod,
+	.slave		= &omap2430_l3_main_hwmod,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Master interfaces on the L3 interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l3_main_masters[] = {
 	&omap2430_l3_main__l4_core,
@@ -469,6 +480,271 @@ static struct omap_hwmod omap2430_uart3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/*
+ * 'dss' class
+ * display sub-system
+ */
+
+static struct omap_hwmod_class_sysconfig omap2430_dss_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2430_dss_hwmod_class = {
+	.name = "dss",
+	.sysc = &omap2430_dss_sysc,
+};
+
+/* dss */
+static struct omap_hwmod_irq_info omap2430_dss_irqs[] = {
+	{ .irq = 25 },
+};
+static struct omap_hwmod_dma_info omap2430_dss_sdma_chs[] = {
+	{ .name = "dispc", .dma_req = 5 },
+};
+
+/* dss */
+/* dss master ports */
+static struct omap_hwmod_ocp_if *omap2430_dss_masters[] = {
+	&omap2430_dss__l3,
+};
+
+static struct omap_hwmod_addr_space omap2430_dss_addrs[] = {
+	{
+		.pa_start	= 0x48050000,
+		.pa_end		= 0x480503FF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss */
+static struct omap_hwmod_ocp_if omap2430_l4_core__dss = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_dss_dss_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap2430_dss_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_dss_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* dss slave ports */
+static struct omap_hwmod_ocp_if *omap2430_dss_slaves[] = {
+	&omap2430_l4_core__dss,
+};
+
+static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_54m_fck" },
+	{ .role = "sys_clk", .clk = "dss2_fck" },
+};
+
+static struct omap_hwmod omap2430_dss_dss_hwmod = {
+	.name		= "dss_dss",
+	.class		= &omap2430_dss_hwmod_class,
+	.main_clk	= "dss1_fck", /* instead of dss_fck */
+	.mpu_irqs	= omap2430_dss_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_dss_irqs),
+	.sdma_reqs	= omap2430_dss_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_dss_sdma_chs),
+
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_DSS_SHIFT,
+		},
+	},
+	.opt_clks	= dss_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
+	.slaves		= omap2430_dss_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_slaves),
+	.masters	= omap2430_dss_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_dss_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/*
+ * 'dispc' class
+ * display controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap2430_dispc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2430_dispc_hwmod_class = {
+	.name = "dispc",
+	.sysc = &omap2430_dispc_sysc,
+};
+
+static struct omap_hwmod_addr_space omap2430_dss_dispc_addrs[] = {
+	{
+		.pa_start	= 0x48050400,
+		.pa_end		= 0x480507FF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss_dispc */
+static struct omap_hwmod_ocp_if omap2430_l4_core__dss_dispc = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_dss_dispc_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap2430_dss_dispc_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_dss_dispc_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* dss_dispc slave ports */
+static struct omap_hwmod_ocp_if *omap2430_dss_dispc_slaves[] = {
+	&omap2430_l4_core__dss_dispc,
+};
+
+static struct omap_hwmod omap2430_dss_dispc_hwmod = {
+	.name		= "dss_dispc",
+	.class		= &omap2430_dispc_hwmod_class,
+	.main_clk	= "dss1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_DSS_SHIFT,
+		},
+	},
+	.slaves		= omap2430_dss_dispc_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_dispc_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/*
+ * 'rfbi' class
+ * remote frame buffer interface
+ */
+
+static struct omap_hwmod_class_sysconfig omap2430_rfbi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2430_rfbi_hwmod_class = {
+	.name = "rfbi",
+	.sysc = &omap2430_rfbi_sysc,
+};
+
+static struct omap_hwmod_addr_space omap2430_dss_rfbi_addrs[] = {
+	{
+		.pa_start	= 0x48050800,
+		.pa_end		= 0x48050BFF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss_rfbi */
+static struct omap_hwmod_ocp_if omap2430_l4_core__dss_rfbi = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_dss_rfbi_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap2430_dss_rfbi_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_dss_rfbi_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* dss_rfbi slave ports */
+static struct omap_hwmod_ocp_if *omap2430_dss_rfbi_slaves[] = {
+	&omap2430_l4_core__dss_rfbi,
+};
+
+static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
+	.name		= "dss_rfbi",
+	.class		= &omap2430_rfbi_hwmod_class,
+	.main_clk	= "dss1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_DSS_SHIFT,
+		},
+	},
+	.slaves		= omap2430_dss_rfbi_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_rfbi_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/*
+ * 'venc' class
+ * video encoder
+ */
+
+static struct omap_hwmod_class omap2430_venc_hwmod_class = {
+	.name = "venc",
+};
+
+/* dss_venc */
+static struct omap_hwmod_addr_space omap2430_dss_venc_addrs[] = {
+	{
+		.pa_start	= 0x48050C00,
+		.pa_end		= 0x48050FFF,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> dss_venc */
+static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_dss_venc_hwmod,
+	.clk		= "dss_54m_fck",
+	.addr		= omap2430_dss_venc_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_dss_venc_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* dss_venc slave ports */
+static struct omap_hwmod_ocp_if *omap2430_dss_venc_slaves[] = {
+	&omap2430_l4_core__dss_venc,
+};
+
+static struct omap_hwmod omap2430_dss_venc_hwmod = {
+	.name		= "dss_venc",
+	.class		= &omap2430_venc_hwmod_class,
+	.main_clk	= "dss1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_DSS_SHIFT,
+		},
+	},
+	.slaves		= omap2430_dss_venc_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_venc_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 /* I2C common */
 static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.rev_offs	= 0x00,
@@ -929,6 +1205,12 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_uart1_hwmod,
 	&omap2430_uart2_hwmod,
 	&omap2430_uart3_hwmod,
+	/* dss class */
+	&omap2430_dss_dss_hwmod,
+	&omap2430_dss_dispc_hwmod,
+	&omap2430_dss_rfbi_hwmod,
+	&omap2430_dss_venc_hwmod,
+	/* i2c class */
 	&omap2430_i2c1_hwmod,
 	&omap2430_i2c2_hwmod,
 
-- 
1.7.0.4

