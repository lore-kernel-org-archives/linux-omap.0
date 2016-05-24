From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/3] ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret
Date: Tue, 24 May 2016 08:35:40 -0500
Message-ID: <1464096940-27145-4-git-send-email-nm@ti.com>
References: <1464096940-27145-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464096940-27145-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

As per the latest revision F of public TRM for DRA7/AM57xx SoCs
SPRUHZ6F[1] (April 2016), with the exception of MPU power domain, all
other power domains do not have memories capable of retention since
they all operate in either "ON" or "OFF" mode. For these power states,
the retention state for memories are basically ignored by PRCM and does
not require to be programmed.

[1] http://www.ti.com/lit/pdf/spruhz6

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomains7xx_data.c | 65 ------------------------------
 1 file changed, 65 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index 88107b449710..eb350a673133 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -37,12 +37,6 @@ static struct powerdomain iva_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 4,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* hwa_mem */
-		[1] = PWRSTS_OFF_RET,	/* sl2_mem */
-		[2] = PWRSTS_OFF_RET,	/* tcm1_mem */
-		[3] = PWRSTS_OFF_RET,	/* tcm2_mem */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* hwa_mem */
 		[1] = PWRSTS_ON,	/* sl2_mem */
@@ -76,10 +70,6 @@ static struct powerdomain ipu_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 2,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* aessmem */
-		[1] = PWRSTS_OFF_RET,	/* periphmem */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* aessmem */
 		[1] = PWRSTS_ON,	/* periphmem */
@@ -94,9 +84,6 @@ static struct powerdomain dss_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* dss_mem */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* dss_mem */
 	},
@@ -110,10 +97,6 @@ static struct powerdomain l4per_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 2,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* nonretained_bank */
-		[1] = PWRSTS_OFF_RET,	/* retained_bank */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* nonretained_bank */
 		[1] = PWRSTS_ON,	/* retained_bank */
@@ -128,9 +111,6 @@ static struct powerdomain gpu_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* gpu_mem */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* gpu_mem */
 	},
@@ -144,8 +124,6 @@ static struct powerdomain wkupaon_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* wkup_bank */
 	},
@@ -158,13 +136,6 @@ static struct powerdomain core_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 5,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* core_nret_bank */
-		[1] = PWRSTS_OFF_RET,	/* core_ocmram */
-		[2] = PWRSTS_OFF_RET,	/* core_other_bank */
-		[3] = PWRSTS_OFF_RET,	/* ipu_l2ram */
-		[4] = PWRSTS_OFF_RET,	/* ipu_unicache */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* core_nret_bank */
 		[1] = PWRSTS_ON,	/* core_ocmram */
@@ -222,9 +193,6 @@ static struct powerdomain vpe_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* vpe_bank */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* vpe_bank */
 	},
@@ -256,11 +224,6 @@ static struct powerdomain l3init_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 3,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* gmac_bank */
-		[1] = PWRSTS_OFF_RET,	/* l3init_bank1 */
-		[2] = PWRSTS_OFF_RET,	/* l3init_bank2 */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* gmac_bank */
 		[1] = PWRSTS_ON,	/* l3init_bank1 */
@@ -276,9 +239,6 @@ static struct powerdomain eve3_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* eve3_bank */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* eve3_bank */
 	},
@@ -292,9 +252,6 @@ static struct powerdomain emu_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* emu_bank */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* emu_bank */
 	},
@@ -307,11 +264,6 @@ static struct powerdomain dsp2_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 3,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* dsp2_edma */
-		[1] = PWRSTS_OFF_RET,	/* dsp2_l1 */
-		[2] = PWRSTS_OFF_RET,	/* dsp2_l2 */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* dsp2_edma */
 		[1] = PWRSTS_ON,	/* dsp2_l1 */
@@ -327,11 +279,6 @@ static struct powerdomain dsp1_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 3,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* dsp1_edma */
-		[1] = PWRSTS_OFF_RET,	/* dsp1_l1 */
-		[2] = PWRSTS_OFF_RET,	/* dsp1_l2 */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* dsp1_edma */
 		[1] = PWRSTS_ON,	/* dsp1_l1 */
@@ -347,9 +294,6 @@ static struct powerdomain cam_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* vip_bank */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* vip_bank */
 	},
@@ -363,9 +307,6 @@ static struct powerdomain eve4_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* eve4_bank */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* eve4_bank */
 	},
@@ -379,9 +320,6 @@ static struct powerdomain eve2_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* eve2_bank */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* eve2_bank */
 	},
@@ -395,9 +333,6 @@ static struct powerdomain eve1_7xx_pwrdm = {
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
-	.pwrsts_mem_ret	= {
-		[0] = PWRSTS_OFF_RET,	/* eve1_bank */
-	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* eve1_bank */
 	},
-- 
2.8.0
