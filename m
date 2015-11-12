From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 3/3] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Thu, 12 Nov 2015 09:32:59 +0200
Message-ID: <1447313579-23873-4-git-send-email-peter.ujfalusi@ti.com>
References: <1447313579-23873-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447313579-23873-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

McASP3 is used by default on DRA7x based boards for audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 56 +++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 51d1ecb384bd..ee4e04434a94 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1298,6 +1298,44 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod = {
 };
 
 /*
+ * 'mcasp' class
+ *
+ */
+static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc = {
+	.sysc_offs	= 0x0004,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dra7xx_mcasp_hwmod_class = {
+	.name	= "mcasp",
+	.sysc	= &dra7xx_mcasp_sysc,
+};
+
+/* mcasp3 */
+static struct omap_hwmod_opt_clk mcasp3_opt_clks[] = {
+	{ .role = "ahclkx", .clk = "mcasp3_ahclkx_mux" },
+};
+
+static struct omap_hwmod dra7xx_mcasp3_hwmod = {
+	.name		= "mcasp3",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp3_aux_gfclk_mux",
+	.flags		= HWMOD_OPT_CLKS_NEEDED,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP3_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= mcasp3_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcasp3_opt_clks),
+};
+
+/*
  * 'mmc' class
  *
  */
@@ -2566,6 +2604,22 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per2 -> mcasp3 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp3_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_1 -> mcasp3 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mcasp3 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mcasp3_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per1 -> elm */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm = {
 	.master		= &dra7xx_l4_per1_hwmod,
@@ -3308,6 +3362,8 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__dcan1,
 	&dra7xx_l4_per2__dcan2,
 	&dra7xx_l4_per2__cpgmac0,
+	&dra7xx_l4_per2__mcasp3,
+	&dra7xx_l3_main_1__mcasp3,
 	&dra7xx_gmac__mdio,
 	&dra7xx_l4_cfg__dma_system,
 	&dra7xx_l3_main_1__dss,
-- 
2.6.2
