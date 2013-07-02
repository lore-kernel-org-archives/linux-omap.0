From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 1/9] ARM: OMAP2+: AM335X: Add a constant CM_INST for all the clkdomains
Date: Tue, 2 Jul 2013 16:58:10 +0530
Message-ID: <1372764498-32503-2-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41794 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab3GBL3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 07:29:11 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

OMAP4 style PRM, CM APIs expect the clkdomains to specify a
cm_inst. Introduce a CM_INST for the AM335x clkdomains so that
we can eventually consolidate the code.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/clockdomains33xx_data.c | 18 ++++++++++++++++++
 arch/arm/mach-omap2/cm33xx.h                |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-omap2/clockdomains33xx_data.c b/arch/arm/mach-omap2/clockdomains33xx_data.c
index 32c90fd..819a6bf 100644
--- a/arch/arm/mach-omap2/clockdomains33xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains33xx_data.c
@@ -25,6 +25,7 @@
 static struct clockdomain l4ls_am33xx_clkdm = {
 	.name		= "l4ls_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_L4LS_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -33,6 +34,7 @@ static struct clockdomain l4ls_am33xx_clkdm = {
 static struct clockdomain l3s_am33xx_clkdm = {
 	.name		= "l3s_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_L3S_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -41,6 +43,7 @@ static struct clockdomain l3s_am33xx_clkdm = {
 static struct clockdomain l4fw_am33xx_clkdm = {
 	.name		= "l4fw_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_L4FW_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -49,6 +52,7 @@ static struct clockdomain l4fw_am33xx_clkdm = {
 static struct clockdomain l3_am33xx_clkdm = {
 	.name		= "l3_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_L3_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -57,6 +61,7 @@ static struct clockdomain l3_am33xx_clkdm = {
 static struct clockdomain l4hs_am33xx_clkdm = {
 	.name		= "l4hs_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_L4HS_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -65,6 +70,7 @@ static struct clockdomain l4hs_am33xx_clkdm = {
 static struct clockdomain ocpwp_l3_am33xx_clkdm = {
 	.name		= "ocpwp_l3_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_OCPWP_L3_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -73,6 +79,7 @@ static struct clockdomain ocpwp_l3_am33xx_clkdm = {
 static struct clockdomain pruss_ocp_am33xx_clkdm = {
 	.name		= "pruss_ocp_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_PRUSS_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -81,6 +88,7 @@ static struct clockdomain pruss_ocp_am33xx_clkdm = {
 static struct clockdomain cpsw_125mhz_am33xx_clkdm = {
 	.name		= "cpsw_125mhz_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_CPSW_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -89,6 +97,7 @@ static struct clockdomain cpsw_125mhz_am33xx_clkdm = {
 static struct clockdomain lcdc_am33xx_clkdm = {
 	.name		= "lcdc_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_LCDC_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -97,6 +106,7 @@ static struct clockdomain lcdc_am33xx_clkdm = {
 static struct clockdomain clk_24mhz_am33xx_clkdm = {
 	.name		= "clk_24mhz_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_CLK_24MHZ_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -105,6 +115,7 @@ static struct clockdomain clk_24mhz_am33xx_clkdm = {
 static struct clockdomain l4_wkup_am33xx_clkdm = {
 	.name		= "l4_wkup_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_WKUP_MOD,
 	.clkdm_offs	= AM33XX_CM_WKUP_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -113,6 +124,7 @@ static struct clockdomain l4_wkup_am33xx_clkdm = {
 static struct clockdomain l3_aon_am33xx_clkdm = {
 	.name		= "l3_aon_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_WKUP_MOD,
 	.clkdm_offs	= AM33XX_CM_L3_AON_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -121,6 +133,7 @@ static struct clockdomain l3_aon_am33xx_clkdm = {
 static struct clockdomain l4_wkup_aon_am33xx_clkdm = {
 	.name		= "l4_wkup_aon_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_WKUP_MOD,
 	.clkdm_offs	= AM33XX_CM_L4_WKUP_AON_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -129,6 +142,7 @@ static struct clockdomain l4_wkup_aon_am33xx_clkdm = {
 static struct clockdomain mpu_am33xx_clkdm = {
 	.name		= "mpu_clkdm",
 	.pwrdm		= { .name = "mpu_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_MPU_MOD,
 	.clkdm_offs	= AM33XX_CM_MPU_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -137,6 +151,7 @@ static struct clockdomain mpu_am33xx_clkdm = {
 static struct clockdomain l4_rtc_am33xx_clkdm = {
 	.name		= "l4_rtc_clkdm",
 	.pwrdm		= { .name = "rtc_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_RTC_MOD,
 	.clkdm_offs	= AM33XX_CM_RTC_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -145,6 +160,7 @@ static struct clockdomain l4_rtc_am33xx_clkdm = {
 static struct clockdomain gfx_l3_am33xx_clkdm = {
 	.name		= "gfx_l3_clkdm",
 	.pwrdm		= { .name = "gfx_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_GFX_MOD,
 	.clkdm_offs	= AM33XX_CM_GFX_L3_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -153,6 +169,7 @@ static struct clockdomain gfx_l3_am33xx_clkdm = {
 static struct clockdomain gfx_l4ls_gfx_am33xx_clkdm = {
 	.name		= "gfx_l4ls_gfx_clkdm",
 	.pwrdm		= { .name = "gfx_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_GFX_MOD,
 	.clkdm_offs	= AM33XX_CM_GFX_L4LS_GFX_CLKSTCTRL__1_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
@@ -161,6 +178,7 @@ static struct clockdomain gfx_l4ls_gfx_am33xx_clkdm = {
 static struct clockdomain l4_cefuse_am33xx_clkdm = {
 	.name		= "l4_cefuse_clkdm",
 	.pwrdm		= { .name = "cefuse_pwrdm" },
+	.prcm_partition	= AM33XX_CM_PARTITION,
 	.cm_inst	= AM33XX_CM_CEFUSE_MOD,
 	.clkdm_offs	= AM33XX_CM_CEFUSE_CLKSTCTRL_OFFSET,
 	.flags		= CLKDM_CAN_SWSUP,
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 64f4baf..452351f 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -29,6 +29,8 @@
 #define AM33XX_CM_REGADDR(inst, reg)				\
 	AM33XX_L4_WK_IO_ADDRESS(AM33XX_CM_BASE + (inst) + (reg))
 
+#define AM33XX_CM_PARTITION	1
+
 /* CM instances */
 #define AM33XX_CM_PER_MOD		0x0000
 #define AM33XX_CM_WKUP_MOD		0x0400
-- 
1.8.1

