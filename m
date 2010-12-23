From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/4] OMAP4: hwmod data: Move the smartreflex structures
Date: Thu, 23 Dec 2010 23:30:30 +0100
Message-ID: <1293143432-9891-2-git-send-email-b-cousson@ti.com>
References: <1293143432-9891-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55579 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab0LWWar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 17:30:47 -0500
In-Reply-To: <1293143432-9891-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

The merge of the SR series on top of the already modified
omap_hwmod_data_44xx.c moved the smartreflex structures at the wrong
position in the file.
- Re-order the structures properly.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  341 ++++++++++++++--------------
 1 files changed, 169 insertions(+), 172 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3e9015a..378d4a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -556,9 +556,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  sl2if
  *  slimbus1
  *  slimbus2
- *  smartreflex_core
- *  smartreflex_iva
- *  smartreflex_mpu
  *  spinlock
  *  timer1
  *  timer10
@@ -1393,6 +1390,170 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
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
+	.name = "smartreflex",
+	.sysc = &omap44xx_smartreflex_sysc,
+	.rev  = 2,
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
@@ -1842,170 +2003,6 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
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
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
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
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -2057,6 +2054,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
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
@@ -2067,11 +2069,6 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
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

