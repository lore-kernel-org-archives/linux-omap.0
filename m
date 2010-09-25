From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 07/11] OMAP4: hwmod: Add inital data for smartreflex modules.
Date: Sat, 25 Sep 2010 18:21:22 +0530
Message-ID: <1285419086-13047-8-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45513 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753097Ab0IYMvj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 08:51:39 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

From: Benoit Cousson <b-cousson@ti.com>

This patch adds the hwmod details for OMAP4 smartreflex modules.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  163 ++++++++++++++++++++++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e20b0ee..ba3c215 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -452,6 +452,165 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/*
+ * 'smartreflex' class
+ * smartreflex module (monitor silicon performance and outputs a measure of
+ * performance error)
+ */
+
+/* The IP is not compliant to type1 / type2 scheme */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_smartreflex = {
+	.sidle_shift	= 24,
+	.enwkup_shift	= 26,
+};
+
+static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
+	.sysc_offs	= 0x0038,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type_smartreflex,
+};
+
+static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
+	.name = "smartreflex",
+	.sysc = &omap44xx_smartreflex_sysc,
+};
+
+/* smartreflex_core */
+static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
+static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] = {
+	{ .irq = 19 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] = {
+	{
+		.pa_start	= 0x4a0dd000,
+		.pa_end		= 0x4a0dd03f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> smartreflex_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_core = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_smartreflex_core_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_smartreflex_core_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* smartreflex_core slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
+	&omap44xx_l4_cfg__smartreflex_core,
+};
+
+static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
+	.name		= "smartreflex_core",
+	.class		= &omap44xx_smartreflex_hwmod_class,
+	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_irqs),
+	.main_clk	= "smartreflex_core_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_smartreflex_core_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* smartreflex_iva */
+static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
+static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
+	{ .irq = 102 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_smartreflex_iva_addrs[] = {
+	{
+		.pa_start	= 0x4a0db000,
+		.pa_end		= 0x4a0db03f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> smartreflex_iva */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_iva = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_smartreflex_iva_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_smartreflex_iva_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* smartreflex_iva slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_smartreflex_iva_slaves[] = {
+	&omap44xx_l4_cfg__smartreflex_iva,
+};
+
+static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
+	.name		= "smartreflex_iva",
+	.class		= &omap44xx_smartreflex_hwmod_class,
+	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_irqs),
+	.main_clk	= "smartreflex_iva_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_smartreflex_iva_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* smartreflex_mpu */
+static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
+static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] = {
+	{ .irq = 18 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_smartreflex_mpu_addrs[] = {
+	{
+		.pa_start	= 0x4a0d9000,
+		.pa_end		= 0x4a0d903f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> smartreflex_mpu */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_smartreflex_mpu_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_smartreflex_mpu_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* smartreflex_mpu slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_smartreflex_mpu_slaves[] = {
+	&omap44xx_l4_cfg__smartreflex_mpu,
+};
+
+static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
+	.name		= "smartreflex_mpu",
+	.class		= &omap44xx_smartreflex_hwmod_class,
+	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_irqs),
+	.main_clk	= "smartreflex_mpu_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_smartreflex_mpu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -472,6 +631,10 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
+
+	&omap44xx_smartreflex_core_hwmod,
+	&omap44xx_smartreflex_iva_hwmod,
+	&omap44xx_smartreflex_mpu_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4

