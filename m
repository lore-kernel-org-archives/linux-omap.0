From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/3] ARM: OMAP: DRA7: powerdomain data: Fix "ON" state for memories
Date: Thu, 31 Mar 2016 16:58:34 -0500
Message-ID: <1459461515-5192-3-git-send-email-nm@ti.com>
References: <1459461515-5192-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459461515-5192-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

When the power domain is in "ON" state, the memories should be always
in "ON", even though the hardware register allows other states to be
written, wrong states may confuse certain hardware blocks.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomains7xx_data.c | 66 +++++++++++++++---------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index f2b4557124f3..81e883d972b9 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -45,10 +45,10 @@ static struct powerdomain iva_7xx_pwrdm = {
 		[3] = PWRSTS_OFF_RET,	/* tcm2_mem */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* hwa_mem */
-		[1] = PWRSTS_OFF_RET,	/* sl2_mem */
-		[2] = PWRSTS_OFF_RET,	/* tcm1_mem */
-		[3] = PWRSTS_OFF_RET,	/* tcm2_mem */
+		[0] = PWRSTS_ON,	/* hwa_mem */
+		[1] = PWRSTS_ON,	/* sl2_mem */
+		[2] = PWRSTS_ON,	/* tcm1_mem */
+		[3] = PWRSTS_ON,	/* tcm2_mem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -83,8 +83,8 @@ static struct powerdomain ipu_7xx_pwrdm = {
 		[1] = PWRSTS_OFF_RET,	/* periphmem */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* aessmem */
-		[1] = PWRSTS_OFF_RET,	/* periphmem */
+		[0] = PWRSTS_ON,	/* aessmem */
+		[1] = PWRSTS_ON,	/* periphmem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -101,7 +101,7 @@ static struct powerdomain dss_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* dss_mem */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* dss_mem */
+		[0] = PWRSTS_ON,	/* dss_mem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -119,8 +119,8 @@ static struct powerdomain l4per_7xx_pwrdm = {
 		[1] = PWRSTS_OFF_RET,	/* retained_bank */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* nonretained_bank */
-		[1] = PWRSTS_OFF_RET,	/* retained_bank */
+		[0] = PWRSTS_ON,	/* nonretained_bank */
+		[1] = PWRSTS_ON,	/* retained_bank */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -136,7 +136,7 @@ static struct powerdomain gpu_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* gpu_mem */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* gpu_mem */
+		[0] = PWRSTS_ON,	/* gpu_mem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -171,11 +171,11 @@ static struct powerdomain core_7xx_pwrdm = {
 		[4] = PWRSTS_OFF_RET,	/* ipu_unicache */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* core_nret_bank */
-		[1] = PWRSTS_OFF_RET,	/* core_ocmram */
-		[2] = PWRSTS_OFF_RET,	/* core_other_bank */
-		[3] = PWRSTS_OFF_RET,	/* ipu_l2ram */
-		[4] = PWRSTS_OFF_RET,	/* ipu_unicache */
+		[0] = PWRSTS_ON,	/* core_nret_bank */
+		[1] = PWRSTS_ON,	/* core_ocmram */
+		[2] = PWRSTS_ON,	/* core_other_bank */
+		[3] = PWRSTS_ON,	/* ipu_l2ram */
+		[4] = PWRSTS_ON,	/* ipu_unicache */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -232,7 +232,7 @@ static struct powerdomain vpe_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* vpe_bank */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* vpe_bank */
+		[0] = PWRSTS_ON,	/* vpe_bank */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -250,8 +250,8 @@ static struct powerdomain mpu_7xx_pwrdm = {
 		[1] = PWRSTS_RET,	/* mpu_ram */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* mpu_l2 */
-		[1] = PWRSTS_OFF_RET,	/* mpu_ram */
+		[0] = PWRSTS_ON,	/* mpu_l2 */
+		[1] = PWRSTS_ON,	/* mpu_ram */
 	},
 };
 
@@ -269,9 +269,9 @@ static struct powerdomain l3init_7xx_pwrdm = {
 		[2] = PWRSTS_OFF_RET,	/* l3init_bank2 */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* gmac_bank */
-		[1] = PWRSTS_OFF_RET,	/* l3init_bank1 */
-		[2] = PWRSTS_OFF_RET,	/* l3init_bank2 */
+		[0] = PWRSTS_ON,	/* gmac_bank */
+		[1] = PWRSTS_ON,	/* l3init_bank1 */
+		[2] = PWRSTS_ON,	/* l3init_bank2 */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -287,7 +287,7 @@ static struct powerdomain eve3_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* eve3_bank */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* eve3_bank */
+		[0] = PWRSTS_ON,	/* eve3_bank */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -303,7 +303,7 @@ static struct powerdomain emu_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* emu_bank */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* emu_bank */
+		[0] = PWRSTS_ON,	/* emu_bank */
 	},
 };
 
@@ -320,9 +320,9 @@ static struct powerdomain dsp2_7xx_pwrdm = {
 		[2] = PWRSTS_OFF_RET,	/* dsp2_l2 */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* dsp2_edma */
-		[1] = PWRSTS_OFF_RET,	/* dsp2_l1 */
-		[2] = PWRSTS_OFF_RET,	/* dsp2_l2 */
+		[0] = PWRSTS_ON,	/* dsp2_edma */
+		[1] = PWRSTS_ON,	/* dsp2_l1 */
+		[2] = PWRSTS_ON,	/* dsp2_l2 */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -340,9 +340,9 @@ static struct powerdomain dsp1_7xx_pwrdm = {
 		[2] = PWRSTS_OFF_RET,	/* dsp1_l2 */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* dsp1_edma */
-		[1] = PWRSTS_OFF_RET,	/* dsp1_l1 */
-		[2] = PWRSTS_OFF_RET,	/* dsp1_l2 */
+		[0] = PWRSTS_ON,	/* dsp1_edma */
+		[1] = PWRSTS_ON,	/* dsp1_l1 */
+		[2] = PWRSTS_ON,	/* dsp1_l2 */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -358,7 +358,7 @@ static struct powerdomain cam_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* vip_bank */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* vip_bank */
+		[0] = PWRSTS_ON,	/* vip_bank */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -374,7 +374,7 @@ static struct powerdomain eve4_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* eve4_bank */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* eve4_bank */
+		[0] = PWRSTS_ON,	/* eve4_bank */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -390,7 +390,7 @@ static struct powerdomain eve2_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* eve2_bank */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* eve2_bank */
+		[0] = PWRSTS_ON,	/* eve2_bank */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
@@ -406,7 +406,7 @@ static struct powerdomain eve1_7xx_pwrdm = {
 		[0] = PWRSTS_OFF_RET,	/* eve1_bank */
 	},
 	.pwrsts_mem_on	= {
-		[0] = PWRSTS_OFF_RET,	/* eve1_bank */
+		[0] = PWRSTS_ON,	/* eve1_bank */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
-- 
2.8.0
