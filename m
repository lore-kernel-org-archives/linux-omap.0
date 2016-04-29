From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 1/7] ARM: OMAP3: hwmod data: Fix McBSP2/3
	sidetone data
Date: Fri, 29 Apr 2016 13:53:16 +0300
Message-ID: <1461927202-17677-2-git-send-email-peter.ujfalusi@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
2.8.1
