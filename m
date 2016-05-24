From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/3] ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_logic_ret
Date: Tue, 24 May 2016 08:35:39 -0500
Message-ID: <1464096940-27145-3-git-send-email-nm@ti.com>
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
SPRUHZ6F[1] (April 2016), with the exception of MPU power domain (and
CPUx sub power domains), all other power domains can either operate
in "ON" mode OR in some cases, "OFF" mode. For these power states,
the logic retention state is basically ignored by PRCM and does not
require to be programmed.

[1] http://www.ti.com/lit/pdf/spruhz6

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomains7xx_data.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index 8ea447ed4dc4..88107b449710 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -36,7 +36,6 @@ static struct powerdomain iva_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_IVA_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 4,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* hwa_mem */
@@ -76,7 +75,6 @@ static struct powerdomain ipu_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_IPU_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* aessmem */
@@ -95,7 +93,6 @@ static struct powerdomain dss_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_DSS_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* dss_mem */
@@ -112,7 +109,6 @@ static struct powerdomain l4per_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_L4PER_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_ON,
-	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* nonretained_bank */
@@ -161,7 +157,6 @@ static struct powerdomain core_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_CORE_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_ON,
-	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 5,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* core_nret_bank */
@@ -226,7 +221,6 @@ static struct powerdomain vpe_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_VPE_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_OFF_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* vpe_bank */
@@ -261,7 +255,6 @@ static struct powerdomain l3init_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_L3INIT_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_ON,
-	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 3,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* gmac_bank */
-- 
2.8.0
