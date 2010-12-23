From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] OMAP4: hwmod data: Fix SR flags, structures order and field alignment
Date: Thu, 23 Dec 2010 15:15:00 +0100
Message-ID: <1293113700-24309-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42986 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab0LWOPP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 09:15:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Smartreflex is missing the recently introduced SIDLE_SMART_WKUP
flag in idlemodes field.

The merge of the DMA and SR series on top of the already modified
omap_hwmod_data_44xx.c moved the dma_system structure at the wrong
position in the file. The same thing happened for the SR structure.
- Re-order the structures properly.

In order to be fully aligned with the Python generator output,
change a couple of fields.
- Add tab in class and dev_attr structures to align fields
- Add a comma at the end of the following line to simplify the
  code generation:
  ".pre_shutdown   = &omap2_wd_timer_disable,"

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  573 ++++++++++++++--------------
 1 files changed, 285 insertions(+), 288 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e2ad1b6..c2806bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -66,7 +66,7 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod;
  * instance(s): dmm
  */
 static struct omap_hwmod_class omap44xx_dmm_hwmod_class = {
-	.name = "dmm",
+	.name	= "dmm",
 };
 
 /* dmm interface data */
@@ -121,7 +121,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
  * instance(s): emif_fw
  */
 static struct omap_hwmod_class omap44xx_emif_fw_hwmod_class = {
-	.name = "emif_fw",
+	.name	= "emif_fw",
 };
 
 /* emif_fw interface data */
@@ -170,7 +170,7 @@ static struct omap_hwmod omap44xx_emif_fw_hwmod = {
  * instance(s): l3_instr, l3_main_1, l3_main_2, l3_main_3
  */
 static struct omap_hwmod_class omap44xx_l3_hwmod_class = {
-	.name = "l3",
+	.name	= "l3",
 };
 
 /* l3_instr interface data */
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
@@ -347,7 +347,7 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
  * instance(s): l4_abe, l4_cfg, l4_per, l4_wkup
  */
 static struct omap_hwmod_class omap44xx_l4_hwmod_class = {
-	.name = "l4",
+	.name	= "l4",
 };
 
 /* l4_abe interface data */
@@ -461,7 +461,7 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
  * instance(s): mpu_private
  */
 static struct omap_hwmod_class omap44xx_mpu_bus_hwmod_class = {
-	.name = "mpu_bus",
+	.name	= "mpu_bus",
 };
 
 /* mpu_private interface data */
@@ -506,7 +506,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  ctrl_module_pad_wkup
  *  ctrl_module_wkup
  *  debugss
- *  dma_system
  *  dmic
  *  dss
  *  dss_dispc
@@ -556,9 +555,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  sl2if
  *  slimbus1
  *  slimbus2
- *  smartreflex_core
- *  smartreflex_iva
- *  smartreflex_mpu
  *  spinlock
  *  timer1
  *  timer10
@@ -580,12 +576,98 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
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
 
 static struct omap_hwmod_class omap44xx_dsp_hwmod_class = {
-	.name = "dsp",
+	.name	= "dsp",
 };
 
 /* dsp */
@@ -682,15 +764,15 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 };
 
 static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
-	.name = "gpio",
-	.sysc = &omap44xx_gpio_sysc,
-	.rev = 2,
+	.name	= "gpio",
+	.sysc	= &omap44xx_gpio_sysc,
+	.rev	= 2,
 };
 
 /* gpio dev_attr */
 static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width = 32,
-	.dbck_flag = true,
+	.bank_width	= 32,
+	.dbck_flag	= true,
 };
 
 /* gpio1 */
@@ -1027,8 +1109,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 };
 
 static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
-	.name = "i2c",
-	.sysc = &omap44xx_i2c_sysc,
+	.name	= "i2c",
+	.sysc	= &omap44xx_i2c_sysc,
 };
 
 /* i2c1 */
@@ -1249,7 +1331,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
  */
 
 static struct omap_hwmod_class omap44xx_iva_hwmod_class = {
-	.name = "iva",
+	.name	= "iva",
 };
 
 /* iva */
@@ -1358,7 +1440,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
  */
 
 static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
-	.name = "mpu",
+	.name	= "mpu",
 };
 
 /* mpu */
@@ -1393,6 +1475,170 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 };
 
 /*
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
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type_smartreflex,
+};
+
+static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
+	.name	= "smartreflex",
+	.sysc	= &omap44xx_smartreflex_sysc,
+	.rev	= 2,
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
+	.vdd_name	= "core",
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
+	.vdd_name	= "iva",
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
+	.vdd_name	= "mpu",
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
+/*
  * 'uart' class
  * universal asynchronous receiver/transmitter (uart)
  */
