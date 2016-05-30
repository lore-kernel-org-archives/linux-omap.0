From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 2/7] ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
Date: Mon, 30 May 2016 11:23:45 +0300
Message-ID: <20160530082350.24285-3-peter.ujfalusi@ti.com>
References: <20160530082350.24285-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530082350.24285-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The McBSPLP's sidetone main clock is the McBSPLP's ICLK, not FCLK as the
sidetone only receives the ICLK from the main McBSP module.
Since the McBSP and sidetone is using the very same clock from PRCM level
the sidetone must not have the prcm section to check the clock status since
the sidetone is only used when McBSP is already configured.
If two separate hwmods looking at the same bit and they would use
pm_runtime in nested way (as it must happen with McBSP and it's ST module)
the hwmod would warn, because the idlest will not match what it is expected
after enable/disable of the clocks.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9869a75c5d96..d72ee6185d5e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1322,16 +1322,8 @@ static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
 	.name		= "mcbsp2_sidetone",
 	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
 	.mpu_irqs	= omap3xxx_mcbsp2_sidetone_irqs,
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
+	.main_clk	= "mcbsp2_ick",
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* mcbsp3_sidetone */
@@ -1344,16 +1336,8 @@ static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
 	.name		= "mcbsp3_sidetone",
 	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
 	.mpu_irqs	= omap3xxx_mcbsp3_sidetone_irqs,
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
+	.main_clk	= "mcbsp3_ick",
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* SR common */
-- 
2.8.3
