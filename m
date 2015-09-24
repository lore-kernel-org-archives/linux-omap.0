From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/17] ARM: OMAP4: hwmod_data: remove reset data
Date: Thu, 24 Sep 2015 17:26:53 +0300
Message-ID: <1443104818-993-13-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is provided via DT and no longer needed under the hwmod database.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   48 +++-------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 43eebf2..0447ba9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -535,21 +535,14 @@ static struct omap_hwmod_class omap44xx_dsp_hwmod_class = {
 };
 
 /* dsp */
-static struct omap_hwmod_rst_info omap44xx_dsp_resets[] = {
-	{ .name = "dsp", .rst_shift = 0 },
-};
-
 static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.name		= "dsp",
 	.class		= &omap44xx_dsp_hwmod_class,
 	.clkdm_name	= "tesla_clkdm",
-	.rst_lines	= omap44xx_dsp_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
 	.main_clk	= "dpll_iva_m4x2_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
-			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_TESLA_TESLA_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
@@ -1414,22 +1407,14 @@ static struct omap_hwmod_class omap44xx_ipu_hwmod_class = {
 };
 
 /* ipu */
-static struct omap_hwmod_rst_info omap44xx_ipu_resets[] = {
-	{ .name = "cpu0", .rst_shift = 0 },
-	{ .name = "cpu1", .rst_shift = 1 },
-};
-
 static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.name		= "ipu",
 	.class		= &omap44xx_ipu_hwmod_class,
 	.clkdm_name	= "ducati_clkdm",
-	.rst_lines	= omap44xx_ipu_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_resets),
 	.main_clk	= "ducati_clk_mux_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
-			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
@@ -1497,23 +1482,14 @@ static struct omap_hwmod_class omap44xx_iva_hwmod_class = {
 };
 
 /* iva */
-static struct omap_hwmod_rst_info omap44xx_iva_resets[] = {
-	{ .name = "seq0", .rst_shift = 0 },
-	{ .name = "seq1", .rst_shift = 1 },
-	{ .name = "logic", .rst_shift = 2 },
-};
-
 static struct omap_hwmod omap44xx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &omap44xx_iva_hwmod_class,
 	.clkdm_name	= "ivahd_clkdm",
-	.rst_lines	= omap44xx_iva_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_resets),
 	.main_clk	= "dpll_iva_m5x2_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET,
-			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_IVAHD_IVAHD_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
@@ -2093,9 +2069,6 @@ static struct omap_mmu_dev_attr mmu_ipu_dev_attr = {
 };
 
 static struct omap_hwmod omap44xx_mmu_ipu_hwmod;
-static struct omap_hwmod_rst_info omap44xx_mmu_ipu_resets[] = {
-	{ .name = "mmu_cache", .rst_shift = 2 },
-};
 
 static struct omap_hwmod_addr_space omap44xx_mmu_ipu_addrs[] = {
 	{
@@ -2119,13 +2092,10 @@ static struct omap_hwmod omap44xx_mmu_ipu_hwmod = {
 	.name		= "mmu_ipu",
 	.class		= &omap44xx_mmu_hwmod_class,
 	.clkdm_name	= "ducati_clkdm",
-	.rst_lines	= omap44xx_mmu_ipu_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_mmu_ipu_resets),
 	.main_clk	= "ducati_clk_mux_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
-			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
@@ -2140,9 +2110,6 @@ static struct omap_mmu_dev_attr mmu_dsp_dev_attr = {
 };
 
 static struct omap_hwmod omap44xx_mmu_dsp_hwmod;
-static struct omap_hwmod_rst_info omap44xx_mmu_dsp_resets[] = {
-	{ .name = "mmu_cache", .rst_shift = 1 },
-};
 
 static struct omap_hwmod_addr_space omap44xx_mmu_dsp_addrs[] = {
 	{
@@ -2166,13 +2133,10 @@ static struct omap_hwmod omap44xx_mmu_dsp_hwmod = {
 	.name		= "mmu_dsp",
 	.class		= &omap44xx_mmu_hwmod_class,
 	.clkdm_name	= "tesla_clkdm",
-	.rst_lines	= omap44xx_mmu_dsp_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_mmu_dsp_resets),
 	.main_clk	= "dpll_iva_m4x2_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
-			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_TESLA_TESLA_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
@@ -2320,16 +2284,14 @@ static struct omap_hwmod omap44xx_cm_core_hwmod = {
 };
 
 /* prm */
-static struct omap_hwmod_rst_info omap44xx_prm_resets[] = {
-	{ .name = "rst_global_warm_sw", .rst_shift = 0 },
-	{ .name = "rst_global_cold_sw", .rst_shift = 1 },
-};
-
 static struct omap_hwmod omap44xx_prm_hwmod = {
 	.name		= "prm",
 	.class		= &omap44xx_prcm_hwmod_class,
-	.rst_lines	= omap44xx_prm_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /*
-- 
1.7.9.5
