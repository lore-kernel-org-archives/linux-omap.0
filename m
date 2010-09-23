From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 7/8] omap4: powerdomain: add context_offset field
Date: Thu, 23 Sep 2010 18:04:50 +0530
Message-ID: <1285245291-26442-8-git-send-email-rnayak@ti.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com>
 <1285245291-26442-2-git-send-email-rnayak@ti.com>
 <1285245291-26442-3-git-send-email-rnayak@ti.com>
 <1285245291-26442-4-git-send-email-rnayak@ti.com>
 <1285245291-26442-5-git-send-email-rnayak@ti.com>
 <1285245291-26442-6-git-send-email-rnayak@ti.com>
 <1285245291-26442-7-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50027 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755155Ab0IWMfC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 08:35:02 -0400
In-Reply-To: <1285245291-26442-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Context register in various power domain is not at same offset
on OMAP4. Mainly the CPUx context resgiters againts rest of
them. This patch adds a field in power-domain strucures to handle
this.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx.h        |   14 ++++++++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

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
index 18b722d..96bf746 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -85,6 +85,7 @@ struct powerdomain;
  * @pwrsts_logic_ret: Possible logic power states when pwrdm in RETENTION
  * @flags: Powerdomain flags
  * @banks: Number of software-controllable memory banks in this powerdomain
+ * @context_offset: Offset for the context register, used only on OMAP4
  * @pwrsts_mem_ret: Possible memory bank pwrstates when pwrdm in RETENTION
  * @pwrsts_mem_on: Possible memory bank pwrstates when pwrdm in ON
  * @pwrdm_clkdms: Clockdomains in this powerdomain
@@ -102,6 +103,7 @@ struct powerdomain {
 	const u8 pwrsts_logic_ret;
 	const u8 flags;
 	const u8 banks;
+	const u8 context_offset;
 	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
 	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
-- 
1.7.0.4

