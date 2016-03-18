From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ARM: OMAP3: hwmod data: Merge and remove the McBSP sidetone related data
Date: Fri, 18 Mar 2016 12:28:48 +0200
Message-ID: <1458296929-718-3-git-send-email-peter.ujfalusi@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

McBSP2 and 3 have integrated sidetone block. The sidetone alone can not
operate, can not be enabled separately from the McBSP it is attached to.
The sidetone is enabled via McBSP register(s) and it is using the McBSP
module's iclk as clock. While the sidetone block of McBSP does have it's
SYSCONFIG registers to enable/disable AUTOIDLE (of McBSP_ICLK) this alone
does not mean that we should have dedicated hwmod for McBSP internal
blocks. Note: The AUTOIDLE bit is set after reset and hwmod is not changing
it in runtime.
The sidetone can not be enabled separately from McBSP, it can only enabled
when McBSP is in use.
Furthermore the sidetone data is specifying the exact same prcm registers
and bits as the McBSP hwmod it is attached to.
As one of the main function of the sidetone hwmod data is to convey the
address and irq number to the main mcbsp hwmod, move them directly to the
corresponding McBSP's hwmod data.
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 120 ++++-------------------------
 1 file changed, 14 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9869a75c5d96..317e9b816a02 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1175,13 +1175,10 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp2_irqs[] = {
 	{ .name = "common", .irq = 17 + OMAP_INTC_START, },
 	{ .name = "tx", .irq = 62 + OMAP_INTC_START, },
 	{ .name = "rx", .irq = 63 + OMAP_INTC_START, },
+	{ .name = "sidetone", .irq = 4 + OMAP_INTC_START, },
 	{ .irq = -1 },
 };
 
-static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
-	.sidetone	= "mcbsp2_sidetone",
-};
-
 static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -1199,7 +1196,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	},
 	.opt_clks	= mcbsp234_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
-	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
 };
 
 /* mcbsp3 */
@@ -1207,13 +1203,10 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp3_irqs[] = {
 	{ .name = "common", .irq = 22 + OMAP_INTC_START, },
 	{ .name = "tx", .irq = 89 + OMAP_INTC_START, },
 	{ .name = "rx", .irq = 90 + OMAP_INTC_START, },
+	{ .name = "sidetone", .irq = 5 + OMAP_INTC_START, },
 	{ .irq = -1 },
 };
 
-static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
-	.sidetone	= "mcbsp3_sidetone",
-};
-
 static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -1231,7 +1224,6 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	},
 	.opt_clks	= mcbsp234_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
-	.dev_attr	= &omap34xx_mcbsp3_dev_attr,
 };
 
 /* mcbsp4 */
@@ -1300,62 +1292,6 @@ static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(mcbsp15_opt_clks),
 };
 
-/* 'mcbsp sidetone' class */
-static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sidetone_sysc = {
-	.sysc_offs	= 0x0010,
-	.sysc_flags	= SYSC_HAS_AUTOIDLE,
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap3xxx_mcbsp_sidetone_hwmod_class = {
-	.name = "mcbsp_sidetone",
-	.sysc = &omap3xxx_mcbsp_sidetone_sysc,
-};
-
-/* mcbsp2_sidetone */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp2_sidetone_irqs[] = {
-	{ .name = "irq", .irq = 4 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
-	.name		= "mcbsp2_sidetone",
-	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp2_sidetone_irqs,
-	.main_clk	= "mcbsp2_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			 .module_bit = OMAP3430_EN_MCBSP2_SHIFT,
-			.module_offs = OMAP3430_PER_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP3430_ST_MCBSP2_SHIFT,
-		},
-	},
-};
-
-/* mcbsp3_sidetone */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp3_sidetone_irqs[] = {
-	{ .name = "irq", .irq = 5 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
-	.name		= "mcbsp3_sidetone",
-	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp3_sidetone_irqs,
-	.main_clk	= "mcbsp3_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCBSP3_SHIFT,
-			.module_offs = OMAP3430_PER_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP3430_ST_MCBSP3_SHIFT,
-		},
-	},
-};
-
 /* SR common */
 static struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
 	.clkact_shift	= 20,
@@ -3108,6 +3044,12 @@ static struct omap_hwmod_addr_space omap3xxx_mcbsp2_addrs[] = {
 		.pa_end		= 0x490220ff,
 		.flags		= ADDR_TYPE_RT
 	},
+	{
+		.name		= "sidetone",
+		.pa_start	= 0x49028000,
+		.pa_end		= 0x490280ff,
+		.flags		= ADDR_TYPE_RT
+	},
 	{ }
 };
 
@@ -3127,6 +3069,12 @@ static struct omap_hwmod_addr_space omap3xxx_mcbsp3_addrs[] = {
 		.pa_end		= 0x490240ff,
 		.flags		= ADDR_TYPE_RT
 	},
+	{
+		.name		= "sidetone",
+		.pa_start	= 0x4902A000,
+		.pa_end		= 0x4902A0ff,
+		.flags		= ADDR_TYPE_RT
+	},
 	{ }
 };
 
@@ -3177,44 +3125,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__mcbsp5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mcbsp2_sidetone_addrs[] = {
-	{
-		.name		= "sidetone",
-		.pa_start	= 0x49028000,
-		.pa_end		= 0x490280ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-/* l4_per -> mcbsp2_sidetone */
-static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp2_sidetone = {
-	.master		= &omap3xxx_l4_per_hwmod,
-	.slave		= &omap3xxx_mcbsp2_sidetone_hwmod,
-	.clk		= "mcbsp2_ick",
-	.addr		= omap3xxx_mcbsp2_sidetone_addrs,
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_addr_space omap3xxx_mcbsp3_sidetone_addrs[] = {
-	{
-		.name		= "sidetone",
-		.pa_start	= 0x4902A000,
-		.pa_end		= 0x4902A0ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-/* l4_per -> mcbsp3_sidetone */
-static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp3_sidetone = {
-	.master		= &omap3xxx_l4_per_hwmod,
-	.slave		= &omap3xxx_mcbsp3_sidetone_hwmod,
-	.clk		= "mcbsp3_ick",
-	.addr		= omap3xxx_mcbsp3_sidetone_addrs,
-	.user		= OCP_USER_MPU,
-};
-
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mailbox = {
 	.master		= &omap3xxx_l4_core_hwmod,
@@ -3651,8 +3561,6 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_per__mcbsp3,
 	&omap3xxx_l4_per__mcbsp4,
 	&omap3xxx_l4_core__mcbsp5,
-	&omap3xxx_l4_per__mcbsp2_sidetone,
-	&omap3xxx_l4_per__mcbsp3_sidetone,
 	&omap34xx_l4_core__mcspi1,
 	&omap34xx_l4_core__mcspi2,
 	&omap34xx_l4_core__mcspi3,
-- 
2.7.3
