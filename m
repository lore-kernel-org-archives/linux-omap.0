From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/4] OMAP4: hwmod data: Move the DMA structures
Date: Thu, 23 Dec 2010 23:30:31 +0100
Message-ID: <1293143432-9891-3-git-send-email-b-cousson@ti.com>
References: <1293143432-9891-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55121 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab0LWWaz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 17:30:55 -0500
In-Reply-To: <1293143432-9891-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

The merge of the DMA series on top of the already modified
omap_hwmod_data_44xx.c put the dma_system structures at
the wrong position in the file.
Re-order it properly.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  196 ++++++++++++++--------------
 1 files changed, 97 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 378d4a7..f35a99d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -254,6 +254,14 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 };
 
 /* l3_main_2 interface data */
+/* dma_system -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
+	.master		= &omap44xx_dma_system_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* iva -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_iva__l3_main_2 = {
 	.master		= &omap44xx_iva_hwmod,
@@ -270,14 +278,6 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* dma_system -> l3_main_2 */
-static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
-	.master		= &omap44xx_dma_system_hwmod,
-	.slave		= &omap44xx_l3_main_2_hwmod,
-	.clk		= "l3_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_cfg -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 	.master		= &omap44xx_l4_cfg_hwmod,
@@ -506,7 +506,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  ctrl_module_pad_wkup
  *  ctrl_module_wkup
  *  debugss
- *  dma_system
  *  dmic
  *  dss
  *  dss_dispc
@@ -577,6 +576,92 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  */
 
 /*
+ * 'dma' class
+ * dma controller for data exchange between memory to memory (i.e. internal or
+ * external memory) and gp peripherals to memory or memory to gp peripherals
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_dma_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x002c,
+	.syss_offs	= 0x0028,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_EMUFREE | SYSC_HAS_MIDLEMODE |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_dma_hwmod_class = {
+	.name	= "dma",
+	.sysc	= &omap44xx_dma_sysc,
+};
+
+/* dma dev_attr */
+static struct omap_dma_dev_attr dma_dev_attr = {
+	.dev_caps	= RESERVE_CHANNEL | DMA_LINKED_LCH | GLOBAL_PRIORITY |
+			  IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORITY,
+	.lch_count	= 32,
+};
+
+/* dma_system */
+static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
+	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
+};
+
+/* dma_system master ports */
+static struct omap_hwmod_ocp_if *omap44xx_dma_system_masters[] = {
+	&omap44xx_dma_system__l3_main_2,
+};
+
+static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
+	{
+		.pa_start	= 0x4a056000,
+		.pa_end		= 0x4a0560ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> dma_system */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_dma_system_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_dma_system_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dma_system_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dma_system_slaves[] = {
+	&omap44xx_l4_cfg__dma_system,
+};
+
+static struct omap_hwmod omap44xx_dma_system_hwmod = {
+	.name		= "dma_system",
+	.class		= &omap44xx_dma_hwmod_class,
+	.mpu_irqs	= omap44xx_dma_system_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dma_system_irqs),
+	.main_clk	= "l3_div_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_SDMA_SDMA_CLKCTRL,
+		},
+	},
+	.dev_attr	= &dma_dev_attr,
+	.slaves		= omap44xx_dma_system_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
+	.masters	= omap44xx_dma_system_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'dsp' class
  * dsp sub-system
  */
@@ -1916,93 +2001,6 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-
-/*
- * 'dma' class
- * dma controller for data exchange between memory to memory (i.e. internal or
- * external memory) and gp peripherals to memory or memory to gp peripherals
- */
-
-static struct omap_hwmod_class_sysconfig omap44xx_dma_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x002c,
-	.syss_offs	= 0x0028,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_EMUFREE | SYSC_HAS_MIDLEMODE |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-/* dma attributes */
-static struct omap_dma_dev_attr dma_dev_attr = {
-	.dev_caps  = RESERVE_CHANNEL | DMA_LINKED_LCH | GLOBAL_PRIORITY |
-				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORITY,
-	.lch_count = 32,
-};
-
-static struct omap_hwmod_class omap44xx_dma_hwmod_class = {
-	.name	= "dma",
-	.sysc	= &omap44xx_dma_sysc,
-};
-
-/* dma_system */
-static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
-};
-
-/* dma_system master ports */
-static struct omap_hwmod_ocp_if *omap44xx_dma_system_masters[] = {
-	&omap44xx_dma_system__l3_main_2,
-};
-
-static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
-	{
-		.pa_start	= 0x4a056000,
-		.pa_end		= 0x4a0560ff,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
-/* l4_cfg -> dma_system */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_dma_system_hwmod,
-	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dma_system_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_dma_system_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* dma_system slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_dma_system_slaves[] = {
-	&omap44xx_l4_cfg__dma_system,
-};
-
-static struct omap_hwmod omap44xx_dma_system_hwmod = {
-	.name		= "dma_system",
-	.class		= &omap44xx_dma_hwmod_class,
-	.mpu_irqs	= omap44xx_dma_system_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dma_system_irqs),
-	.main_clk	= "l3_div_ck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_SDMA_SDMA_CLKCTRL,
-		},
-	},
-	.slaves		= omap44xx_dma_system_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
-	.masters	= omap44xx_dma_system_masters,
-	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
-	.dev_attr	= &dma_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -2022,12 +2020,12 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_l4_per_hwmod,
 	&omap44xx_l4_wkup_hwmod,
 
-	/* dma class */
-	&omap44xx_dma_system_hwmod,
-
 	/* mpu_bus class */
 	&omap44xx_mpu_private_hwmod,
 
+	/* dma class */
+	&omap44xx_dma_system_hwmod,
+
 	/* dsp class */
 	&omap44xx_dsp_hwmod,
 	&omap44xx_dsp_c0_hwmod,
-- 
1.7.0.4

