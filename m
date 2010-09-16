From: rnayak@ti.com
Subject: [PATCH 5/5] OMAP4: powerdomain: add context_offset field
Date: Thu, 16 Sep 2010 19:03:04 +0530
Message-ID: <1284643984-5406-5-git-send-email-rnayak@ti.com>
References: <1284643984-5406-1-git-send-email-rnayak@ti.com>
 <1284643984-5406-2-git-send-email-rnayak@ti.com>
 <1284643984-5406-3-git-send-email-rnayak@ti.com>
 <1284643984-5406-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33080 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab0IPNdN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 09:33:13 -0400
In-Reply-To: <1284643984-5406-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Context register in various power domain is not at same offset
on OMAP4. Mainly the CPUx context resgiters againts rest of
them. This patch adds a field in power-domain strucures to handle
this.

This will be needed to make "pwrdm_clear_all_prev_pwrst" API work on
OMAP4.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomains44xx.h        |   14 ++++++++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-omap2/powerdomains44xx.h
index 9c01b55..65e919b 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.h
+++ b/arch/arm/mach-omap2/powerdomains44xx.h
@@ -40,6 +40,7 @@ static struct powerdomain core_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 5,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* core_nret_bank */
 		[1] = PWRSTS_OFF_RET,	/* core_ocmram */
@@ -64,6 +65,7 @@ static struct powerdomain gfx_44xx_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* gfx_mem */
 	},
@@ -81,6 +83,7 @@ static struct powerdomain abe_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_OFF,
 	.banks		  = 2,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_RET,	/* aessmem */
 		[1] = PWRDM_POWER_OFF,	/* periphmem */
@@ -100,6 +103,7 @@ static struct powerdomain dss_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* dss_mem */
 	},
@@ -117,6 +121,7 @@ static struct powerdomain tesla_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_RET,	/* tesla_edma */
 		[1] = PWRSTS_OFF_RET,	/* tesla_l1 */
@@ -137,6 +142,7 @@ static struct powerdomain wkup_44xx_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 1,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* wkup_bank */
 	},
@@ -153,6 +159,7 @@ static struct powerdomain cpu0_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
+	.context_offset	  = 0x18,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* cpu0_l1 */
 	},
@@ -169,6 +176,7 @@ static struct powerdomain cpu1_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
+	.context_offset	  = 0x18,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* cpu1_l1 */
 	},
@@ -184,6 +192,7 @@ static struct powerdomain emu_44xx_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* emu_bank */
 	},
@@ -200,6 +209,7 @@ static struct powerdomain mpu_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* mpu_l1 */
 		[1] = PWRSTS_OFF_RET,	/* mpu_l2 */
@@ -220,6 +230,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_OFF,
 	.banks		  = 4,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* hwa_mem */
 		[1] = PWRSTS_OFF_RET,	/* sl2_mem */
@@ -242,6 +253,7 @@ static struct powerdomain cam_44xx_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* cam_mem */
 	},
@@ -259,6 +271,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* l3init_bank1 */
 	},
@@ -276,6 +289,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
+	.context_offset	  = 0x24,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* nonretained_bank */
 		[1] = PWRDM_POWER_RET,	/* retained_bank */
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 3ea7220..a524285 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -102,6 +102,7 @@ struct powerdomain {
 	const u8 pwrsts_logic_ret;
 	const u8 flags;
 	const u8 banks;
+	const s16 context_offset;
 	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
 	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
-- 
1.6.0.4