@@ -1410,8 +1656,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
 };
 
 static struct omap_hwmod_class omap44xx_uart_hwmod_class = {
-	.name = "uart",
-	.sysc = &omap44xx_uart_sysc,
+	.name	= "uart",
+	.sysc	= &omap44xx_uart_sysc,
 };
 
 /* uart1 */
@@ -1643,7 +1889,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
 static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap44xx_wd_timer_sysc,
-	.pre_shutdown	= &omap2_wd_timer_disable
+	.pre_shutdown	= &omap2_wd_timer_disable,
 };
 
 /* wd_timer2 */
@@ -1755,257 +2001,8 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
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
-/*
- * 'smartreflex' class
- * smartreflex module (monitor silicon performance and outputs a measure of
- * performance error)
- */
-
-/* The IP is not compliant to type1 / type2 scheme */
-static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_smartreflex = {
-	.sidle_shift	= 24,
-	.enwkup_shift	= 26,
-};
-
-static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
-	.sysc_offs	= 0x0038,
-	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type_smartreflex,
-};
-
-static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
-	.name = "smartreflex",
-	.sysc = &omap44xx_smartreflex_sysc,
-	.rev  = 2,
-};
-
-/* smartreflex_core */
-static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
-static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] = {
-	{ .irq = 19 + OMAP44XX_IRQ_GIC_START },
-};
-
-static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] = {
-	{
-		.pa_start	= 0x4a0dd000,
-		.pa_end		= 0x4a0dd03f,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
-/* l4_cfg -> smartreflex_core */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_core = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_smartreflex_core_hwmod,
-	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_core_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* smartreflex_core slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
-	&omap44xx_l4_cfg__smartreflex_core,
-};
-
-static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
-	.name		= "smartreflex_core",
-	.class		= &omap44xx_smartreflex_hwmod_class,
-	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_irqs),
-	.main_clk	= "smartreflex_core_fck",
-	.vdd_name	= "core",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
-		},
-	},
-	.slaves		= omap44xx_smartreflex_core_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
-/* smartreflex_iva */
-static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
-static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
-	{ .irq = 102 + OMAP44XX_IRQ_GIC_START },
-};
-
-static struct omap_hwmod_addr_space omap44xx_smartreflex_iva_addrs[] = {
-	{
-		.pa_start	= 0x4a0db000,
-		.pa_end		= 0x4a0db03f,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
-/* l4_cfg -> smartreflex_iva */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_iva = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_smartreflex_iva_hwmod,
-	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_iva_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* smartreflex_iva slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_smartreflex_iva_slaves[] = {
-	&omap44xx_l4_cfg__smartreflex_iva,
-};
-
-static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
-	.name		= "smartreflex_iva",
-	.class		= &omap44xx_smartreflex_hwmod_class,
-	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_irqs),
-	.main_clk	= "smartreflex_iva_fck",
-	.vdd_name	= "iva",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
-		},
-	},
-	.slaves		= omap44xx_smartreflex_iva_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
-/* smartreflex_mpu */
-static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
-static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] = {
-	{ .irq = 18 + OMAP44XX_IRQ_GIC_START },
-};
-
-static struct omap_hwmod_addr_space omap44xx_smartreflex_mpu_addrs[] = {
-	{
-		.pa_start	= 0x4a0d9000,
-		.pa_end		= 0x4a0d903f,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
-/* l4_cfg -> smartreflex_mpu */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_smartreflex_mpu_hwmod,
-	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_mpu_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* smartreflex_mpu slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_smartreflex_mpu_slaves[] = {
-	&omap44xx_l4_cfg__smartreflex_mpu,
-};
-
-static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
-	.name		= "smartreflex_mpu",
-	.class		= &omap44xx_smartreflex_hwmod_class,
-	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_irqs),
-	.main_clk	= "smartreflex_mpu_fck",
-	.vdd_name	= "mpu",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
-		},
-	},
-	.slaves		= omap44xx_smartreflex_mpu_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
+
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
 
@@ -2024,12 +2021,12 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
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
@@ -2056,6 +2053,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
 
+	/* smartreflex class */
+	&omap44xx_smartreflex_core_hwmod,
+	&omap44xx_smartreflex_iva_hwmod,
+	&omap44xx_smartreflex_mpu_hwmod,
+
 	/* uart class */
 	&omap44xx_uart1_hwmod,
 	&omap44xx_uart2_hwmod,
@@ -2066,11 +2068,6 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_wd_timer2_hwmod,
 	&omap44xx_wd_timer3_hwmod,
 
-	/* smartreflex class */
-	&omap44xx_smartreflex_core_hwmod,
-	&omap44xx_smartreflex_iva_hwmod,
-	&omap44xx_smartreflex_mpu_hwmod,
-
 	NULL,
 };
 
-- 
1.7.0.4

