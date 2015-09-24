From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 13/17] ARM: OMAP5: hwmod_data: remove reset data
Date: Thu, 24 Sep 2015 17:26:54 +0300
Message-ID: <1443104818-993-14-git-send-email-t-kristo@ti.com>
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

This is provided via DT, and no longer needed in the hwmod database.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 7c3fac0..9e33ac8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -1378,21 +1378,14 @@ static struct omap_hwmod_class omap54xx_mmu_hwmod_class = {
 	.sysc = &omap54xx_mmu_sysc,
 };
 
-static struct omap_hwmod_rst_info omap54xx_mmu_dsp_resets[] = {
-	{ .name = "mmu_cache", .rst_shift = 1 },
-};
-
 static struct omap_hwmod omap54xx_mmu_dsp_hwmod = {
 	.name		= "mmu_dsp",
 	.class		= &omap54xx_mmu_hwmod_class,
 	.clkdm_name	= "dsp_clkdm",
-	.rst_lines	= omap54xx_mmu_dsp_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_mmu_dsp_resets),
 	.main_clk	= "dpll_iva_h11x2_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_DSP_DSP_CLKCTRL_OFFSET,
-			.rstctrl_offs = OMAP54XX_RM_DSP_RSTCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_DSP_DSP_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
@@ -1400,21 +1393,14 @@ static struct omap_hwmod omap54xx_mmu_dsp_hwmod = {
 };
 
 /* mmu ipu */
-static struct omap_hwmod_rst_info omap54xx_mmu_ipu_resets[] = {
-	{ .name = "mmu_cache", .rst_shift = 2 },
-};
-
 static struct omap_hwmod omap54xx_mmu_ipu_hwmod = {
 	.name		= "mmu_ipu",
 	.class		= &omap54xx_mmu_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.rst_lines	= omap54xx_mmu_ipu_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_mmu_ipu_resets),
 	.main_clk	= "dpll_core_h22x2_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_IPU_IPU_CLKCTRL_OFFSET,
-			.rstctrl_offs = OMAP54XX_RM_IPU_RSTCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_IPU_IPU_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
-- 
1.7.9.5
