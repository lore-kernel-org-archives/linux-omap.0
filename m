From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/5] arm: omap: introduce 32k timer hwmod for omap2/3/4
Date: Tue, 19 Oct 2010 12:22:15 +0300
Message-ID: <1287480136-2046-5-git-send-email-balbi@ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41781 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758119Ab0JSJWl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 05:22:41 -0400
In-Reply-To: <1287480136-2046-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Add 32k timer hwmod to the database.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   52 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   52 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   51 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   61 ++++++++++++++++++++++++++++
 4 files changed, 216 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a1a3dd6..05b9d2a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -557,6 +557,57 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.flags		= HWMOD_16BIT_REG,
 };
 
+/*
+ * 'counter' class
+ * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
+ */
+
+static struct omap_hwmod_class omap2420_counter_hwmod_class = {
+	.name = "counter",
+};
+
+/* counter_32k */
+static struct omap_hwmod omap2420_counter_32k_hwmod;
+static struct omap_hwmod_addr_space omap2420_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x48004000,
+		.pa_end		= 0x48000fff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> counter_32k */
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__counter_32k = {
+	.master		= &omap2420_l4_wkup_hwmod,
+	.slave		= &omap2420_counter_32k_hwmod,
+	.clk		= "l4_ck",
+	.addr		= omap2420_counter_32k_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_counter_32k_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* counter_32k slave ports */
+static struct omap_hwmod_ocp_if *omap2420_counter_32k_slaves[] = {
+	&omap2420_l4_wkup__counter_32k,
+};
+
+static struct omap_hwmod omap2420_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.class		= &omap2420_counter_hwmod_class,
+	.main_clk	= "sync_32k_ick",
+	.prcm = {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
+		},
+	},
+	.slaves		= omap2420_counter_32k_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_counter_32k_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -569,6 +620,7 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_uart3_hwmod,
 	&omap2420_i2c1_hwmod,
 	&omap2420_i2c2_hwmod,
+	&omap2420_counter_32k_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 7cf0d3a..96e9b12 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -569,6 +569,57 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/*
+ * 'counter' class
+ * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
+ */
+
+static struct omap_hwmod_class omap2430_counter_hwmod_class = {
+	.name = "counter",
+};
+
+/* counter_32k */
+static struct omap_hwmod omap2430_counter_32k_hwmod;
+static struct omap_hwmod_addr_space omap2430_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x48004000,
+		.pa_end		= 0x48000fff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> counter_32k */
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__counter_32k = {
+	.master		= &omap2430_l4_wkup_hwmod,
+	.slave		= &omap2430_counter_32k_hwmod,
+	.clk		= "l4_ck",
+	.addr		= omap2430_counter_32k_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_counter_32k_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* counter_32k slave ports */
+static struct omap_hwmod_ocp_if *omap2430_counter_32k_slaves[] = {
+	&omap2430_l4_wkup__counter_32k,
+};
+
+static struct omap_hwmod omap2430_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.class		= &omap2430_counter_hwmod_class,
+	.main_clk	= "sync_32k_ick",
+	.prcm = {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_counter_32k_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_counter_32k_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
@@ -581,6 +632,7 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_uart3_hwmod,
 	&omap2430_i2c1_hwmod,
 	&omap2430_i2c2_hwmod,
+	&omap2430_counter_32k_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ed6bf4a..8e8fae4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -736,6 +736,56 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * 'counter' class
+ * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
+ */
+static struct omap_hwmod_class omap3xxx_counter_hwmod_class = {
+	.name = "counter",
+};
+
+/* counter_32k */
+static struct omap_hwmod omap3xxx_counter_32k_hwmod;
+static struct omap_hwmod_addr_space omap3xxx_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x48324000,
+		.pa_end		= 0x48320fff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> counter_32k */
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__counter_32k = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_counter_32k_hwmod,
+	.clk		= "wkup_l4_ick",
+	.addr		= omap3xxx_counter_32k_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_counter_32k_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* counter_32k slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_counter_32k_slaves[] = {
+	&omap3xxx_l4_wkup__counter_32k,
+};
+
+static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.class		= &omap3xxx_counter_hwmod_class,
+	.main_clk	= "omap_32ksync_ick",
+	.prcm = {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_GPT1_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_counter_32k_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_counter_32k_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -751,6 +801,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
+	&omap3xxx_counter_32k_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 0d5c6eb..e86dc11 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -383,6 +383,63 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 };
 
 /*
+ * 'counter' class
+ * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_counter_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0004,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_counter_hwmod_class = {
+	.name = "counter",
+	.sysc = &omap44xx_counter_sysc,
+};
+
+/* counter_32k */
+static struct omap_hwmod omap44xx_counter_32k_hwmod;
+static struct omap_hwmod_addr_space omap44xx_counter_32k_addrs[] = {
+	{
+		.pa_start	= 0x4a304000,
+		.pa_end		= 0x4a30401f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> counter_32k */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__counter_32k = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_counter_32k_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_counter_32k_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_counter_32k_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* counter_32k slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_counter_32k_slaves[] = {
+	&omap44xx_l4_wkup__counter_32k,
+};
+
+static struct omap_hwmod omap44xx_counter_32k_hwmod = {
+	.name		= "counter_32k",
+	.class		= &omap44xx_counter_hwmod_class,
+	.main_clk	= "sys_32k_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_SYNCTIMER_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_counter_32k_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_counter_32k_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'i2c' class
  * multimaster high-speed i2c controller
  */
@@ -1058,6 +1115,10 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_l4_cfg_hwmod,
 	&omap44xx_l4_per_hwmod,
 	&omap44xx_l4_wkup_hwmod,
+
+	/* counter class */
+	&omap44xx_counter_32k_hwmod,
+
 	/* i2c class */
 	&omap44xx_i2c1_hwmod,
 	&omap44xx_i2c2_hwmod,
-- 
1.7.3.1.120.g38a18

