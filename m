From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 7/9] OMAP4: powerdomain: Update MPU powerdomain for 4460
Date: Wed, 25 May 2011 18:56:54 -0700
Message-ID: <1306375016-707-8-git-send-email-nm@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42624 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757063Ab1EZB5a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:57:30 -0400
Received: by mail-yi0-f42.google.com with SMTP id 12so171984yib.1
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:57:29 -0700 (PDT)
In-Reply-To: <1306375016-707-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

The 4460 platform has changes in the MPU powerdomain,
hence model a new powerdomain for it and identify
is using the CHIP_IS_OMAP446X macro.
Also move all the common powerdomains to use
CHIP_IS_44XX so they are reused on OMAP4460.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |   53 ++++++++++++++++++---------
 1 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index c4222c7..034a4c7 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -35,7 +35,7 @@ static struct powerdomain core_44xx_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_CORE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 5,
@@ -61,7 +61,7 @@ static struct powerdomain gfx_44xx_pwrdm = {
 	.name		  = "gfx_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_GFX_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -78,7 +78,7 @@ static struct powerdomain abe_44xx_pwrdm = {
 	.name		  = "abe_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_ABE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 2,
@@ -98,7 +98,7 @@ static struct powerdomain dss_44xx_pwrdm = {
 	.name		  = "dss_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_DSS_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
@@ -116,7 +116,7 @@ static struct powerdomain tesla_44xx_pwrdm = {
 	.name		  = "tesla_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_TESLA_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
@@ -138,7 +138,7 @@ static struct powerdomain wkup_44xx_pwrdm = {
 	.name		  = "wkup_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_WKUP_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -154,7 +154,7 @@ static struct powerdomain cpu0_44xx_pwrdm = {
 	.name		  = "cpu0_pwrdm",
 	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU0_INST,
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -171,7 +171,7 @@ static struct powerdomain cpu1_44xx_pwrdm = {
 	.name		  = "cpu1_pwrdm",
 	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU1_INST,
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -188,7 +188,7 @@ static struct powerdomain emu_44xx_pwrdm = {
 	.name		  = "emu_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_EMU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -200,7 +200,7 @@ static struct powerdomain emu_44xx_pwrdm = {
 };
 
 /* mpu_44xx_pwrdm: Modena processor and the Neon coprocessor power domain */
-static struct powerdomain mpu_44xx_pwrdm = {
+static struct powerdomain mpu_443x_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
@@ -220,12 +220,30 @@ static struct powerdomain mpu_44xx_pwrdm = {
 	},
 };
 
+static struct powerdomain mpu_446x_pwrdm = {
+	.name		  = "mpu_pwrdm",
+	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
+	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4460),
+	.pwrsts		  = PWRSTS_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.banks		  = 2,
+	.pwrsts_mem_ret	= {
+		[0] = PWRSTS_OFF_RET,	/* mpu_l2 */
+		[1] = PWRSTS_RET,	/* mpu_ram */
+	},
+	.pwrsts_mem_on	= {
+		[0] = PWRSTS_ON,	/* mpu_l2 */
+		[1] = PWRSTS_ON,	/* mpu_ram */
+	},
+};
+
 /* ivahd_44xx_pwrdm: IVA-HD power domain */
 static struct powerdomain ivahd_44xx_pwrdm = {
 	.name		  = "ivahd_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_IVAHD_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 4,
@@ -249,7 +267,7 @@ static struct powerdomain cam_44xx_pwrdm = {
 	.name		  = "cam_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_CAM_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -266,7 +284,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.name		  = "l3init_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_L3INIT_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -284,7 +302,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
 	.name		  = "l4per_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_L4PER_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
@@ -307,7 +325,7 @@ static struct powerdomain always_on_core_44xx_pwrdm = {
 	.name		  = "always_on_core_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_ALWAYS_ON_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_ON,
 };
 
@@ -316,7 +334,7 @@ static struct powerdomain cefuse_44xx_pwrdm = {
 	.name		  = "cefuse_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_CEFUSE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_ON,
 };
 
@@ -339,7 +357,8 @@ static struct powerdomain *powerdomains_omap44xx[] __initdata = {
 	&cpu0_44xx_pwrdm,
 	&cpu1_44xx_pwrdm,
 	&emu_44xx_pwrdm,
-	&mpu_44xx_pwrdm,
+	&mpu_443x_pwrdm,
+	&mpu_446x_pwrdm,
 	&ivahd_44xx_pwrdm,
 	&cam_44xx_pwrdm,
 	&l3init_44xx_pwrdm,
-- 
1.7.1

