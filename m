From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 5/6] OMAP4: powerdomain: Reuse on 4460 using CHIP_IS_44XX
Date: Sat, 2 Jul 2011 08:00:25 +0530
Message-ID: <1309573826-10615-6-git-send-email-rnayak@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
 <1309573826-10615-2-git-send-email-rnayak@ti.com>
 <1309573826-10615-3-git-send-email-rnayak@ti.com>
 <1309573826-10615-4-git-send-email-rnayak@ti.com>
 <1309573826-10615-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42753 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848Ab1GBCbr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 22:31:47 -0400
In-Reply-To: <1309573826-10615-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>

The 4460 platform has no difference in the powerdomains as compared
to the 4430 platform. Hence just update the .omap_chip field to make
sure the same powerdomain data can be reused on the 4460 platform.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |   32 +++++++++++++-------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 247e794..bebadaf 100644
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
@@ -204,7 +204,7 @@ static struct powerdomain mpu_44xx_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
@@ -225,7 +225,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 	.name		  = "ivahd_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_IVAHD_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 4,
@@ -249,7 +249,7 @@ static struct powerdomain cam_44xx_pwrdm = {
 	.name		  = "cam_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_CAM_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -266,7 +266,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.name		  = "l3init_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_L3INIT_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -284,7 +284,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
 	.name		  = "l4per_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_L4PER_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
@@ -307,7 +307,7 @@ static struct powerdomain always_on_core_44xx_pwrdm = {
 	.name		  = "always_on_core_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_ALWAYS_ON_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_ON,
 };
 
@@ -316,7 +316,7 @@ static struct powerdomain cefuse_44xx_pwrdm = {
 	.name		  = "cefuse_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_CEFUSE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
-- 
1.7.4.1

