From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 14/14] ARM: OMAP3+: voltage: remove unused volt_setup_time parameter
Date: Thu, 31 May 2012 16:55:50 +0300
Message-ID: <1338472550-20743-15-git-send-email-t-kristo@ti.com>
References: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53690 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932353Ab2EaN4V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 09:56:21 -0400
In-Reply-To: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This is no longer needed as the ramp times are calculated from
voltage deltas + slew rates.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    5 -----
 arch/arm/mach-omap2/voltage.h  |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 188f210..ecae989 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -141,7 +141,6 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.volt_setup_time	= 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -158,7 +157,6 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
 static struct omap_voltdm_pmic omap3_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.volt_setup_time        = 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -175,7 +173,6 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -193,7 +190,6 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -211,7 +207,6 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 static struct omap_voltdm_pmic omap4_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index d2d5b2b..4d02d6e 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -155,7 +155,6 @@ struct omap_volt_data {
 struct omap_voltdm_pmic {
 	int slew_rate;
 	int step_size;
-	u16 volt_setup_time;
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
 	u16 cmd_reg_addr;
-- 
1.7.4.1

